import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../dataLayer/cubit/app_cubit.dart';
import '../../dataLayer/cubit/app_state.dart';
import '../widget/book_list_item.dart';
import '../widget/mainButton.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit.getBooks(); // أول تحميل للكتب

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        cubit.getBooks(isPagination: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (BuildContext context, AppState state) {},
      builder: (context, state) {
        

        return Scaffold(
          appBar: AppBar(title: const Text('Book Listing')),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Search for books...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: state is GetBooksLoading && cubit.allBooks.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: cubit.allBooks.length + (cubit.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < cubit.allBooks.length) {
                            final book = cubit.allBooks[index];
                            return BookListItem(
                              title: book.title ?? 'Untitled',
                              authors: book.authors?.map((a) => a.name ?? 'Unknown').toList() ?? ['Unknown'],
                              // summary: book.summaries,
                              coverImageUrl: book.formats?.imageJpeg,
                            );
                          } else {
                            // Loading indicator عند نهاية السكروول
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

