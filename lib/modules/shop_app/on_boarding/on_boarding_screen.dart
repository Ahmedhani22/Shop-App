import 'package:flutter/material.dart';
import 'package:flutter2/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter2/shared/component/components.dart';
import 'package:flutter2/shared/network/local/cash_helper.dart';
import 'package:flutter2/shared/style/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/shop3.jpg',
      title: 'onboarding 1 title',
      body: 'onboarding 1 body',
    ),
    BoardingModel(
      image: 'assets/images/shop2.png',
      title: 'onboarding 2 title',
      body: 'onboarding 2 body',
    ),
    BoardingModel(
      image: 'assets/images/shop.jpg',
      title: 'onboarding 3 title',
      body: 'onboarding 3 body',
    ),
  ];
  bool isLast = false;
  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value)
        {
          navigateAndFinish(context, ShopLoginScreen());
        }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(
                press: submit,
                text: 'Skip'),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: boardController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoargingItems(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      spacing: 5.0,
                      expansionFactor: 4,
                      activeDotColor: defaultColor,
                    ),
                    controller: boardController,
                    count: boarding.length,
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();

                      } else {
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildBoargingItems(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text('${model.title}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              )),
          SizedBox(
            height: 15.0,
          ),
          Text('${model.body}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              )),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
