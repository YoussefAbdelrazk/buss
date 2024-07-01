import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Presentation/HomePage.dart';
import '../Presentation/LoginPage.dart';
import '../main.dart';

// class ImageWithTextPage extends StatelessWidget {
//   final String imageUrl;
//   final String text;

//   const ImageWithTextPage(
//       {super.key, required this.imageUrl, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.90,
//             child: Image.asset(
//               imageUrl,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             bottom: 35,
//             left: 50,
//             child: Text(
//               text,
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ImageSliderPage extends StatefulWidget {
  const ImageSliderPage({super.key});

  @override
  State<ImageSliderPage> createState() => _ImageSliderPageState();
}

class _ImageSliderPageState extends State<ImageSliderPage> {
  PageController pageController = PageController();
  // final List<ImageWithTextPage> pages = [
  //   const ImageWithTextPage(
  //     imageUrl: 'assets/PageView1.jpg',
  //     text: 'This is the first page',
  //   ),
  //   const ImageWithTextPage(
  //     imageUrl: 'assets/PageView2.jpg',
  //     text: 'Book And Pay',
  //   ),
  //   const ImageWithTextPage(
  //     imageUrl: 'assets/PageView3.jpg',
  //     text: 'Join Now To Our App',
  //   ),
  // ];

  List<String> Pages = [
    'assets/PageView1.jpg',
    'assets/PageView2.jpg',
    'assets/PageView3.jpg',
  ];
  List<String> Texts = [
    'Try Our App',
    'Book Your Ticket Now',
    'Join Our Application',
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: Pages.length,
      controller: pageController,
      itemBuilder: (context, index) => Scaffold(
        body: Stack(children: [
          const SizedBox.expand(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Image.asset(
              Pages[index],
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                // Handle last page scenario (optional)
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => _handleInitialScreen(),
                  ),
                );
              }, // Call the provided function
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                if (pageController.page!.toInt() < Pages.length - 1) {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                } else {
                  // Handle last page scenario (optional)
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => _handleInitialScreen(),
                    ),
                  );
                }
              }, // Call the provided function
              child: const Icon(Icons.navigate_next),
            ),
          ),
          Positioned(
            bottom: 100,
            right: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              Texts[index],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
    );
  }

  Widget _handleInitialScreen() {
    final String? userId = sharedPref.getString('id');

    if (userId == null) {
      return const LoginPage(); // Login screen if no ID
    } else {
      return HomePage(
        userName: sharedPref
            .getString('username')
            .toString(), // Handle potential nulls
        password: sharedPref
            .getString('password')
            .toString(), // Handle potential nulls
      );
    }
  }
}
