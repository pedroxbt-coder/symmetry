import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/local/local_user_bloc.dart';
// import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/local/local_user_event.dart';

// import '../../../../daily_news/presentation/pages/home/daily_news.dart';
// import '../../../domain/entities/user_entity.dart';
import '../sign_up/sign_up.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

void signIn(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('The sign-in function could not be implemented.'),
    ),
  );

  // String email = _emailController.text.trim();
  // var userEntity = SignUpParamsEntity(
  //     email: email, password: _passwordController.toString());
  // context.read<LocalUserBloc>().add(SignIn(userEntity));
  //
  // _emailController.clear();
  // _passwordController.clear();
  //
  // Navigator.pushAndRemoveUntil(
  //   context,
  //   MaterialPageRoute(builder: (context) => const DailyNews()),
  //   (route) => false,
  // );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _signup(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
                color: Color(0xffF7F7F9), shape: BoxShape.circle),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Hello Again',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              _emailAddress(),
              const SizedBox(
                height: 20,
              ),
              _password(),
              const SizedBox(
                height: 50,
              ),
              _signin(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailAddress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email Address',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
              filled: true,
              hintText: 'example@gmail.com',
              hintStyle: const TextStyle(
                  color: Color(0xff6A6A6A),
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
              fillColor: const Color(0xffF7F7F9),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14))),
        )
      ],
    );
  }

  Widget _password() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          obscureText: true,
          controller: _passwordController,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF7F7F9),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14))),
        )
      ],
    );
  }

  Widget _signin(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff0D6EFD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: () async {
        signIn(context);
      },
      child: const Text("Sign In"),
    );
  }

  Widget _signup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            const TextSpan(
              text: "New User? ",
              style: TextStyle(
                  color: Color(0xff6A6A6A),
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
            TextSpan(
                text: "Create Account",
                style: const TextStyle(
                    color: Color(0xff1A1D1E),
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  }),
          ])),
    );
  }
}
