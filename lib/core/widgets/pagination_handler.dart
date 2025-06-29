import 'package:flutter/widgets.dart';

class PaginationHandler {
  final ScrollController scrollController;
  final bool Function() hasNextPage;
  final Future<void> Function() onLoadMore;

  PaginationHandler({
    required this.scrollController,
    required this.hasNextPage,
    required this.onLoadMore,
  }) {
    _init();
  }

  void _init() {
    scrollController.addListener(_scrollListener);
  }

  void dispose() {
    scrollController.removeListener(_scrollListener);
  }

  void _scrollListener() async {
    final isAtBottom =
        scrollController.position.atEdge &&
        scrollController.position.pixels != 0;

    if (isAtBottom && hasNextPage()) {
      await onLoadMore();
    }
  }
}
