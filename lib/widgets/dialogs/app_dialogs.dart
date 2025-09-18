import 'package:flutter/material.dart';
import 'package:todo_diversition/constants/app_text_styles.dart';
import 'package:todo_diversition/constants/colours.dart';

class AppDialogs {
  AppDialogs._();

  static Future<void> success(
    BuildContext context, {
    String title = 'Success',
    required String message,
    String buttonText = 'OK',
    VoidCallback? onOk,
    bool dismissible = true,
  }) async {
    return _baseDialog(
      context,
      dismissible: dismissible,
      icon: const Icon(Icons.check_circle, color: Colors.white, size: 42),
      iconBg: Colors.green,
      title: title,
      message: message,
      primaryText: buttonText,
      primaryColor: Colors.green,
      onPrimary: onOk,
    );
  }

  static Future<void> error(
    BuildContext context, {
    String title = 'Error',
    required String message,
    String buttonText = 'OK',
    VoidCallback? onOk,
    bool dismissible = true,
  }) async {
    return _baseDialog(
      context,
      dismissible: dismissible,
      icon: const Icon(Icons.error_rounded, color: Colors.white, size: 42),
      iconBg: Colours.red,
      title: title,
      message: message,
      primaryText: buttonText,
      primaryColor: Colours.red,
      onPrimary: onOk,
    );
  }

  static Future<bool?> confirm(
    BuildContext context, {
    String title = 'Confirm',
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color confirmColor = Colours.primary,
    bool dismissible = false,
  }) async {
    bool? result;
    await _baseDialog(
      context,
      dismissible: dismissible,
      icon: const Icon(Icons.help_outline, color: Colors.white, size: 42),
      iconBg: Colours.primary,
      title: title,
      message: message,
      primaryText: confirmText,
      secondaryText: cancelText,
      primaryColor: confirmColor,
      onPrimary: () => result = true,
      onSecondary: () => result = false,
    );
    return result;
  }

  static Future<void> _baseDialog(
    BuildContext context, {
    required Widget icon,
    required Color iconBg,
    required String title,
    required String message,
    required String primaryText,
    Color? primaryColor,
    VoidCallback? onPrimary,
    String? secondaryText,
    VoidCallback? onSecondary,
    bool dismissible = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          backgroundColor: Colours.white,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 280),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: iconBg,
                      shape: BoxShape.circle,
                    ),
                    child: icon,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bold.copyWith(
                      color: Colours.black,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regular.copyWith(
                      color: Colours.black.withOpacity(0.75),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox.shrink(),
                  Row(
                    children: [
                      if (secondaryText != null) ...[
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide(
                                color: Colours.grey.withOpacity(0.4),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              onSecondary?.call();
                            },
                            child: Text(
                              secondaryText,
                              style: AppTextStyles.medium.copyWith(
                                color: Colours.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor ?? Colours.primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            onPrimary?.call();
                          },
                          child: Text(
                            primaryText,
                            style: AppTextStyles.medium.copyWith(
                              color: Colours.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
