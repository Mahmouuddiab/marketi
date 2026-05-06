import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        leading: SizedBox(),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProfileError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is ProfileSuccess) {
            final user = state.user;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  /// Profile Image
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      user.image ??
                          "https://i.pravatar.cc/300",
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Name
                  Text(
                    user.name ?? "No Name",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Info Card
                  Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: Text(user.email ?? "No Email"),
                        ),
                        const Divider(),

                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text(user.phone ?? "No Phone"),
                        ),
                        const Divider(),

                        ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(user.address ?? "No Address"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}