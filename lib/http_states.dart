
/// http states for the app
abstract class HttpState {}

class InitialState extends HttpState {}

class LoadingState extends HttpState {}

class LocalErrorState extends HttpState {}

class SuccessState extends HttpState {}