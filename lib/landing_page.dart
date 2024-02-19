import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController(keepPage: false, viewportFraction: 1);
  List<LandingObject> myObject = [
    LandingObject(
      title: "Rain",
        lottie:
            "https://lottie.host/159bb034-37f7-4d04-a3aa-6f81d71f0199/v4uw7Qemqa.json",
        text: "The pitter-patter of raindrops creates a soothing symphony, embracing earth with tranquility."),
    LandingObject(
      title: "Cloudy",
        lottie:
            "https://lottie.host/c705fc44-6282-40a9-bb8b-438fd5ccb59a/rzFSAoSN9E.json",
        text: "The sky veiled in gray, whispers of impending rain, a serene ambiance fills the air."),
    LandingObject(
      title: "Thunder",
        lottie:
            "https://lottie.host/35a18723-7e14-4d96-aa71-c8fea5610217/NzzzrO6IkF.json",
        text: "Thunder roars, lightning strikes, nature's fierce display illuminates the darkened skies with brilliance."),
    LandingObject(
      title: "Snow",
        lottie:
            "https://lottie.host/2ee3ce7f-8abf-44ef-8476-58a3a3a66932/X8Pjtx45Y5.json",
        text: 
"Snowflakes gently fall, blanketing the earth in a serene white coat, winter's tranquil embrace.")
  ];
  int currentPage = 0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    pageListener();
  }

  pageListener() {
    _pageController.addListener(() {
      /* int page = _pageController.page!.toInt();
      setState(() {
        currentPage = page;
        if (page != currentPage) {
          _controller.repeat();
        }
      }); */
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: myObject.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(myObject[index].title, style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Lottie.network(myObject[index].lottie),
                  SizedBox(
                    height: 30,
                  ),
                  FadeInRight(
                    duration: Duration(seconds: 2),
                      controller: (controller) => _controller = controller,
                      child: Text(myObject[index].text, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),))
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        height: 120,
        child: Column(
          children: [
            Center(
              child: SmoothPageIndicator(
                  controller: _pageController,
                  count: myObject.length,
                  effect: ExpandingDotsEffect(
                      dotHeight: 5,
                      dotWidth: 5,
                      dotColor: Colors.green,
                      activeDotColor: Colors.blue)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    print(_pageController.page);
                    _controller.reset();
                    _controller.forward();
                    setState(() {
                      currentPage = currentPage+1;
                    });
                    _pageController.animateToPage(currentPage, duration: Duration(seconds: 1), curve: Curves.ease);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      (_pageController.hasClients)?(_pageController.page ==2.0)?"Get Started":"Next":"Next",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LandingObject {
  String title;
  String lottie;
  String text;
  LandingObject({required this.title, required this.lottie, required this.text});
}
