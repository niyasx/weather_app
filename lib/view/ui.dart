import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/view/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  WeatherModel? model;

  @override
  Widget build(BuildContext context) {
    void dispose(){
  searchpagecontroller.clear();
}
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Scaffold(
        extendBodyBehindAppBar: true,resizeToAvoidBottomInset:false,
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: MediaQuery.of(context).size.height * .12,
          title: TextField(
            controller: searchpagecontroller,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          onSubmitted: (value) {


            setState(() {
              currentlocation=searchpagecontroller.text;
            });
           
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            dispose();

          },
          ),
        ),
       
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text(searchpagecontroller.text),
            // Image.asset(""),
            Text("${model?.cityName}"),
            Text("${model?.temperature}"),
            Text("${model?.description}"),]
          ),
        ),
      ),
    );
  }
}
