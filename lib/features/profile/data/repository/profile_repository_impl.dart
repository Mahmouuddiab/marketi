import 'package:injectable/injectable.dart';
import 'package:marketi/features/profile/data/data%20source/profile_remote_ds.dart';
import 'package:marketi/features/profile/domain/entity/profile_entity.dart';
import 'package:marketi/features/profile/domain/repository/profile_repository.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRemoteDs remote;
  ProfileRepositoryImpl(this.remote);
  @override
  Future<ProfileEntity> getProfile() async{
   final dto = await remote.getProfile();
   return dto ;
  }

}