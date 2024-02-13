import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dataModel/faq_item.dart';
import 'homePageBloc/events/fetch.dart';
import 'homePageBloc/home_page_bloc.dart';
import 'homePageBloc/states/error.dart';
import 'homePageBloc/states/fetched.dart';
import 'homePageBloc/states/fetching.dart';
import 'homePageBloc/states/initial.dart';
import 'homePageBloc/states/resource_homepage_state.dart';

class HomePageListView extends StatefulWidget {
  final int numberOfModel;
  final HomeBloc bloc;
  HomePageListView(
      {super.key, required this.numberOfModel, required this.bloc});
  final ScrollController itemScrollController = ScrollController();
  final List<FaqItem> objects = [];

  void reset() {
    // Clear objects
    objects.clear();
    // Request starting page again
    bloc.add(const FetchEvent(
      count: 1,
    ));
  }

  @override
  State<HomePageListView> createState() => _HomePageListViewState();
}

class ItemScrollController {}

class _HomePageListViewState extends State<HomePageListView> {
  bool modelBuildsInProgress = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.bloc
        ..add(const FetchEvent(
          count: 1,
        )),
      child: BlocListener<HomeBloc, ResourceHomePageState>(
        listener: (context, state) {
          if (state is HomeErrorState) {
            print('something went wrong while listning event ${state.event}');
          }
        },
        child: BlocBuilder<HomeBloc, ResourceHomePageState>(
            builder: blocStateBuilder),
      ),
    );
  }

  Widget blocStateBuilder(context, state) {
    if (state is InitialHomeState) {
      return loadingWidget();
    } else if (state is FetchingState) {
      return loadingWidget();
    } else if (state is FetchedState && state.response != null) {
      widget.objects.addAll(state.response!.faqList);
    }
    if (widget.objects.isEmpty) {
      return noItemFoundBuilder(context);
    }
    return ListView.builder(
      controller: widget.itemScrollController,
      itemCount: widget.objects.length,
      itemBuilder: (context, index) =>
          itemBuilder(context, index, widget.objects[index]),
    );
  }

  Widget loadingWidget() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurpleAccent,
          ),
        )
      ],
    );
  }

  Widget noItemFoundBuilder(context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Text('No item Found for home page')],
    );
  }

  Widget itemBuilder(BuildContext context, int index, FaqItem data) {
    return ListTile(
      leading: const Icon(Icons.question_answer_rounded),
      title: Text(
        data.header,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        data.description,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
      ),
    );
  }
}
