import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:marketi/core/di/di.dart';
import 'package:marketi/core/router/app_routes.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/features/home/presentation/cubit/home_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/home_state.dart';
import 'package:marketi/features/home/presentation/widgets/banner_show.dart';
import 'package:marketi/features/home/presentation/widgets/custom_row.dart';
import 'package:marketi/features/home/presentation/widgets/home_field.dart';
import 'package:marketi/features/home/presentation/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeCubit homeCubit = getIt<HomeCubit>();

  @override
  void initState() {
    super.initState();
    homeCubit.getHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        builder: (context, state) {
          final isLoading = state is HomeLoading;
          final products = state is HomeSuccess ? state.products : [];
          final categories = state is HomeSuccess ? state.categories : [];

          if (state is HomeError) {
            return Center(child: Text(state.message));
          }
          return Skeletonizer(
            enabled: isLoading,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///  Header
                      Row(
                        children: [
                          Text(
                            "Hello, User",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            "assets/svg/notification_icon.svg",
                            height: 25.h,
                            width: 25.w,
                          ),
                        ],
                      ),

                      SizedBox(height: 13.h),

                      ///  Search
                      HomeField(
                        hintTxt: "What are you looking for ?",
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.darkblue700,
                        ),
                        suffixIcon: Image.asset("assets/icons/Filter_Icon.png"),
                      ),

                      SizedBox(height: 15.h),

                      ///  Banner
                      const BannerShow(),

                      SizedBox(height: 15.h),

                      ///  Products Header
                      CustomRow(
                        text1: "Products",
                        text2: "View all",
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.allProduct);
                        },
                      ),

                      SizedBox(height: 13.h),

                      ///  Products List
                      SizedBox(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: isLoading ? 5 : products.length,
                          itemBuilder: (context, index) {
                            final product = isLoading ? null : products[index];

                            return ProductCard(
                              image: product?.thumbnail ?? '',
                              price: product?.price.toString() ?? '',
                              name: product?.title ?? '',
                              rate: product?.rating.toString() ?? '',
                              discount: product?.discountPercentage.toString() ?? '',
                              onTap: () {},
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 13.h),

                      ///  Categories Header
                      CustomRow(
                        text1: "Categories",
                        text2: "View all",
                        onTap: () {},
                      ),

                      SizedBox(height: 13.h),

                      ///  Categories List
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: isLoading ? 5 : categories.length,
                          itemBuilder: (context, index) {
                            final category = isLoading
                                ? null
                                : categories[index];

                            return Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: category != null
                                    ? Image.network(
                                        category.image,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(color: Colors.grey.shade300),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
