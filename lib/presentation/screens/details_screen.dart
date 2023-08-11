import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../blocs/notification/notications_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final String pushMessageId;

  const DetailsScreen({super.key, required this.pushMessageId});

  @override
  Widget build(BuildContext context) {
    final PushMessage? message =
        context.watch<NoticationsBloc>().getMessageById(pushMessageId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles push"),
      ),
      body: message != null ? _DetailsView(message: message) : const Center( child: Text("Notificacion no existe"),),
    );
  }
}

class _DetailsView extends StatelessWidget {
  final PushMessage message;
  const _DetailsView({required this.message});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          if (message.imageUrl != null) Image.network(message.imageUrl!),
          const SizedBox(
            height: 30,
          ),
          Text(
            message.title,
            style: textStyle.titleMedium,
          ),
          Text(message.body),
          const Divider(),
          Text(message.data.toString()),
        ],
      ),
    );
  }
}
