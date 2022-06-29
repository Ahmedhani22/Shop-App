import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/modules/shop_app/register/cubit.dart';
import 'package:flutter2/modules/shop_app/register/states.dart';
import 'package:flutter2/shared/component/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/shop_app_layout.dart';
import '../../../shared/component/constance.dart';
import '../../../shared/network/local/cash_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context, state)
        {
          if (state is ShopRegisterSuccessState) {
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
        builder: (context, state)
        {
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
                          'Register',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'name  must be not empty';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),

                        SizedBox(
                          height: 10.0,
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
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          Sufixpress: () {
                            ShopRegisterCubit.get(context).ShopChangePasswordVisibility();
                          },
                          onSubmit: () {

                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'phone must be not empty';
                            }
                          },
                          label: 'phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilderRec(
                          condition: state is !ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: EmailController.text,
                                  password: PasswordController.text,
                                  phone: phoneController.text
                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
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
