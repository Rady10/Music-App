import 'package:flutter/material.dart';
import 'package:music/core/theme/app_pallete.dart';
import 'package:music/features/auth/repositories/auth_remote_repository.dart';
import 'package:music/features/auth/view/pages/login_page.dart';
import 'package:music/features/auth/view/widgets/custom_form_field.dart';
import 'package:music/features/auth/view/widgets/gradinet_button.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final nameContorller = TextEditingController();
  final emailContorller = TextEditingController();
  final passwordContorller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameContorller.dispose();
    emailContorller.dispose();
    passwordContorller.dispose();
    super.dispose();
    formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up.',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30,),
              CustomFormField(
                hintText: 'Name',
                controller: nameContorller,
              ),
              const SizedBox(height: 15,),
              CustomFormField(
                hintText: 'Email',
                controller: emailContorller,
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
                  await AuthRemoteRepository().signup(
                    name: nameContorller.text, 
                    email: emailContorller.text, 
                    password: passwordContorller.text
                  );
                },
                buttonText: 'Sign Up',
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => const LoginPage())
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account?  ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: const [
                      TextSpan(
                        text: 'Sign in',
                        style: TextStyle(
                          color: Pallete.gradient3,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ]
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}