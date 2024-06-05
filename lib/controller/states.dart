abstract class ProminaStates{}
class ProminaInitialState extends ProminaStates{}
class AuthLoadingState extends ProminaStates{}
class AuthSuccessState extends ProminaStates{}
class AuthErrorState extends ProminaStates{
  final String error;

  AuthErrorState(this.error);
}

class GalleryLoadingState extends ProminaStates{}
class GalleryLoadedState extends ProminaStates {
  final List<String> images;

  GalleryLoadedState(this.images);
}
class GalleryErrorState extends ProminaStates {
  final String error;

  GalleryErrorState(this.error);
}

class UploadLoadingState extends ProminaStates {}
class UploadSuccessState extends ProminaStates {}
class UploadErrorState extends ProminaStates {
  final String error;

  UploadErrorState(this.error);
}