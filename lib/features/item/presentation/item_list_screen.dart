import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:storedgev2/core/constants/constants.dart';
import 'package:storedgev2/features/item/application/item_provider.dart';

import '../../../core/config/router/route_enum.dart';
import 'widgets/item_card.dart';

class ItemsListScreen extends ConsumerWidget {
  const ItemsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allItemsStream = ref.watch(itemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Items List'),
        titleTextStyle:
            AppBarTheme.of(context).titleTextStyle?.copyWith(fontSize: 24),
      ),
      body: allItemsStream.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No items found.'));
          }
          return CustomScrollView(slivers: [
            SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding / 4, vertical: defaultPadding),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: defaultPadding / 4,
                    crossAxisSpacing: defaultPadding / 2,
                    childAspectRatio: 0.655,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final item = items[index];
                      return ItemCard(
                        image: item.image.first,
                        name: item.name,
                        price: item.price,
                        stock: item.stock,
                        category: item.category,
                        onTap: () => context.pushNamed(
                            AppRoutes.itemDetails.routeName,
                            pathParameters: {'id': item.id!}),
                      );
                    },
                    childCount: items.length,
                  ),
                ))
          ]);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(AppRoutes.addItem.routeName),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
