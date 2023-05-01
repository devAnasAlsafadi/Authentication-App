import 'dart:convert';

import 'package:ellancer_api/api/api_settings.dart';
import 'package:ellancer_api/models/api_base_response.dart';
import 'package:ellancer_api/models/category.dart';
import 'package:ellancer_api/models/user.dart';
import 'package:http/http.dart' as http;
class UserApiController {


  Future<List<User>> getUsers() async{
    var url  = Uri.parse(ApiSettings.users);
    var response = await http.get(url);
    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      ApiBaseResponse apiBaseResponse = ApiBaseResponse.fromJson(jsonResponse);
      return apiBaseResponse.data;
    }else{
      //SHOW ERROR MESSAGE
    }
    return [];
  }


  Future<List<Category>> getCategories() async {
    var url = Uri.parse(ApiSettings.categories);
    var response = await http.get(url);
    if(response.statusCode == 200){
      var jsonObjectCategory = jsonDecode(response.body)['data'] as List;
      List<Category> list = jsonObjectCategory.map((e) => Category.fromJson(e)).toList();
      return list;
    }
    return [];
  }
}