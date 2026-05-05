import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketi/core/di/di.dart';
import 'package:marketi/core/router/app_routes.dart';
import 'package:marketi/core/toast/app_toast.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/validator/app_validator.dart';
import 'package:marketi/features/auth/domain/entity/login_entity.dart';
import 'package:marketi/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:marketi/features/auth/presentation/cubit/auth_state.dart';
import 'package:marketi/shared/custom_button.dart';
import 'package:marketi/shared/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool secure = true;
  final _formKey = GlobalKey<FormState>();
  late final AuthCubit authCubit = getIt<AuthCubit>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: authCubit,
        listener: (context, state) {
          if (state is LoginSuccessState) {
            AppToast.show("Success Login",type: ToastType.success);
            Navigator.pushReplacementNamed(context, AppRoutes.root);
          }

          if (state is LoginErrorState) {
            AppToast.show("Success Fail",type: ToastType.error);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 18.h,
                    children: [
                      SizedBox(height: 50.h),

                      /// Logo
                      Center(
                        child: Image.asset(
                          "assets/images/Logo_Splash_Screen.png",
                        ),
                      ),

                      SizedBox(height: 30.h),

                      /// Email
                      CustomTextField(
                        label: "Email",
                        controller: emailController,
                        prefixIcon: Image.asset(
                          "assets/icons/evaEmailOutline0.png",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (_) =>
                            AppValidator.emailValidator(emailController.text),
                      ),

                      /// Password
                      CustomTextField(
                        label: "Password",
                        controller: passwordController,
                        prefixIcon: Image.asset(
                          "assets/icons/Password_Icon.png",
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: secure,
                        validator: (_) => AppValidator.passwordValidator(
                          passwordController.text,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              secure = !secure;
                            });
                          },
                          icon: Icon(
                            secure ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),

                      SizedBox(height: 75.h),

                      state is LoginLoadingState
                       ? CircularProgressIndicator(color: AppColors.primaryColor,)
                       : CustomButton(
                        txt: "Login",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authCubit.login(
                              LoginEntity(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 6,
                        children: [
                          Text(
                            "Don't have an account ?",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppColors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.register,
                              );
                            },
                            child: Text(
                              "Register",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
