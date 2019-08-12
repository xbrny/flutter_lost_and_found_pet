import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/api/abstract_user_api.dart';
import 'package:lost_found_pet_prototype/router.dart';
import 'package:lost_found_pet_prototype/service_locator.dart';
import 'package:lost_found_pet_prototype/theme/brand_theme.dart';
import 'package:lost_found_pet_prototype/view_model/auth_model.dart';
import 'package:lost_found_pet_prototype/view_model/navigation_model.dart';
import 'package:lost_found_pet_prototype/view_model/post_list_model.dart';
import 'package:lost_found_pet_prototype/view_model/post_model.dart';
import 'package:lost_found_pet_prototype/view_model/tab_model.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalNavigation>.value(
          value: GlobalNavigation(value: _navigatorKey),
        ),
        StreamProvider<FirebaseUser>.value(
          value: locator<AbstractUserApi>().authUser,
        ),
        Provider<AuthModel>(
          builder: (_) => locator<AuthModel>(),
        ),
        ChangeNotifierProvider<TabModel>(
          builder: (_) => locator<TabModel>(),
        ),
        ChangeNotifierProvider<FoundPostListModel>(
          builder: (_) => locator<FoundPostListModel>(),
        ),
        ChangeNotifierProvider<LostPostListModel>(
          builder: (_) => locator<LostPostListModel>(),
        ),
        ChangeNotifierProxyProvider<FirebaseUser, UserPostListModel>(
          builder: (_, firebaseUser, __) => locator<UserPostListModel>(),
        ),
        ChangeNotifierProvider<CreatePostModel>(
          builder: (_) => locator<CreatePostModel>(),
        ),
        ChangeNotifierProvider<SelectedPostModel>(
          builder: (_) => locator<SelectedPostModel>(),
        ),
      ],
      child: MaterialApp(
        theme: kBrandTheme,
        navigatorKey: _navigatorKey,
        initialRoute: Router.initialRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
