import 'package:flutter/material.dart';
import 'package:music/core/theme/app_pallete.dart';
import 'package:music/core/utils.dart';
import 'package:music/core/widgets/loader.dart';
import 'package:music/features/auth/view/pages/signup_page.dart';
import 'package:music/core/widgets/custom_form_field.dart';
import 'package:music/features/auth/view/widgets/gradinet_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:music/features/home/view/pages/home_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

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
    final isLoading = ref.watch(authViewmodelProvider.select(
        (val) => val?.isLoading == true
      )
    );

    ref.listen(
      authViewmodelProvider,
      (_,next){
        next?.when(
          data: (data){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
              (_) => false
            );
          }, 
          error: (error, st){
            showSnackBar(
              context, 
              error.toString()
            );
          }, 
          loading: (){}
        );
      }
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
      ),
      body: isLoading ? const Loader() : SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
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
                    if(formKey.currentState!.validate()){
                      await ref.read(authViewmodelProvider.notifier).loginUser(
                        email: emailContorller.text, password: passwordContorller.text
                      );
                    } else {
                      showSnackBar(context, 'Missing Fields!');
                    }
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
                            color: Colors.greenAccent
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
      ),
    );
  }
}