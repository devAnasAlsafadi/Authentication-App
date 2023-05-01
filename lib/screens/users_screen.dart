import 'package:ellancer_api/api/controller/user_api_controller.dart';
import 'package:ellancer_api/models/user.dart';
import 'package:flutter/material.dart';
class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late Future<List<User>> _future;
  List<User> users  = [];

  @override
  void initState() {
    super.initState();
    _future = UserApiController().getUsers();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users'),),
      body: FutureBuilder<List<User>>(
        future: _future,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }else if (snapshot.hasData && snapshot.data!.isNotEmpty){
            users = snapshot.data??[];
            return ListView.separated(
              padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder:(context, index) {
                  return ListTile(
                      title: Text('${users[index].firstName} ${users[index].lastName}'),
                      subtitle: Text(users[index].email),
                      leading: CircleAvatar(radius: 40,backgroundImage: NetworkImage(users[index].image),)
                  );
                },
                separatorBuilder:(context, index) =>  Divider(color: Colors.grey[300],indent: 20,endIndent: 20,thickness: 0.5),
                itemCount: users.length);
          }else{
            return const Center(child: Text('No Data',style: TextStyle(color: Colors.grey,fontSize: 30),),);
          }
        },

      ),
    );
  }
}
