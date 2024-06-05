abstract class ProminaStates{}
class ProminaInitialState extends ProminaStates{}
class AuthLoadingState extends ProminaStates{}
class AuthSuccessState extends ProminaStates{}
class AuthErrorState extends ProminaStates{
  final String error;

  AuthErrorState(this.error);
}