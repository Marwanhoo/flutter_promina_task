import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_promina_task/controller/states.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProminaCubit extends Cubit<ProminaStates> {
  ProminaCubit() : super(ProminaInitialState());

  Future<void> login(String email, String password) async {
    emit(AuthLoadingState());
    try {
      final response = await http.post(
        Uri.parse('https://flutter.prominaagency.com/api/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print("==========");
        print("json Data $jsonData");
        print("==========");
        final String token = jsonData['token'];
        await saveToken(token);
        emit(AuthSuccessState());
      } else {
        emit(AuthErrorState("Failed to authenticate"));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  Future<void> checkAuthentication()async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if(token != null){
      emit(AuthSuccessState());
    }else{
      emit(ProminaInitialState());
    }

  }


  Future<void> logout()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("authToken");
    emit(ProminaInitialState());
  }

}
