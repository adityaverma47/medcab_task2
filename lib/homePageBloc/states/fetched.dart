import '../../dataModel/faq_data.dart';
import 'resource_homepage_state.dart';

class FetchedState extends ResourceHomePageState {
  final FaqData? response;
  final int count;
  const FetchedState(
      {this.response, required super.event, required this.count});
}
