// import 'package:flutter/material.dart';
//
// class RecordMobileLayout extends StatefulWidget {
//   const RecordMobileLayout({super.key});
//
//   @override
//   State<RecordMobileLayout> createState() => _RecordMobileLayoutState();
// }
//
// class _RecordMobileLayoutState extends State<RecordMobileLayout> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
//
// class RecordTabletLayout extends StatefulWidget {
//   const RecordTabletLayout({super.key});
//
//   @override
//   State<RecordTabletLayout> createState() => _RecordTabletLayoutState();
// }
//
// class _RecordTabletLayoutState extends State<RecordTabletLayout> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Visibility(
//             visible: showSend,
//             child: const Column(
//               children: [
//                 Text('STEP TWO:', style: TextStyle(fontWeight: FontWeight.bold),),
//                 SizedBox(height: 5,),
//                 Text("PRESS 'SEND' WHEN YOU'RE HAPPY"),
//                 Text("WITH YOUR bLOVE MESSAGE AND ARE"),
//                 Text("READY TO SEND IT TO YOUR bLOVE"),
//                 Text("BEAR."),
//                 //SizedBox(height: 40,),
//               ],
//             )
//         ),
//         Visibility(
//             visible: !showSend,
//             child: const Column(
//               children: [
//                 Text('STEP ONE:', style: TextStyle(fontWeight: FontWeight.bold),),
//                 SizedBox(height: 5,),
//                 Text('PRESS THE RED ICON TO RECORD YOUR'),
//                 Text('bLOVE MESSAGE.'),
//                 //SizedBox(height: 40,),
//               ],
//             )
//         ),
//         const SizedBox(height: 40,),
//         Visibility(
//           visible: showRecording,
//           child: IconButton(
//             icon: SvgPicture.asset('assets/RecordButtonBig.svg', width: 150, height: 150,),
//             padding: EdgeInsets.zero,
//             onPressed: recordButtonPressed,
//           ),
//         ),
//         Visibility(
//           visible: showStop,
//           child: IconButton(
//               icon: SvgPicture.asset('assets/StopButtonBig.svg', width: 150, height: 150,),
//               padding: EdgeInsets.zero,
//               onPressed: stopRecording
//           ),
//         ),
//         Visibility(
//           visible: showSend,
//           child: IconButton(
//             icon: SvgPicture.asset('assets/HeartSubmitButtonBig.svg' , width: 150, height: 150,),
//             padding: EdgeInsets.zero,
//             onPressed: () {
//               confettiController.play();
//               setState(() {
//                 showSend = !showSend;
//                 showRecording = !showRecording;
//               });
//             },
//           ),
//         ),
//         if(showSend)
//           Column(
//             children: [
//               TextButton(
//                 onPressed: playRecording,
//                 child: const Text('Play Recording', style: TextStyle(color: AppColors.heartRed, fontSize: 20),),
//               ),
//               TextButton(
//                 onPressed: reset,
//                 child: const Text('Reset', style: TextStyle(color: AppColors.heartRed),),
//               ),
//             ],
//           ),
//         const SizedBox(height: 20,),
//         Text(bear, style: const TextStyle(fontSize: 20),),
//         const SizedBox(height: 10,),
//         SvgPicture.asset(currentBearImage, width: 250, height: 250,),
//       ],
//     );
//   }
// }
//
//
//
// class RecordDesktopLayout extends StatefulWidget {
//   const RecordDesktopLayout({super.key});
//
//   @override
//   State<RecordDesktopLayout> createState() => _RecordDesktopLayoutState();
// }
//
// class _RecordDesktopLayoutState extends State<RecordDesktopLayout> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
//
//
