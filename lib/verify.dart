import 'package:stacked/stacked.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import 'model/verify_product_model.dart';

class VerifyWidget extends StatefulWidget {
  const VerifyWidget({Key key, this.code}) : super(key: key);
  final String code;

  @override
  _VerifyWidgetState createState() => _VerifyWidgetState();
}

class _VerifyWidgetState extends State<VerifyWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final qrcode = widget.code;
    String qrcode = '0xc542911d7910ad76776ce298baa469a0d142fb3c';
    debugPrint(qrcode);
    return ViewModelBuilder<VerifyProductModel>.nonReactive(
        viewModelBuilder: () => VerifyProductModel(),
        onModelReady: (model) async =>
            await model.verifyQRCode(context, qrcode),
        builder: (context, model, child) => Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              appBar: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 60,
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeWidget(),
                      ),
                    );
                  },
                ),
                title: Text(
                  'Verify',
                  style: FlutterFlowTheme.of(context).title2.override(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 22,
                      ),
                ),
                actions: [],
                centerTitle: false,
                elevation: 2,
              ),
              body: SafeArea(
                child: GestureDetector(
                  onTap: () =>
                      FocusScope.of(context).requestFocus(_unfocusNode),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.network(
                              '../assets/images/appbar_up.png',
                              width: MediaQuery.of(context).size.width,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 390,
                                      height: 354,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/13/600',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: Text(
                            'VERIFIED',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Outfit',
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: GridView(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1,
                                ),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: [
                                  ListView(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 0, 0),
                                          child: Text(
                                            'Item ID:',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 0, 0),
                                          child: Text(
                                            'Components ID:',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 0, 0),
                                          child: Text(
                                            'jbsakjbcbasjcbjascjjcascjlal',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 0, 0),
                                          child: Text(
                                            'wvacfsdvcesascsadvaedsvcvsfd',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
