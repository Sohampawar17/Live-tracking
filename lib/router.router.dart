// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i12;
import 'package:flutter/material.dart';
import 'package:geolocation/model/add_order_model.dart' as _i13;
import 'package:geolocation/screens/geolocation/geolocation_view.dart' as _i5;
import 'package:geolocation/screens/home_screen/home_page.dart' as _i3;
import 'package:geolocation/screens/lead_screen/add_lead_screen/add_lead_screen.dart'
    as _i10;
import 'package:geolocation/screens/lead_screen/lead_list/lead_screen.dart'
    as _i9;
import 'package:geolocation/screens/lead_screen/update_screen/update_screen.dart'
    as _i11;
import 'package:geolocation/screens/login/login_view.dart' as _i4;
import 'package:geolocation/screens/sales_order/add_sales_order/add_order_screen.dart'
    as _i7;
import 'package:geolocation/screens/sales_order/items/add_items_screen.dart'
    as _i8;
import 'package:geolocation/screens/sales_order/list_sales_order/list_sales_order_screen.dart'
    as _i6;
import 'package:geolocation/screens/splash_screen/splash_screen.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i14;

class Routes {
  static const splashScreen = '/';

  static const homePage = '/home-page';

  static const loginViewScreen = '/login-view-screen';

  static const geolocation = '/Geolocation';

  static const listOrderScreen = '/list-order-screen';

  static const addOrderScreen = '/add-order-screen';

  static const itemScreen = '/item-screen';

  static const leadListScreen = '/lead-list-screen';

  static const addLeadScreen = '/add-lead-screen';

  static const updateLeadScreen = '/update-lead-screen';

  static const all = <String>{
    splashScreen,
    homePage,
    loginViewScreen,
    geolocation,
    listOrderScreen,
    addOrderScreen,
    itemScreen,
    leadListScreen,
    addLeadScreen,
    updateLeadScreen,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashScreen,
      page: _i2.SplashScreen,
    ),
    _i1.RouteDef(
      Routes.homePage,
      page: _i3.HomePage,
    ),
    _i1.RouteDef(
      Routes.loginViewScreen,
      page: _i4.LoginViewScreen,
    ),
    _i1.RouteDef(
      Routes.geolocation,
      page: _i5.Geolocation,
    ),
    _i1.RouteDef(
      Routes.listOrderScreen,
      page: _i6.ListOrderScreen,
    ),
    _i1.RouteDef(
      Routes.addOrderScreen,
      page: _i7.AddOrderScreen,
    ),
    _i1.RouteDef(
      Routes.itemScreen,
      page: _i8.ItemScreen,
    ),
    _i1.RouteDef(
      Routes.leadListScreen,
      page: _i9.LeadListScreen,
    ),
    _i1.RouteDef(
      Routes.addLeadScreen,
      page: _i10.AddLeadScreen,
    ),
    _i1.RouteDef(
      Routes.updateLeadScreen,
      page: _i11.UpdateLeadScreen,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashScreen: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashScreen(),
        settings: data,
      );
    },
    _i3.HomePage: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.HomePage(),
        settings: data,
      );
    },
    _i4.LoginViewScreen: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.LoginViewScreen(),
        settings: data,
      );
    },
    _i5.Geolocation: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.Geolocation(),
        settings: data,
      );
    },
    _i6.ListOrderScreen: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.ListOrderScreen(),
        settings: data,
      );
    },
    _i7.AddOrderScreen: (data) {
      final args = data.getArgs<AddOrderScreenArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.AddOrderScreen(key: args.key, orderid: args.orderid),
        settings: data,
      );
    },
    _i8.ItemScreen: (data) {
      final args = data.getArgs<ItemScreenArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.ItemScreen(
            key: args.key, warehouse: args.warehouse, items: args.items),
        settings: data,
      );
    },
    _i9.LeadListScreen: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.LeadListScreen(),
        settings: data,
      );
    },
    _i10.AddLeadScreen: (data) {
      final args = data.getArgs<AddLeadScreenArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i10.AddLeadScreen(key: args.key, leadid: args.leadid),
        settings: data,
      );
    },
    _i11.UpdateLeadScreen: (data) {
      final args = data.getArgs<UpdateLeadScreenArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i11.UpdateLeadScreen(key: args.key, updateId: args.updateId),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class AddOrderScreenArguments {
  const AddOrderScreenArguments({
    this.key,
    required this.orderid,
  });

  final _i12.Key? key;

  final String orderid;

  @override
  String toString() {
    return '{"key": "$key", "orderid": "$orderid"}';
  }

  @override
  bool operator ==(covariant AddOrderScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.orderid == orderid;
  }

  @override
  int get hashCode {
    return key.hashCode ^ orderid.hashCode;
  }
}

class ItemScreenArguments {
  const ItemScreenArguments({
    this.key,
    required this.warehouse,
    required this.items,
  });

  final _i12.Key? key;

  final String warehouse;

  final List<_i13.Items> items;

  @override
  String toString() {
    return '{"key": "$key", "warehouse": "$warehouse", "items": "$items"}';
  }

  @override
  bool operator ==(covariant ItemScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.warehouse == warehouse &&
        other.items == items;
  }

  @override
  int get hashCode {
    return key.hashCode ^ warehouse.hashCode ^ items.hashCode;
  }
}

class AddLeadScreenArguments {
  const AddLeadScreenArguments({
    this.key,
    required this.leadid,
  });

  final _i12.Key? key;

  final String leadid;

  @override
  String toString() {
    return '{"key": "$key", "leadid": "$leadid"}';
  }

  @override
  bool operator ==(covariant AddLeadScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.leadid == leadid;
  }

  @override
  int get hashCode {
    return key.hashCode ^ leadid.hashCode;
  }
}

class UpdateLeadScreenArguments {
  const UpdateLeadScreenArguments({
    this.key,
    required this.updateId,
  });

  final _i12.Key? key;

  final String updateId;

  @override
  String toString() {
    return '{"key": "$key", "updateId": "$updateId"}';
  }

  @override
  bool operator ==(covariant UpdateLeadScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.updateId == updateId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ updateId.hashCode;
  }
}

extension NavigatorStateExtension on _i14.NavigationService {
  Future<dynamic> navigateToSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomePage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homePage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginViewScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginViewScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGeolocation([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.geolocation,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToListOrderScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.listOrderScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddOrderScreen({
    _i12.Key? key,
    required String orderid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addOrderScreen,
        arguments: AddOrderScreenArguments(key: key, orderid: orderid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToItemScreen({
    _i12.Key? key,
    required String warehouse,
    required List<_i13.Items> items,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.itemScreen,
        arguments:
            ItemScreenArguments(key: key, warehouse: warehouse, items: items),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLeadListScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.leadListScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddLeadScreen({
    _i12.Key? key,
    required String leadid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addLeadScreen,
        arguments: AddLeadScreenArguments(key: key, leadid: leadid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpdateLeadScreen({
    _i12.Key? key,
    required String updateId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.updateLeadScreen,
        arguments: UpdateLeadScreenArguments(key: key, updateId: updateId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomePage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homePage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginViewScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginViewScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGeolocation([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.geolocation,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithListOrderScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.listOrderScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddOrderScreen({
    _i12.Key? key,
    required String orderid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addOrderScreen,
        arguments: AddOrderScreenArguments(key: key, orderid: orderid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithItemScreen({
    _i12.Key? key,
    required String warehouse,
    required List<_i13.Items> items,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.itemScreen,
        arguments:
            ItemScreenArguments(key: key, warehouse: warehouse, items: items),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLeadListScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.leadListScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddLeadScreen({
    _i12.Key? key,
    required String leadid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addLeadScreen,
        arguments: AddLeadScreenArguments(key: key, leadid: leadid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpdateLeadScreen({
    _i12.Key? key,
    required String updateId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.updateLeadScreen,
        arguments: UpdateLeadScreenArguments(key: key, updateId: updateId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
