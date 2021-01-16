import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:game_app_flutter/app/AppState.dart';
import 'package:game_app_flutter/config.dart';
import 'package:game_app_flutter/personas/PersonaAction.dart';
import 'package:game_app_flutter/player/PlayerState.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

@immutable
class PlayerAction {
  final PlayerState state;

  PlayerAction(this.state);

  static Future<void> loginAction({Store<AppState> store, refreshToken, function}) async {
    try {
      final result = await function();
      await secureStorage.write(key: 'refresh_token', value: result.refreshToken ?? refreshToken);
      await store.dispatch(PlayerAction(PlayerState(
        idToken: parseIdToken(result.idToken),
        profile: await getUserDetails(result.accessToken),
      )));
      await store.dispatch(PersonaAction.loadPersonas);
      return store.dispatch(PlayerAction(PlayerState(
        isLoading: false,
        isError: false,
        isLoggedIn: true,
      )));
    } catch (e, s) {
      print('login error: $e - stack: $s');
      return store.dispatch(PlayerAction(PlayerState(
        isLoading: false,
        isError: false,
        isLoggedIn: false,
      )));
    }
  }

  static Future<void> playerTryQuickLoginAction(Store<AppState> store) async {
    store.dispatch(PlayerAction(PlayerState(isLoading: true)));
    final refreshToken = await secureStorage.read(key: 'refresh_token');
    if (refreshToken == null) return store.dispatch(PlayerAction(PlayerState(isLoading: false)));
    return loginAction(
      store: store,
      refreshToken: refreshToken,
      function: () async => await appAuth.token(TokenRequest(AUTH0_CLIENT_ID, AUTH0_REDIRECT_URI, issuer: AUTH0_ISSUER, refreshToken: refreshToken)),
    );
  }

  static Future<void> playerLoginAction(Store<AppState> store) async {
    store.dispatch(PlayerAction(PlayerState(isLoading: true)));
    return loginAction(
      store: store,
      function: () async => await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(AUTH0_CLIENT_ID, AUTH0_REDIRECT_URI, issuer: 'https://$AUTH0_DOMAIN', scopes: ['openid', 'profile', 'offline_access'], promptValues: ['login']),
      ),
    );
  }

  static Future<void> playerLogoutAction(Store<AppState> store) async {
    store.dispatch(PlayerAction(PlayerState(isLoading: true)));
    await secureStorage.delete(key: 'refresh_token');
    store.dispatch(PlayerAction(PlayerState.initial()));
  }
}

Map<String, dynamic> parseIdToken(String idToken) {
  final parts = idToken.split(r'.');
  assert(parts.length == 3);
  return jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
}

Future<Map<String, dynamic>> getUserDetails(String accessToken) async {
  final url = 'https://$AUTH0_DOMAIN/userinfo';
  final response = await get(url, headers: {'Authorization': 'Bearer $accessToken'});
  if (response.statusCode == 200) return jsonDecode(response.body);
  throw Exception('Failed to get user details');
}
