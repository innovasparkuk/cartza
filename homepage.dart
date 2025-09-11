import 'package:ecommercepro/bannerslider.dart';
import 'package:flutter/material.dart';
class homepage extends StatefulWidget{
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){
          },
            icon: Icon(Icons.menu, color: Colors.black54,),
          ),
          title:Center(child: Image.asset("assets/Images/cartzalogo.jpg", width: 130,)) ,
          actions: [
            IconButton(onPressed: (){

            }, icon: Icon(Icons.shopping_cart_outlined, color: Colors.black54,))
          ],
        ),

      body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20
                    ),
                    child: Text("Welcome !", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 7,
                    ),
                    child: Container(
                      width: 295,
                      height: 40,
                      child: TextField(
                        // controller: ,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Color(0xFFFF6F00)),
                          ),
                          isDense: true,
                          prefixIcon: IconButton(onPressed: (){
                          }, icon: Icon(Icons.search, color: Colors.black54,size: 20)),
                          suffixIcon: IconButton(onPressed: (){
                          }, icon: Icon(Icons.keyboard_voice, color: Colors.black54,size: 20)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(padding: EdgeInsetsGeometry.only(
                          right: 10,
                        ),
                          child:  IconButton(onPressed: (){

                            },
                                icon: Icon(Icons.tune, size: 25,),
                                style: IconButton.styleFrom(
                                  backgroundColor:  Color(0xFF4CAF50),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),)
                            ),
                          ),]),
                  )
                    ],
                  ),
             SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20
                    ),
                    child: Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(width: 190,),
                  Expanded(
                    child: TextButton(onPressed: (){

                    }, child: Text("View All ->", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 10),)),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                      },
                      child:Container(
                        width: 80,
                        height: 90,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        color: Colors.white,
                          child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10
                                  ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xFF4CAF50),
                                    child: CircleAvatar(
                                      radius: 25,
                                    backgroundImage: AssetImage("assets/Images/men wear.jpeg"),
                                    ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 65,
                                      left: 24
                                  ),
                                  child: Text("Men's", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                                ),
                                ]
                          ),
                        ),
                      ),
                    InkWell(
                      onTap: (){

                      },
                      child:Container(
                        width: 80,
                        height: 90,
                        color: Colors.white,
                        child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10
                                ),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:  Color(0xFF4CAF50),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage("assets/Images/womenwear.jpeg"),
                                  ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 65,
                                    left: 15
                                ),
                                child: Text("Women's", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                              ),
                            ]
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child:Container(
                        width: 80,
                        height: 90,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        color: Colors.white,
                        child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10
                                ),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:  Color(0xFF4CAF50),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage("assets/Images/western wear.jpeg"),
                                  ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 65,
                                    left: 15
                                ),
                                child: Text("Western", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                              ),
                            ]
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child:Container(
                        width: 80,
                        height: 90,
                        color: Colors.white,
                        child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10
                                ),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:  Color(0xFF4CAF50),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage("assets/Images/beauty.jpeg"),
                                  ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 65,
                                    left: 20
                                ),
                                child: Text("Beauty", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                              ),
                            ]
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child:Container(
                        width: 80,
                        height: 90,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        color: Colors.white,
                        child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10
                                ),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:  Color(0xFF4CAF50),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage("assets/Images/jewelry.jpeg"),
                                  ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 65,
                                    left: 20
                                ),
                                child: Text("Jewelry", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                              ),
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              BannerSlider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20
                    ),
                    child: Text("Flash Sale", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(width: 195,),
                  Expanded(
                    child: TextButton(onPressed: (){

                    }, child: Text("View All ->", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 10),)),
                  )
                ],
              ),
            SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10
              ),
              child: InkWell(
              onTap: (){
              },
              child:Container(
              width: 115,
              height: 150,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
              color: Colors.white,
              ),
              margin: EdgeInsets.only(left: 8, right: 8),
              child: Stack(
              children: [
              ClipRRect(
                      borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)
                      ),
                      child: Image.asset("assets/Images/daimond ring.jpeg",
                        fit: BoxFit.fitWidth, height: 115,),
              ),
              Padding(
              padding: const EdgeInsets.only(
              top: 115,
              left: 10
              ),
              child: Text("Silver Ring", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),),
              ),
              Padding(
              padding: const EdgeInsets.only(
              top: 130,
              left: 10
              ),
              child: Text("Rs.300" ,style: TextStyle( color:Color(0xFF4CAF50),fontSize: 12, fontWeight: FontWeight.w900),),
              ),
              Padding(
              padding: const EdgeInsets.only(
              left: 90,
                        bottom: 230
              ),
              child: IconButton(onPressed: (){

              }, icon: Icon(Icons.favorite_border_outlined, size: 15,color: Colors.deepOrange,)),
              )]
              ),
              ),
              ),
            ),
        InkWell(
          onTap: (){

          },
          child:Container(
            width: 115,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Colors.white,
            ),
            child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)
                    ),
                    child: Image.asset("assets/Images/daldaoil.jpeg",
                      height: 115, fit: BoxFit.fitWidth,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 115,
                        left: 10
                    ),
                    child: Text("Dalda Oil", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 130,
                        left: 10
                    ),
                    child: Text("Rs.100" ,style: TextStyle(color:Color(0xFF4CAF50),fontSize: 12, fontWeight: FontWeight.w900),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 90,
                        bottom: 230
                    ),
                    child: IconButton(onPressed: (){

                    }, icon: Icon(Icons.favorite_border_outlined, size: 15,color: Colors.deepOrange,)),
                  )]
            ),
          ),
        ),
        InkWell(
          onTap: (){

          },
          child:Container(
            width: 115,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(left: 8, right: 8),
            child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)
                    ),
                    child: Image.asset("assets/Images/iphone13.jpeg",
                      height: 115, fit: BoxFit.fitWidth,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 115,
                        left: 10
                    ),
                    child: Text("IPhone 13", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 130,
                        left: 10
                    ),
                    child: Text("Rs.200,000" ,style: TextStyle(color:Color(0xFF4CAF50),fontSize: 12, fontWeight: FontWeight.w900),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 90,
                        bottom: 230
                    ),
                    child: IconButton(onPressed: (){

                    }, icon: Icon(Icons.favorite_border_outlined, size: 15,color: Colors.deepOrange,)),
                  )]
            ),
          ),
        ),
        InkWell(
          onTap: (){

          },
          child:Container(
            width: 115,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Colors.white,
            ),
            child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)
                    ),
                    child: Image.asset("assets/Images/realmephonecase.jpeg",
                      height: 115, fit: BoxFit.fitWidth,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 115,
                        left: 10
                    ),
                    child: Text("Realme Covers", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 130,
                        left: 10
                    ),
                    child: Text("Rs.1200" ,style: TextStyle(color:Color(0xFF4CAF50),fontSize: 12, fontWeight: FontWeight.w900),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 90,
                        bottom: 230
                    ),
                    child: IconButton(onPressed: (){

                    }, icon: Icon(Icons.favorite_border_outlined, size: 15,color: Colors.deepOrange,)),
                  )]
            ),
          ),
        ),
        InkWell(
          onTap: (){

          },
          child:Container(
            width: 115,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(left: 8, right: 8),
            child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)
                    ),
                    child: Image.asset("assets/Images/pantcoat.jpeg",
                     height: 115, fit: BoxFit.fitWidth,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 115,
                        left: 10
                    ),
                    child: Text("Men's Coat", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 130,
                        left: 10
                    ),
                    child: Text("Rs.5000" ,style: TextStyle(color:Color(0xFF4CAF50),fontSize: 12, fontWeight: FontWeight.w900),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 90,
                      bottom: 230
                    ),
                    child: IconButton(onPressed: (){

                    }, icon: Icon(Icons.favorite_border_outlined, size: 15,color: Colors.deepOrange,)),
                  )]
            ),
          ),
        ),
        InkWell(
          onTap: (){

          },
          child:Container(
            width: 115,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(right: 10),
            child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)
                    ),
                    child: Image.asset("assets/Images/phonecase.jpeg",
                      height: 115, fit: BoxFit.fitWidth,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 115,
                        left: 10
                    ),
                    child: Text("IPhone Case", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 130,
                        left: 10
                    ),
                    child: Text("Rs.1500" ,style: TextStyle(color:Color(0xFF4CAF50),fontSize: 12, fontWeight: FontWeight.w900),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 90,
                        bottom: 230
                    ),
                    child: IconButton(onPressed: (){

                    }, icon: Icon(Icons.favorite_border_outlined, size: 15,color: Colors.deepOrange,)),
                  )]
            ),
          ),
        ),
            ] ),

            ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20
                    ),
                    child: Text("Recommended Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){

                      },
                      child:Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Container(
                          width: 170,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only( right: 7, bottom: 10),
                          child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)
                                  ),
                                  child: Image.asset("assets/Images/phonecase.jpeg",
                                    width: 170, height: 150, fit: BoxFit.fitWidth,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 150,
                                      left: 10
                                  ),
                                  child: Text("IPhone Case", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 170,
                                      left: 10
                                  ),
                                  child: Text("Rs.1500" ,style: TextStyle(color:Color(0xFF4CAF50),fontSize: 13, fontWeight: FontWeight.w900),),
                                ),
                                ]
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){

                      },
                      child:Padding(
                        padding: const EdgeInsets.only(
                            right: 20,
                          left: 10
                        ),
                        child: Container(
                          width: 170,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            color: Colors.white,
                          ),
                         margin: EdgeInsets.only( right: 5, bottom: 10),
                          child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)
                                  ),
                                  child: Image.asset("assets/Images/frock.jpeg",
                                    width: 190, height: 150, fit: BoxFit.fitWidth,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 150,
                                      left: 10
                                  ),
                                  child: Text("Girls Frock", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 170,
                                      left: 10
                                  ),
                                  child: Text("Rs.1200" ,style: TextStyle(color:Color(0xFF4CAF50),fontSize: 13, fontWeight: FontWeight.w900),),
                                ),
                              ]
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child:Padding(
                            padding: const EdgeInsets.only(
                                left: 20
                            ),
                            child: Container(
                              width: 170,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only( right: 5, bottom: 10),
                              child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)
                                      ),
                                      child: Image.asset("assets/Images/geometric engagemnetring.jpeg",
                                        width: 170, height: 150, fit: BoxFit.fitWidth,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 150,
                                          left: 10
                                      ),
                                      child: Text("Engagement Ring", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 170,
                                          left: 10
                                      ),
                                      child: Text("Rs.2000" ,style: TextStyle(color: Color(0xFF4CAF50),fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child:Padding(
                            padding: const EdgeInsets.only(
                                right: 20,
                                left: 10
                            ),
                            child: Container(
                              width: 170,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only( right: 5, bottom: 10),
                              child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)
                                      ),
                                      child: Image.asset("assets/Images/jewelry.jpeg",
                                        width: 190, height: 150, fit: BoxFit.fitWidth,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 150,
                                          left: 10
                                      ),
                                      child: Text("Necklace", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 170,
                                          left: 10
                                      ),
                                      child: Text("Rs.500" ,style: TextStyle(color:Color(0xFF4CAF50),fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child:Padding(
                            padding: const EdgeInsets.only(
                                left: 20
                            ),
                            child: Container(
                              width: 170,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only( right: 5, bottom: 10),
                              child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)
                                      ),
                                      child: Image.asset("assets/Images/sweaterdress.jpeg",
                                        width: 170, height: 150, fit: BoxFit.fitWidth,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 150,
                                          left: 10
                                      ),
                                      child: Text("Cardian Dress", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 170,
                                          left: 10
                                      ),
                                      child: Text("Rs.3000" ,style: TextStyle(color:Color(0xFF4CAF50),fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child:Padding(
                            padding: const EdgeInsets.only(
                                right: 20,
                                left: 10
                            ),
                            child: Container(
                              width: 170,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only( right: 5, bottom: 10),
                              child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)
                                      ),
                                      child: Image.asset("assets/Images/stainless set utensils.jpeg",
                                        width: 190, height: 150, fit: BoxFit.fitWidth,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 150,
                                        left: 10
                                      ),
                                      child: Text("Stainless Steel Set", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 170,
                                          left: 10
                                      ),
                                      child: Text("Rs.500" ,style: TextStyle(color:Color(0xFF4CAF50),fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child:Padding(
                            padding: const EdgeInsets.only(
                                left: 20
                            ),
                            child: Container(
                              width: 170,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only( right: 5, bottom: 10),
                              child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)
                                      ),
                                      child: Image.asset("assets/Images/silicon sticks.jpeg",
                                        width: 170, height: 150, fit: BoxFit.fitWidth,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 150,
                                          left: 10
                                      ),
                                      child: Text("Silicone Set", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 170,
                                          left: 10
                                      ),
                                      child: Text("Rs.800" ,style: TextStyle(fontSize: 13, color:Color(0xFF4CAF50),fontWeight: FontWeight.w900),),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child:Padding(
                            padding: const EdgeInsets.only(
                                right: 20,
                                left: 10
                            ),
                            child: Container(
                              width: 170,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only( right: 5, bottom: 10),
                              child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)
                                      ),
                                      child: Image.asset("assets/Images/setofrings.jpeg",
                                        width: 190, height: 150, fit: BoxFit.fitWidth,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 150,
                                          left: 10
                                      ),
                                      child: Text("Ring Sets", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 170,
                                          left: 10
                                      ),
                                      child: Text("Rs.500" ,style: TextStyle(fontSize: 13, color:Color(0xFF4CAF50),fontWeight: FontWeight.w900),),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child:Padding(
                            padding: const EdgeInsets.only(
                                left: 20
                            ),
                            child: Container(
                              width: 170,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only( right: 5, bottom: 10),
                              child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)
                                      ),
                                      child: Image.asset("assets/Images/semiformaldress.jpeg",
                                        width: 170, height: 150, fit: BoxFit.fitWidth,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 150,
                                          left: 10
                                      ),
                                      child: Text("Formal Dress", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 170,
                                          left: 10
                                      ),
                                      child: Text("Rs.900" ,style: TextStyle(fontSize: 13, color:Color(0xFF4CAF50),fontWeight: FontWeight.w900),),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child:Padding(
                            padding: const EdgeInsets.only(
                                right: 20,
                                left: 10
                            ),
                            child: Container(
                              width: 170,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only( right: 5, bottom: 10),
                              child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)
                                      ),
                                      child: Image.asset("assets/Images/samsungphonecase.jpeg",
                                        width: 190, height: 150, fit: BoxFit.fitWidth,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 150,
                                          left: 10
                                      ),
                                      child: Text("Galaxy A17 Phone Case", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 170,
                                          left: 10
                                      ),
                                      child: Text("Rs.1000" ,style: TextStyle(color:Color(0xFF4CAF50),fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child:Padding(
                            padding: const EdgeInsets.only(
                                left: 20
                            ),
                            child: Container(
                              width: 170,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only( right: 5, bottom: 10),
                              child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)
                                      ),
                                      child: Image.asset("assets/Images/salwar.jpeg",
                                        width: 170, height: 150, fit: BoxFit.fitWidth,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 150,
                                          left: 10
                                      ),
                                      child: Text("Eastern Dress", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 170,
                                          left: 10
                                      ),
                                      child: Text("Rs.3000" ,style: TextStyle(fontSize: 13, color:Color(0xFF4CAF50),fontWeight: FontWeight.w900),),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child:Padding(
                            padding: const EdgeInsets.only(
                                right: 20,
                                left: 10
                            ),
                            child: Container(
                              width: 170,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only( right: 5, bottom: 10),
                              child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)
                                      ),
                                      child: Image.asset("assets/Images/oilspray.jpeg",
                                        width: 190, height: 150, fit: BoxFit.fitWidth,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 150,
                                          left: 10
                                      ),
                                      child: Text("Oil Spray", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 170,
                                          left: 10
                                      ),
                                      child: Text("Rs.1100" ,style: TextStyle(fontSize: 13,color:Color(0xFF4CAF50), fontWeight: FontWeight.w900),),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
     ] ),
      ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: 0, 
              onTap: (int index) {
              },
              items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Color(0xFF4CAF50),),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Message',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity_rounded),
                label: 'Account',
              ),
              ],
          ),

    );
  }
  }