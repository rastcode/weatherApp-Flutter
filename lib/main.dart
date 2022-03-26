import 'package:flutter/material.dart';
import 'package:weatherapp1/weather_api_client.dart';
import 'package:weatherapp1/weather_model.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),

      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //api call
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  String city='tabriz';
  List<String>cityList=['tehran','tokyo','london','paris','beijing'];
  TextEditingController textController = TextEditingController();


  Future<void> getData( String city) async {
      data = await client.getCurrentWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.7),
        appBar: AppBar(
          backgroundColor: Colors.teal.withOpacity(0.9),
          elevation: 0.0,
          actions: [
            AnimSearchBar(
              rtl: true,
            width: 230,
            prefixIcon: Icon(Icons.search,color: Colors.black,),
            suffixIcon: Icon(Icons.search,color: Colors.green,),
            closeSearchOnSuffixTap: true,
            textController: textController,
            onSuffixTap: () {
              setState(() {
                city=textController.text;
                textController.clear();
              });}
              )
          ],
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Weather",
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getData(city),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {

              return SingleChildScrollView(
                child: Column(

                  children:[
                    main(),
                    listview(),
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              print(snapshot.error);
              return Center(
                child: Container(
        child: LoadingAnimationWidget.inkDrop(
          color: Colors.red, size: 60.0,
         
        ),
              ));
            }
            return Container(
            );

          },
        )
    );
  }
  Widget main(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //widget
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
             Image(image: AssetImage(status()),fit:BoxFit.fill ,),
            Container(
              margin: EdgeInsets.all(10),
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.8)
              ),
              child: Center(child: Text(data!.cityName.toString(),
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),),
            ),
          ],
        ),
        // currentWeather(Icons.wb_sunny_rounded, "${data!.temp}°",
        //     "${data!.cityName}"),
        SizedBox(
          height: 1.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          //
          CardItem(Icons.thermostat,'${data!.temp} ℃', Colors.red),
          CardItem(Icons.air,'${data!.wind} km/h', Colors.blue),
        ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           CardItem(Icons.cloud,'${data!.humidity} %' .toString(), Colors.white),
          CardItem(Icons.wb_sunny_outlined,'${data!.main}', Colors.yellow),
        ],),
        SizedBox(
          height: 5.0,
        ),
        //ad
        //uidone
      ],
    );

  }
  Container CardItem(IconData icon,String text,Color color){
    return Container(
      height: 130,
      width: 180,
      child: Card(
        color: Colors.teal.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,color: color,size: 40,),
            SizedBox( height:10),
            Text(text,style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
  String status(){
    if(data!.main=='Clouds'){
      return 'assets/images/cliud.gif';
    }else if(data!.main=='Rain'){
      return 'assets/images/rain.gif';
    }else{
      return 'assets/images/sun-dribbble.gif';
    }
  }
 Widget listview(){

    return Container(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cityList.length,
          itemBuilder: (context, index){
        return GestureDetector(
          onTap: (){
            setState(() {
              city=cityList[index];
            });
          },
          child: Container(
            alignment: Alignment.bottomCenter,
            height: 160,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image:DecorationImage(image: AssetImage('assets/images/${cityList[index]}.jpg'),fit: BoxFit.cover)
            ),
            margin: EdgeInsets.all(5),
            child:Container(
              margin: EdgeInsets.all(10),
              width: 70,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withOpacity(0.8)
              ),
              child: Center(child: Text(cityList[index],
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),),
            ) ,
          ),
        );

      }));




  }

}
