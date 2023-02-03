import 'package:flutter/material.dart';

import 'field_textform.dart';

class UserInfoForm extends StatelessWidget {
  const UserInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: Column(
        children: const [
          FieldUserFormWidget(fieldName: 'Nombre:'),
          FieldUserFormWidget(fieldName: 'Apellido(s):'),
          FieldUserFormWidget(fieldName: 'Fecha de nacimiento:'),
          FieldUserFormWidget(fieldName: 'Lugar de nacimiento:'),
          FieldUserFormWidget(fieldName: 'Número de celular:'),
          FieldUserFormWidget(fieldName: 'Correo electrónico:'),
          FieldUserFormWidget(fieldName: 'Contraseña:'),
          FieldUserFormWidget(fieldName: 'Confirmar contraseña:')
        ],
      ),
    );
  }
}
