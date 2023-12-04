import 'package:geolocation/screens/geolocation/geolocation_view.dart';
import 'package:geolocation/screens/home_screen/home_page.dart';
import 'package:geolocation/screens/lead_screen/add_lead_screen/add_lead_screen.dart';
import 'package:geolocation/screens/lead_screen/update_screen/update_screen.dart';
import 'package:geolocation/screens/login/login_view.dart';
import 'package:geolocation/screens/sales_order/add_sales_order/add_order_screen.dart';
import 'package:geolocation/screens/sales_order/items/add_items_screen.dart';
import 'package:geolocation/screens/sales_order/list_sales_order/list_sales_order_screen.dart';
import 'package:geolocation/screens/splash_screen/splash_screen.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'screens/lead_screen/lead_list/lead_screen.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreen, initial: true),

    MaterialRoute(page: HomePage),
    MaterialRoute(page: LoginViewScreen),
    MaterialRoute(page: Geolocation),
    MaterialRoute(page: ListOrderScreen),
    MaterialRoute(page: AddOrderScreen),
    MaterialRoute(page: ItemScreen),
    MaterialRoute(page: LeadListScreen),
    MaterialRoute(page: AddLeadScreen),
    MaterialRoute(page: UpdateLeadScreen)

    // DetailedFarmerScreen
  ],
  dependencies: [
    Singleton(classType: NavigationService),
  ],
)
class App {
  //empty class, will be filled after code generation
}
// flutter pub run build_runner build --delete-conflicting-outputs
