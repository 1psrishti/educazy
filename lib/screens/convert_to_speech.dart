import 'package:educazy/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../HelperMethods/savePdf.dart';

// import 'package:pdf/pdf.dart';

class ConvertToSpeech extends StatefulWidget {
  const ConvertToSpeech({Key? key}) : super(key: key);

  @override
  State<ConvertToSpeech> createState() => _ConvertToSpeechState();
}

class _ConvertToSpeechState extends State<ConvertToSpeech> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Color(0xff2F2F2F)),
        title: Text(
          "PDF/Text to Speech Converter",
          style: GoogleFonts.sourceSansPro(
            color: Color(0xff2F2F2F),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffF1F1F1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        "Upload PDF",
                        style: GoogleFonts.sourceSansPro(
                          color: Color(0xff2F2F2F),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.file_upload_outlined,
                        color: Color(0xff2F2F2F),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomText(
                  "OR",
                  style: GoogleFonts.sourceSansPro(
                    color: Color(0xff999999),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(8),
                  height: 237,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffEEEEEE),
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Type here...",
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),

                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    PdfDocument document = PdfDocument();
                    final page = document.pages.add();

                    PdfTextElement textElement = PdfTextElement(
                        text: controller.text,
                        font: PdfStandardFont(PdfFontFamily.helvetica, 12));

                    textElement.draw(
                        page: page,
                        bounds: Rect.fromLTWH(0, 150, page.getClientSize().width,
                            page.getClientSize().height))!;


                    document.pages.add();

                    List<int> bytes = await document.save();
                    document.dispose();

                    saveAndLaunchFile(bytes, 'BrailleConverted.pdf');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: width,
                    child: Text(
                      "Convert",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    // width: double.in
                    decoration: const BoxDecoration(
                      color: Color(0xff62C733),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
