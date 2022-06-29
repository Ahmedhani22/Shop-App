import 'package:flutter/material.dart';
import 'package:flutter2/modules/counter_app/counter/cubit/cubit.dart';
import 'package:flutter2/modules/counter_app/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// state less contain one class provide widget

// state ful contain  classes

// 1. first class provide widget
// 2. second class provide state from this widget

class CounterScreen extends StatelessWidget {
  // 1. constructor
  // 2. init state
  // 3. build

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state)
        {
          if (state is CounterMinusState)
            {
              print('miuns state ${state.Counter}');
            }
          if (state is CounterPlusState)
          {
            print('plus state ${state.Counter}');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Counter',
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).minus();
                    },
                    child: Text(
                      'MINUS',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Text(
                      '${CounterCubit.get(context).Counter}',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).plus();
                    },
                    child: Text(
                      'PLUS',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
