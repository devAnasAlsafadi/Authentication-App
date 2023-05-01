
import 'package:ellancer_api/api/controller/auth_api_controller.dart';
import 'package:ellancer_api/helpers/helpers.dart';
import 'package:ellancer_api/models/student.dart';
import 'package:ellancer_api/widgtes/app_text_fiels.dart';
import 'package:flutter/material.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>  with Helpers{

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController fullNameController;
   String _gender = 'M';

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fullNameController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const  Text('Register'),),
      body: ListView(
        padding:const  EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        children: [
          const  Text('Create new account...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
          const SizedBox(height: 5,),
          const  Text('Enter details below',style: TextStyle(color: Colors.grey,fontSize: 18),),
          const SizedBox(height: 40,),
          AppTextField(
            controller: fullNameController,
            prefixIcon: Icons.person,
            hint: 'Full Name',
            type: TextInputType.text,
          ),
          const SizedBox(height: 20,),
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
          const SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Male'),
                    contentPadding: EdgeInsets.zero,
                    value: 'M',
                    groupValue: _gender,
                    onChanged: (value) {
                      if(value != null){
                        setState(() {
                          _gender = value;
                        });
                      }
                    },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Female'),
                  contentPadding: EdgeInsets.zero,
                  value: 'F',
                  groupValue: _gender,
                  onChanged: (value) {
                    if(value != null){
                      setState(() {
                        _gender = value;
                      });
                    }
                  },
                ),
              )

            ],
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
               await perFormRegister();
              },
              child: const Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)),
          const SizedBox(height: 10,),

        ],
      ),
    );
  }

  Future<void> perFormRegister() async {
    if(checkData()){
      await register();
    }
  }
  bool checkData(){
    if(emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
             fullNameController.text.isNotEmpty &&
                _gender.isNotEmpty){
      return true;
    }else{
      showSnackBar(context: context, message: 'Enter Required Data!',error: true);
      return false;
    }
  }

  Student get student{
    Student s = Student();
    s.fullName = fullNameController.text;
    s.email = emailController.text;
    s.password = passwordController.text;
    s.gender = _gender;
    return s;
  }

  Future<void> register()async {
    bool status = await AuthApiController().register(context: context, student: student);
    if(status) Navigator.pop(context);
  }

}

