import 'package:flutter/material.dart';
import 'package:marketi/features/profile/presentation/widgets/custom_divider.dart'; // Import your new divider

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Terms of Service",
          style: TextStyle(
            color: Color(0xFF1F2C37),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Last Updated: May 2024",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            _buildSection(
              "1. Acceptance of Terms",
              "By accessing and using Marketi, you agree to be bound by these terms and conditions. If you do not agree, please refrain from using our services.",
            ),
            const CustomDivider(height: 40),
            _buildSection(
              "2. User Account",
              "You are responsible for maintaining the confidentiality of your account credentials. Any activities under your account are your sole responsibility.",
            ),
            const CustomDivider(height: 40),
            _buildSection(
              "3. Purchases & Payments",
              "All transactions are processed securely. Marketi reserves the right to refuse service or cancel orders at our discretion.",
            ),
            const CustomDivider(height: 40),
            _buildSection(
              "4. Privacy Policy",
              "Your data security is important to us. Please review our Privacy Policy to understand how we collect and use your personal information.",
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2C37),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF707070),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}