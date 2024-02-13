import 'resource_homepage_state.dart';

class HomeErrorState extends ResourceHomePageState {
  final int errorCode;
  final String? errorMessage;
  const HomeErrorState(
      {required super.event, required this.errorCode, this.errorMessage});
}
