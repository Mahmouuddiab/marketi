import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/features/home/presentation/cubit/home_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/home_state.dart';
import 'package:marketi/features/home/presentation/screens/product_by_category_screen.dart';
import 'package:marketi/features/home/presentation/widgets/category_list_item.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<HomeCubit>().getHome();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "All Categories",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.darkblue700,
            size: 20,
          ),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is HomeSuccess) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: state.categories.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return CategoryListItem(
                    category: category,
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ProductsByCategoryScreen(category: category.name),));
                    }
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}