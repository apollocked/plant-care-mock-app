import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mock_plant_care_app/view/widgets/glass_container.dart';
import 'form_helpers.dart';

class CareScheduleSection extends StatelessWidget {
  const CareScheduleSection({
    super.key,
    required this.waterDaysCtrl,
    required this.feedDaysCtrl,
    required this.onSurface,
  });

  final TextEditingController waterDaysCtrl;
  final TextEditingController feedDaysCtrl;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return GlassContainer(
      borderRadius: 20,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormSectionHeader(icon: '📅', label: 'Care Schedule', onSurface: onSurface),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: waterDaysCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(color: onSurface),
                  decoration: InputDecoration(
                    labelText: 'Water every',
                    suffixText: 'days',
                    prefixIcon: Icon(Icons.water_drop_outlined, color: Colors.blue.shade400, size: 20),
                  ),
                  validator: validatePositiveInt,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: feedDaysCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(color: onSurface),
                  decoration: InputDecoration(
                    labelText: 'Feed every',
                    suffixText: 'days',
                    prefixIcon: Icon(Icons.grass_outlined, color: Colors.green.shade600, size: 20),
                  ),
                  validator: validatePositiveInt,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _ScheduleTips(onSurface: onSurface, scheme: scheme),
        ],
      ),
    );
  }
}

class _ScheduleTips extends StatelessWidget {
  const _ScheduleTips({required this.onSurface, required this.scheme});
  final Color onSurface;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.lightbulb_outline_rounded, size: 14, color: scheme.primary),
              const SizedBox(width: 6),
              Text('Common Care Tips',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: scheme.primary)),
            ],
          ),
          const SizedBox(height: 8),
          _TipRow(icon: '💧', text: 'Water: 2-3 days for succulents, 5-7 for tropicals.', onSurface: onSurface),
          const SizedBox(height: 4),
          _TipRow(icon: '🧪', text: 'Feed: 7-14 days during growing season, rare in winter.', onSurface: onSurface),
        ],
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  const _TipRow({required this.icon, required this.text, required this.onSurface});
  final String icon;
  final String text;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(icon, style: const TextStyle(fontSize: 10)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 10, color: onSurface.withValues(alpha: 0.7), fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}
