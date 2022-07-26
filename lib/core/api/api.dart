// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'dart:ui';
// import 'package:dummy_api/core/api/base_api.dart';
// import 'package:dummy_api/core/constant/b7c_constant.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class API {
//   ///overriden to true if end not in dev
//   static const _post = "post";
//   static const _get = "get";
//   static const _timeout = 300;

//   static Future get(
//       BuildContext context, String path, Map<String, Object> reqBody) async {
//     return await _fetch(context, _get, path, reqBody, true);
//   }

//   static Future post(
//       BuildContext context, String path, Map<String, Object> reqBody) async {
//     return await _fetch(context, _post, path, reqBody, true);
//   }

//   static Future _fetch(BuildContext? context, String method, String path,
//       Map<String, Object?> reqBodyMap, bool loading) async {
//     log("reqBodyMap : $reqBodyMap");
//     log("path : $path");
//     bool _error = false;

//     if (loading) await _showLoading(context!);

//     var resJson = await BaseApi().dio.get(path, queryParameters: reqBodyMap);

//     http.Response response;

//     Map<String, String> headers = {};
//     headers['content-type'] = "application/json";
//     reqBodyMap['limit'] = B7CConstants.limit;

//     var reqBody = json.encode(reqBodyMap);

//     final String url = B7CConstants.baseUrl + path;
//     var logStr = "";
//     logStr += "Request Begin -- [$method] $url";
//     logStr += "\t\n[Request Body Raw] : \n\t$reqBody";

//     logStr += "\t\n[Request Headers] : \n\t$headers";
//     logStr += "\t\n[Request Body] : \n\t$reqBody";
//     var start = DateTime.now().millisecondsSinceEpoch;
//     try {
//       if (method == _post) {
//         response = await http
//             .post(Uri.parse(url), headers: headers, body: reqBody)
//             .timeout(const Duration(seconds: _timeout), onTimeout: () {
//           _error = true;
//           if (loading) Navigator.pop(context!);
//           _showAlert(context, 'Server Timeout');
//           logStr += ("\n:: PROCESS TIME OUT! ::");
//           // ignore: null_argument_to_non_null_type
//           return Future.value();
//         });
//       } else {
//         response = await http
//             .get(Uri.parse(url))
//             .timeout(const Duration(seconds: _timeout));
//       }
//       // ignore: unnecessary_null_comparison
//       if (response != null) {
//         logStr += "\t\n[Response Code] : \n\t${response.statusCode}";

//         if (response.statusCode == 200) {
//           // ignore: unnecessary_null_comparison
//           if (response.body != null) {
//             logStr +=
//                 "\t\n[Response Headers] : \n\t${response.headers.toString()}";
//             // log += "\t\n[Response Raw] : \n\t${response.body.toString()}";
//             // ignore: prefer_typing_uninitialized_variables
//             var respDecode;

//             respDecode = json.decode(response.body);
//             logStr += "\t\n[Response Body] : \n\t${response.body.toString()}";

//             return respDecode;
//           } else {
//             _error = true;
//             if (loading) Navigator.pop(context!);
//             _showAlert(context, "Server Bermasalah");
//           }
//         } else if (response.statusCode == 401) {
//           _error = true;

//           _showAlert(context, "Server Bermasalah");
//           return null;
//         } else if (response.statusCode == 403) {
//           _error = true;

//           _showAlert(context, "Server Bermasalah");
//           return null;
//         } else if (response.statusCode == 503) {
//           _error = true;
//           _showAlert(context, 'Server tidak dapat dijangkau');

//           return null;
//         } else if (response.statusCode == 502) {
//           _error = true;
//           _showAlert(context, 'Server tidak dapat dijangkau');
//         } else {
//           _error = true;
//           if (loading) Navigator.pop(context!);
//           _showAlert(context, '(${response.statusCode})');
//           logStr +=
//               "\nERROR : ${response.reasonPhrase} (${response.statusCode})";
//           return null;
//         }
//       } else {
//         _error = true;
//         if (loading) Navigator.pop(context!);
//         _showAlert(context, 'Tidak ada respon dari server');
//         logStr += "\nERROR : ${response.toString()}";
//       }
//     } on FormatException catch (_) {
//       _error = true;
//       if (loading) Navigator.pop(context!);
//       _showAlert(context, 'Response Error from system');
//     } on http.ClientException catch (_) {
//       _error = true;
//       if (loading) Navigator.pop(context!);
//     } on HttpException catch (_) {
//       _error = true;
//       if (loading) Navigator.pop(context!);
//     } on SocketException catch (_) {
//       _error = true;
//       if (loading) Navigator.pop(context!);
//       _showAlert(context, 'Server tidak dapat dijangkau');
//     } finally {
//       if (!_error && loading) Navigator.pop(context!);
//       var end = DateTime.now().millisecondsSinceEpoch;
//       logStr += "\n--> ${end - start}ms";
//       if (kDebugMode) {
//         log(logStr);
//       }
//     }
//   }
// }

// _showAlert(context, message) {
//   return AlertDialog(
//     elevation: 6,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(25),
//     ),
//     title: const Center(
//         child: Text(
//       'Ops Terjadi Kesalahan',
//       style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
//     )),
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           message!,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ],
//     ),
//   );
// }

// _showLoading(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) {
//       return WillPopScope(
//         onWillPop: () async => false,
//         child: Stack(
//           children: [
//             Positioned.fill(
//                 child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                     child: Container(
//                       color: Colors.white12,
//                     ))),
//             const Center(
//                 child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
//             ))
//           ],
//         ),
//       );
//     },
//   );
// }
