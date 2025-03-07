

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:home_ease/core/networking/remote/api_service.dart';
import 'package:home_ease/core/networking/remote/dio_factory.dart';
import 'package:home_ease/features/auth/login/logic/login_cubit.dart';
import 'package:home_ease/features/auth/login/data/repo/login_repo.dart';
import 'package:home_ease/features/auth/register/data/repos/register_repo.dart';
import 'package:home_ease/features/auth/register/logic/register_cubit.dart';


final getIt = GetIt.instance;

Future <void> setupGetIt() async{
  // Dio & ApiService


  Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));


 //login
    getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
    getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  //Register
    getIt.registerLazySingleton<RegisterRepo>(() => RegisterRepo(getIt()));
    getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));




    // getIt.registerLazySingleton<ForGetPasswordRepo>(() => ForGetPasswordRepo(getIt()));
    // getIt.registerFactory<ResetpasswordCubit>(() => ResetpasswordCubit(getIt()));


    // getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));



    

}