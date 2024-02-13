import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../dataModel/faq_data.dart';
import 'events/fetch.dart';
import 'events/initial.dart';
import 'events/resource_homepage_even.dart';
import 'states/error.dart';
import 'states/fetched.dart';
import 'states/fetching.dart';
import 'states/initial.dart';
import 'states/resource_homepage_state.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends Bloc<ResourceHomepageEvent, ResourceHomePageState> {
  HomeBloc() : super(InitialHomeState(event: InitialHomeEvent())) {
    on(
      (event, emit) async {
        if (event is FetchEvent) {
          await fetchFaqList(event, emit);
        }
      },
    );
  }

  Future<void> fetchFaqList(
      FetchEvent event, Emitter<ResourceHomePageState> emit) async {
    try {
      emit(FetchingState(event: event));

      final response = await http.get(
          Uri.parse('https://dev.cabmed.in/api/app_data/rentTool/getFAQData'));
      if (response.statusCode != 200) {
        emit(HomeErrorState(
            event: event,
            errorCode: response.statusCode,
            errorMessage: 'IsNull or somthing went wrong in fetch data'));
      } else {
        final parseddata = FaqData.fromJson(json.decode(response.body));
        print('============ response is : ${json.decode(response.body)}');
        emit(FetchedState(
            event: event, response: parseddata, count: event.count));
      }
    } catch (e) {
      emit(HomeErrorState(
          event: event,
          errorCode: 404,
          errorMessage: 'Somethng went wromg on fetching data'));
    }
  }
}
