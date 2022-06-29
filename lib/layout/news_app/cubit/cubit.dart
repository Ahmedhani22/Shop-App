import 'package:flutter/material.dart';
import 'package:flutter2/layout/news_app/cubit/states.dart';
import 'package:flutter2/modules/news_app/business/business_screen.dart';
import 'package:flutter2/modules/news_app/science/science_screen.dart';
import 'package:flutter2/modules/news_app/sport/sport_screen.dart';

import 'package:flutter2/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<BottomNavigationBarItem> BottomItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'sports',
    ),
  ];
  List<Widget> Screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportScreen(),
  ];

  void ChangeBottomNavBar(int index) {
    currentindex = index;
    if (index == 1) GetScience();
    if (index == 2) GetSports();
    emit(NewsBottomNavBarState());
  }

  List<dynamic> Business = [];

  void GetBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '7c0028f2201a43cda1d45e4e9f05092c',
    }).then((value) {
      // print(value.data['articles'][0]['title']);
      Business = value.data['articles'];
      print(Business[0]['title']);
      emit(NewsBusinessSuccessState());
    }).catchError((error) {
      print('error when get data${error.toString()}');
      emit(NewsBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> Science = [];

  void GetScience() {
    emit(NewsGetScienceLoadingState());
    if (Science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'Science',
        'apiKey': '7c0028f2201a43cda1d45e4e9f05092c',
      }).then((value) {
        // print(value.data['articles'][0]['title']);
        Science = value.data['articles'];
        print(Science[0]['title']);
        emit(NewsScienceSuccessState());
      }).catchError((error) {
        print('error when get data${error.toString()}');
        emit(NewsScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsScienceSuccessState());
    }
  }

  List<dynamic> Sports = [];

  void GetSports() {
    emit(NewsGetSportsLoadingState());
    if (Sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'Sports',
        'apiKey': '7c0028f2201a43cda1d45e4e9f05092c',
      }).then((value) {
        // print(value.data['articles'][0]['title']);
        Sports = value.data['articles'];
        print(Sports[0]['title']);
        emit(NewsSportsSuccessState());
      }).catchError((error) {
        print('error when get data${error.toString()}');
        emit(NewsSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsSportsSuccessState());
    }
  }

  List<dynamic> search = [];

  void GetSearch(String value) {
    search = [];
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': '7c0028f2201a43cda1d45e4e9f05092c',
    }).then((value) {
      //  print(value.data.toString());
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSearchErrorState(error.toString()));
    });
  }
}
