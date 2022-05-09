// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:udhaarkaroapp/constants/constants.dart';
// import 'package:udhaarkaroapp/controllers/confirmation_controller.dart';
// import 'package:udhaarkaroapp/controllers/controllers.dart';
// import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
// import 'package:udhaarkaroapp/widgets/widgets.dart';
//
// class ConfirmationsList extends StatefulWidget {
//   @override
//   _ConfirmationsListState createState() => _ConfirmationsListState();
// }
//
// class _ConfirmationsListState extends State<ConfirmationsList> {
//   final BasicController _basicController = Get.find(tag: "basic-control");
//   final _confirmationController =
//       Get.put(ConfirmationController(), tag: "confirmation");
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     if (_confirmationController.confirmationList.isEmpty) {
//       _confirmationController.load.value = 1;
//     }
//     super.initState();
//
//     NotificationCheck().check(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor:
//             (!_basicController.dark.value) ? whiteColor : blackColor,
//         body: Stack(
//           children: [
//             CustomScrollView(
//               slivers: [
//                 SliverHeader(text: LanguageController().getText(confirmHeaderTxt),),
//                 SliverList(
//                   delegate: SliverChildListDelegate([
//                     SingleChildScrollView(
//                       child: SizedBox(
//                         height: displayHeight(context) * 0.78,
//                         child: Scrollbar(
//                           controller: _scrollController,
//                           thickness: 7,
//                           radius: const Radius.circular(20),
//                           child: Obx(() {
//                             if (_confirmationController.load.value == 0) {
//                               if (_confirmationController
//                                   .confirmationList.isNotEmpty) {
//                                 _confirmationController.response.value = "no data";
//                                 return ListView.builder(
//                                   physics: const BouncingScrollPhysics(),
//                                   shrinkWrap: true,
//                                   itemCount: _confirmationController
//                                       .confirmationList.length,
//                                   itemBuilder: (context, index) {
//                                     return ConfirmationCard(
//                                       str: _confirmationController
//                                           .confirmationList[index],
//                                     );
//                                   },
//                                 );
//                               } else if (_confirmationController.response.value ==
//                                   "error") {
//                                 return ErrorScreen(
//                                   text:
//                                   LanguageController().getText(errorTxt),
//                                 );
//                               } else {
//                                 return NoDataScreen(
//                                   text: LanguageController().getText(noConfirmDataTxt),
//                                 );
//                               }
//                             } else {
//                               return const Text("");
//                             }
//                           }),
//                         ),
//                       ),
//                     )
//                   ]),
//                 ),
//               ],
//             ),
//             Obx(
//               () => Center(
//                 child: FoldingCubeLoader(
//                   load: _confirmationController.load.value,
//                   bgContainer: false,
//                   color: (_basicController.dark.value)
//                       ? whiteColor
//                       : darkBlueColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
