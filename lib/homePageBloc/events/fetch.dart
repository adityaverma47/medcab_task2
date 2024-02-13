import 'resource_homepage_even.dart';

class FetchEvent extends ResourceHomepageEvent {
  final int count;
  const FetchEvent({required this.count});

  @override
  List<Object> get props => [count];
}
