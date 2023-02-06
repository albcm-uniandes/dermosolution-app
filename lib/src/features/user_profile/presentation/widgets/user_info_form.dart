import 'package:dermosolution_app/src/features/user_profile/presentation/widgets/field_passwordform.dart';
import 'package:dermosolution_app/src/features/user_profile/presentation/widgets/field_numberform.dart';
import 'package:dermosolution_app/src/features/user_profile/presentation/widgets/field_emailform.dart';
import 'package:flutter/material.dart';

import 'field_textform.dart';

class UserInfoForm extends StatelessWidget {
  const UserInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 3, 18, 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FieldUserFormWidget(fieldName: 'Nombre'),
          FieldUserFormWidget(fieldName: 'Apellido(s)'),
          FieldUserFormWidget(fieldName: 'Fecha de nacimiento (dd/mm/aaaa)'),
          FieldUserFormWidget(fieldName: 'Lugar de nacimiento'),
          FieldUserFormWidget(fieldName: 'Lugar de residencia'),
          FieldUserNumberWidget(fieldName: 'Edad'),
          FieldUserFormWidget(fieldName: 'Sexo (H, M)'),
          FieldUserNumberWidget(fieldName: 'Número de celular'),
          FieldUserEmailWidget(fieldName: 'Correo electrónico'),
          FieldUserPasswordWidget(fieldName: 'Contraseña'),
          FieldUserPasswordWidget(fieldName: 'Confirmar contraseña')
        ],
      ),
    );
  }
}
