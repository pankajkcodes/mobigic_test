import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';

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
  int totalLength = 0;
  bool isMnVisible = true;
  bool isListVisible = true;
  bool isGridVisible = true;
  String searchValue = '';
  List<String> alphabetsList = [];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Mobigic test"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isMnVisible = true;
                    isGridVisible = false;
                    isListVisible = false;
                    alphabetsList.clear();
                    totalLength = 0;
                    log("message");
                  });
                },
                icon: const Icon(Icons.restore)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isMnVisible
                ? SizedBox(
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
                                hintText: "Enter rows",
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          height: height * 0.07,
                          width: width * 0.3,
                          padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    10.0) //                 <--- border radius here
                                ),
                          ),
                          child: TextField(
                            controller: columnController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: "Enter Column",
                                border: InputBorder.none),
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
                                          content: Text("Can't Be Empty")));
                                }
                                setState(() {
                                  row = int.parse(rowController.text);
                                  column = int.parse(columnController.text);
                                  log(row.toString());
                                  totalLength = row * column;
                                  isMnVisible = false;
                                  isListVisible = true;
                                  isGridVisible = false;
                                });
                              },
                              child: const Text("Submit"),
                            )),
                      ],
                    ),
                  )
                : const SizedBox(),
            // Type alphabets which you want to show in grid
            totalLength == 0
                ? const SizedBox()
                : totalLength.isNaN
                    ? const SizedBox()
                    : isListVisible == false
                        ? const SizedBox()
                        : Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Type alphabets which you want to show in grid",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(7),
                                height: height * 0.5,
                                child: ListView.builder(
                                    itemCount: totalLength,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                          leading: Text("$index"),
                                          title: SizedBox(
                                            height: height * 0.1,
                                            width: width * 0.89,
                                            child: TextFormField(
                                              onChanged: (value) {

                                                setState(() {
                                                  alphabetsList.insert(
                                                      index, value);
                                                });
                                              },
                                            ),
                                          ),
                                          trailing: Text("List item $index"));
                                    }),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isListVisible = false;
                                      isMnVisible = false;
                                      isGridVisible = true;
                                      if (alphabetsList.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text("Can't be empty")));
                                      }
                                    });
                                  },
                                  child: const Text("SHOW"))
                            ],
                          ),

            // Show The Grid View
            isGridVisible == false
                ? const SizedBox() :
            alphabetsList.isEmpty
                ? const SizedBox()
                : Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(11, 5, 11, 5),
                        height: height * 0.07,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0),
                          borderRadius: const BorderRadius.all(Radius.circular(
                                  11) //                 <--- border radius here
                              ),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.search,
                          ),
                          title: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                searchValue = value;
                              });
                              log(searchValue);
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: "Search alphabet"),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(7),
                        height: height * 0.77,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: column,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4),
                            itemCount: alphabetsList.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: alphabetsList[index],
                                        hintStyle: TextStyle(
                                            color: searchValue ==
                                                    alphabetsList[index]
                                                ? Colors.green
                                                : Colors.black,
                                        fontWeight: searchValue ==
                                            alphabetsList[index]
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                                    ),
                                    onChanged: (value) {

                                      setState(() {
                                        alphabetsList.insert(index, value);
                                      });
                                    },
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    alphabetsList.clear();
  }
}
