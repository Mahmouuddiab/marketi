import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marketi/core/service/my_fatoura_service.dart';
import 'package:url_launcher/url_launcher.dart';


class PaymentScreen extends StatefulWidget {
  final double amount;
  final String customerName;
  final String customerEmail;
  final String customerMobile;

  const PaymentScreen({
    super.key,
    required this.amount,
    required this.customerName,
    required this.customerEmail,
    required this.customerMobile,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  // ─────────────────────────────────────────────────────────────
  // SERVICE
  // ─────────────────────────────────────────────────────────────

  final MyFatoorahService _service = MyFatoorahService(
    apiToken:
    "SK_KWT_vVZlnnAqu8jRByOWaRPNId4ShzEDNt256dvnjebuyzo52dXjAfRx2ixW5umjWSUx",
  );

  // ─────────────────────────────────────────────────────────────
  // CALLBACK URLS
  // ─────────────────────────────────────────────────────────────

  static const String _callbackUrl = 'https://google.com';
  static const String _errorUrl = 'https://google.com';

  // ─────────────────────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────────────────────

  bool _loading = true;
  bool _paying = false;

  String? _error;

  List<PaymentMethod> _methods = [];

  PaymentMethod? _selectedMethod;

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  // ─────────────────────────────────────────────────────────────
  // INIT
  // ─────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _loadMethods();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────────
  // LOAD METHODS
  // ─────────────────────────────────────────────────────────────

  Future<void> _loadMethods() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final methods = await _service.getPaymentMethods(
        amount: widget.amount,
        currencyIso: "SAR",
      );

      setState(() {
        _methods = methods;
        _loading = false;
      });

      _animationController.forward(from: 0);
    } catch (e) {
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  // ─────────────────────────────────────────────────────────────
  // PAY
  // ─────────────────────────────────────────────────────────────

  Future<void> _pay() async {
    if (_selectedMethod == null) return;

    setState(() {
      _paying = true;
    });

    try {
      final result = await _service.executePayment(
        paymentMethodId: _selectedMethod!.paymentMethodId,
        amount: widget.amount,
        customerName: widget.customerName,
        customerEmail: widget.customerEmail,
        customerMobile: widget.customerMobile,
        currencyIso: "SAR",
        callbackUrl: _callbackUrl,
        errorUrl: _errorUrl,
      );

      final uri = Uri.parse(result.paymentUrl);

      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      setState(() {
        _paying = false;
      });
    } catch (e) {
      setState(() {
        _paying = false;
        _error = e.toString();
      });
    }
  }

  // ─────────────────────────────────────────────────────────────
  // UI
  // ─────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0F1E),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // HEADER
  // ─────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1A2340),
            Color(0xFF0D1526),
          ],
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Secure Checkout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Powered by MyFatoorah',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF00C9A7),
                  Color(0xFF0098A0),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${widget.amount.toStringAsFixed(2)} SAR',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // BODY
  // ─────────────────────────────────────────────────────────────

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF00C9A7),
        ),
      );
    }

    if (_error != null) {
      return _buildError();
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'Choose Payment Method',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                ..._methods.map(_buildMethodCard),
              ],
            ),
          ),
          _buildPayButton(),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // METHOD CARD
  // ─────────────────────────────────────────────────────────────

  Widget _buildMethodCard(PaymentMethod method) {
    final selected =
        _selectedMethod?.paymentMethodId == method.paymentMethodId;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = method;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF00C9A7).withOpacity(.12)
              : const Color(0xFF141A2E),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? const Color(0xFF00C9A7)
                : Colors.white.withOpacity(.06),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  method.paymentMethodImageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.paymentMethodEn,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${method.totalAmount.toStringAsFixed(2)} ${method.currencyIso}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.45),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? const Color(0xFF00C9A7)
                    : Colors.transparent,
                border: Border.all(
                  color: selected
                      ? const Color(0xFF00C9A7)
                      : Colors.white24,
                  width: 2,
                ),
              ),
              child: selected
                  ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 14,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // PAY BUTTON
  // ─────────────────────────────────────────────────────────────

  Widget _buildPayButton() {
    final enabled = _selectedMethod != null && !_paying;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: GestureDetector(
        onTap: enabled ? _pay : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          height: 58,
          decoration: BoxDecoration(
            gradient: enabled
                ? const LinearGradient(
              colors: [
                Color(0xFF00C9A7),
                Color(0xFF0098A0),
              ],
            )
                : null,
            color: enabled ? null : const Color(0xFF1E2540),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: _paying
                ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                : Text(
              enabled
                  ? 'Pay ${widget.amount.toStringAsFixed(2)} SAR'
                  : 'Select payment method',
              style: TextStyle(
                color: enabled
                    ? Colors.white
                    : Colors.white.withOpacity(.3),
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // ERROR
  // ─────────────────────────────────────────────────────────────

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 70,
            ),
            const SizedBox(height: 20),
            const Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _error ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(.5),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _loadMethods,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF00C9A7),
                      Color(0xFF0098A0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}