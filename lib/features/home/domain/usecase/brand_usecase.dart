import 'package:injectable/injectable.dart';
import 'package:marketi/features/home/domain/entity/brand_entity.dart';
import 'package:marketi/features/home/domain/repository/home_repository.dart';

@injectable
class BrandUseCase {
  HomeRepository repository;
  BrandUseCase(this.repository);
  Future<List<BrandEntity>> call()=> repository.brands();
}