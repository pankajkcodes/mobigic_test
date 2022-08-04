import 'dart:developer';

import 'package:flutter/material.dart';

import 'grid_screen.dart';
import 'home_screen.dart';

class InputTakingScreen extends StatefulWidget {
  final int column;
  final int row;

  const InputTakingScreen({Key? key, required this.column, required this.row})
      : super(key: key);

  @override
  State<InputTakingScreen> createState() => _InputTakingScreenState();
}

class _InputTakingScreenState extends State<InputTakingScreen> {
  late List alphabetsList;

  @override
  void initState() {
    super.initState();

    log("Length from home : ${widget.row * widget.column}");
  }

  @override
  Widget build(BuildContext context) {

    alphabetsList =
        List.filled(widget.column * widget.row, null, growable: false);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(

        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                  icon: Padding(
                    padding: EdgeInsets.fromLTRB(0,0,0,width*0.27),
                    child: const Icon(Icons.restore,color: Colors.white,),
                  )),
            )
          ],
        ),
        body: ListView.builder(
            itemCount: widget.row * widget.column,
            itemBuilder: (BuildContext context, int index) {
              return TextFormField(
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom ),
                onChanged: (value) {
                  alphabetsList[index] = value;
                  log(alphabetsList.toString());
                  if (alphabetsList.length ==
                      widget.row * widget.column &&
                      !alphabetsList.contains(null)) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CustomGridView(
                                    alphabetsList:
                                    alphabetsList,
                                    column: widget.column,
                                    row: widget.row)));
                  }
                },
                decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    hintText:
                    "Enter ${index + 1} alphabet"),
              );
            }));
  }
}
