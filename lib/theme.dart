import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff904b3c),
      surfaceTint: Color(0xff904b3c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdad3),
      onPrimaryContainer: Color(0xff3a0a03),
      secondary: Color(0xff77574f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdad3),
      onSecondaryContainer: Color(0xff2c1510),
      tertiary: Color(0xff6e5d2e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xfff8e0a6),
      onTertiaryContainer: Color(0xff241a00),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff231917),
      onSurfaceVariant: Color(0xff534340),
      outline: Color(0xff85736f),
      outlineVariant: Color(0xffd8c2bd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2c),
      inversePrimary: Color(0xffffb4a4),
      primaryFixed: Color(0xffffdad3),
      onPrimaryFixed: Color(0xff3a0a03),
      primaryFixedDim: Color(0xffffb4a4),
      onPrimaryFixedVariant: Color(0xff733427),
      secondaryFixed: Color(0xffffdad3),
      onSecondaryFixed: Color(0xff2c1510),
      secondaryFixedDim: Color(0xffe7bdb4),
      onSecondaryFixedVariant: Color(0xff5d3f39),
      tertiaryFixed: Color(0xfff8e0a6),
      onTertiaryFixed: Color(0xff241a00),
      tertiaryFixedDim: Color(0xffdbc48c),
      onTertiaryFixedVariant: Color(0xff544519),
      surfaceDim: Color(0xffe8d6d2),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ee),
      surfaceContainer: Color(0xfffceae6),
      surfaceContainerHigh: Color(0xfff7e4e0),
      surfaceContainerHighest: Color(0xfff1dfdb),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff6e3023),
      surfaceTint: Color(0xff904b3c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffaa6050),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff593c35),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff8f6c65),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff504115),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff857342),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff231917),
      onSurfaceVariant: Color(0xff4f3f3c),
      outline: Color(0xff6c5b58),
      outlineVariant: Color(0xff897773),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2c),
      inversePrimary: Color(0xffffb4a4),
      primaryFixed: Color(0xffaa6050),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff8d493a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff8f6c65),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff75544d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff857342),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff6b5a2c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe8d6d2),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ee),
      surfaceContainer: Color(0xfffceae6),
      surfaceContainerHigh: Color(0xfff7e4e0),
      surfaceContainerHighest: Color(0xfff1dfdb),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff431107),
      surfaceTint: Color(0xff904b3c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6e3023),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff341c16),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff593c35),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2c2100),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff504115),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff2e211e),
      outline: Color(0xff4f3f3c),
      outlineVariant: Color(0xff4f3f3c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2c),
      inversePrimary: Color(0xffffe7e2),
      primaryFixed: Color(0xff6e3023),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff511b10),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff593c35),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff402620),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff504115),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff382b02),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe8d6d2),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ee),
      surfaceContainer: Color(0xfffceae6),
      surfaceContainerHigh: Color(0xfff7e4e0),
      surfaceContainerHighest: Color(0xfff1dfdb),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb4a4),
      surfaceTint: Color(0xffffb4a4),
      onPrimary: Color(0xff561f13),
      primaryContainer: Color(0xff733427),
      onPrimaryContainer: Color(0xffffdad3),
      secondary: Color(0xffe7bdb4),
      onSecondary: Color(0xff442a24),
      secondaryContainer: Color(0xff5d3f39),
      onSecondaryContainer: Color(0xffffdad3),
      tertiary: Color(0xffdbc48c),
      onTertiary: Color(0xff3c2f04),
      tertiaryContainer: Color(0xff544519),
      onTertiaryContainer: Color(0xfff8e0a6),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1a110f),
      onSurface: Color(0xfff1dfdb),
      onSurfaceVariant: Color(0xffd8c2bd),
      outline: Color(0xffa08c88),
      outlineVariant: Color(0xff534340),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfdb),
      inversePrimary: Color(0xff904b3c),
      primaryFixed: Color(0xffffdad3),
      onPrimaryFixed: Color(0xff3a0a03),
      primaryFixedDim: Color(0xffffb4a4),
      onPrimaryFixedVariant: Color(0xff733427),
      secondaryFixed: Color(0xffffdad3),
      onSecondaryFixed: Color(0xff2c1510),
      secondaryFixedDim: Color(0xffe7bdb4),
      onSecondaryFixedVariant: Color(0xff5d3f39),
      tertiaryFixed: Color(0xfff8e0a6),
      onTertiaryFixed: Color(0xff241a00),
      tertiaryFixedDim: Color(0xffdbc48c),
      onTertiaryFixedVariant: Color(0xff544519),
      surfaceDim: Color(0xff1a110f),
      surfaceBright: Color(0xff423734),
      surfaceContainerLowest: Color(0xff140c0a),
      surfaceContainerLow: Color(0xff231917),
      surfaceContainer: Color(0xff271d1b),
      surfaceContainerHigh: Color(0xff322825),
      surfaceContainerHighest: Color(0xff3d3230),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffbaab),
      surfaceTint: Color(0xffffb4a4),
      onPrimary: Color(0xff330501),
      primaryContainer: Color(0xffcc7c6a),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffecc1b8),
      onSecondary: Color(0xff26100b),
      secondaryContainer: Color(0xffae8880),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffe0c990),
      onTertiary: Color(0xff1e1500),
      tertiaryContainer: Color(0xffa38f5b),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1a110f),
      onSurface: Color(0xfffff9f8),
      onSurfaceVariant: Color(0xffdcc6c1),
      outline: Color(0xffb39e9a),
      outlineVariant: Color(0xff927f7b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfdb),
      inversePrimary: Color(0xff743528),
      primaryFixed: Color(0xffffdad3),
      onPrimaryFixed: Color(0xff2b0300),
      primaryFixedDim: Color(0xffffb4a4),
      onPrimaryFixedVariant: Color(0xff5e2418),
      secondaryFixed: Color(0xffffdad3),
      onSecondaryFixed: Color(0xff200b07),
      secondaryFixedDim: Color(0xffe7bdb4),
      onSecondaryFixedVariant: Color(0xff4b2f29),
      tertiaryFixed: Color(0xfff8e0a6),
      onTertiaryFixed: Color(0xff171000),
      tertiaryFixedDim: Color(0xffdbc48c),
      onTertiaryFixedVariant: Color(0xff433409),
      surfaceDim: Color(0xff1a110f),
      surfaceBright: Color(0xff423734),
      surfaceContainerLowest: Color(0xff140c0a),
      surfaceContainerLow: Color(0xff231917),
      surfaceContainer: Color(0xff271d1b),
      surfaceContainerHigh: Color(0xff322825),
      surfaceContainerHighest: Color(0xff3d3230),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffff9f8),
      surfaceTint: Color(0xffffb4a4),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffbaab),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffff9f8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffecc1b8),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffffaf6),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffe0c990),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1a110f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffff9f8),
      outline: Color(0xffdcc6c1),
      outlineVariant: Color(0xffdcc6c1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfdb),
      inversePrimary: Color(0xff4e180d),
      primaryFixed: Color(0xffffe0da),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffbaab),
      onPrimaryFixedVariant: Color(0xff330501),
      secondaryFixed: Color(0xffffe0da),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffecc1b8),
      onSecondaryFixedVariant: Color(0xff26100b),
      tertiaryFixed: Color(0xfffde5aa),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffe0c990),
      onTertiaryFixedVariant: Color(0xff1e1500),
      surfaceDim: Color(0xff1a110f),
      surfaceBright: Color(0xff423734),
      surfaceContainerLowest: Color(0xff140c0a),
      surfaceContainerLow: Color(0xff231917),
      surfaceContainer: Color(0xff271d1b),
      surfaceContainerHigh: Color(0xff322825),
      surfaceContainerHighest: Color(0xff3d3230),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
