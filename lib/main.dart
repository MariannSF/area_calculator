import 'package:flutter/material.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Area calculator', style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.yellow,
        ),
        body: AreaCalculator(),

      ),
    );
  }
}

class AreaCalculator extends StatefulWidget {
  const AreaCalculator({super.key});

  @override
  State<AreaCalculator> createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {


  List<String> shapes = ['Rectangle', 'Triangle'];
  String currentShape = 'Rectangle';
  String result = '0';
  double width = 0;
  double height = 0;
   double area = 0;

  final TextEditingController widthTextField = TextEditingController();
  final TextEditingController heightTextField = TextEditingController();
  @override
  void initState() {

    super.initState();
    result = '0';
    currentShape = 'Rectangle';

  }
  @override
  Widget build(BuildContext context) {
    return
      Column(

        children: [

          DropdownButton(
              value: currentShape,
              items: shapes.map((String shapes) {
                return DropdownMenuItem(child: Text(shapes), value: shapes,);
              },).toList(),
              onChanged: (String? newShape) {
                setState(() {
                  currentShape = newShape!;
                  widthTextField.clear();
                  heightTextField.clear();
                  area = 0.0;
                 calculateArea();


                });
              }),



          Visibility(
            visible: currentShape == 'Rectangle',
            child: RectangleWidget(shape: 'Rectangle',),
          ),
          Visibility(
            visible: currentShape == 'Triangle',
            child: TriangleWidget(shape: 'Triangle',),
          ),


          Controller(controller: widthTextField, hint: 'Width'),

          Controller(controller: heightTextField, hint: 'Height'),



          Container(margin: EdgeInsets.all(15.0),

          child: ElevatedButton(
            child: Text('CalculateArea',
            style: TextStyle(fontSize: 18.0),),
            onPressed: calculateArea,
          ),),

          Text(result,
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.green[700],
            ),),




        ],
      );
  }



  void calculateArea() {
   // double area;

    width = double.tryParse(widthTextField.text) ?? 00.00;
    height = double.tryParse(heightTextField.text) ?? 00.00 ;
    print('From calculate areaa');
    //print(heightTextField.text);
    //print(widthTextField.text);
    print('------------------------');

    if (currentShape == 'Rectangle') {
      area = width * height;
      print(width);
      print(height);
    }
    else if (currentShape == 'Triangle') {
      print(width);
      print(height);
      area = width * height / 2;
    }
    else {
      area = 0;
    }
    setState(() {
      result = 'The area is ' + area.toString();
    });
  }



}

class RectangleWidget extends StatelessWidget {
  final String? shape;

  RectangleWidget({
    required this.shape
  });

  @override
  Widget build(BuildContext context) {
    print("from class " + shape!);


    return Container(
      child: CustomPaint(
        child: Container(
          width: 300,
          height: 200,
          color: Colors.amberAccent,
        ),
        // foregroundPainter: LinePainter(),
      ),
      margin: EdgeInsets.all(50.0),
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(),
    );
  }
}

class TriangleWidget extends StatelessWidget {
  final String? shape;

  TriangleWidget({
    required this.shape
  });

  @override
  Widget build(BuildContext context) {
    print("from class Triangle" + shape!);
    return Container(
      child: CustomPaint(
        child: CustomPaint(size: Size(200, 200), painter: DrawTriangle()),
      ),
      margin: EdgeInsets.all(50.0),
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(),
    );
  }
}

class DrawTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(path, Paint()
      ..color = Colors.green);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


class Controller extends StatelessWidget {
  Controller({required this.controller, required this.hint});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, decoration: InputDecoration(
        prefixIcon: (this.hint == 'Width') ?
        Icon(Icons.border_bottom_outlined) :
        Icon(Icons.border_left_outlined), filled: true, hintText: hint),
      keyboardType: TextInputType.number,);
  }


}



