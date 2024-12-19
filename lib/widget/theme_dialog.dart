import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/config/theme/cubit/theme_cubit.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.ltr.select_theme),
      content: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SelectTheme(
                value: ThemeMode.light,
                groupValue: state,
                iconData: Icons.light_mode,
                color: Colors.yellowAccent.shade700,
              ),
              SelectTheme(
                value: ThemeMode.dark,
                groupValue: state,
                iconData: Icons.dark_mode,
                color: Colors.blue.shade800,
              ),
              SelectTheme(
                value: ThemeMode.system,
                groupValue: state,
                iconData: Icons.settings,
                color: Colors.blueGrey,
              ),
            ],
          );
        },
      ),
    );
  }
}

class SelectTheme extends StatelessWidget {
  const SelectTheme({
    super.key,
    required this.value,
    required this.groupValue,
    required this.iconData,
    required this.color,
  });

  final IconData iconData;
  final ThemeMode value;
  final ThemeMode groupValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () => context.read<ThemeCubit>().setTheme(value),
        child: Card(
          shadowColor: color,
          color: color,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    iconData,
                    size: 35.0,
                    color: Colors.white,
                    shadows: const [
                      Shadow(color: Colors.black, blurRadius:10.0)
                    ],
                  ),
                  Radio<ThemeMode>(
                    value: value,
                    groupValue: groupValue,
                    onChanged: (e) => context.read<ThemeCubit>().setTheme(e!),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
