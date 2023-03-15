import 'dart:html';
import 'dart:html';

import 'add_textile.dart';
import 'create_product.dart';
import 'verify.dart';
import 'add_textile.dart';

import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'setup/firebase_options.dart';
import 'model/home_model.dart';
import 'setup/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:convert/convert.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    Key key,
  }) : super(key: key);
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String dropDownValue;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => Scaffold(
              key: scaffoldKey,
              backgroundColor: Colors.lightGreen,
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  loginForm(context, model);
                },
                backgroundColor: Colors.amber,
                icon: Icon(
                  Icons.vpn_key_rounded,
                ),
                elevation: 8,
                label: Container(),
              ),
              body: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  '../assets/images/appbar_up.png',
                                ).image,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 0, 24, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 20, 20, 20),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    //NavBarPage(initialPage: 'QR_track'),
                                                    MobileScanner(
                                                      allowDuplicates: false,
                                                      onDetect:
                                                          ((barcode, args) {
                                                        if (barcode.rawValue ==
                                                            null) {
                                                          debugPrint(
                                                              'Failed to scan qrcode');
                                                        } else {
                                                          final String code =
                                                              barcode.rawValue;
                                                          debugPrint(
                                                              'qrcode found $code');
                                                          setState(() {});
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      VerifyWidget(
                                                                          code:
                                                                              code)));
                                                        }
                                                      }),
                                                    )
                                                //VerifyWidget(),
                                                ),
                                          );
                                        },
                                        text: 'Verify',
                                        options: FFButtonOptions(
                                          width: 200,
                                          height: 50,
                                          color: Colors.pink,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .subtitle2
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    if (model.userState == 'Admin')
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 20),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            !model.isUserLogged
                                                ? showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "User not logged in"),
                                                        content: Text(
                                                            "You can not use this function wihtout being logged. Please log in."),
                                                        actions: [
                                                          TextButton(
                                                            child: Text("OK"),
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                          ),
                                                        ],
                                                      );
                                                      ;
                                                    },
                                                  )
                                                : await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddTextileWidget()),
                                                  );
                                          },
                                          text: 'Add',
                                          options: FFButtonOptions(
                                            width: 200,
                                            height: 50,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle2
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    if (model.userState == 'Admin')
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 24, 0, 0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            !model.isUserLogged
                                                ? showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "User not logged in"),
                                                        content: Text(
                                                            "You can not use this function wihtout being logged. Please log in."),
                                                        actions: [
                                                          TextButton(
                                                            child: Text("OK"),
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                          ),
                                                        ],
                                                      );
                                                      ;
                                                    },
                                                  )
                                                : await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CreateProductWidget(),
                                                    ),
                                                  );
                                          },
                                          text: 'Create',
                                          options: FFButtonOptions(
                                            width: 200,
                                            height: 50,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle2
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                            elevation: 3,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 44, 0, 30),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          FlutterFlowDropDown(
                                            initialOption:
                                                (model.userState == null)
                                                    ? 'User'
                                                    : model.userState,
                                            options: ['User', 'Admin'],
                                            onChanged: (val) => {
                                              model.setUserStateDropDown(
                                                  context, val),
                                              dropDownValue = val,
                                              setState(() {
                                                dropDownValue = val;
                                              })
                                            },
                                            width: 180,
                                            height: 50,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color: Colors.black,
                                                    ),
                                            hintText: 'Please select...',
                                            fillColor: Colors.white,
                                            elevation: 2,
                                            borderColor: Colors.transparent,
                                            borderWidth: 0,
                                            borderRadius: 0,
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 4, 12, 4),
                                            hidesUnderline: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

loginForm(BuildContext context, HomeViewModel viewModel) {
  final loginController = TextEditingController();

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Login'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: loginController,
                    decoration: InputDecoration(
                      labelText: viewModel.key == null
                          ? 'Private key'
                          : viewModel.key.privateKey
                              .map((x) => x.toRadixString(16))
                              .toList()
                              .join(),
                      icon: Icon(Icons.key),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
                child: Text("Submit"),
                onPressed: () {
                  viewModel.login(context, loginController.text);
                })
          ],
        );
      });
}
