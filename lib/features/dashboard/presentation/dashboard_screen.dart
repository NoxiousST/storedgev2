import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:storedgev2/core/constants/constants.dart';
import 'package:storedgev2/features/authentication/data/firebase_auth_service.dart';
import 'package:storedgev2/features/dashboard/application/dashboard_provider.dart';
import 'package:storedgev2/features/dashboard/presentation/widgets/dashboard_card.dart';

import '../../../core/config/router/route_enum.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemCount = ref.watch(itemCollectionCountProvider);
    final supplierCount = ref.watch(supplierCollectionCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(color: primaryColor, fontWeight: FontWeight.w500),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout_rounded,
            ),
            onPressed: () async {
              await ref.read(firebaseAuthServiceProvider.notifier).signOut();
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(itemCollectionCountProvider);
          ref.invalidate(supplierCollectionCountProvider);
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  spacing: defaultPadding,
                  children: [
                    itemCount.when(
                      data: (count) => DashboardCard(
                        count: count.toString(),
                        type: "Item",
                        onTap: () =>
                            context.pushNamed(AppRoutes.items.routeName),
                        icon: Icons.tv_rounded,
                        title: "Item List",
                        description:
                            "Your inventory consists of $count unique items. You can update item details, or add new products as necessary.",
                      ),
                      loading: () => const FakerDashboardCard(),
                      error: (error, stack) => Text('Failed to load items'),
                    ),
                    supplierCount.when(
                      data: (count) => DashboardCard(
                        count: count.toString(),
                        type: "Supplier",
                        onTap: () =>
                            context.pushNamed(AppRoutes.supplier.routeName),
                        icon: Icons.storage_rounded,
                        title: "Supplier List",
                        description:
                            "We currently work with $count trusted suppliers. You can update their contact information or view their locations on the map.",
                      ),
                      loading: () => const FakerDashboardCard(),
                      error: (error, stack) => Text('Failed to load suppliers'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
