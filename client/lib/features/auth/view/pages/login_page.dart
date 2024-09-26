import 'package:flutter/material.dart';
import 'package:music/core/theme/app_pallete.dart';
import 'package:music/features/auth/repositories/auth_remote_repository.dart';
import 'package:music/features/auth/view/pages/signup_page.dart';
import 'package:music/features/auth/view/widgets/custom_form_field.dart';
import 'package:music/features/auth/view/widgets/gradinet_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailContorller = TextEditingController();
  final passwordContorller = TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    passwordContorller.dispose();
    emailContorller.dispose();
    super.dispose();
    formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In.',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 30,),
              CustomFormField(
                hintText: 'Email', 
                controller: emailContorller
              ),
              const SizedBox(height: 15,),
              CustomFormField(
                hintText: 'Password', 
                controller: passwordContorller,
                isObsecure: true,
              ),
              const SizedBox(height: 20,),
              GradinetButton(
                onTap: () async {
                  await AuthRemoteRepository().login(
                    email: emailContorller.text, 
                    password: passwordContorller.text
                  );
                },
                buttonText: 'Log In',
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => const SignupPage())
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account?  ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: const [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Pallete.gradient3
                        )
                      )
                    ]
                  )
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}