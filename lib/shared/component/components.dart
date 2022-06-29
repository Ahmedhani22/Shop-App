import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:flutter2/modules/news_app/web-view/web_view_screen.dart';
import 'package:flutter2/shared/style/color.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/news_app/cubit/states.dart';

Widget defaultButton({
  required Function function,
  required String text,
  Color background = Colors.blue,
  double width = double.infinity,
  bool isUpperCase = true,
  double radius = 3.0,
}) =>
    Container(
        width: width,
        child: MaterialButton(
          onPressed: () {
            function();
          },
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(radius),
        ));

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  required FormFieldValidator<String> validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? Sufixpress,
  VoidCallback? OnTap,
  ValueChanged<String>? onChange,
  Function? onSubmit,
}) =>
    TextFormField(
      onTap: OnTap,
      onChanged: onChange,
      onFieldSubmitted: (value){
        onSubmit!();
      },
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  Sufixpress!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultTextButton({
  required Function press,
  required String text,
}) =>
    TextButton(
      onPressed:() {
        press();
      },
      child: Text(text.toUpperCase()),
    );

Widget buildTaskItems(Map model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text('${model['time']}'),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );

Widget MyDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticalTtems(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text('${article['title']}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                    Text(
                      "${article['publishedAt']}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articlebuilder(list, context, {isSearch = false}) =>
    ConditionalBuilderRec(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticalTtems(list[index], context),
          separatorBuilder: (context, index) => MyDivider(),
          itemCount: list.length),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (route) {
      return false;
    });
void ShowToast({required String text, required TostStates state }) =>
Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: ChooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);
enum TostStates {SUCCESS, ERROR, WARNING}

Color ? ChooseToastColor(TostStates state)
{
  Color color;
  switch(state)
  {
    case TostStates.SUCCESS :
      color = Colors.green;
      break;
    case TostStates.ERROR :
      color = Colors.red;
      break;
    case TostStates.WARNING :
      color = Colors.yellow;
      break;
  }
  return color;

}


Widget buildListProduct(model,context,{bool isOldPrice= true,}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(

      children: [
        Container(
          height: 120.0,
          width: 120.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage( model.image! ),
                width:120,
                height: 120.0,
                fit: BoxFit.cover,
              ),
              if (model.discount!= 0 && isOldPrice)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                )
            ],
          ),
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, height: 1.3),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      '${model.oldPrice}',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      ShopCubit.get(context).ChangeFavorites(model.id!);
                    },
                    icon: CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);


