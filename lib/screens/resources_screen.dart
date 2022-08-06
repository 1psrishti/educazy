import 'package:educazy/data/resources_data.dart';
import 'package:educazy/widgets/header_logo.dart';
import 'package:educazy/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Resources extends StatefulWidget {
  static const name = 'resourcesscreen';
  const Resources({Key? key}) : super(key: key);

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HeaderLogo(),
          const SizedBox(
            height: 28,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0613 * width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Resources',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: const Color(0xFF3D3D3D)),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(),
                Text(
                  'Never stop learning! Books, worksheets and reading materials now just one click away.',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: const Color(0xFF5E5D5D)),
                ),
                Container(
                    child: GridView.builder(
                  itemCount: resources.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 16),
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Container(
                        width: 108,
                        height: 123,
                        decoration:
                            BoxDecoration(color: Color(0xFFF3F3F3), boxShadow: [
                          const BoxShadow(
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
                ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
