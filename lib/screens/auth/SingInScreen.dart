import 'package:dash_port_hand_made/screens/auth/cubit/cubit.dart';
import 'package:dash_port_hand_made/screens/auth/cubit/state.dart';
import 'package:dash_port_hand_made/shared/Cache_Helper/cache_helper.dart';
import 'package:dash_port_hand_made/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  // const LoginScreen({super.key});

  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginErrorState) {
            message(context, state.error, longTime: 7);
          } else if (state is LoginSuccessState) {
            // SharedPreferences?.setBool('login', true);
            CacheHelper().saveData(key: 'Login', value: true).then(
                  (value) => Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false),
                );
            message(context, "Log In Successfully");
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white10,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black12,
                    ),
                    width: 400,
                    height: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sing-in ',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          // width: 350.w,
                          child: Form(
                            key: context.read<LoginCubit>().formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '  Email:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.lightBlueAccent),
                                  ),
                                  MyTextField(
                                    controller: context
                                        .read<LoginCubit>()
                                        .emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This Field is required';
                                      }
                                      if (!value.contains('@')) {
                                        return 'Email Must Contains @gmail.com ';
                                      }
                                      return null;
                                    },
                                    hintText: 'Enter Your Email',
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: const Icon(Icons.email),
                                  ),
                                  const Text(
                                    '  Password:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.lightBlueAccent),
                                  ),
                                  MyTextField(
                                    controller: context
                                        .read<LoginCubit>()
                                        .passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This Field is required';
                                      }
                                      return null;
                                    },
                                    obscureText:
                                        context.read<LoginCubit>().isobscure,
                                    hintText: 'Enter Your password',
                                    keyboardType: TextInputType.visiblePassword,
                                    prefixIcon: const Icon(Icons.password),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        context
                                            .read<LoginCubit>()
                                            .isvisblePassword();
                                      },
                                      icon: context.read<LoginCubit>().isobscure
                                          ? const Icon(Icons.visibility_off)
                                          : const Icon(Icons.remove_red_eye),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 40.h,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: double.infinity,
                                    // height: 400.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 91, 158, 213),
                                      ),
                                      onPressed: () async {
                                        context
                                            .read<LoginCubit>()
                                            .siginIN(context);
                                      },
                                      child: const Text(
                                        'Sign-in',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'NotoSerif'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
