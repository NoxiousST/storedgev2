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
        data: (suppliers) {
          final activeSuppliers = suppliers.where((s) => !s.deleted).toList();
          if (activeSuppliers.isEmpty) {
            return const Center(child: Text('No items found.'));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding / 4,
              vertical: defaultPadding,
            ),
            child: ListView.separated(
              itemCount: activeSuppliers.length,
              itemBuilder: (context, index) {
                final supplier = activeSuppliers[index];
                return ListTile(
                  onTap: () => context.pushNamed(
                    AppRoutes.supplierDetails.routeName,
                    pathParameters: {'id': supplier.id!},
                  ),
                  leading: CircleAvatar(
                    backgroundColor: primaryColor,
                    child: Text(supplier.name[0].toUpperCase()),
                  ),
                  title: Text(supplier.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        supplier.location.address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        supplier.contact,
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_rounded),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: defaultPadding,
              ),
            ),
          );
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
