import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../dataLayer/cubit/app_cubit.dart';
import '../../dataLayer/cubit/app_state.dart';
import '../helper/snakbar_error.dart';
import '../widget/mainButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (BuildContext context, AppState state) {
        if (state is GetWeatherError) {
          showCustomErrorSnackbar(message: state.error, context: context);
        }
      },
      builder: (context, state) {
        final formKey = GlobalKey<FormState>();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Welcome to Weather App',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32.0,
                horizontal: 8.0,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: cubit.cityController,
                      decoration: InputDecoration(
                        labelText: 'Enter city name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'City name cannot be empty!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    MainButton(
                      label: 'Get Weather',
                      function: () async {
                        if (formKey.currentState!.validate()) {
                          cubit.getWeather(context);
                        }
                      },
                      hight: 54,
                      width: 295,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 32),

                    state is GetWeatherLoading
                        ? CircularProgressIndicator()
                        : cubit.weather == null || state is GetWeatherError
                        ? Text(
                          "Please enter your city\nand press get weather",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                        : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    cubit.cityController.text,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  cubit.getWeatherIcon(
                                    cubit.weather?.main?.temp ?? 0,
                                  ),
                                  Text(
                                    "Temperature: ${cubit.weather?.main?.temp ?? ''}°C",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),

                              SizedBox(height: 8),

                              Text(
                                "Weather: ${cubit.weather?.weather?[0].main ?? ''}",
                                style: TextStyle(fontSize: 25),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Wind Speed: ${cubit.weather?.wind?.speed ?? ''}",
                                style: TextStyle(fontSize: 25),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Humidity: ${cubit.weather?.main?.humidity ?? ''}",
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
