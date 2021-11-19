import 'dart:io';

import 'package:assignment/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final name = TextEditingController();
  late final emailC = TextEditingController();
  late final phoneC = TextEditingController();
  late final items = TextEditingController();
  late final company = TextEditingController();
  late String nameF;
  late String email;
  late String phone;
  late String cName;
  late String items_wrote;

  @override
  void initState() {
    name.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('assignment'),
      ),
      backgroundColor: const Color(0xFFffffff),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Form(
          child: ListView(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Please fill the details",
                style: TextStyle(fontSize: 30, color: Colors.blue),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                    labelText: "Enter Your name",
                    hintText: "  jhon",
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(20),
                    suffixIcon: name.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            onPressed: () => name.clear(),
                            icon: const Icon(Icons.close))),
                onChanged: (v) {
                  nameF = v;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailC,
                decoration: InputDecoration(
                    labelText: "Enter Your email",
                    hintText: "  jhon@gmail.com",
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(20),
                    suffixIcon: emailC.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            onPressed: () => name.clear(),
                            icon: const Icon(Icons.close))),
                onChanged: (v) {
                  email = v;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: phoneC,
                decoration: InputDecoration(
                    labelText: "Enter Your phone",
                    hintText: "  134567890",
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(20),
                    suffixIcon: phoneC.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            onPressed: () => name.clear(),
                            icon: const Icon(Icons.close))),
                onChanged: (v) {
                  phone = v;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: company,
                decoration: InputDecoration(
                    labelText: "Enter Your company name",
                    hintText: "  google",
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(20),
                    suffixIcon: company.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            onPressed: () => name.clear(),
                            icon: const Icon(Icons.close))),
                onChanged: (v) {
                  cName = v;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: items,
                maxLines: null,
                decoration: InputDecoration(
                    labelText: "Enter Your items",
                    hintText: "  bread,laptop",
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(20),
                    suffixIcon: items.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            onPressed: () => name.clear(),
                            icon: const Icon(Icons.close))),
                onChanged: (v) {
                  items_wrote = v;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              ButtonWidget(
                  text: "Generate Pdf",
                  onClicked: () async {
                    _createPDF();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument doc = PdfDocument();
    final page = doc.pages.add();
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height));
    page.graphics.drawString(
        "Mindgo tech private Limited \n\n\n employer : $nameF\n\n mail :$email\n\n phone No. :$phone \n\n Company name :$cName \n\n items : $items_wrote",
        PdfStandardFont(PdfFontFamily.helvetica, 30));

    List<int> bytes = doc.save();
    doc.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())!.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }
}
