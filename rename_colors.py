import os
import re

dir_path = r"c:\Users\admin\Desktop\VS Codes\Mobile Application\lib"

replacements = {
    r'\bAppColors\.matteBlack\b': 'AppColors.background',
    r'\bAppColors\.richBlack\b': 'AppColors.backgroundDark',
    r'\bAppColors\.darkSurface\b': 'AppColors.surface',
    r'\bAppColors\.cardSurface\b': 'AppColors.surfaceLight',
    r'\bAppColors\.elevatedSurface\b': 'AppColors.surfaceDark',
    r'\bAppColors\.deepEmerald\b': 'AppColors.primaryDark',
    r'\bAppColors\.darkTeal\b': 'AppColors.primaryDarker',
    r'\bAppColors\.richNavy\b': 'AppColors.secondaryDark',
    r'\bAppColors\.midnightTeal\b': 'AppColors.primaryDarkest',
    r'\bAppColors\.emeraldLight\b': 'AppColors.primaryLight',
    r'\bAppColors\.gold\b': 'AppColors.primary',
    r'\bAppColors\.goldLight\b': 'AppColors.primaryLighter',
    r'\bAppColors\.goldDim\b': 'AppColors.primaryDim',
    r'\bAppColors\.goldSoft\b': 'AppColors.primarySoft',
    r'\bAppColors\.textPrimary\b': 'AppColors.textMain',
    r'\bAppColors\.textSecondary\b': 'AppColors.textMuted',
    r'\bAppColors\.textMuted\b': 'AppColors.textLight',
    r'\bAppColors\.textGold\b': 'AppColors.textPrimaryAccent',
    r'\bAppColors\.goldGradient\b': 'AppColors.primaryGradient',
    r'\bAppColors\.emeraldGradient\b': 'AppColors.secondaryGradient',
    r'\bAppColors\.darkGradient\b': 'AppColors.backgroundGradient',
    r'\bAppColors\.heroGradient\b': 'AppColors.heroGradient',
    r'\bAppColors\.cardGradient\b': 'AppColors.cardGradient',
    r'\bAppColors\.tealGoldGradient\b': 'AppColors.accentGradient',
    r'\bAppColors\.glassWhite\b': 'AppColors.glassSurface',
    r'\bAppColors\.glassBorder\b': 'AppColors.glassBorder',
    r'\bAppColors\.glassGold\b': 'AppColors.glassPrimary',
    r'\bAppColors\.goldShadow\b': 'AppColors.primaryShadow',
}

for root, dirs, files in os.walk(dir_path):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            new_content = content
            for old, new in replacements.items():
                new_content = re.sub(old, new, new_content)
                
            if new_content != content:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print(f"Updated {filepath}")
