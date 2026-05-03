import 'package:injectable/injectable.dart';
import 'package:marketi/features/home/data/data%20source/home_remote_ds.dart';
import 'package:marketi/features/home/domain/entity/category_entity.dart';
import 'package:marketi/features/home/domain/entity/product_entity.dart';
import 'package:marketi/features/home/domain/repository/home_repository.dart';


@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeRemoteDs remote;
  HomeRepositoryImpl(this.remote);
  @override
  Future<List<ProductEntity>> products({
    required int skip,
    required int limit
}) async{
   final dto = remote.products(
     skip: skip,
     limit: limit
   );
   return dto ;
  }

  @override
  Future<List<CategoryEntity>> categories() async{
    final dto = await remote.categories();
    return dto ;
  }

}