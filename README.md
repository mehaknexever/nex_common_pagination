<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

- Automatically detects when the user scrolls near the bottom of the content.
- Triggers a provided pagination function to load more data.
- Customizable to fit various use cases.

## Getting started

This package provides a utility class for handling pagination when the user scrolls. It triggers a function to load more data when the user reaches near the bottom of the scrollable content.

## Features

- Automatically triggers a pagination function when scrolling near the bottom.
- Configurable to enable or disable pagination.

## Installation

Add this package to your `pubspec.yaml` file:

```yaml
dependencies:
  your_package_name:
    git:
      url: git@github.com:yourusername/yourrepository.git
      ref: main
```
Run flutter pub get to install the dependencies.

## Usage

The PaginationWidget class is a StatelessWidget that wraps a child widget and listens for scroll notifications to trigger a pagination function when the user reaches near the bottom of the scrollable content.

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pagination_widget.dart';

class MyListView extends StatelessWidget {
  final List<String> items = List.generate(50, (index) => 'Item $index');
  int totalItems = 100;
  int currentItems = 50;

  void fetchMoreItems() {
    // Fetch more items and update the list
  }

  @override
  Widget build(BuildContext context) {
    return PaginationWidget(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(items[index]));
        },
      ),
      paginationFunction: fetchMoreItems,
      total: totalItems,
      current: currentItems,
      paginate: true,
    );
  }
}

```

### Pagination Widget Parameters
- child (Widget): The child widget that will be wrapped by the pagination logic.
- paginationFunction (void Function()): The function to be called to load more data when the user scrolls near the bottom.
- total (int): The total number of items available.
- current (int): The current number of items loaded.
- paginate (bool?, optional): A flag indicating whether to enable pagination.

## Notes

- Ensure to handle the pagination function appropriately to avoid performance issues or excessive API calls.
- Adjust the scroll position threshold as needed by modifying the scrollInfo.metrics.pixels check in the PaginationWidget.

Author
Mehak

License
This project is licensed under the MIT License - see the LICENSE file for details..
