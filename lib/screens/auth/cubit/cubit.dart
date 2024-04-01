import 'package:dash_port_hand_made/screens/auth/cubit/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isobscure = false;
  void isvisblePassword() {
    isobscure = !isobscure;
    emit(LoginVisiblePasswordState());
  }

  void siginIN(BuildContext context) async {
    emit(LoginLoadinState());
    try {
      if (formKey.currentState?.validate() ?? false) {
        if (emailController.text == 'Ahmed@gmail.com' &&
            passwordController.text == '123456789') {
          Navigator.pushNamed(context, '/home');
          print('\nSuccess\n');
          emit(LoginSuccessState());
        } else {
          emit(
            LoginErrorState(error: 'You are Not Admin'),
          );
        }
        // if (formKey.currentState?.validate() ?? false) {
        //   String email = emailController.text;
        //   String password = passwordController.text;
        //   UserCredential result = await FirebaseAuth.instance
        //       .signInWithEmailAndPassword(email: email, password: password);
        //   Navigator.pushNamed(context, '/addProd');

        //   print(result);
        //   emit(LoginSuccessState());
        // }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You are not Admin'),
        ),
      );
      print(e);
      if (e.code ==
          "[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong Password'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
          ),
        );
      }
    }
  }
}
