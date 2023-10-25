import 'package:flutter/material.dart';
import 'package:new_nabni_app/data/model/material_model.dart';
import 'package:new_nabni_app/view/screen/contractor/choose_material_screen.dart';

class InvoceTeble extends StatelessWidget {
  final List items;

  const InvoceTeble({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 200,
        child: Table(
          children: [
            for (int i = 0; i < items.length; i++)
              _buildTableRow(
                  (i + 1).toString(),
                  items[i].subject_type,
                  '${items[i].price} ريال',
                  '${items[i].quantity} ${items[i].supplier_unit}',
                  '${int.parse(items[i].price) * int.parse(items[i].quantity)} ريال'),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(
    String cell1,
    String cell2,
    String cell3,
    String cell4,
    String cell5,
  ) {
    return TableRow(
      children: [
        Center(
          child: TableCell(
            child: Text(
              cell1,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Center(
          child: TableCell(
            child: Text(
              cell2,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Center(
          child: TableCell(
            child: Text(
              cell3,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Center(
          child: TableCell(
            child: Text(
              cell4,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Center(
          child: TableCell(
            child: Text(
              cell5,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
