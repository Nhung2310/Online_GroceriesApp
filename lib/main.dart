import 'package:flutter/material.dart';
import 'package:online_groceries_app/firebase_options.dart';
import 'package:online_groceries_app/ui/account_screen.dart';
import 'package:online_groceries_app/ui/cart_screen.dart';
import 'package:online_groceries_app/ui/category_screen.dart';
import 'package:online_groceries_app/ui/checkout_screen.dart';
import 'package:online_groceries_app/ui/email_verified_screen.dart';
import 'package:online_groceries_app/ui/explore_screen.dart';
import 'package:online_groceries_app/ui/favourite_screen.dart';
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
import 'package:online_groceries_app/controller/product_controller.dart';
import 'package:online_groceries_app/ui/product_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(ProductController());

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
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),

          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => const SplashScreen()),
            GetPage(name: '/sign_up', page: () => SignUp()),
            GetPage(name: '/shop', page: () => ShopScreen()),
            GetPage(
              name: '/product_detail',
              page: () => ProductDetailScreen(product: Get.arguments),
            ),
            GetPage(name: '/order_accepted', page: () => OrderAccepted()),
            GetPage(name: '/onbording', page: () => Onbording()),
            GetPage(name: '/log_in', page: () => Login()),
            GetPage(name: '/home', page: () => HomeScreen()),
            GetPage(name: '/favourite', page: () => FavouriteScreen()),
            GetPage(name: '/explore', page: () => ExploreScreen()),
            GetPage(
              name: '/email_verified',
              page: () => EmailVerifiedScreen(email: Get.arguments),
            ),
            GetPage(
              name: '/check_out',
              page: () => CheckoutScreen(price: Get.arguments),
            ),
            GetPage(
              name: '/category',
              page:
                  () => CategoryScreen(
                    title: Get.arguments,
                    product: Get.arguments,
                  ),
            ),
            GetPage(name: '/cart', page: () => CartScreen()),
            GetPage(name: '/account', page: () => AccountScreen()),
            // Add other routes her
          ],
        );
      },
    );
  }
}
