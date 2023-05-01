import 'package:ellancer_api/api/controller/auth_api_controller.dart';
import 'package:ellancer_api/helpers/helpers.dart';
import 'package:ellancer_api/models/student.dart';
import 'package:ellancer_api/widgtes/app_text_fiels.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  with Helpers {

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TapGestureRecognizer tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    tapGestureRecognizer = TapGestureRecognizer();
    tapGestureRecognizer.onTap = navigateToRegisterScreen;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const  Text('Login'),),
      body: ListView(
        padding:const  EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        children: [
         const  Text('Welcome...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
         const SizedBox(height: 5,),
         const  Text('Enter email && password',style: TextStyle(color: Colors.grey,fontSize: 18),),
          const SizedBox(height: 40,),
          AppTextField(
              controller: emailController,
              prefixIcon: Icons.email,
              hint: 'Email',
              type: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20,),
          AppTextField(
            controller: passwordController,
            prefixIcon: Icons.lock,
            hint: 'Password',
            type: TextInputType.visiblePassword,
            obscures: true,
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(

                onPressed: (){
                  Navigator.pushNamed(context, "/forget_password_screen");
                },
                child: Text('Forget Password!',style: TextStyle(color: Colors.blue,fontSize: 16),)
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
             style: ElevatedButton.styleFrom(
               minimumSize:const  Size(0, 50),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10),

               ),
               elevation: 3,
             ),
              onPressed: ()async {
               await performLogin();
              },
              child: const Text('Login',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)),
          const SizedBox(height: 10,),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Don\'t have an account? ',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),
              children: [
                TextSpan(
                  recognizer: tapGestureRecognizer,
                  text: 'Create Now!',
                  style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16)
                )
              ]
            ),

          ),


        ],
      ),
    );
  }

  void navigateToRegisterScreen(){
    Navigator.pushNamed(context, '/register_screen');
  }

  Future<void> performLogin()async{
    if(checkData()){
      await login();
    }
  }

  bool checkData(){
    if(emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty
        ){
      return true;
    }else{
      showSnackBar(context: context, message: 'Enter Required Data!',error: true);
      return false;
    }
  }

  Future<void> login ()async{
    bool status =  await AuthApiController().login(context: context, email: emailController.text, password: passwordController.text);
     if(status) Navigator.pushReplacementNamed(context, '/categories_screen');
  }
}

