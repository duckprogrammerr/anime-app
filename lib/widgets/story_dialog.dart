import 'package:flutter/material.dart';

class AdvanceCustomAlert extends StatelessWidget {
  final String story;
  AdvanceCustomAlert(this.story);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      backgroundColor: Color(0xff333333),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 500,
            padding: EdgeInsets.fromLTRB(10, 45, 10, 10),
            child: Column(
              children: [
                Text(
                  'القصة',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 300,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(right: 40),
                    child: Text(
                      story,
                      softWrap: true,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent)),
                  child: Text(
                    '! تمام',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: -20,
            child: CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 30,
              child: Icon(
                Icons.article,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
