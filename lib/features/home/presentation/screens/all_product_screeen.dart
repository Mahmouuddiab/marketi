import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:marketi/core/toast/app_toast.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:marketi/features/cart/presentation/cubit/cart_state.dart';
import 'package:marketi/features/home/presentation/cubit/home_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/home_state.dart';
import 'package:marketi/features/home/presentation/screens/product_details.dart';
import 'package:marketi/features/home/presentation/widgets/product_card.dart';
import 'package:marketi/features/search/presentation/screens/search_screen.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<HomeCubit>();
    cubit.getHome();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        cubit.loadMore();
      }
    });
  }

  Future<void> _onRefresh() async {
    await context.read<HomeCubit>().getHome();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildLoadingIndicator({String message = "Loading..."}) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            const SizedBox(width: 12),
            Text(message, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddToCartSuccess) {
          AppToast.show("Added to cart", type: ToastType.success);
        }

        if (state is AddToCartError) {
          AppToast.show("Failed to add", type: ToastType.error);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          title: const Text("All Products"),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColors.darkblue700),
          ),
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                },
                icon: Icon(Icons.search)
            )
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeError) {
              return Center(child: Text(state.message));
            }

            if (state is HomeSuccess) {
              return CustomRefreshIndicator(
                onRefresh: _onRefresh,
                builder: (context, child, controller) {
                  return Stack(
                    children: [
                      Transform.translate(
                        offset: Offset(0, controller.value * 80),
                        child: child,
                      ),
                      if (controller.isLoading)
                        Positioned(
                          top: 10,
                          left: 0,
                          right: 0,
                          child: _buildLoadingIndicator(message: "Refreshing"),
                        ),
                    ],
                  );
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(12),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.77,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final product = state.products[index];
                          return ProductCard(
                            image: product.thumbnail,
                            price: product.price.toString(),
                            name: product.title,
                            rate: product.rating.toString(),
                            discount: product.discountPercentage.toString(),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailsScreen(product: product),
                                ),
                              );
                            },
                            onTapButton: () {
                              context.read<CartCubit>().addToCart(product.id);
                            },
                          );
                        }, childCount: state.products.length),
                      ),
                    ),
                    // This SliverToBoxAdapter spans the full width, centering your loader
                    if (state.hasMore)
                      SliverToBoxAdapter(
                        child: _buildLoadingIndicator(message: "Loading"),
                      ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
