import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../dataLayer/cubit/app_cubit.dart';
import '../../dataLayer/cubit/app_state.dart';
import '../helper/snakbar_error.dart';
import '../widget/book_list_item.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('welocome to Book App'))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: cubit.nameBookController,
              onChanged: (value) {
                cubit.onSearchSubmitted(value);
              },
              decoration: InputDecoration(
                hintText: 'Search by title or author...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocConsumer<AppBloc, AppState>(
              listener: (context, state) {
                if (state is GetBooksPaginationError ||
                    state is GetBooksError ||
                    state is GetBooksSearchError) {
                  showCustomErrorSnackbar(
                    message: (state as dynamic).error,
                    context: context,
                  );
                }
              },
              builder: (context, state) {
                if ((state is GetBooksLoading ||
                        state is GetBooksSearchLoading) &&
                    cubit.allBooks.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification.metrics.pixels >=
                            scrollNotification.metrics.maxScrollExtent - 200 &&
                        !cubit.isLoadingMore &&
                        cubit.hasMoreData) {
                      if (cubit.isSearching) {
                        cubit.searchBooks(isPagination: true);
                      } else {
                        cubit.getBooks(isPagination: true);
                      }
                    }
                    return false;
                  },
                  child: ListView.builder(
                    itemCount:
                        cubit.allBooks.length + (cubit.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < cubit.allBooks.length) {
                        final book = cubit.allBooks[index];
                        return BookListItem(
                          title: book.title ?? '',
                          summary:
                              (book.summaries != null &&
                                      book.summaries!.isNotEmpty)
                                  ? book.summaries!.first
                                  : null,

                          authors:
                              book.authors?.map((a) => a.name ?? '').toList() ??
                              ['Unknown'],
                          coverImageUrl: book.formats?.imageJpeg,
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
