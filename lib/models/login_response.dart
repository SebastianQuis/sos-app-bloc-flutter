import 'dart:convert';

class LoginResponse {
    String kind;
    String idToken;
    String email;
    String refreshToken;
    String expiresIn;
    String localId;

    LoginResponse({
        required this.kind,
        required this.idToken,
        required this.email,
        required this.refreshToken,
        required this.expiresIn,
        required this.localId,
    });

    factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        kind: json["kind"],
        idToken: json["idToken"],
        email: json["email"],
        refreshToken: json["refreshToken"],
        expiresIn: json["expiresIn"],
        localId: json["localId"],
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "idToken": idToken,
        "email": email,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
        "localId": localId,
    };
}