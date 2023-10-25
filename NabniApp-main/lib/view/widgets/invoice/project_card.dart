import 'package:flutter/material.dart';
import 'package:new_nabni_app/core/constant/appcolors.dart';

class ProjectCard extends StatelessWidget {
  final String titel, subtitle;
  final String status;
  const ProjectCard({Key? key, required this.titel, required this.subtitle, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.bgColor,
      child: ListTile(
        title: Text(
          titel,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.secondeColor),
        ),
        // subtitle: Text(
        //   subtitle,
        //   style: const TextStyle(
        //       color: AppColors.gray, fontSize: 14, fontWeight: FontWeight.w400),
        // ),
        leading: const Icon(Icons.file_copy_outlined),
        trailing: Text(
          status,
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
