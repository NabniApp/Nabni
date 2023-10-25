import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';

class PDFViewerPage extends StatelessWidget {
  final String pdfPath; // Path to the PDF file.

  PDFViewerPage(this.pdfPath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 253, 249),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfPath,
        autoSpacing: true,
        pageFling: true,
        onError: (e) {
          showCustomSnackBar(context, "هذا الملف ليس pdf!");
        },
      ),
    );
  }
}
