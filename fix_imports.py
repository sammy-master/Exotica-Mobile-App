files = {
    'lib/features/shell/main_shell.dart': [
        ("'../core/theme/ex_colors.dart'", "'../../core/theme/ex_colors.dart'"),
        ("'../core/theme/ex_typography.dart'", "'../../core/theme/ex_typography.dart'"),
        ("'../providers/providers.dart'", "'../../providers/providers.dart'"),
        ("'../core/widgets/cart_bottom_sheet.dart'", "'../../core/widgets/cart_bottom_sheet.dart'"),
        ("'home/home_screen.dart'", "'../home/home_screen.dart'"),
        ("'categories/categories_screen.dart'", "'../categories/categories_screen.dart'"),
        ("'profile/profile_screen.dart'", "'../profile/profile_screen.dart'"),
    ],
    'lib/features/splash/splash_screen.dart': [
        ("'../core/theme/ex_colors.dart'", "'../../core/theme/ex_colors.dart'"),
        ("'../core/theme/ex_typography.dart'", "'../../core/theme/ex_typography.dart'"),
    ],
    'lib/features/home/home_screen.dart': [
        ("'../../core/theme/ex_colors.dart'", "'../../core/theme/ex_colors.dart'"),
    ],
}

for fpath, replacements in files.items():
    with open(fpath, 'r', encoding='utf-8') as f:
        content = f.read()
    for old, new in replacements:
        content = content.replace(old, new)
    with open(fpath, 'w', encoding='utf-8') as f:
        f.write(content)
    print('Fixed', fpath)
