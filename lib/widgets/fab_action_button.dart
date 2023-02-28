/// This is suitable/best icon for FAB buttons used by [expandable_fab], this widget is
/// provided to simplify created buttons used by [expandable_fab]
import 'package:flutter/material.dart';

@immutable
class FabActionButton extends StatelessWidget {
  const FabActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}
