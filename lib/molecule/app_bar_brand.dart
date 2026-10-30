import 'package:flutter/material.dart';

import '../atom/brand_mark.dart';

class AppBarBrand extends StatelessWidget {
  const AppBarBrand({super.key});

  @override
  Widget build(BuildContext context) => Row(children: [
        const BrandMark(),
        const SizedBox(width: 10),
        const Text('daymark', style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: -.5)),
      ]);
}
