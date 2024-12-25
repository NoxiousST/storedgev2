enum AppRoutes {
  dashboard,
  login,
  register,
  items,
  addItem,
  updateItem,
  itemDetails,
  supplier,
  addSupplier,
  updateSupplier,
  supplierDetails,
  addTransaction,
  map
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.dashboard:
        return '/';
      case AppRoutes.login:
        return '/login';
      case AppRoutes.register:
        return '/register';
      case AppRoutes.items:
        return '/item';
      case AppRoutes.addItem:
        return '/item/add';
      case AppRoutes.updateItem:
        return '/item/update/:id';
      case AppRoutes.itemDetails:
        return '/item/:id';
      case AppRoutes.supplier:
        return '/suplier';
      case AppRoutes.addSupplier:
        return '/suplier/add';
      case AppRoutes.updateSupplier:
        return '/item/suplier/:id';
      case AppRoutes.supplierDetails:
        return '/suplier/:id';
      case AppRoutes.addTransaction:
        return '/item/transaction/add';
      case AppRoutes.map:
        return '/map';
    }
  }

  String get routeName {
    switch (this) {
      case AppRoutes.dashboard:
        return 'Home';
      case AppRoutes.login:
        return 'Login';
      case AppRoutes.register:
        return 'Register';
      case AppRoutes.items:
        return 'Itmes';
      case AppRoutes.addItem:
        return 'Add Item';
      case AppRoutes.updateItem:
        return 'Update Item';
      case AppRoutes.itemDetails:
        return 'Item Details';
      case AppRoutes.supplier:
        return 'Supplier';
      case AppRoutes.addSupplier:
        return 'Add Supplier';
      case AppRoutes.updateSupplier:
        return 'Update Supplier';
      case AppRoutes.supplierDetails:
        return 'Supplier Details';
      case AppRoutes.addTransaction:
        return 'Add Transaction';
      case AppRoutes.map:
        return 'Map';
    }
  }
}