import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/cache/cache_helper.dart';
import 'package:marketi/core/network/dio_helper.dart';
import 'package:marketi/features/profile/data/data source/profile_remote_ds.dart';
import 'package:marketi/features/profile/data/models/profile_model.dart';

@Injectable(as: ProfileRemoteDs)
class ProfileRemoteDsImpl implements ProfileRemoteDs {
  @override
  Future<ProfileModel> getProfile() async {
    try {
      final token = await CacheHelper.getToken();

      if (token == null || token.isEmpty) {
        throw Exception("User token not found");
      }

      final response = await DioHelper.get(
        url: "https://supermarket-dan1.onrender.com/api/v1/portfoilo/userData",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else {
        throw Exception("Failed with status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}