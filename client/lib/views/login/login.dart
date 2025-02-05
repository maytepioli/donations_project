import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoguinState createState() => LoguinState();
}

class LoguinState extends State<Login> {
  late Color myColor;
  late Size mediaSize = MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
            image: AssetImage("assets/images/color-pastel.jpg"),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(myColor.withAlpha(70), BlendMode.dstATop)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop(mediaSize)),
          Positioned(bottom: 0, child: _buildBottom(mediaSize)),
        ]),
      ),
    );
  }
}

Widget _buildTop(dynamic mediaSize) {
  return SizedBox(
    width: mediaSize.width,
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Image.asset(
        'assets/icons/osoo-removebg.png',
        width: 100,
        height: 100,
        fit: BoxFit.contain,
      ),
      Text(
        'HopeBox',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40,
            letterSpacing: 2.0),
      )
    ]),
  );
}

Widget _buildBottom(dynamic mediaSize) {
  return SizedBox(
    width: mediaSize.width,
    child: Card(),
  );
}
