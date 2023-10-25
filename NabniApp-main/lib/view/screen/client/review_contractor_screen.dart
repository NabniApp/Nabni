import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/client_controller.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/view/widgets/custom_button.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';
import 'package:new_nabni_app/view/widgets/custom_text_field.dart';

class ReviewContractorScreen extends StatefulWidget {
  final UserModel model;
  final String project_id;
  ReviewContractorScreen({super.key, required this.model, required this.project_id});

  @override
  State<ReviewContractorScreen> createState() => _ReviewContractorScreenState();
}

class _ReviewContractorScreenState extends State<ReviewContractorScreen> {
  TextEditingController review = TextEditingController();
    double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 253, 249),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: .7,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff8B7C61),
              )),
          title: Text(
            'تقييم المقاول',
            style: TextStyle(color: Color(0xff8B7C61), fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'Cairo'),
          ),
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 200.0),
                margin: const EdgeInsets.only(top: 70.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 1,
                        blurRadius: 5)
                  ],
                ),
                child: Column(children: [
                  CustomTextField(
                    hintText: 'اكتب تقييم',
                    controller: review,
                    prefixIcon: Icon(
                      Icons.reviews,
                      color: Color(0xff8B7C61),
                      size: 25,
                    ),
                    inputType: TextInputType.multiline,
                    maxLines: 6,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          style: BorderStyle.solid,
                          width: 10),
                    ),
                    activeBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          style: BorderStyle.solid,
                          width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 231, 231, 231),
                          style: BorderStyle.solid,
                          width: 1),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GetBuilder<ClientController>(builder: (controller) {
                    return controller.isLoading
                        ? CircularProgressIndicator()
                        : CustomButton(
                            buttonText: 'إرسال',
                            onPressed: () {
                              if (review.text.isEmpty) {
                                showCustomSnackBar(
                                    context, 'ادخل المحتوي من فضلك');
                              } else if (rating == 0.0) {
                                showCustomSnackBar(
                                    context, 'قيم المقاول من فضلك');
                              } else {
                                controller.addReview(context,
                                    content: review.text,
                                    rating: rating,
                                    contractor_id: widget.model.id, project_id: widget.project_id);
                              }
                            },
                          );
                  }),
                ]),
              ),
              Positioned(
                  top: -10,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        if (widget.model.image == null)
                          const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/images/placeholder.jpg')),
                        if (widget.model.image != null)
                          CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(widget.model.image!)),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(widget.model.username!,
                            style: const TextStyle(
                                color: Color(0xff8B7C61),
                                fontFamily: 'Cairo',
                                fontSize: 17,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 5,
                        ),
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (_rating) {
                            setState(() {
                              rating = _rating;
                            });
                            print(rating);
                          },
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
