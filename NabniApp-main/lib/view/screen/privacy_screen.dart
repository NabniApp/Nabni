import 'package:flutter/material.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  @override
  _TermsAndConditionsScreenState createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF8B7C61),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Color(0xFFFDFCF9),
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  ImageAsset.logo,
                  width: 198,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'شروط المستخدم وسياسة الخصوصية:',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFF8B7C61),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color:
                                Colors.black.withOpacity(0.12999999523162842),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'شروط المستخدم:\n',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'بتحميل واستخدام تطبيق "نبني"، فإنك توافق على شروط المستخدم وتعهد بالامتثال لها.\nيجب تقديم معلومات صحيحة ومحدثة عند التسجيل في التطبيق، بما في ذلك الاسم ومعلومات الاتصال والتفاصيل الشخصية الأخرى المطلوبة.\nأنت مسؤول عن المحتوى الذي تقدمه أو تشاركه عبر التطبيق، ويجب أن يكون المحتوى قانوني ولا ينتهك حقوق الملكية الفكرية للآخرين.\nيمكنك استخدام التطبيق للتواصل مع المقاولين والموردين وترتيب وإدارة المعاملات. يجب عليك التعامل بنزاهة واحترافية في جميع التفاعلات والصفقات.\nنحن غير مسؤولين عن أي صفقات أو خدمات يقدمها المقاولين أو الموردين عبر التطبيق. يجب عليك مراجعة وتقييم المقاولين والموردين واتخاذ القرارات المناسبة بناءً على تقديرك الخاص.\n',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: '\nسياسة الخصوصية:\n',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'نجمع بعض المعلومات الشخصية التي تقدمها عند التسجيل واستخدام التطبيق، مثل الاسم وعنوان البريد الإلكتروني ومعلومات الاتصال الأخرى المطلوبة.\nنستخدم المعلومات التي تقدمها لتسهيل عملية التواصل بين العملاء والمقاولين والموردين وتحسين تجربتك في استخدام التطبيق.\nلن نكشف عن المعلومات الشخصية لأطراف ثالثة دون موافقتك، إلا في حالة الالتزام بالقوانين أو طلب قانوني.\nنتخذ تدابير أمنية لحماية المعلومات الشخصية ونلتزم بمعايير الأمان المناسبة لحماية بياناتك.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )),
    );
  }
}
