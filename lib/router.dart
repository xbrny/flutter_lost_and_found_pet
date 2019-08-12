import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/screen/home_screen.dart';
import 'package:lost_found_pet_prototype/screen/post_create_screen.dart';
import 'package:lost_found_pet_prototype/screen/post_details_screen.dart';
import 'package:lost_found_pet_prototype/screen/user_login_screen.dart';
import 'package:lost_found_pet_prototype/screen/user_profile_screen.dart';
import 'package:lost_found_pet_prototype/screen/user_register_screen.dart';
import 'package:lost_found_pet_prototype/view_model/login_model.dart';
import 'package:lost_found_pet_prototype/view_model/register_model.dart';
import 'package:provider/provider.dart';

class Router {
  static const home = 'home';
  static const lostPostList = 'lost-pet-list';
  static const foundPostList = 'found-pet-list';
  static const postCreate = 'post-create';
  static const postDetails = 'post-details';
  static const userProfile = 'user-profile';
  static const userLogin = 'user-login';
  static const userRegister = 'user-register';

  static const initialRoute = home;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) {
        switch (settings.name) {
          case home:
            return HomeScreen();
          case postCreate:
            return PostCreateScreen();
          case postDetails:
            return PostDetailsScreen();
          case userProfile:
            return UserProfileScreen();
          case userLogin:
            return ChangeNotifierProvider(
              builder: (_) => LoginModel(),
              child: UserLoginScreen(),
            );
          case userRegister:
            return ChangeNotifierProvider(
              builder: (_) => RegisterModel(),
              child: UserRegisterScreen(),
            );
          default:
            return Scaffold(
              body: Center(
                child: Text('Page not found'),
              ),
            );
        }
      },
    );
  }
}
