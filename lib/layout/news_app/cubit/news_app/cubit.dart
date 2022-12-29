


import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../modules/business/business_screen.dart';
import '../../../../modules/science/science_screen.dart';
import '../../../../modules/sports/sport_screen.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../states.dart';

class NewsCubit extends Cubit<NewsStates>
{

  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;

  List<BottomNavigationBarItem>bottomItems=
  [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center),label: 'business'),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),label: 'sport'),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),label: 'science'),


  ];
void ChangeBottomNavBar(int index){
  currentIndex=index;
  if (index==1){getSports();}
  if(index==2){getScience();}

  emit(NewsBottomNewState());
}
List<Widget>screens=[
  BusinessScreen(),
  SportScreen(),
  ScienceScreen(),

];
List<dynamic>business=[];
  List<dynamic>sport=[];
  List<dynamic>science=[];
void getBusiness(){
  emit(NewGetBusinessLoadingState());
  DioHelper.getData(url: 'v2/top-headlines', query: {
    'country': 'eg',
    'category': 'business',
    'apiKey': '05d4aa8f2fa44933912a8195644e8a83'
  }).then((value) {
    business= value.data['articles'];
    print(business[0]['title']);
    emit(NewsGetBusinessSuccessState());
  }).catchError((error){
    emit(NewsGetBusinessErrorState(error.toString()));
    print(error.toString());
  }
  );
}
  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sport.length==0){
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '05d4aa8f2fa44933912a8195644e8a83'
      }).then((value) {
        sport= value.data['articles'];
        print(sport[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        emit(NewsGetSportsErrorState(error.toString()));
        print(error.toString());
      }
      );
    }
    else {
      emit(NewsGetSportsSuccessState());
    }

  }
  void getScience(){
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': '05d4aa8f2fa44933912a8195644e8a83'
    }).then((value) {
      science= value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      emit(NewsGetScienceErrorState(error.toString()));
      print(error.toString());
    }
    );

  }


}

