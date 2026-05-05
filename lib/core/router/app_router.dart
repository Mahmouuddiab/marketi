import 'package:flutter/material.dart';
import 'package:marketi/features/auth/presentation/screens/login_screen.dart';
import 'package:marketi/features/auth/presentation/screens/register_screen.dart';
import 'package:marketi/features/boarding%20pages/screen/on_boarding_screen.dart';
import 'package:marketi/features/home/presentation/screens/all_brand_screen.dart';
import 'package:marketi/features/home/presentation/screens/all_category_screen.dart';
import 'package:marketi/features/home/presentation/screens/all_product_screeen.dart';
import 'package:marketi/root.dart';
import 'package:marketi/splash_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.onBoarding:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case AppRoutes.root:
        return MaterialPageRoute(builder: (_) => Root());
      case AppRoutes.allProduct:
        return MaterialPageRoute(builder: (_) => AllProductsScreen());
      case AppRoutes.allCategory:
        return MaterialPageRoute(builder: (_) => AllCategoryScreen());
      case AppRoutes.allBrands:
        return MaterialPageRoute(builder: (_) => AllBrandScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(body: Center(child: Text("Not Found"))),
        );
    }
  }
}