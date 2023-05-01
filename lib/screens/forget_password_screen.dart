import 'package:ellancer_api/api/controller/auth_api_controller.dart';
import 'package:ellancer_api/helpers/helpers.dart';
import 'package:ellancer_api/screens/reset_password_screen.dart';
import 'package:ellancer_api/widgtes/app_text_fiels.dart';
import 'package:flutter/material.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>  with Helpers {

  late TextEditingController emailController;


  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();

  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const  Text('Forget password'),),
      body: ListView(
        padding:const  EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        children: [
          const  Text('Forget Password...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
          const SizedBox(height: 5,),
          const  Text('Enter email to reset password',style: TextStyle(color: Colors.grey,fontSize: 18),),
          const SizedBox(height: 30,),
          AppTextField(
            controller: emailController,
            prefixIcon: Icons.email,
            hint: 'Email',
            type: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize:const  Size(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),

                ),
                elevation: 3,
              ),
              onPressed: ()async {
                await performForgetPassword();
              },
              child: const Text('Send',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)),
        ],
      ),
    );
  }



  Future<void> performForgetPassword()async{
    if(checkData()){
      await forgetPassword();
    }
  }

  bool checkData(){
    if(emailController.text.isNotEmpty){
      return true;
    }else{
      showSnackBar(context: context, message: 'Enter Required Data!',error: true);
      return false;
    }
  }

  Future<void> forgetPassword ()async{
    bool status =  await AuthApiController().forgetPassword(context: context, email: emailController.text);
    if(status) Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => ResetPassword(email: emailController.text,)));
  }
}

