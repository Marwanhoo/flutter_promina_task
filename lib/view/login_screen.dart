import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_promina_task/controller/cubit.dart';
import 'package:flutter_promina_task/controller/states.dart';
import 'package:flutter_promina_task/core/widgets/text_form_field_widget.dart';
import 'package:flutter_promina_task/view/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController(text: 'shields.kobe@example.net');
    TextEditingController passwordController = TextEditingController(text: 'password');
    return BlocConsumer<ProminaCubit, ProminaStates>(
      listener: (context, state) {
        if(state is AuthSuccessState){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const HomeScreen()));
        }else if (state is AuthErrorState){
          //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Check User Name OR Password")));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1564951434112-64d74cc2a2d7?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    "My \n Gellary",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      height: 0.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 35),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: Column(
                            children: [
                              const Text(
                                "LOG IN",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              const SizedBox(height: 30),
                              TextFormFieldWidget(controller: usernameController, hintText: "User Name"),
                              const SizedBox(height: 30),
                              TextFormFieldWidget(controller: passwordController, hintText: "Password"),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff7bb3ff),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () {
                                  BlocProvider.of<ProminaCubit>(context).login(usernameController.text, passwordController.text);
                                },
                                child: state is AuthLoadingState
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        "SUBMIT",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
