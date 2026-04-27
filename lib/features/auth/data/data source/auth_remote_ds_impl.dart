import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/cache/cache_helper.dart';
import 'package:marketi/core/network/dio_helper.dart';
import 'package:marketi/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:marketi/features/auth/data/models/login_model.dart';
import 'package:marketi/features/auth/data/models/register_model.dart';
import 'package:marketi/features/auth/domain/entity/login_entity.dart';
import 'package:marketi/features/auth/domain/entity/register_entity.dart';

@Injectable(as: AuthRemoteDs)
class AuthRemoteDsImpl implements AuthRemoteDs {
  @override
  Future<Unit> register(RegisterEntity registerEntity) async {
    try {
      final response = await DioHelper.post(
        url: "https://supermarket-dan1.onrender.com/api/v1/auth/signUp",
        data: {
          "name": registerEntity.name,
          "phone": registerEntity.phone,
          "email": registerEntity.email,
          "password": registerEntity.password,
          "confirmPassword": registerEntity.confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        final user =  RegisterModel.fromJson(response.data);
        print("register message : ${user.message}");
        return unit;
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }

  @override
  Future<Unit> login(LoginEntity loginEntity) async{
   try {
     final response = await DioHelper.post(
       url: "https://supermarket-dan1.onrender.com/api/v1/auth/signIn",
       data: {
         "email": loginEntity.email,
         "password": loginEntity.password,
       },
     );
     if(response.statusCode == 200){
       final user = LoginModel.fromJson(response.data);
       final token = user.token;
       CacheHelper.saveToken(token);
       print("user token : $token");
       return unit ;
     }
     else{
       throw Exception("Server error: ${response.statusCode}");
     }
   }
   catch(e) {
     throw Exception("Network error: $e");
   }
  }
}