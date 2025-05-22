import 'package:flutter/material.dart';
import 'package:online_groceries_app/app_routes_name.dart';
import 'package:online_groceries_app/binding/account_binding.dart';
import 'package:online_groceries_app/binding/cart_binding.dart';
import 'package:online_groceries_app/binding/category_binding.dart';
import 'package:online_groceries_app/binding/checkout_binding.dart';
import 'package:online_groceries_app/binding/email_binding.dart';
import 'package:online_groceries_app/binding/explore_binding.dart';
import 'package:online_groceries_app/binding/favourite_binding.dart';
import 'package:online_groceries_app/binding/home_binding.dart';
import 'package:online_groceries_app/binding/login_binding.dart';
import 'package:online_groceries_app/binding/onbording_binding.dart';
import 'package:online_groceries_app/binding/order_accepted_binding.dart';
import 'package:online_groceries_app/binding/product_detail_binding.dart';
import 'package:online_groceries_app/binding/shop_binding.dart';
import 'package:online_groceries_app/binding/sign_up_binding.dart';
import 'package:online_groceries_app/binding/splash_binding.dart';
import 'package:online_groceries_app/firebase_options.dart';
import 'package:online_groceries_app/services/setting_services.dart';
import 'package:online_groceries_app/ui/account_screen.dart';
import 'package:online_groceries_app/ui/cart_screen.dart';
import 'package:online_groceries_app/ui/category_screen.dart';
import 'package:online_groceries_app/ui/checkout_screen.dart';
import 'package:online_groceries_app/ui/email_verified_screen.dart';
import 'package:online_groceries_app/ui/explore_screen.dart';
import 'package:online_groceries_app/ui/home_screen.dart';
import 'package:online_groceries_app/ui/log_in_screen.dart';
import 'package:online_groceries_app/ui/onbording_screen.dart';
import 'package:online_groceries_app/ui/order_accepted_screen.dart';
import 'package:online_groceries_app/ui/shop_screen.dart';
import 'package:online_groceries_app/ui/sign_up_screen.dart';
import 'package:online_groceries_app/ui/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/ui/product_detail_screen.dart';
import 'messages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.putAsync(() => SettingServices().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          translations: Messages(),
          locale: Locale('en', 'US'),
          fallbackLocale: Locale('vi', 'VN'),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutesName.splash,
          initialBinding: SplashBinding(),
          getPages: [
            GetPage(
              name: AppRoutesName.splash,
              page: () => const SplashScreen(),
              binding: SplashBinding(),
            ),
            GetPage(
              name: AppRoutesName.signUp,
              page: () => SignUp(),
              binding: SignUpBinding(),
            ),
            GetPage(
              name: AppRoutesName.shop,
              page: () => ShopScreen(),
              binding: ShopBinding(),
            ),
            GetPage(
              name: AppRoutesName.productDetail,
              page: () => ProductDetailScreen(),
              binding: ProductDetailBinding(),
            ),
            GetPage(
              name: AppRoutesName.orderAccepted,
              page: () => OrderAccepted(),
              binding: OrderAcceptedBinding(),
            ),
            GetPage(
              name: AppRoutesName.onbording,
              page: () => Onbording(),
              binding: OnbordingBinding(),
            ),
            GetPage(
              name: AppRoutesName.login,
              page: () => Login(),
              binding: LoginBinding(),
            ),
            GetPage(
              name: AppRoutesName.home,
              page: () => HomeScreen(),
              bindings: [
                HomeBinding(),
                ShopBinding(),
                ExploreBinding(),
                CartBinding(),
                FavouriteBinding(),
                AccountBinding(),
              ],
            ),
            GetPage(
              name: AppRoutesName.explore,
              page: () => ExploreScreen(),
              binding: ExploreBinding(),
            ),
            GetPage(
              name: AppRoutesName.emailVerified,
              page: () => EmailVerifiedScreen(),
              binding: EmailBinding(),
            ),
            GetPage(
              name: AppRoutesName.checkOut,
              page: () => CheckoutScreen(price: Get.arguments),
              binding: CheckoutBinding(),
            ),

            GetPage(
              name: AppRoutesName.category,
              page: () => CategoryScreen(),
              binding: CategoryBinding(),
            ),
            GetPage(
              name: AppRoutesName.cart,
              page: () => CartScreen(),
              binding: CartBinding(),
            ),
            GetPage(
              name: AppRoutesName.account,
              page: () => AccountScreen(),
              binding: AccountBinding(),
            ),
            // Add other routes her
          ],
        );
      },
    );
  }
}
