import 'package:ellancer_api/prefs/pref_controller.dart';
import 'package:flutter/material.dart';
class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}



class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    String route = SharedPrefController().loggedIn?'/categories_screen':'/login_screen';
    Future.delayed(const Duration(seconds: 3),() => Navigator.pushReplacementNamed(context, route),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors:[
              Colors.blue.shade800,
              Colors.orange.shade400,
            ]
          ),
        ),
        child: const Text('Api App',style:TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 22),),
      ),
    );
  }
}
