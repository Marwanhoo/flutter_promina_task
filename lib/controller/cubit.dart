import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_promina_task/controller/states.dart';
import 'package:flutter_promina_task/model/global_user.dart';
import 'package:flutter_promina_task/model/user_model.dart';
import 'package:flutter_promina_task/view/gallery_photo_view_wrapper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

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
        UserModel user = UserModel.fromJson(jsonData);
        GlobalUser.userModel = user;
        await saveToken(user.token);
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

  Future<void> fetchGallery()async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null) {
      emit(AuthErrorState("No authentication token found"));
      return;
    }
    
    emit(GalleryLoadingState());
    try{
      final response = await http.get(
        Uri.parse("https://flutter.prominaagency.com/api/my-gallery"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200){
        final jsonData = json.decode(response.body);
        final List<String> images = List<String>.from(jsonData['data']['images']);
        emit(GalleryLoadedState(images));
      }else{
        emit(GalleryErrorState("Failed to fetch gallery"));
      }
    }catch (e){
      emit(GalleryErrorState(e.toString()));
    }
  }

  Future<void> uploadImage (File image)async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      emit(AuthErrorState("No authentication token found"));
      return;
    }

    try{
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://flutter.prominaagency.com/api/upload'),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath('img', image.path));
      final response = await request.send();
      if(response.statusCode == 200){
        emit(UploadSuccessState());
        fetchGallery();
      }else{
        emit(UploadErrorState("Failed to upload image"));
      }
    }catch (e){
      emit(UploadErrorState(e.toString()));
    }
  }

  Future<void> pickImage(ImageSource source)async{
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if(pickedFile != null){
      uploadImage(File(pickedFile.path));
    }
  }


  void openGallery(BuildContext context, int initialIndex, List<String> gallery) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => GalleryPhotoViewWrapper(
        galleryItems: gallery,
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        initialIndex: initialIndex,
      ),
    ));
  }


}
