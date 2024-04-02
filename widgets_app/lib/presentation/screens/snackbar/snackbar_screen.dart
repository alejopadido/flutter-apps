import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {
  static const name = 'snackbar_screen';
  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    final snackbar = SnackBar(
      content: const Text('Hello Snackbar!'),
      action: SnackBarAction(label: 'Ok!', onPressed: () {}),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
            'Proident enim quis duis duis adipisicing ipsum est labore et. Mollit nisi dolor officia eu. Lorem adipisicing velit mollit veniam minim.'),
        actions: [
          TextButton(
              onPressed: () => context.pop(), child: const Text('Cancel')),
          FilledButton(
              onPressed: () => context.pop(), child: const Text('Accept')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars and Dialogs'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {
                showAboutDialog(
                  context: context,
                  children: [
                    const Text(
                        'Incididunt esse ullamco culpa do tempor consequat. Aliquip sint aliquip ea sunt. Cupidatat reprehenderit ipsum proident aute labore id consequat enim sunt.')
                  ],
                );
              },
              child: const Text('Used licenses'),
            ),
            FilledButton.tonal(
              onPressed: () => openDialog(context),
              child: const Text('Show dialog'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Show Snackbar'),
        onPressed: () => showCustomSnackbar(context),
        icon: const Icon(Icons.remove_red_eye_outlined),
      ),
    );
  }
}
