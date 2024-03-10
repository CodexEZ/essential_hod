import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';

class PDFPage extends StatefulWidget {
  String? link;

  PDFPage({super.key,required this.link});

  @override
  State<PDFPage> createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.link);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("File",style: GoogleFonts.poppins(),),
      ),
      body: Container(
        child:PDF(
          swipeHorizontal: true,
        ).cachedFromUrl('${widget.link}'),

      ),
    ) ;
  }
}
