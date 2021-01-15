import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:game_app_flutter/auth0.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import 'app.dart';

@immutable
class PlayerState {
  final bool isError;
  final bool isLoading;
  final bool isLoggedIn;
  final Map<String, dynamic> idToken;
  final Map<String, dynamic> profile;

  const PlayerState({
    this.isError,
    this.isLoading,
    this.isLoggedIn,
    this.idToken,
    this.profile,
  });

  factory PlayerState.initial() => PlayerState(
        isError: false,
        isLoading: false,
        isLoggedIn: false,
        idToken: null,
        profile: null,
      );

  PlayerState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required bool isLoggedIn,
    @required Map<String, dynamic> idToken,
    @required Map<String, dynamic> profile,
  }) =>
      PlayerState(
        isError: isError ?? this.isError,
        isLoading: isLoading ?? this.isLoading,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        idToken: idToken ?? this.idToken,
        profile: profile ?? this.profile,
      );
}

@immutable
class SetPlayerStateAction {
  final PlayerState state;

  SetPlayerStateAction(this.state);
}

playerReducer(PlayerState state, SetPlayerStateAction action) {
  final payload = action.state;
  return state.copyWith(
    isError: payload.isError,
    isLoading: payload.isLoading,
    isLoggedIn: payload.isLoggedIn,
    idToken: payload.idToken,
    profile: payload.profile,
  );
}

Future<void> playerTryQuickLoginAction(Store<AppState> store) async {
  store.dispatch(SetPlayerStateAction(PlayerState(isLoading: true)));
  final refreshToken = await secureStorage.read(key: 'refresh_token');
  if (refreshToken == null) return store.dispatch(SetPlayerStateAction(PlayerState(isLoading: false)));
  try {
    final result = await appAuth.token(TokenRequest(
      AUTH0_CLIENT_ID,
      AUTH0_REDIRECT_URI,
      issuer: AUTH0_ISSUER,
      refreshToken: refreshToken,
    ));
    secureStorage.write(key: 'refresh_token', value: result.refreshToken ?? refreshToken);
    return store.dispatch(SetPlayerStateAction(PlayerState(
      isLoading: false,
      isError: false,
      isLoggedIn: true,
      idToken: parseIdToken(result.idToken),
      profile: await getUserDetails(result.accessToken),
    )));
  } catch (e, s) {
    print('error on refresh token: $e - stack: $s');
    return store.dispatch(SetPlayerStateAction(PlayerState(
      isLoading: false,
      isError: true,
      isLoggedIn: false,
    )));
  }
}

Future<void> playerLoginAction(Store<AppState> store) async {
  store.dispatch(SetPlayerStateAction(PlayerState(isLoading: true)));
  try {
    final AuthorizationTokenResponse result = await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(AUTH0_CLIENT_ID, AUTH0_REDIRECT_URI, issuer: 'https://$AUTH0_DOMAIN', scopes: ['openid', 'profile', 'offline_access'], promptValues: ['login']),
    );
    await secureStorage.write(key: 'refresh_token', value: result.refreshToken);
    return store.dispatch(SetPlayerStateAction(PlayerState(
      isLoading: false,
      isError: false,
      isLoggedIn: true,
      idToken: parseIdToken(result.idToken),
      profile: await getUserDetails(result.accessToken),
    )));
  } catch (e, s) {
    print('login error: $e - stack: $s');
    return store.dispatch(SetPlayerStateAction(PlayerState(
      isLoading: false,
      isError: false,
      isLoggedIn: false,
    )));
  }
}

Future<void> playerLogoutAction(Store<AppState> store) async {
  store.dispatch(SetPlayerStateAction(PlayerState(isLoading: true)));
  await secureStorage.delete(key: 'refresh_token');
  store.dispatch(SetPlayerStateAction(PlayerState.initial()));
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
