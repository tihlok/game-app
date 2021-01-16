import 'package:game_app_flutter/player/PlayerAction.dart';
import 'package:game_app_flutter/player/PlayerState.dart';

playerReducer(PlayerState state, PlayerAction action) {
  final payload = action.state;
  return state.copyWith(
    isError: payload.isError,
    isLoading: payload.isLoading,
    isLoggedIn: payload.isLoggedIn,
    idToken: payload.idToken,
    profile: payload.profile,
  );
}
