import 'package:equatable/equatable.dart';

import '../events/resource_homepage_even.dart';

abstract class ResourceHomePageState extends Equatable {
  final ResourceHomepageEvent event;

  const ResourceHomePageState({required this.event});

  @override
  List<Object> get props => [event];
}
