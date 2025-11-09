#!/usr/bin/env python3
"""
Generate MySchema app icon from user's logo.
Creates a 1024x1024 PNG icon suitable for iOS and Android.
"""

from PIL import Image, ImageDraw
import os

def create_app_icon_from_logo():
    """Create app icon from user's logo with proper sizing and background."""

    size = 1024
    primary_teal = (79, 154, 148)  # AppTheme.primaryTeal
    accent_green = (93, 176, 117)  # AppTheme.accentGreen

    # Create base image with gradient background
    img = Image.new('RGB', (size, size), primary_teal)
    draw = ImageDraw.Draw(img)

    # Draw gradient-like effect with circles
    center = size // 2
    circle_radius = size // 3

    # Outer circle
    draw.ellipse(
        [center - circle_radius, center - circle_radius,
         center + circle_radius, center + circle_radius],
        fill=accent_green,
        outline=None
    )

    # Try to load user's logo if it exists
    logo_path = os.path.join(os.path.dirname(__file__), 'assets', 'icons', 'myschema_logo.png')
    if os.path.exists(logo_path):
        try:
            logo = Image.open(logo_path).convert('RGBA')
            # Resize logo to fit in the circle (80% of circle radius)
            logo_size = int(circle_radius * 1.6)
            logo = logo.resize((logo_size, logo_size), Image.Resampling.LANCZOS)

            # Create a transparent background for logo
            logo_bg = Image.new('RGBA', (size, size), (0, 0, 0, 0))
            # Paste logo in center
            logo_x = (size - logo_size) // 2
            logo_y = (size - logo_size) // 2
            logo_bg.paste(logo, (logo_x, logo_y), logo)

            # Convert main image to RGBA and composite
            img = img.convert('RGBA')
            img = Image.alpha_composite(img, logo_bg)
            img = img.convert('RGB')
        except Exception as e:
            print(f"Warning: Could not load logo: {e}")

    # Save the icon
    output_path = os.path.join(os.path.dirname(__file__), 'assets', 'icons', 'app_icon.png')
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    img.save(output_path, 'PNG')

    print(f"✓ App icon created successfully at {output_path}")
    print(f"  Size: {size}x{size} pixels")
    print(f"  Format: PNG (no transparency for iOS)")

if __name__ == '__main__':
    try:
        create_app_icon_from_logo()
    except ImportError:
        print("Error: PIL (Pillow) is required. Install it with: pip install Pillow")
    except Exception as e:
        print(f"Error creating app icon: {e}")

