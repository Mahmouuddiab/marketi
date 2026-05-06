import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/router/app_router.dart';
import 'package:marketi/core/router/app_routes.dart';
import 'package:marketi/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/home_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit.dart';
import 'core/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<HomeCubit>()),
            BlocProvider(create: (context) => getIt<CartCubit>()),
            BlocProvider(create: (context) => getIt<ProfileCubit>()),
          ],
          child: MaterialApp(
            title: 'Marketi',
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRouter.generateRoute,
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
          ),
        );
      },
    );
  }
}
