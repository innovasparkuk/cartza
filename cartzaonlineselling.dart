import 'package:ecommercepro/bannerslider.dart';
import 'package:ecommercepro/shopcreatepage.dart';
import 'package:flutter/material.dart';
class cartzapage extends StatefulWidget{
  @override
  State<cartzapage> createState() => _cartzapageState();
}

class _cartzapageState extends State<cartzapage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        title: Text("Start Selling on Cartza", style: TextStyle(fontSize: 18),),
        actions: [
          IconButton(onPressed: (){
          }, icon: Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body:  SingleChildScrollView(
        child: Column(
                children: [
                  Center(child: Text("START YOUR ONLINE BUSINESS\nWITH US IN 3 EASY STEPS",
                    textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey),)),
                  Container(
                    height:300,
                    width: double.infinity,
                    child: Image.asset("assets/Images/sellinglogo3.jpg"),
                  ),
                  OutlinedButton(onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => Shopcreatepage(),));
                  }, 
                      child: Text("Start Selling", style: TextStyle(fontSize: 18),),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green,
                    side: BorderSide(color: Colors.orange, width: 3),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30)

                  ),)
                ],
              ),
      ),
    );
  }
}