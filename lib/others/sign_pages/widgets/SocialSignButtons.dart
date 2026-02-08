import 'package:ecommerce_app/core/config/AppSizes.dart';
import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // for logos

class SocialSignButtons extends StatelessWidget {
  const SocialSignButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Column(
      children: [
        SizedBox(height: AppSizes.verticalSpaceMedium().height),
        //-------------------------------------------------------------------------- -OR-
        Row(
          children: [
            const Expanded(child: Divider(thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                tr.generalOr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const Expanded(child: Divider(thickness: 1)),
          ],
        ),
        SizedBox(height: AppSizes.verticalSpaceMedium().height),

        //-------------------------------------------------------------------------- Social buttons
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
            label: Text(tr.nameFacebook),
          ),
        ),
        SizedBox(height: AppSizes.verticalSpaceMedium().height),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
            label: Text(tr.nameGoogle),
          ),
        ),
        SizedBox(height: AppSizes.verticalSpaceMedium().height),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.apple, color: Colors.black),
            label: Text(tr.nameAppleId),
          ),
        ),
      ],
    );
  }
}
