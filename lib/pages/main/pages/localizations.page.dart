import 'package:flutter/material.dart';
import 'package:testemundowap/core/theme/core.theme.colors.dart';
import 'package:testemundowap/domain/entity/position.entity.dart';

class LocationRegister extends StatelessWidget {
  final List<PositionEntity> positionsList;
  final Future<void> Function() onRefresh;
  const LocationRegister(
      {super.key, required this.positionsList, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        backgroundColor: AppColors.lightGrey,
        color: AppColors.white,
        onRefresh: onRefresh,
        child: ListView.builder(
          itemCount: positionsList.length,
          itemBuilder: (context, index) {
            final position = positionsList[index];
            final time = position.registerTime;
            final localization =
                "Latitude: ${position.latitude}\nLogitude: ${position.logitude}";
            final stringTime =
                "${time.day}/${time.month}/${time.year} - ${time.hour}:${time.minute}:${time.second}";
            return ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.map),
              ),
              title: Text(
                localization,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text(stringTime),
              trailing: const Icon(Icons.cancel),
            );
          },
        ));
  }
}
