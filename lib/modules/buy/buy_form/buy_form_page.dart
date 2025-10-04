import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask/mask.dart';
import 'package:supermarket/core/widgets/app_button.dart';
import 'package:supermarket/core/widgets/app_form_field.dart';
import 'buy_form_controller.dart';

class BuyFormPage extends GetView<BuyFormController> {
  const BuyFormPage({super.key});

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
                Text(controller.product.name),
                SizedBox(height: 20),
                AppFormField(
                  label: 'Preço',
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  controller: controller.controllerPrice,
                  validator: (e) => Mask.validations.money(e, min: 0.01),
                  inputFormatters: [Mask.money()],
                ),
                SizedBox(height: 20),
                AppFormField(
                  label: 'Descrição',
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  controller: controller.controllerDescription,
                  onFieldSubmitted: (_) => controller.save(),
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
