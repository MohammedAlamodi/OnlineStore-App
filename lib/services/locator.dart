
import "package:get_it/get_it.dart";
import 'package:market_app/controller/userController.dart';
import 'package:market_app/services/auth.dart';
import 'package:market_app/services/storage.dart';


final locator = GetIt.instance;

void setupServices(){
  locator.registerSingleton<Auth>(Auth());
  locator.registerSingleton<Storage>(Storage());
  locator.registerSingleton<UserController>(UserController());
}