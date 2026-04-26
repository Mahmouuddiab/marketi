import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketi/core/di/di.dart';
import 'package:marketi/core/toast/app_toast.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/validator/app_validator.dart';
import 'package:marketi/features/auth/domain/entity/register_entity.dart';
import 'package:marketi/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:marketi/features/auth/presentation/cubit/auth_state.dart';
import 'package:marketi/shared/custom_button.dart';
import 'package:marketi/shared/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  bool secure = true;
  final _formKey = GlobalKey<FormState>();
  late final AuthCubit authCubit = getIt<AuthCubit>();


  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: authCubit,
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            AppToast.success(context, "Registered successfully");
          }

          if (state is RegisterErrorState) {
            AppToast.error(context, state.error);
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
                    spacing: 15.h,
                    children: [
                      /// Logo
                      Center(
                        child: Image.asset(
                          "assets/images/Logo_Splash_Screen.png",
                        ),
                      ),

                      /// Full Name
                      CustomTextField(
                        label: "Full Name",
                        controller: nameController,
                        prefixIcon: Image.asset("assets/icons/Name_Icon.png"),
                        keyboardType: TextInputType.name,
                        validator: (_) => AppValidator.displayNameValidator(
                          nameController.text,
                        ),
                      ),

                      /// Phone
                      CustomTextField(
                        label: "Phone Number",
                        controller: phoneController,
                        prefixIcon: Image.asset("assets/icons/Phone_Icon.png"),
                        keyboardType: TextInputType.number,
                        validator: (_) => AppValidator.phoneValidator(
                          phoneController.text,
                          context,
                        ),
                      ),

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
                        keyboardType: TextInputType.multiline,
                        validator: (_) => AppValidator.passwordValidator(
                          passwordController.text,
                        ),
                        obscureText: secure,
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

                      /// Password Confirmation
                      CustomTextField(
                        label: "Confirm Password",
                        controller: confirmController,
                        prefixIcon: Image.asset(
                          "assets/icons/Password_Icon.png",
                        ),
                        keyboardType: TextInputType.multiline,
                        validator: (_) => AppValidator.repeatPasswordValidator(
                          password: passwordController.text,
                          value: confirmController.text,
                        ),
                        obscureText: secure,
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

                      SizedBox(height: 20.h),

                      /// Register Button
                      state is RegisterLoadingState
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : CustomButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  authCubit.register(
                                    RegisterEntity(
                                      name: nameController.text.trim(),
                                      phone: phoneController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      confirmPassword: confirmController.text.trim(),
                                    ),
                                  );
                                }
                              },
                              txt: "Register",
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 6,
                        children: [
                          Text(
                            "Already have an account ?",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppColors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              /// go to login screen
                            },
                            child: Text(
                              " Login",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppColors.primaryColor,
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
