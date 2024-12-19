import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymbro/config/l10n/app_local.dart';

class DialogUpdate extends StatefulWidget {
  const DialogUpdate({super.key, required this.name, required this.onSave});

  final String name;
  final void Function(String newName) onSave;

  @override
  State<DialogUpdate> createState() => _DialogUpdateState();
}

class _DialogUpdateState extends State<DialogUpdate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _cntrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cntrl.text = widget.name;
  }

  @override
  void dispose() {
    super.dispose();
    _cntrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.ltr.update_name,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextFormField to change name
            TextFormField(
              autofocus: true,
              controller: _cntrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (e) {
                if (e!.isEmpty) {
                  return context.ltr.cant_be_empty;
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        //Back Button
        TextButton(
          onPressed: () => context.pop(),
          child: Text(context.ltr.back),
        ),
        // Button to Save
        ActionChip(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              widget.onSave(_cntrl.text.trimRight());
              context.pop();
            }
          },
          label: Text(context.ltr.save),
        )
      ],
    );
  }
}
