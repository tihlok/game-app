import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:game_app_flutter/auth0.dart';
import 'package:game_app_flutter/login.dart';
import 'package:game_app_flutter/profile.dart';
import 'package:game_app_flutter/tab.dart';
import 'package:http/http.dart';

void main() => runApp(RPGApp());

class RPGApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG',
      theme: ThemeData(
          primaryColor: Colors.red[900],
          accentColor: Colors.white,
          scaffoldBackgroundColor: Color(0xFF1F1F1F),
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: Colors.red[900],
          )),
      home: AppPage(title: 'RPG'),
    );
  }
}

class AppPage extends StatefulWidget {
  AppPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage;
  Map<String, Map<String, dynamic>> player;

  @override
  void initState() {
    if (!kIsWeb)
      initAction();
    else
      initWeb();
    super.initState();
  }

  void initAction() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) return;

    setState(() {
      isBusy = true;
    });

    try {
      final response = await appAuth.token(TokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        refreshToken: storedRefreshToken,
      ));
      final idToken = parseIdToken(response.idToken);
      final profile = await getUserDetails(response.accessToken);
      secureStorage.write(key: 'refresh_token', value: response.refreshToken ?? storedRefreshToken);
      setState(() {
        isBusy = false;
        isLoggedIn = true;
        player = {"idToken": idToken, "profile": profile};
      });
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction();
    }
  }

  void initWeb() async {}

  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);
    return jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<Map<String, dynamic>> getUserDetails(String accessToken) async {
    final url = 'https://$AUTH0_DOMAIN/userinfo';
    final response = await get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to get user details');
  }

  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final AuthorizationTokenResponse result = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(AUTH0_CLIENT_ID, AUTH0_REDIRECT_URI, issuer: 'https://$AUTH0_DOMAIN', scopes: ['openid', 'profile', 'offline_access'], promptValues: ['login']),
      );
      final idToken = parseIdToken(result.idToken);
      final profile = await getUserDetails(result.accessToken);
      await secureStorage.write(key: 'refresh_token', value: result.refreshToken);
      setState(() {
        isBusy = false;
        isLoggedIn = true;
        player = {"idToken": idToken, "profile": profile};
      });
    } catch (e, s) {
      print('login error: $e - stack: $s');
      setState(() {
        isBusy = false;
        isLoggedIn = false;
        errorMessage = e.toString();
      });
    }
  }

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    setState(() {
      isLoggedIn = false;
      isBusy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TabData(icon: Icons.settings, page: Profile(logoutAction, player)),
    ];

    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: isLoggedIn
              ? AppBar(
                  title: Center(child: Text("RPG")),
                  bottom: TabBar(tabs: tabs.map((e) => e.tab).toList()),
                )
              : null,
          body: Center(
            child: isBusy
                ? CircularProgressIndicator()
                : isLoggedIn
                    ? TabBarView(children: tabs.map((e) => e.page).toList())
                    : Login(loginAction, errorMessage),
          ),
        ));
  }
}
