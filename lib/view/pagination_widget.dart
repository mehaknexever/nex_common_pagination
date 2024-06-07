import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A widget that handles pagination when the user scrolls.
///
/// The `PaginationWidget` class is a `StatelessWidget` that wraps a child widget and
/// listens for scroll notifications to trigger a pagination function when the user
/// reaches near the bottom of the scrollable content.
///
/// Example usage:
/// ```dart
/// PaginationWidget(
///   child: ListView.builder(
///     itemCount: items.length,
///     itemBuilder: (context, index) {
///       return ListTile(title: Text(items[index]));
///     },
///   ),
///   paginationFunction: fetchMoreItems,
///   total: totalItems,
///   current: currentItems,
///   paginate: true,
/// );
/// ```
class PaginationWidget extends StatelessWidget {
  /// The child widget that will be wrapped by the pagination logic.
  final Widget child;

  /// The function to be called to load more data when the user scrolls near the bottom.
  final void Function() paginationFunction;

  /// The total number of items available.
  final int total;

  /// The current number of items loaded.
  final int current;

  /// A flag indicating whether to enable pagination.
  final bool? paginate;

  /// Constructs a `PaginationWidget`.
  ///
  /// The [child], [paginationFunction], [total], and [current] parameters are required.
  PaginationWidget({
    Key? key,
    required this.child,
    required this.paginationFunction,
    required this.total,
    required this.current,
    this.paginate,
  }) : super(key: key);

  Timer? timer;
  final RxBool scrollState = true.obs;
  final RxBool loader = true.obs;
  final RxDouble height = 0.0.obs;
  final RxInt position = 0.obs;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollStartNotification) {
          scrollState.value = false;
        } else if (scrollInfo is ScrollUpdateNotification) {
          scrollState.value = false;
        } else if (scrollInfo is ScrollEndNotification) {
          scrollState.value = true;
        }

        print("Total ====>>>>  $total");
        print("Current Page  ====>>>>  $current");

        if (total > current) {
          print("Pagination ====>>>>  ${total > current}");

          bool paginate = this.paginate ?? false;
          if (paginate) {
            paginate = scrollInfo.metrics.pixels >=
                    (scrollInfo.metrics.maxScrollExtent - 200) &&
                scrollInfo.metrics.pixels >= 0.0;
          } else {
            paginate = scrollInfo.metrics.pixels >
                    (scrollInfo.metrics.maxScrollExtent - 200) &&
                scrollInfo.metrics.pixels > 0.0;
          }

          if (paginate) {
            if (timer != null) {
              timer!.cancel();
              timer = null;
            }
            timer = Timer(const Duration(milliseconds: 500), () async {
              paginationFunction();
              timer!.cancel();
              timer = null;
            });
          }
        }
        return false;
      },
      child: child,
    );
  }
}
