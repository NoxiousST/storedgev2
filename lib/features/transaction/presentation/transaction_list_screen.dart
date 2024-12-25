import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:storedgev2/core/constants/constants.dart';
import 'package:storedgev2/features/supplier/application/supplier_provider.dart';

import '../../../core/config/router/route_enum.dart';

class SupplierListScreen extends ConsumerWidget {
  const SupplierListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allSupplierStream = ref.watch(suppliersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Supllier List'),
        titleTextStyle:
            AppBarTheme.of(context).titleTextStyle?.copyWith(fontSize: 24),
      ),
      body: allSupplierStream.when(
        data: (supplier) {
          if (supplier.isEmpty) {
            return const Center(child: Text('No items found.'));
          }
          return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 4, vertical: defaultPadding),
              child: ListView.builder(
                  itemCount: supplier.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Text(
                          supplier[index].name[0].toUpperCase(),
                        ),
                      ),
                      title: Text(supplier[index].name),
                      subtitle: Text(supplier[index].location.address),
                    );
                  }));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(AppRoutes.addSupplier.routeName),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
