class CommonState {}

class CommonInitialState extends CommonState {}

class CommonLoadingState extends CommonState {
  final bool showLoading;

  CommonLoadingState({this.showLoading = true});
}

class CommonSucessState<Type> extends CommonState {
  final Type data;

  CommonSucessState({required this.data});
}

class CommonErrorState extends CommonState {
  final String message;

  CommonErrorState({required this.message});
}
