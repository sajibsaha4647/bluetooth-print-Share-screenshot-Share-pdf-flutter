import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';

import '../Provider/Provider.dart';
import '../Utils/Utils.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({Key? key}) : super(key: key);

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  PrintingInfo? printingInfo;

  @override
  void initState() {
    inits();
    super.initState();
  }

  Future<void> inits() async {
    final into = await Printing.info();
    setState(() {
      printingInfo = into;
    });
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        const PdfPreviewAction(icon: Icon(Icons.save), onPressed: saveFile)
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pdf print"),
        ),
        body: PdfPreview(
          maxPageWidth: 700,
          actions: actions,
          canChangeOrientation :false,
          canChangePageFormat :false,
          onPrinted: showPrintedToast,
          onShared: showSharedToast,
          build: (PdfPageFormat format) async{
            final reportProvider =
                Provider.of<providersss>(context, listen: false);

            final doc = pw.Document(title: "flutter pdf");
            final logoImage = pw.MemoryImage(
                (await rootBundle.load('Assets/Group.png'))
                    .buffer
                    .asUint8List());
            final footerImage = pw.MemoryImage(
                (await rootBundle.load('Assets/Group.png'))
                    .buffer
                    .asUint8List());

            final font =
                await rootBundle.load('Assets/NotoSansBengaliBlack.ttf');
            final ttf = pw.Font.ttf(font);

            final pageTheme = await _myPageTheme(format);

            doc.addPage(pw.MultiPage(
                pageTheme: pageTheme,
                header: (final context) => pw.Image(
                    alignment: pw.Alignment.topLeft,
                    logoImage,
                    fit: pw.BoxFit.contain),
                footer: (final context) => pw.Image(
                    alignment: pw.Alignment.topLeft,
                    logoImage,
                    fit: pw.BoxFit.contain),
                build: (final context) => [
                      pw.Container(
                          child: pw.Text(reportProvider.text.toString(),
                              style: pw.TextStyle(font: ttf))),
                  pw.Center(

                  )
                    ]));

            return doc.save();
          },
        ),
      ),
    );
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
}
