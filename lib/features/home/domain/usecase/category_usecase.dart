import 'package:injectable/injectable.dart';
import 'package:marketi/features/home/domain/entity/category_entity.dart';
import 'package:marketi/features/home/domain/repository/home_repository.dart';

@injectable
class CategoryUseCase {
  HomeRepository repository;
  CategoryUseCase(this.repository);
  Future<List<CategoryEntity>> call()=> repository.categories();
}