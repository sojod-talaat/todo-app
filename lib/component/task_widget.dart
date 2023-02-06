import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/bloc/bloc.dart';

Widget buildTaskWidget(Map model, context) {
  return Consumer<AppCubit>(builder: (context, provider, x) {
    return Dismissible(
      key: Key(model["id"].toString()),
      onDismissed: (direction) => provider.delete(model['id']),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 20, top: 20),
        child: Row(
          children: [
            CircleAvatar(
              minRadius: 40,
              child: Text(model["time"]),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model["tasktitlle"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    model["date"],
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  provider.update("Archive", model["id"]);
                },
                icon: const Icon(
                  Icons.archive_sharp,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  provider.update("done", model["id"]);
                },
                icon: const Icon(Icons.done_sharp))
          ],
        ),
      ),
    );
  });
}
