import 'package:flutter/material.dart';
import 'package:music/core/theme/app_pallete.dart';
import 'package:music/core/utils.dart';
import 'package:music/core/widgets/loader.dart';
import 'package:music/features/auth/view/pages/login_page.dart';
import 'package:music/core/widgets/custom_form_field.dart';
import 'package:music/features/auth/view/widgets/gradinet_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/features/auth/viewmodel/auth_viewmodel.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
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
    final isLoading = ref
        .watch(authViewmodelProvider.select((val) => val?.isLoading == true));
    ref.listen(authViewmodelProvider, (_, next) {
      next?.when(
          data: (data) {
            showSnackBar(context, 'Account Created Successfuly! Please Login.');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const LoginPage(),
              ),
            );
          },
          error: (error, st) {
            showSnackBar(context, error.toString());
          },
          loading: () {});
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
                      const Text(
                        'Sign Up.',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomFormField(
                        hintText: 'Name',
                        controller: nameContorller,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomFormField(
                        hintText: 'Email',
                        controller: emailContorller,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomFormField(
                        hintText: 'Password',
                        controller: passwordContorller,
                        isObsecure: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GradinetButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await ref.read(authViewmodelProvider.notifier).signUp(
                                name: nameContorller.text,
                                email: emailContorller.text,
                                password: passwordContorller.text);
                          } else {
                            showSnackBar(context, 'Missing Fields');
                          }
                        },
                        buttonText: 'Sign Up',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginPage(),
                            ),
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
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
