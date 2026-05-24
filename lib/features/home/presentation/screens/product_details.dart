import 'package:flutter/material.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/features/home/domain/entity/product_entity.dart';
import 'package:marketi/features/payment/payment_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────
  // PAYMENT FLOW
  // ─────────────────────────────────────────────

  void _openPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          amount: widget.product.price.toDouble(),
          // ⚠️ Replace with real user data from auth/cubit
          customerName: 'Guest User',
          customerEmail: 'guest@email.com',
          customerMobile: '0000000000',
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // UI
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // ───────── IMAGE HEADER ─────────
          SliverAppBar(
            expandedHeight: 450,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: BackButton(color: Colors.black),
              ),
            ),
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildImageGallery(),
            ),
          ),

          // ───────── PRODUCT DETAILS ─────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand + Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.brand,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 18),
                          Text(
                            " ${widget.product.rating} ",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "\$${widget.product.price}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const Divider(height: 40),

                  _buildSectionTitle("Product Description"),
                  const SizedBox(height: 10),

                  Text(
                    widget.product.description,
                    style: TextStyle(
                      color: Colors.grey[700],
                      height: 1.6,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle("Specifications"),
                  const SizedBox(height: 12),

                  _buildSpecItem("SKU", widget.product.sku),
                  _buildSpecItem(
                      "Weight", "${widget.product.weight}g"),
                  _buildSpecItem(
                      "Warranty", widget.product.warrantyInformation),
                  _buildSpecItem(
                      "Shipping", widget.product.shippingInformation),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),

      // ───────── BOTTOM ACTION ─────────
      bottomSheet: _buildBottomAction(),
    );
  }

  // ─────────────────────────────────────────────
  // IMAGE GALLERY
  // ─────────────────────────────────────────────

  Widget _buildImageGallery() {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.product.images.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.product.images[index],
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
          ),
        ),

        // Thumbnails
        Container(
          height: 100,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: widget.product.images.length,
            separatorBuilder: (_, __) =>
            const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final isActive = _currentIndex == index;

              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 76,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isActive
                          ? Colors.blueAccent
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.product.images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSpecItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(color: Colors.grey[600])),
          const Spacer(),
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // BOTTOM ACTION
  // ─────────────────────────────────────────────

  Widget _buildBottomAction() {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.favorite_border,
              color: AppColors.primaryColor,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: ElevatedButton(
              onPressed: _openPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize:
                const Size(double.infinity, 56),
              ),
              child: const Text(
                "Checkout",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}