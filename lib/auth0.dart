import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

const AUTH0_DOMAIN = 'critical-rpg.us.auth0.com';
const AUTH0_CLIENT_ID = '0cBR1CWWJI1A7CO4b3q3d64o7Auh6A0U';
const AUTH0_REDIRECT_URI = 'games.pixelfox.rpg://callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
