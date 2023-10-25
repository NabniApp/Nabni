import 'package:flutter/material.dart';
import 'package:new_nabni_app/core/constant/appcolors.dart';

class InvoceTableHead extends StatelessWidget {
  const InvoceTableHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        child: Table(
          children: const [
            TableRow(
              decoration: BoxDecoration(),
              children: [
                Center(
                  child: TableCell(
                      child: Text(
                    'الرقم',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor),
                  )),
                ),
                Center(
                    child: TableCell(
                        child: Text('المورد',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor)))),
                Center(
                    child: TableCell(
                        child: Text('السعر',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor)))),
                Center(
                    child: TableCell(
                        child: Text('الكمية',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor)))),
                Center(
                    child: TableCell(
                        child: Text('الاجمالي',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor)))),
               
              ],
            ),
          ],
        ),
      ),
    );
  }
}
