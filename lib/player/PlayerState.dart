import 'package:meta/meta.dart';

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

  get id => this.profile["sub"];

  get picture => this.profile["picture"] ?? '';

  get name => this.idToken["name"] ?? '';

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
