import 'dart:convert';
import 'dart:io';
import 'package:educazy/data/resources_data.dart';
import 'package:educazy/widgets/header_logo.dart';
import 'package:educazy/widgets/screen_wrapper.dart';
import 'package:educazy/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:read_pdf_text/read_pdf_text.dart';

class Resources extends StatefulWidget {
  static const String name = "resources";
  const Resources({Key? key}) : super(key: key);

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  String pdfText = "";
  String url =
      "https://api.funtranslations.com/translate/braille/unicode.json?text=";
  String displayedText = "";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 28,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0613 * width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HeaderText(text: 'Resources'),
                  const TaglineText(
                      text:
                          'Never stop learning! Books, worksheets and reading materials now just one click away.'),
                  const SizedBox(height: 20),
                  GridView.builder(
                    itemCount: resources.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, crossAxisSpacing: 16),
                    itemBuilder: (context, index) {
                      return Column(children: [
                        Container(
                          width: 108,
                          height: 123,
                          decoration: const BoxDecoration(
                              color: Color(0xFFF3F3F3),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 8),
                                  blurRadius: 79,
                                  spreadRadius: -19,
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                )
                              ]),
                        ),
                        Text(
                          resources[index].name,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        )
                      ]);
                    },
                  ),
                  const SizedBox(height: 50),
                  const HeaderText(text: "Braille Converter"),
                  const TaglineText(text: "Easily convert text to braille."),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      final FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );
                      if (result != null) {
                        File file = File(result.files.single.path ?? "");
                        getPDFText(file.path).then((pdfText) {
                          final text = pdfText.replaceAll("\n", " ");
                          pdfText = text;
                          setState(() {
                            displayedText = "PDF selected.";
                          });
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: const Text(
                        "Select Pdf",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xffEDEDED),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(displayedText),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      getBraille(pdfText);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: const Text(
                        "Convert to Braille",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xff62C733),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Future<String> getPDFText(String path) async {
    try {
      pdfText = await ReadPdfText.getPDFtext(path);
    } on PlatformException {
      debugPrint("Failed to get PDF text.");
    }
    return pdfText;
  }

  void getBraille(String text) {
    text = text.substring(0, 1900);
    text = text.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    displayedText = "";
    String finalUrl = url + text;
    final uri = Uri.parse(finalUrl);
    http.get(uri).then((response) {
      if (response.statusCode == 200) {
        final responseBody = response.body;
        final decodedJson = jsonDecode(responseBody);
        final brailleData = decodedJson['contents'];
        final List resultsList = brailleData['translated'];
        for (var i = 0; i < resultsList.length; i++) {
          debugPrint(resultsList[i]);
          displayedText = displayedText + resultsList[i];
        }
        setState(() {});
      } else {
        debugPrint(response.statusCode.toString());
      }
    }).catchError((e) {
      debugPrint("---------------------------$e-----------------------------");
    });
  }
}
