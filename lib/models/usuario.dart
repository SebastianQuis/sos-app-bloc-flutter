import 'dart:convert';

class Usuario {
    String apellidos;
    int celular;
    int dni;
    int edad;
    String email;
    String nombres;
    String password;
    String? id;
    String padre;

    Usuario({
        required this.apellidos,
        required this.celular,
        required this.dni,
        required this.edad,
        required this.email,
        required this.nombres,
        required this.password,
        this.id,
        this.padre = 'no padre',
    });

    factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        apellidos: json["apellidos"],
        celular: json["celular"],
        dni: json["dni"],
        edad: json["edad"],
        email: json["email"],
        nombres: json["nombres"],
        password: json["password"],
        padre: json["padre"],
    );

    Map<String, dynamic> toJson() => {
        "apellidos": apellidos,
        "celular": celular,
        "dni": dni,
        "edad": edad,
        "email": email,
        "nombres": nombres,
        "password": password,
        "padre": padre,
    };
}
