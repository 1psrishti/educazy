import 'dart:convert';
import 'dart:io';
import 'package:educazy/data/resources_data.dart';
import 'package:educazy/screens/convert_to_braille.dart';
import 'package:educazy/screens/convert_to_speech.dart';
import 'package:educazy/main.dart';
import 'package:educazy/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:read_pdf_text/read_pdf_text.dart';

import '../utils/custom_colors.dart';
import '../widgets/book_card.dart';
import 'classes_screen.dart';
import 'enrolled_class_screen.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    currentscreen = Resources.name;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0613 * width),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    CustomText(
                      "Resources",
                      style: GoogleFonts.sourceSansPro(
                        color: Color(0xff0A5580),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomText(
                      "NCERT Books in Braille Script",
                      style: GoogleFonts.sourceSansPro(
                        color: Color(0xff555555),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            BookCard(
                              imagePath: "assets/images/social.png",
                              course: "Social Science",
                              grade: "Class 8",
                            ),
                            const SizedBox(width: 16),
                            BookCard(
                              imagePath: "assets/images/social.png",
                              course: "Social Science",
                              grade: "Class 8",
                            ),
                            const SizedBox(width: 16),
                            BookCard(
                              imagePath: "assets/images/social.png",
                              course: "Social Science",
                              grade: "Class 8",
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomText(
                      "???????",
                      style: GoogleFonts.sourceSansPro(
                        color: Color(0xff555555),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    EnrolledClass(
                      width: width,
                      facultyName: 'Convert to Braille',
                      subjectName: '',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const ConvertToBraille()),
                          ),
                        );
                      },
                      image: Icon(
                        Entypo.globe,
                        color: CustomColors.green,
                        size: 24,
                      ),
                      primaryColor: const Color(0XFF1D934C),
                      backColor: const Color(0xFF1D934C).withOpacity(0.05),
                    ),
                    EnrolledClass(
                      width: width,
                      facultyName: 'Convert to Speech',
                      subjectName: '',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => ConvertToSpeech()),
                          ),
                        );
                      },
                      image: Icon(
                        Entypo.globe,
                        color: CustomColors.green,
                        size: 24,
                      ),
                      primaryColor: const Color(0XFF1D934C),
                      backColor: const Color(0xFF1D934C).withOpacity(0.05),
                    ),
                    SizedBox(
                      height: 150,
                    ),
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
                        child: const CustomText(
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
                    CustomText(
                      displayedText,
                      style: GoogleFonts.sourceCodePro(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        getBraille(pdfText);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        child: const CustomText(
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
                    const CustomText(
                      'Resources',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
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
                          CustomText(
                            resources[index].name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          )
                        ]);
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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

  _write(String text) async {
    final Directory? directory = await getExternalStorageDirectory();
    final File file = File('${directory!.path}/my_file.txt');
    print(directory.path);
    await file.writeAsString(text).then((value) => print(file));
    print("done");
  }

  void getBraille(String text) {
    text = text.substring(0, text.length - 1);
    text = text.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    // _write(text);
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
