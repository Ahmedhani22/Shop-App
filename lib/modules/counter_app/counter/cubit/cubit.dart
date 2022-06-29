

import 'package:bloc/bloc.dart';
import 'package:flutter2/modules/counter_app/counter/cubit/states.dart';




import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super(CounterInitialState());

 static CounterCubit get(context)=> BlocProvider.of(context);
 int Counter =1;

  void minus(){
    Counter--;
    emit(CounterMinusState(Counter));
  }
  void plus(){
    Counter++;
    emit(CounterPlusState(Counter));
  }

}
