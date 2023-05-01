import 'package:ellancer_api/prefs/pref_controller.dart';
import 'package:ellancer_api/screens/categories_screen.dart';
import 'package:ellancer_api/screens/forget_password_screen.dart';
import 'package:ellancer_api/screens/launch_screen.dart';
import 'package:ellancer_api/screens/login_screen.dart';
import 'package:ellancer_api/screens/register_screen.dart';
import 'package:ellancer_api/screens/users_screen.dart';
import 'package:flutter/material.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initShared();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      routes: {
        '/users_screen': (context) =>UsersScreen(),
        '/categories_screen': (context) =>CategoriesScreen(),
        '/launch_screen': (context) =>LaunchScreen(),
        '/login_screen': (context) =>LoginScreen(),
        '/register_screen': (context) =>RegisterScreen(),
        '/forget_password_screen': (context) =>ForgetPassword(),
      },
    );
  }
}
