import 'package:marketi/features/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.email,
    required super.address,
    required super.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['message'];

    return ProfileModel(
      id: data['_id'],
      name: data['name'],
      phone: data['phone'],
      email: data['email'],
      address: data['address'],
      image: data['image'],
    );
  }
}