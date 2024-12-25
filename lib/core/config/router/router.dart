import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/authentication/application/auth_provider.dart';
import '../../../features/authentication/presentation/login_screen.dart';
import '../../../features/authentication/presentation/register_screen.dart';
import '../../../features/dashboard/presentation/dashboard_screen.dart';
import '../../../features/item/presentation/item_datails_screen.dart';
import '../../../features/item/presentation/item_form_screen.dart';
import '../../../features/item/presentation/item_list_screen.dart';
import '../../../features/supplier/presentation/map_screen.dart';
import '../../../features/supplier/presentation/supplier_datails_screen.dart';
import '../../../features/supplier/presentation/supplier_form_screen.dart';
import '../../../features/supplier/presentation/supplier_list_screen.dart';
import '../../../features/transaction/presentation/transaction_form_screen.dart';
import '../../utils/refresh_listenable.dart';
import './route_enum.dart';

part 'router.g.dart';

final _key = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(Ref ref) {
  final auth = ref.watch(authRepositoryProvider);
  final router = GoRouter(
    navigatorKey: _key,
    initialLocation: AppRoutes.dashboard.path,
    routes: [
      GoRoute(
        path: AppRoutes.dashboard.path,
        name: AppRoutes.dashboard.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: DashboardScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.register.path,
        name: AppRoutes.register.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: RegisterScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.items.path,
        name: AppRoutes.items.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: ItemsListScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.addItem.path,
        name: AppRoutes.addItem.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: ItemFormScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.updateItem.path,
        name: AppRoutes.updateItem.routeName,
        pageBuilder: (context, state) {
          final itemId = state.pathParameters['id']!;
          return MaterialPage(child: ItemFormScreen(id: itemId));
        },
      ),
      GoRoute(
        path: AppRoutes.itemDetails.path,
        name: AppRoutes.itemDetails.routeName,
        pageBuilder: (context, state) {
          final itemId = state.pathParameters['id']!;
          return MaterialPage(child: ItemDetailsScreen(id: itemId));
        },
      ),
      GoRoute(
        path: AppRoutes.supplier.path,
        name: AppRoutes.supplier.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: SupplierListScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.addSupplier.path,
        name: AppRoutes.addSupplier.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: SupplierFormScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.updateSupplier.path,
        name: AppRoutes.updateSupplier.routeName,
        pageBuilder: (context, state) {
          final itemId = state.pathParameters['id']!;
          return MaterialPage(child: SupplierFormScreen(id: itemId));
        },
      ),
      GoRoute(
        path: AppRoutes.supplierDetails.path,
        name: AppRoutes.supplierDetails.routeName,
        pageBuilder: (context, state) {
          final itemId = state.pathParameters['id']!;
          return MaterialPage(child: SupplierDatailsScreen(id: itemId));
        },
      ),
      GoRoute(
          path: AppRoutes.addTransaction.path,
          name: AppRoutes.addTransaction.routeName,
          pageBuilder: (context, state) {
            return MaterialPage(
              child: TransactionFormScreen(
                  itemId: state.uri.queryParameters['itemId']!),
            );
          }),
      GoRoute(
        path: AppRoutes.map.path,
        name: AppRoutes.map.routeName,
        pageBuilder: (context, state) {
          final lat = state.uri.queryParameters['latitude'];
          final lng = state.uri.queryParameters['longitude'];

          if (lat != null && lng != null) {
            final latitude = double.tryParse(lat);
            final longitude = double.tryParse(lng);

            if (latitude != null && longitude != null) {
              final LatLng point = LatLng(latitude, longitude);
              return MaterialPage(
                child: MapScreen(point: point),
              );
            }
          }

          return const MaterialPage(
            child: MapScreen(),
          );
        },
      )
    ],
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges()),
    redirect: (context, state) async {
      final bool isLoggedIn = auth.currentUser != null;
      final bool isLoggingIn = state.matchedLocation == AppRoutes.login.path ||
          state.matchedLocation == AppRoutes.register.path;

      if (!isLoggedIn && !isLoggingIn) {
        return AppRoutes.login.path;
      }

      if (isLoggedIn && isLoggingIn) {
        return AppRoutes.dashboard.path;
      }

      return null;
    },
  );

  ref.onDispose(router.dispose);
  return router;
}