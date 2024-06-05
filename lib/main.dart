import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_promina_task/controller/cubit.dart';
import 'package:flutter_promina_task/controller/my_bloc_observer.dart';
import 'package:flutter_promina_task/controller/states.dart';
import 'package:flutter_promina_task/view/home_screen.dart';
import 'package:flutter_promina_task/view/login_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProminaCubit()..checkAuthentication(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Promina Task',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: BlocBuilder<ProminaCubit, ProminaStates>(
          builder: (context, state) {
            if (state is AuthSuccessState) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
