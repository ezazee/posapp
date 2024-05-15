import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:lakasir/controllers/auths/auth_controller.dart';
import 'package:lakasir/controllers/setting_controller.dart';
import 'package:lakasir/utils/auth.dart';
import 'package:lakasir/utils/colors.dart';
import 'package:lakasir/widgets/confirm_dialog.dart';
import 'package:lakasir/widgets/dialog.dart';
import 'package:lakasir/widgets/filled_button.dart';
import 'package:lakasir/widgets/my_card_list.dart';
import 'package:lakasir/widgets/text_field.dart';

class TransactionSetting extends StatelessWidget {
  const TransactionSetting({
    super.key,
    required this.settingController,
    required this.authController,
  });
  final SettingController settingController;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            "menu_transaction".tr,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        if (can(authController.permissions, 'set default tax'))
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: MyCardList(
              onTap: () {
                final MoneyMaskedTextController taxController =
                    MoneyMaskedTextController(
                  thousandSeparator: '.',
                  decimalSeparator: ',',
                  rightSymbol: ' %',
                  precision: 1,
                );
                settingController.setting.value.defaultTax != null
                    ? taxController.updateValue(
                        settingController.setting.value.defaultTax!)
                    : taxController.updateValue(0);
                Get.dialog(MyDialog(
                  content: Column(
                    children: [
                      MyTextField(
                        controller: taxController,
                        label: "field_tax".tr,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      MyFilledButton(
                        onPressed: () {
                          settingController.updateSetting(
                            "default_tax",
                            taxController.numberValue,
                          );
                          Get.back();
                          Get.rawSnackbar(
                            message: "set_detault_tax_success".tr,
                            backgroundColor: success,
                          );
                        },
                        child: Text("global_save".tr),
                      ),
                    ],
                  ),
                ));
              },
              imagebox: Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Icon(
                  Icons.receipt_long_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              list: [
                Text("set_detault_tax".tr,
                    style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
        if (can(authController.permissions, 'enable cash drawer'))
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: MyCardList(
              imagebox: Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Icon(
                  Icons.money_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              list: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("cashier_cash_drawer".tr,
                        style: const TextStyle(fontSize: 20)),
                    Obx(
                      () {
                        var cashDrawerEnabled =
                            settingController.setting.value.cashDrawerEnabled;
                        return Switch(
                          focusColor: primary,
                          value: cashDrawerEnabled,
                          onChanged: (value) {
                            Get.dialog(MyConfirmDialog(
                              title: "global_warning".tr,
                              content: Text(cashDrawerEnabled
                                  ? "cashier_cash_drawer_question_deactivate".tr
                                  : "cashier_cash_drawer_question_activate".tr),
                              onConfirm: () {
                                settingController.updateSetting(
                                  "cash_drawer_enabled",
                                  value,
                                );
                                Get.back();
                              },
                              confirmText: "global_ok".tr,
                            ));
                          },
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        if (can(authController.permissions, 'set selling method'))
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: MyCardList(
              route: '/menu/setting/selling_method',
              imagebox: Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const HeroIcon(
                  HeroIcons.arrowsPointingIn,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              list: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("selling_method".tr,
                        style: const TextStyle(fontSize: 20)),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
