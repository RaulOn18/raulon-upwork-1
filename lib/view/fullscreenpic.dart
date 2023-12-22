import 'package:flutter/material.dart';

class FullScreenPic extends StatefulWidget {
  List pic = [];
  int index;

  FullScreenPic({super.key, required this.pic, required this.index});

  @override
  State<FullScreenPic> createState() => _FullScreenPicState();
}

class _FullScreenPicState extends State<FullScreenPic> {
  ScrollController scrollController = ScrollController();

  bool isJump = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // scrollController.addListener(() {
    //   if (scrollController.hasClients && isJump == false) {
    //     print("scrollhasclient : ${scrollController.hasClients}");
    //     setState(() {
    //       scrollController
    //           .jumpTo(MediaQuery.of(context).size.width * widget.index);
    //       isJump = true;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    print("pic : ${widget.pic}");
    print("index : ${widget.index}");

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        InteractiveViewer(
          maxScale: 100,
          child: Center(
            child: ListView.builder(
              // controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.pic.length,
              itemBuilder: (context, itemindex) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.network(widget.pic[itemindex]),
                );

                // if (itemindex == widget.pic.length - 1) {
                //   print("itemindex : ${itemindex}");
                // }

                // if (isJump == true) {
                //   return Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: MediaQuery.of(context).size.height,
                //     child: Image.network(widget.pic[itemindex]),
                //   );
                // } else {
                //   return Container(
                //     width: itemindex.toDouble(),
                //   );
                // }
              },
            ),
          ),
        ),
        SafeArea(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }
}
