import 'dart:convert';
import 'dart:io';

import 'package:ellancer_api/api/api_settings.dart';
import 'package:ellancer_api/helpers/helpers.dart';
import 'package:ellancer_api/models/student.dart';
import 'package:ellancer_api/prefs/pref_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthApiController with Helpers{
  Future<bool> register({required BuildContext context ,required Student student})async{
    var url = Uri.parse(ApiSettings.register);
    var response = await http.post(url,body: {
      "email":student.email,
      "full_name":student.fullName,
      "password":student.password,
      "gender":student.gender,
    });

    if(response.statusCode == 201){
      String message = jsonDecode(response.body)['message'];
      showSnackBar(context: context, message: message);
      return true;
    }else if(response.statusCode == 400){
      String message = jsonDecode(response.body)['message'];
      showSnackBar(context: context, message: message,error: true);
    }
    return false;

  }

  Future<bool> login({required BuildContext context , required String email , required String password})async{
    var url = Uri.parse(ApiSettings.login);
    var response = await http.post(url,body: {
      "email":email,
      "password":password
    });
    if(response.statusCode==200){
      var jsonObject = jsonDecode(response.body)["object"];
      Student student = Student.fromJson(jsonObject);
      SharedPrefController().save(student:student);
      showSnackBar(context: context, message: jsonDecode(response.body)['message']);
      return true;
    }else{
      showSnackBar(context: context, message: jsonDecode(response.body)['message'],error: true);
    }
    return false;
  }







  Future<bool> logout ({required BuildContext context})async{
    var url =Uri.parse(ApiSettings.logout);
    var response  = await http.get(url,headers: {
      HttpHeaders.authorizationHeader:SharedPrefController().token,
      HttpHeaders.acceptHeader:"application/json"
    });
    if(response.statusCode == 200 || response.statusCode == 401){
      SharedPrefController().clear();
      if(response.statusCode == 200){
        showSnackBar(context: context, message: jsonDecode(response.body)['message']);
      }
      return true;
    }else{
      // showSnackBar(context: context, message: jsonDecode(response.body)['message'],error: true);
      return false;
    }
  }


  Future<bool> forgetPassword({required BuildContext context , required String email})async{
    var url = Uri.parse(ApiSettings.forgetPassword);
    var response = await http.post(url,body: {
      "email":email
    });
    if(response.statusCode == 200){
      showSnackBar(context: context, message: jsonDecode(response.body)["message"]);
      return true;
    }else{
      showSnackBar(context: context, message: jsonDecode(response.body)["message"],error:true);
      return false;
    }
  }

  Future<bool> resetPassword({
  required BuildContext context,
  required String email,
  required String code,
  required String newPassword,
  required String confirmPassword,
})async{
    var url = Uri.parse(ApiSettings.resetPassword);
    var response = await http.post(url,body: {
      "email":email,
      "code":code,
      "password":newPassword,
      "password_confirmation":confirmPassword
    });
    if(response.statusCode == 200){
      String message  = jsonDecode(response.body)["message"];
      showSnackBar(context: context, message:message);
      return true;
    }else if (response.statusCode == 400){
      String message  = jsonDecode(response.body)["message"];
      showSnackBar(context: context, message:message,error: true);
    }else{
      showSnackBar(context: context, message:'somethings Went Wrong!',error: true);
    }
    return false;

  }

}