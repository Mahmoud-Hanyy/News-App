import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazaaf/modules/news/business/business_screen.dart';
import 'package:wazaaf/modules/news/cubit/states.dart';
import 'package:wazaaf/modules/news/science/science_screen.dart';
import 'package:wazaaf/modules/news/sport/sport_screen.dart';
import 'package:wazaaf/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems=[
    const BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Business'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Science'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: 'Sports'
    ),
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    if(index == 1) getScience();
    if(index == 2) getSports();
    emit(NewsBottomNavState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    const ScienceScreen(),
    const SportScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> science = [];
  List<dynamic> sports = [];
  List<dynamic> search = [];

  void getBusiness(){
    {
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'business',
          'apiKey':'c40229a5da4142ca88648f9a0180684a',
        },).then((value) {
      business = value?.data['articles'];
      emit(NewsGetBusinessSuccessState());
      },).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }
  }

  void getScience(){
    {
      emit(NewsGetScienceLoadingState());
      if(science.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'science',
          'apiKey':'c40229a5da4142ca88648f9a0180684a',
        },).then((value) {
        science = value?.data['articles'];
      },).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
        emit(NewsGetScienceSuccessState());
      }
    }
  }

  void getSports(){
    {
      emit(NewsGetSportsLoadingState());
      if(sports.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'sport',
          'apiKey':'c40229a5da4142ca88648f9a0180684a',
        },).then((value) {
        sports = value?.data['articles'];
      },).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
        emit(NewsGetSportsSuccessState());
      }
    }
  }

  void getSearch(String value){
    {
      emit(NewsGetSearchSuccessState());

      search = [];

      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'tesla',
          'apiKey':'c40229a5da4142ca88648f9a0180684a',
        },).then((value) {
        search = value?.data['articles'];
        emit(NewsGetSearchSuccessState());
      },).catchError((error){
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
      }
    }
  }