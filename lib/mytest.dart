// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:jahez/models/ViewModels/ServiceProviderVM.dart';
// import 'package:jahez/screens/serviceProviderScreens/SPOrdersScreens/currentSPOrdersScreen.dart';
// import 'package:jahez/screens/serviceProviderScreens/SPOrdersScreens/finishedSPOrdersScreen.dart';
// import 'package:jahez/services/app_localization.dart';
// import 'package:jahez/services/UserPreferences.dart';
//
// import '../../constants.dart';
// import 'SPOrdersScreens/ongoingSPOrdersScreen.dart';
// import 'getServiceProviderCompInfoScreen.dart';
//
// class SPHomeScreen extends StatefulWidget {
//   static String id = 'CusOrdersScreen';
//
//   @override
//   _SPHomeScreenState createState() => _SPHomeScreenState();
// }
//
// class _SPHomeScreenState extends State<SPHomeScreen> {
//   ServiceProviderInfoVM getServiceProInfo;
//
//   var _screenHeight;
//
//   var _screenWidth;
//
//   var _isPortrait;
//
//   var height_X_width;
//
//   var textStyle2;
//
//   var textStyle1;
//   var textTitleStyle;
//
//   List<Widget> containers = [];
//
//   @override
//   void initState() {
//     getServiceProInfo = UserPreferences().getServiceProviderInfo;
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _screenHeight = MediaQuery.of(context).size.height;
//     _screenWidth = MediaQuery.of(context).size.width;
//     _isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
//     height_X_width = _screenHeight * _screenWidth;
//
//     textTitleStyle = TextStyle(
//         fontFamily: 'Main',
//         fontWeight: FontWeight.bold,
//         fontSize:
//         _isPortrait ? height_X_width * .00008 : height_X_width * .000099);
//     textStyle1 = TextStyle(
//         fontFamily: 'Main',
//         fontWeight: FontWeight.bold,
//         fontSize:
//         _isPortrait ? height_X_width * .000056 : height_X_width * .00006);
//     textStyle2 = TextStyle(
//       fontFamily: 'Main',
//       fontSize: _isPortrait ? height_X_width * .000048 : height_X_width * .00005,
//     );
//     containers = [
//       getServiceProInfo.accountStatus == "NewUser"
//           ? netificationToGerServiceProInfo(context)
//           : getServiceProInfo.accountStatus == "UnderReview"
//           ? yourAccountUnderReview(context)
//           : OngoingSPOrders(),
//       //////////////////////////////////////////////////
//       getServiceProInfo.accountStatus == "NewUser"
//           ? netificationToGerServiceProInfo(context)
//           : getServiceProInfo.accountStatus == "UnderReview"
//           ? yourAccountUnderReview(context)
//           : CurrentSPOrders(),
//       //////////////////////////////////////////////////
//       getServiceProInfo.accountStatus == "NewUser"
//           ? netificationToGerServiceProInfo(context)
//           : getServiceProInfo.accountStatus == "UnderReview"
//           ? yourAccountUnderReview(context)
//           : FinishedSPOrders(),
//     ];
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: kMainColor,
//           title: Center(
//             child: Text(
//               '${AppLocalization.of(context).translate('home')}',
//               style: textStyle1,
//             ),
//           ),
//           bottom: TabBar(
//             labelStyle: textStyle2,
//             tabs: <Widget>[
//               Tab(
//                 text:
//                 '${AppLocalization.of(context).translate('ongoingOrders')}',
//               ),
//               Tab(
//                 text:
//                 '${AppLocalization.of(context).translate('myCurrentOrders')}',
//               ),
//               Tab(
//                 text:
//                 '${AppLocalization.of(context).translate('myFinishedOrders')}',
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: containers,
//         ),
//       ),
//     );
//   }
//
//   netificationToGerServiceProInfo(context) {
//     return ListView(
//       children: [
//         Container(
//           height: _isPortrait ? _screenHeight * .7 : _screenWidth * .8,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Material(
//                 color: Colors.white,
//                 elevation: 12.0,
//                 // borderOnForeground: true,
//                 borderRadius: BorderRadius.circular(10.0),
//                 shadowColor: Color(0x802196F3),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(
//                         height: _screenHeight * .02,
//                       ),
//                       Text(
//                         '${AppLocalization.of(context).translate('hi')}: ${getServiceProInfo.firstName}',
//                         style: textTitleStyle,
//                       ),
//                       Text(
//                         '${AppLocalization.of(context).translate('SP_home_boxGetInfo_youShouldHint')}:',
//                         style: textStyle2,
//                       ),
//                       Row(
//                         children: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pushNamed(
//                                   context, GetServiceProviderCompInfoScreen.id);
//                             },
//                             child: Text(
//                               '${AppLocalization.of(context).translate('SP_home_boxGetInfo_CompRegInfoHint')}:',
//                               style: TextStyle(
//                                   fontFamily: 'Main',
//                                   fontSize: _isPortrait
//                                       ? height_X_width * .000067
//                                       : height_X_width * .000067),
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: _screenHeight * .02,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       AppLocalization.of(context)
//                           .translate('SP_home_boxGetInfo_noOrdersHint'),
//                       style: textStyle2,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   yourAccountUnderReview(context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               AppLocalization.of(context)
//                   .translate('hi'),
//               style: textStyle1,
//             ),
//             Text(' ${getServiceProInfo.firstName}',
//               style: textStyle1,
//             ),
//           ],
//         ),
//         Text(
//           AppLocalization.of(context)
//               .translate('SP_home_yourAccUnderReview_hint'),
//           style: textStyle2,
//         ),
//       ],
//     );
//   }
// }
