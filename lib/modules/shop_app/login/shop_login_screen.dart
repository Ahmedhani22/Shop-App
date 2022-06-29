import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/layout/shop_app/shop_app_layout.dart';
import 'package:flutter2/modules/shop_app/cubit/cubit.dart';
import 'package:flutter2/modules/shop_app/cubit/states.dart';
import 'package:flutter2/modules/shop_app/register/shopregister_screen.dart';

import 'package:flutter2/shared/component/components.dart';
import 'package:flutter2/shared/component/constance.dart';
import 'package:flutter2/shared/network/local/cash_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {

              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value)
              {
                token = state.loginModel.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              ShowToast(
                text:state.loginModel.message!, state:TostStates.ERROR,
              );

            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: EmailController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'email address must be not empty';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultFormField(
                          controller: PasswordController,
                          type: TextInputType.visiblePassword,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'password must be not empty';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: ShopLoginCubit.get(context).suffix,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          Sufixpress: () {
                            ShopLoginCubit.get(context)
                                .ShopChangePasswordVisibility();
                          },
                          onSubmit: () {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: EmailController.text,
                                password: PasswordController.text,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilderRec(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: EmailController.text,
                                  password: PasswordController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account ?',
                            ),
                            defaultTextButton(
                                press: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                text: 'register')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}