import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mobigic_test/src/input_taking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var rowController = TextEditingController();
  var columnController = TextEditingController();
  int row = 0;
  int column = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Mobigic test"),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: height * 0.07,
                    width: width * 0.3,
                    padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0) //
                              ),
                    ),
                    child: TextField(
                      controller: rowController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Enter rows", border: InputBorder.none),
                    ),
                  ),
                  Container(
                    height: height * 0.07,
                    width: width * 0.3,
                    padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0),
                      borderRadius: const BorderRadius.all(Radius.circular(
                              10.0) //
                          ),
                    ),
                    child: TextField(
                      controller: columnController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Enter Column", border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                      height: height * 0.07,
                      width: width * 0.3,
                      child: ElevatedButton(
                        onPressed: () {
                          if (rowController.text.isEmpty &&
                              columnController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Empty")));
                          } else {
                            if(mounted){

                              setState(() {
                                row = int.parse(rowController.text);
                                column = int.parse(columnController.text);
                              });
                            }

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InputTakingScreen(
                                        column: column, row: row)));
                          }

                        },
                        child: const Text("Submit"),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
