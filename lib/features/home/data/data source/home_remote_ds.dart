import 'package:marketi/features/home/data/models/product_model.dart';

abstract class HomeRemoteDs {
  Future<List<ProductModel>> products();
}