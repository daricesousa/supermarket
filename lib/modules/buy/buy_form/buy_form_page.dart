import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask/mask.dart';
import 'package:supermarket/core/extensions/double_ext.dart';
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
                Text(
                  controller.product.fullName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 20),
                AppFormField(
                  label: 'Preço',
                  textInputType: TextInputType.number,
                  controller: controller.controllerPrice,
                  validator: (e) => Mask.validations.money(e, min: 0.01),
                  inputFormatters: [Mask.money()],
                ),
                SizedBox(height: 20),

                AppFormField(
                  label: 'Descrição',
                  maxLines: 2,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  controller: controller.controllerDescription,
                  onFieldSubmitted: (_) => controller.save(),
                ),
                SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: AppFormField(
                        label: 'Tamanho da unidade',
                        controller: controller.controllerUnitSize,

                        textInputType: TextInputType.number,
                        onFieldSubmitted: (_) => controller.save(),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: AppFormField(
                        label: 'Valor por ${controller.product.unit}',
                        enabled: false,
                        controller: controller.controllerPriceConverted,

                        textInputType: TextInputType.number,
                        onFieldSubmitted: (_) => controller.save(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Card(
                  color: Colors.yellow[50],
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Último: ${controller.product.lastPrice.displayPrice()}",
                            ),
                            SizedBox(width: 20),
                            Text(
                              "Média: ${controller.product.priceAverage.displayPrice()}",
                            ),
                            SizedBox(width: 20),
                            controller.product.priceArrowIcon,
                          ],
                        ),

                        Obx(() => comparePrices()),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 8),
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

  Widget comparePrices() {
    String text = "Mesmo preço da média";
    Color color = Colors.green;
    final difference = controller.diferenceAverage.value;
    if (difference == null) return Container();
    if (difference > 0) {
      text = "${difference.displayPrice()} mais barato que a média";
    } else {
      text = "${difference.abs().displayPrice()} mais caro que a média";
      color = Colors.red;
    }
    return Text(text, style: TextStyle(color: color));
  }
}
