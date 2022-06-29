import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:flutter2/layout/shop_app/cubit/states.dart';
import 'package:flutter2/shared/component/components.dart';
import 'package:flutter2/shared/component/constance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // if(state is ShopSuccessUserDataState)
        //   {
        //     nameController.text = state.loginModel.data!.name!;
        //     emailController.text = state.loginModel.data!.email!;
        //     phoneController.text = state.loginModel.data!.phone!;
        //   }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilderRec(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdataUserState)
                      LinearProgressIndicator(),
                      SizedBox(height: 20.0,),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return ' name must not be empty ';
                          }
                        },
                        label: 'Name',
                        prefix: Icons.person,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return ' email must not be empty ';
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return ' phone must not be empty ';
                          }
                        },
                        label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                          function: () {
                            if(formKey.currentState!.validate())
                              {
                                ShopCubit.get(context).getUpdataUser(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                );
                              }

                          },
                          text: 'Updata'),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                          function: () {
                            SignOut(context);
                          },
                          text: 'LogOut'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
