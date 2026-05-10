import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/cache/cache_helper.dart';
import 'package:marketi/core/router/app_routes.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_state.dart';
import 'package:marketi/features/profile/presentation/widgets/custom_divider.dart';

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
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox(),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    /// HEADER
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                            ),
                            child: ClipOval(child: Icon(Icons.person)),
                          ),

                          const SizedBox(width: 18),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name ?? "",
                                  style: const TextStyle(
                                    color: Color(0xFF1F2C37),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                SizedBox(height: 3.h),

                                Text(
                                  user.email ?? 'example@gmail.com',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.settings_outlined,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// FULL SCREEN MENU
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.04),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [
                            Expanded(
                              child: ProfileListItem(
                                icon: Icons.language_outlined,
                                title: 'Language',
                                onTap: () {},
                              ),
                            ),

                            const CustomDivider(),

                            Expanded(
                              child: ProfileListItem(
                                icon: Icons.account_balance_wallet_outlined,
                                title: 'Marketi Pay',
                                onTap: () {},
                              ),
                            ),

                            const CustomDivider(),

                            Expanded(
                              child: ProfileListItem(
                                icon: Icons.help_outline_outlined,
                                title: 'Help & Support',
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.helpSupport,
                                  );
                                },
                              ),
                            ),

                            const CustomDivider(),

                            Expanded(
                              child: ProfileListItem(
                                icon: Icons.verified_user_outlined,
                                title: 'Terms of Service',
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.termServices,
                                  );
                                },
                              ),
                            ),

                            const CustomDivider(),

                            Expanded(
                              child: ProfileListItem(
                                icon: Icons.feedback_outlined,
                                title: 'Give us Feedback',
                                onTap: () {},
                              ),
                            ),

                            const CustomDivider(),

                            Expanded(
                              child: ProfileListItem(
                                icon: Icons.info_outline_rounded,
                                title: 'Invite Friends',
                                onTap: () {},
                              ),
                            ),

                            const CustomDivider(),

                            Expanded(
                              child: ProfileListItem(
                                icon: Icons.power_settings_new_rounded,
                                title: 'Sign out',
                                onTap: () {
                                  _showLogoutDialog(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

/// LOGOUT DIALOG
void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Sign out"),
        content: Text("are you sure you want to sign out ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _performLogout(context);
              Navigator.pop(context);
            },
            child: Text("Sign out", style: const TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,

        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8),

          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: AppColors.primaryColor, size: 25),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// LOGOUT FUNCTION
void _performLogout(BuildContext context) async {
  await CacheHelper.clearToken();
  Navigator.pushReplacementNamed(context, AppRoutes.login);
}
