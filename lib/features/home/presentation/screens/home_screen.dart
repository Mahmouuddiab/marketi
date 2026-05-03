import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketi/core/di/di.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/features/home/presentation/cubit/home_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/home_state.dart';
import 'package:marketi/features/home/presentation/widgets/banner_show.dart';
import 'package:marketi/features/home/presentation/widgets/custom_row.dart';
import 'package:marketi/features/home/presentation/widgets/home_field.dart';
import 'package:marketi/features/home/presentation/widgets/product_card.dart';
import 'package:marketi/features/home/presentation/widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

   HomeCubit homeCubit = getIt<HomeCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit,HomeState>(
        bloc: homeCubit..getHome(),
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
            }

            if(state is HomeSuccess){
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Hello, User",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset("assets/svg/bell_icon.svg")
                        ],
                      ),
                      SizedBox(height: 13.h,),
                      HomeField(
                        hintTxt: "What are you looking for ?",
                        prefixIcon: Icon(Icons.search,color: AppColors.darkblue700,),
                        suffixIcon: Image.asset("assets/icons/Filter_Icon.png"),
                      ),
                      SizedBox(height: 15.h,),
                      BannerShow(),
                      SizedBox(height: 15.h,),
                      CustomRow(text1: "Products", text2: "View all"),
                      SizedBox(height: 13.h,),
                      SizedBox(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.products.length,
                            itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductCard(
                                image: product.thumbnail,
                                price: product.price.toString(),
                                name: product.title,
                                rate: product.rating.toString(),
                                discount: product.discountPercentage.toString(),
                                onTap: (){}
                            );
                            },
                        ),
                      )
                    ],
                  ),
                ),
              ) ;
            }
            if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
      ),
    );
  }
}
