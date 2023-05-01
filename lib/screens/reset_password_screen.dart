
import 'package:ellancer_api/api/controller/auth_api_controller.dart';
import 'package:ellancer_api/helpers/helpers.dart';
import 'package:ellancer_api/widgtes/app_text_fiels.dart';
import 'package:ellancer_api/widgtes/code_text_field.dart';
import 'package:flutter/material.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key , required  this.email}) : super(key: key);
  final String email;


  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>  with Helpers {

  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController firstCodeController;
  late TextEditingController secondCodeController;
  late TextEditingController thirdCodeController;
  late TextEditingController fourthCodeController;
  late FocusNode firstNode;
  late FocusNode secondNode;
  late FocusNode thirdNode;
  late FocusNode fourthNode;
  bool obSecurePassword = true;



  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    firstCodeController = TextEditingController();
    secondCodeController = TextEditingController();
    thirdCodeController = TextEditingController();
    fourthCodeController = TextEditingController();
    firstNode = FocusNode();
    secondNode = FocusNode();
    thirdNode = FocusNode();
    fourthNode = FocusNode();

  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    firstCodeController.dispose();
    secondCodeController.dispose();
    thirdCodeController.dispose();
    fourthCodeController.dispose();
    firstNode.dispose();
    secondNode.dispose();
    thirdNode.dispose();
    fourthNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const  Text('Reset password'),),
      body: ListView(
        padding:const  EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        children: [
          const  Text('Enter new Password...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
          const SizedBox(height: 5,),
          const  Text('Enter new password and received code',style: TextStyle(color: Colors.grey,fontSize: 18),),
          const SizedBox(height: 20,),
          Row(
            children: [
              Expanded(child:CodeTextField(controller: firstCodeController, node: firstNode, onChanged: (value) {
                if(value.isNotEmpty){
                  secondNode.requestFocus();
                }
              })),
              const SizedBox(width: 5,),
              Expanded(child:CodeTextField(controller: secondCodeController, node: secondNode, onChanged: (value) {
                value.isNotEmpty
                    ?thirdNode.requestFocus()
                    :firstNode.requestFocus();
              })),
              const SizedBox(width: 5,),
              Expanded(child:CodeTextField(controller: thirdCodeController, node: thirdNode, onChanged: (value) {
                value.isNotEmpty
                    ?fourthNode.requestFocus()
                    :secondNode.requestFocus();
              })),
              const SizedBox(width: 5,),
              Expanded(child:CodeTextField(controller: fourthCodeController, node: fourthNode, onChanged: (value) {
                if(value.isEmpty){
                  thirdNode.requestFocus();
                }
              })),
              const SizedBox(width: 5,),
            ],
          ),
          const SizedBox(height: 20,),
          AppTextField(
            onPressedSuffix: (){
              setState(() {
                obSecurePassword =! obSecurePassword;
              });
            } ,
            suffixIcon:obSecurePassword?Icons.visibility_off:Icons.visibility ,
            controller: newPasswordController,
            prefixIcon: Icons.lock,
            hint: 'New Password',
            type: TextInputType.visiblePassword,
            obscures: obSecurePassword,
          ),
          const SizedBox(height: 20,),
          AppTextField(
            onPressedSuffix: (){
              setState(() {
                obSecurePassword =! obSecurePassword;
              });
            } ,
            suffixIcon:obSecurePassword?Icons.visibility_off:Icons.visibility ,
            controller: confirmPasswordController,
            prefixIcon: Icons.lock,
            hint: 'Confirm Password',
            type: TextInputType.visiblePassword,
            obscures: obSecurePassword,
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
                await performResetPassword();
              },
              child: const Text('Send',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)),
        ],
      ),
    );
  }




  Future<void> performResetPassword()async{
    if(checkData()){
      await resetPassword();
    }
  }

  bool checkPassword(){
    if(
    newPasswordController.text.isNotEmpty
        && confirmPasswordController.text.isNotEmpty
    ){
      return true;
    }else {
      showSnackBar(context: context, message: 'Enter Required Password!',error: true);
      return false;
    }
  }

  bool checkCode(){
    if(
    firstCodeController.text.isNotEmpty
        && secondCodeController.text.isNotEmpty
        && thirdCodeController.text.isNotEmpty
        && fourthCodeController.text.isNotEmpty
    ){
      return true;
    }else {
      showSnackBar(context: context, message: 'Enter Required Code!',error: true);
      return false;
    }
  }


  bool checkData(){
    if(checkCode() && checkPassword()){
      return true;
    }
      return false;
  }

  String get code => "${firstCodeController.text}${secondCodeController.text}${thirdCodeController.text}${fourthCodeController.text}";
  Future<void> resetPassword ()async{
    bool status =  await AuthApiController().resetPassword(context: context, email: widget.email, code: code, newPassword: newPasswordController.text, confirmPassword: confirmPasswordController.text);
    if(status) Navigator.pushReplacementNamed(context, '/login_screen');
  }
}


