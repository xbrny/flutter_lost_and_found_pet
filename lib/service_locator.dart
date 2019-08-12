import 'package:get_it/get_it.dart';
import 'package:lost_found_pet_prototype/api/abstract_post_api.dart';
import 'package:lost_found_pet_prototype/api/abstract_user_api.dart';
import 'package:lost_found_pet_prototype/api/post_api.dart';
import 'package:lost_found_pet_prototype/api/user_api.dart';
import 'package:lost_found_pet_prototype/view_model/auth_model.dart';
import 'package:lost_found_pet_prototype/view_model/post_list_model.dart';
import 'package:lost_found_pet_prototype/view_model/post_model.dart';
import 'package:lost_found_pet_prototype/view_model/tab_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton<AbstractPostApi>(() => PostApi());
  locator.registerLazySingleton<AbstractUserApi>(() => UserApi());

  locator.registerLazySingleton(() => TabModel());
  locator.registerLazySingleton(() => FoundPostListModel());
  locator.registerLazySingleton(() => LostPostListModel());
  locator.registerLazySingleton(() => UserPostListModel());
  locator.registerLazySingleton(() => CreatePostModel());
  locator.registerLazySingleton(() => SelectedPostModel());
  locator.registerLazySingleton(() => AuthModel());
}
