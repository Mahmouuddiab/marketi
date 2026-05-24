import 'dart:convert';
import 'package:http/http.dart' as http;

class MyFatoorahService {
  // ✅ TEST API URL
  static const String _baseUrl = 'https://apitest.myfatoorah.com';

  final String apiToken;

  MyFatoorahService({
    required this.apiToken,
  });

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $apiToken',
  };

  // ─────────────────────────────────────────────────────────────
  // GET PAYMENT METHODS
  // ─────────────────────────────────────────────────────────────
  Future<List<PaymentMethod>> getPaymentMethods({
    required double amount,
    required String currencyIso,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/v2/InitiatePayment'),
      headers: _headers,
      body: jsonEncode({
        "InvoiceAmount": amount,
        "CurrencyIso": currencyIso,
      }),
    );

    print("InitiatePayment Status: ${response.statusCode}");
    print("InitiatePayment Body: ${response.body}");

    final json = _decodeResponse(response);

    final methods = json['Data']['PaymentMethods'] as List<dynamic>;

    return methods
        .map((e) => PaymentMethod.fromJson(e))
        .toList();
  }

  // ─────────────────────────────────────────────────────────────
  // EXECUTE PAYMENT
  // ─────────────────────────────────────────────────────────────
  Future<PaymentInitResult> executePayment({
    required int paymentMethodId,
    required double amount,
    required String customerName,
    required String customerEmail,
    required String customerMobile,
    required String currencyIso,
    required String callbackUrl,
    required String errorUrl,
  }) async {
    final body = {
      "PaymentMethodId": paymentMethodId,
      "InvoiceValue": amount,
      "CustomerName": customerName,
      "CustomerEmail": customerEmail,
      "CustomerMobile": customerMobile,
      "DisplayCurrencyIso": currencyIso,
      "CallBackUrl": callbackUrl,
      "ErrorUrl": errorUrl,
      "Language": "EN",
    };

    final response = await http.post(
      Uri.parse('$_baseUrl/v2/ExecutePayment'),
      headers: _headers,
      body: jsonEncode(body),
    );

    print("ExecutePayment Status: ${response.statusCode}");
    print("ExecutePayment Body: ${response.body}");

    final json = _decodeResponse(response);

    final data = json['Data'];

    return PaymentInitResult(
      invoiceId: data['InvoiceId'].toString(),
      paymentUrl: data['PaymentURL'],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // PAYMENT STATUS
  // ─────────────────────────────────────────────────────────────
  Future<PaymentStatusResult> getPaymentStatus({
    required String paymentId,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/v2/GetPaymentStatus'),
      headers: _headers,
      body: jsonEncode({
        "Key": paymentId,
        "KeyType": "PaymentId",
      }),
    );

    print("GetPaymentStatus Status: ${response.statusCode}");
    print("GetPaymentStatus Body: ${response.body}");

    final json = _decodeResponse(response);

    return PaymentStatusResult.fromJson(json['Data']);
  }

  // ─────────────────────────────────────────────────────────────
  // RESPONSE HANDLER
  // ─────────────────────────────────────────────────────────────
  Map<String, dynamic> _decodeResponse(http.Response response) {
    final json = jsonDecode(response.body);

    if (response.statusCode == 401) {
      throw Exception(
        '401 Unauthorized - Token invalid or permission denied',
      );
    }

    if (json['IsSuccess'] != true) {
      throw Exception(
        json['Message'] ??
            json['ValidationErrors']?.toString() ??
            'Unknown MyFatoorah Error',
      );
    }

    return json;
  }
}

// ─────────────────────────────────────────────────────────────
// MODELS
// ─────────────────────────────────────────────────────────────

class PaymentInitResult {
  final String invoiceId;
  final String paymentUrl;

  PaymentInitResult({
    required this.invoiceId,
    required this.paymentUrl,
  });
}

class PaymentStatusResult {
  final String invoiceId;
  final String invoiceStatus;
  final double invoiceValue;

  PaymentStatusResult({
    required this.invoiceId,
    required this.invoiceStatus,
    required this.invoiceValue,
  });

  bool get isPaid => invoiceStatus == 'Paid';

  factory PaymentStatusResult.fromJson(Map<String, dynamic> json) {
    return PaymentStatusResult(
      invoiceId: json['InvoiceId'].toString(),
      invoiceStatus: json['InvoiceStatus'],
      invoiceValue: (json['InvoiceValue'] as num).toDouble(),
    );
  }
}

class PaymentMethod {
  final int paymentMethodId;
  final String paymentMethodEn;
  final String paymentMethodImageUrl;
  final double totalAmount;
  final String currencyIso;

  PaymentMethod({
    required this.paymentMethodId,
    required this.paymentMethodEn,
    required this.paymentMethodImageUrl,
    required this.totalAmount,
    required this.currencyIso,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      paymentMethodId: json['PaymentMethodId'],
      paymentMethodEn: json['PaymentMethodEn'],
      paymentMethodImageUrl: json['ImageUrl'],
      totalAmount: (json['TotalAmount'] as num).toDouble(),
      currencyIso: json['CurrencyIso'],
    );
  }
}