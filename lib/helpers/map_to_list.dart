
import 'package:sos_harold_app/models/models.dart';

List<Usuario> convertirMapaACitas(Map<String, dynamic> mapa) {
  List<Usuario> usuarios = [];

  mapa.forEach((key, value) {
    Usuario user = Usuario.fromJson(value);
    user.id = key;
    usuarios.add(user);
  });

  return usuarios;
}

