import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/preference.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/mytext.dart';
import 'package:new_nabni_app/view/widgets/myimage.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  Preference sharePref = Preference.shared;

  List<String> introBigtext = <String>[
    "مرحباَ بك في نبني",
    "مرحباَ بك في نبني",
    "مرحباَ بك في نبني",
  ];

  List<String> introSmalltext = <String>[
    "تطبيق “نبني” يساعد المقاولين على إيجاد عمل\n ويساعد من لديه مشروع بناء",
    " يسهل عملية البناء على العميل ووضع الميزانية\n المناسبة له",
    "يساعد المورmدين في بيع مواد البناء\n",
  ];

  List<String> icons = <String>[
    ImageAsset.onBoardingImageOne,
    ImageAsset.onBoardingImageTwo,
    ImageAsset.onBoardingImageThree
  ];

  PageController pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);
  int pos = 0;

  _storeOnboardInfo() async {
    sharePref.setString(AppConstants.SEEN, "1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    child: PageView.builder(
                      itemCount: introBigtext.length,
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Container(
                            margin: const EdgeInsets.all(50),
                            child: MyImage(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                imagePath: icons[index]),
                          ),
                        );
                      },
                      onPageChanged: (index) {
                        pos = index;
                        currentPageNotifier.value = index;
                        debugPrint("pos:$pos");
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DotsIndicator(
                            dotsCount: introBigtext.length,
                            position: pos.toDouble(),
                            decorator: DotsDecorator(
                              activeColor: Color(0xff8B7C61),
                              color: Colors.brown.shade100,
                              size: const Size.square(7.0),
                              activeSize: const Size(18.0, 6.0),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyText(
                                colors: Color(0xff8B7C61),
                                maxline: 2,
                                title: introBigtext[pos],
                                textalign: TextAlign.center,
                                size: 20,
                                fontWeight: FontWeight.w600,
                                fontstyle: FontStyle.normal),
                          ),
                          // const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyText(
                                colors: Color.fromARGB(255, 141, 139, 139),
                                maxline: 5,
                                title: introSmalltext[pos],
                                textalign: TextAlign.center,
                                size: 14,
                                fontWeight: FontWeight.w600,
                                fontstyle: FontStyle.normal),
                          ),
                          const Spacer(),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 100,
                            child: TextButton(
                                child: MyText(
                                  title: pos == introBigtext.length - 1
                                      ? "سجل معنا"
                                      : "التالي",
                                  colors: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.all(5)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context).primaryColor),
                                    shape:
                                        MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor)))),
                                onPressed: () => {
                                      if (pos == introBigtext.length - 1)
                                        {
                                          _storeOnboardInfo(),
                                          Get.offAndToNamed(
                                              RouteHelper.getLoginRoute())
                                        }
                                      else
                                        {
                                          pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.ease)
                                        }
                                    }),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              _storeOnboardInfo();
                              Get.offAndToNamed(RouteHelper.getLoginRoute());
                            },
                            child: MyText(
                                colors: Color(0xff8B7C61),
                                maxline: 1,
                                title: 'تخطي',
                                textalign: TextAlign.center,
                                size: 14,
                                fontWeight: FontWeight.w600,
                                fontstyle: FontStyle.normal),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
