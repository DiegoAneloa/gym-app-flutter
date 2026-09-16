import 'package:flutter/material.dart';
import 'package:gym_app/View/widgets/login.dart';

void main ()
{
  runApp(const MyApp()); 
}

class MyApp  extends StatelessWidget
{
  const MyApp({super.key});

  @override //sobrescribimos un metodo 
  Widget   build(BuildContext context) {
   return  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme:ThemeData (
      useMaterial3: false,
      colorSchemeSeed:const Color.fromARGB(255, 236, 131, 11) 
      ),
      home: Login()
   );
  }
}