import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobigic_test/src/home_screen.dart';

class CustomGridView extends StatefulWidget {
  final List alphabetsList;
  final int column;
  final int row;

  const CustomGridView(
      {Key? key,
        required this.alphabetsList,
        required this.column,
        required this.row})
      : super(key: key);

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  String searchValue = '';

  @override
  void initState() {
    super.initState();
    log("Length from input : ${widget.alphabetsList}");
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(11, 5, 11, 5),
            height: height * 0.07,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0),
              borderRadius: const BorderRadius.all(
                  Radius.circular(11) //                 <--- border radius here
              ),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.search,
              ),
              title: TextFormField(
                onChanged: (value) {
                  if (mounted) {
                    setState(() {
                      searchValue = value;
                    });
                  }

                  print(searchValue);
                },
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Search alphabet"),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(7),
            height: height * 0.77,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.column,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4),
                itemCount: widget.alphabetsList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      padding: EdgeInsets.all(height*0.04),
                      child: TextFormField(
                        initialValue: widget.alphabetsList[index],
                        style: TextStyle(
                            fontSize: height*0.021,
                            color: searchValue.contains(widget.alphabetsList[index])
                                ? Colors.cyanAccent
                                : Colors.white,
                            fontWeight:
                            searchValue.contains(widget.alphabetsList[index])
                                ? FontWeight.bold
                                : FontWeight.normal),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.alphabetsList[index] = value;
                          });
                        },
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}