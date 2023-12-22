import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditFeedView extends StatefulWidget {
  const EditFeedView({super.key});

  @override
  State<EditFeedView> createState() => _EditFeedViewState();
}

class _EditFeedViewState extends State<EditFeedView> {
  String modeValue = "public";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Feed",
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: const Icon(Icons.close), onPressed: () => Get.back()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                hint: const Text("Select Feed Type"),
                dropdownColor: const Color(0xff262626),
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                value: modeValue,
                items: [
                  DropdownMenuItem(
                    value: "public",
                    child: Container(
                      alignment: Alignment.center,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.public, size: 20),
                          Text(
                            "Public",
                          )
                        ],
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "private",
                    child: Container(
                      alignment: Alignment.center,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock, size: 20),
                          Text(
                            "Private",
                          )
                        ],
                      ),
                    ),
                  ),
                ],
                underline: Container(),
                onChanged: (value) {
                  setState(() {
                    modeValue = value!;
                  });
                  print(value);
                  print(modeValue);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: TextField(
                  maxLines: 10, //or null
                  decoration: InputDecoration.collapsed(
                      hintText: "Enter your text here"),
                ),
              ),
            ),
            Expanded(child: Container()),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor: const MaterialStatePropertyAll(
                  Color(0xff262626),
                ),
              ),
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Save",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
