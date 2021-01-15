import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import 'app.dart';

class Player {
  String name;
  String picture;

  Player(Map<String, dynamic> json) {
    name = json["name"];
    picture = json["picture"];
  }
}

@immutable
class PlayerState {
  final bool isError;
  final bool isLoading;
  final bool isLoggedIn;
  final Player player;

  const PlayerState({
    this.isError,
    this.isLoading,
    this.isLoggedIn,
    this.player,
  });

  factory PlayerState.initial() => PlayerState(
        isError: false,
        isLoading: false,
        isLoggedIn: false,
        player: null,
      );

  PlayerState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required bool isLoggedIn,
    @required Player player,
  }) =>
      PlayerState(
        isError: isError ?? this.isError,
        isLoading: isLoading ?? this.isLoading,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        player: player ?? this.player,
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
    player: payload.player,
  );
}

Future<void> playerLoginAction(Store<AppState> store) async {
  store.dispatch(SetPlayerStateAction(PlayerState(isLoading: true)));
}
