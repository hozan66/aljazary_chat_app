import 'package:get_it/get_it.dart';
import '../../business_logic/chat_room_cubit/chat_room_cubit.dart';

// Service locator library
// registerLazySingleton creates the instance only in the first call on the object
// If it's necessary and it will be removed otherwise
// GetIt.instance or GetIt.I

// Create a get_it locator
final locator = GetIt.instance;

// Create a setupLocator() method and create our services
// Register all the services that you need
void setupLocator() {
  locator.registerLazySingleton(() => ChatRoomCubit());
  // locator.registerLazySingleton(() => NameOfClass());
}

// Usage of creating the object

// 1. NameOfClass get service => GetIt.I<NameOfClass>();
// 2. locator.get<NameOfClass>();
