import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask/mask.dart';
import 'package:supermarket/core/widgets/app_button.dart';
import 'package:supermarket/core/widgets/app_form_field.dart';

import './product_form_controller.dart';

class ProductFormPage extends GetView<ProductFormController> {
  const ProductFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produto')),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Form(
            key: controller.formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SizedBox(height: 20),
                AppFormField(
                  label: 'Nome',
                  controller: controller.controllerName,
                  validator: Mask.validations.generic,
                  inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      return newValue.copyWith(
                        text: newValue.text.toUpperCase(),
                        selection: newValue.selection,
                      );
                    }),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton(
                      label: 'Cancelar',
                      color: Colors.red,
                      onPressed: Get.back,
                    ),
                    SizedBox(width: 16),
                    AppButton(label: 'Salvar', onPressed: controller.save),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
