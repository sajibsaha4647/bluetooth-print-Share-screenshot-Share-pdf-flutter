
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../Provider/Provider.dart';

Future<Uint8List> generatePdf( PdfPageFormat format, )async{
      final doc = pw.Document(
        title:"flutter pdf"
      );
      final logoImage = pw.MemoryImage(
        (await rootBundle.load('Assets/Group.png')).buffer.asUint8List()
      );
      final footerImage = pw.MemoryImage(
          (await rootBundle.load('Assets/Group.png')).buffer.asUint8List()
      );

      final font = await rootBundle.load('Assets/NotoSansBengaliBlack.ttf') ;
      final ttf = pw.Font.ttf(font);





      final pageTheme  = await _myPageTheme(format);

      doc.addPage(
        pw.MultiPage(
          pageTheme:pageTheme,
          header: (final context)=>pw.Image(
          alignment: pw.Alignment.topLeft,
          logoImage,
          fit: pw.BoxFit.contain
        ),
          footer:  (final context)=>pw.Image(
          alignment: pw.Alignment.topLeft,
          logoImage,
          fit: pw.BoxFit.contain
          ),
        build: (final context)=>[
          pw.Container(
            child: pw.Text("বাংলা সাল",style: pw.TextStyle(font: ttf))
          )
        ]


        )
      );

      return doc.save();
}

Future<pw.PageTheme>_myPageTheme(PdfPageFormat format) async{
      return const pw.PageTheme(
        margin: pw.EdgeInsets.symmetric(
          horizontal: 1*PdfPageFormat.cm,vertical: 0.5*PdfPageFormat.cm
        ),
        textDirection: pw.TextDirection.ltr,
        orientation: pw.PageOrientation.portrait,
      );
}


Future<void>saveFile(final BuildContext context,final LayoutCallback build,final PdfPageFormat pageFormat) async{
  final bytes  =await build(pageFormat);
  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/doco.pdf');
  print("save as file ${file.path}" );
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);

}

void showPrintedToast(final BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Document printed successfully")));
}

void showSharedToast(final BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Document shared successfully")));
}