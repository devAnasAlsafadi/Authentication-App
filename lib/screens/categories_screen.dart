import 'package:ellancer_api/api/controller/auth_api_controller.dart';
import 'package:ellancer_api/api/controller/user_api_controller.dart';
import 'package:ellancer_api/models/category.dart';
import 'package:flutter/material.dart';
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  List<Category> categories = [];
  late Future<List<Category>> _future;
  @override
  void initState() {
    super.initState();
    _future = UserApiController().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories'),
      actions: [
        IconButton(onPressed: ()async{

          await logout();
        }, icon:const  Icon(Icons.logout)),
      ],),
      body: FutureBuilder<List<Category>>(
        future: _future,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasData && snapshot.data!.isNotEmpty){
            categories = snapshot.data??[];
            return GridView.builder(
              padding:const  EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10
              ),
              itemBuilder: (context, index) {
                return Card(

                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(radius: 40,backgroundImage: NetworkImage(categories[index].image),),
                     const  SizedBox(height: 10,),
                      Text(categories[index].title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                    ],
                  ),);
              },
              itemCount: categories.length,
            );
          }else{
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                Icon(Icons.warning,size: 80,color: Colors.grey,),
                Text('NO DATA' ,style: TextStyle(color: Colors.grey,fontSize: 24,fontWeight: FontWeight.bold),)
                ],
              ),
            );
          }
        },
      )
    );
  }

  Future<void> logout()async {
    bool status = await AuthApiController().logout(context: context);
    if(status) Navigator.pushReplacementNamed(context, '/login_screen');
  }


}
