import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteMessage extends StatelessWidget {
  final VoidCallback onDelete;
  final bool actionAllowed;

  const DeleteMessage(
      {Key? key, required this.actionAllowed, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ElevatedButton(
          child: const Text('Eliminar Mensaje'),
          onPressed: actionAllowed ? onDelete : null,
        ),
      ),
    );
  }
}
