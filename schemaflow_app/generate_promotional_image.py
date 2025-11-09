#!/usr/bin/env python3
"""
Generate promotional image for MySchema app in-app purchase.
Creates a 1200x628 PNG image suitable for App Store promotional use.
"""

import os

def create_promotional_image():
    """Create a promotional image for MySchema in-app purchase."""
    
    try:
        from PIL import Image, ImageDraw, ImageFont
    except ImportError:
        print("Error: PIL (Pillow) is required. Install it with: pip install Pillow")
        return
    
    # Promotional image dimensions (1200x628 for App Store)
    width, height = 1200, 628
    
    # Colors matching app theme
    primary_teal = (79, 154, 148)
    accent_green = (93, 176, 117)
    background = (245, 245, 245)
    text_dark = (33, 33, 33)
    
    # Create image with gradient background
    img = Image.new('RGB', (width, height), background)
    draw = ImageDraw.Draw(img)
    
    # Draw gradient-like background (left side teal, right side lighter)
    for x in range(width):
        # Calculate color gradient
        ratio = x / width
        r = int(background[0] * (1 - ratio) + primary_teal[0] * ratio)
        g = int(background[1] * (1 - ratio) + primary_teal[1] * ratio)
        b = int(background[2] * (1 - ratio) + primary_teal[2] * ratio)
        draw.line([(x, 0), (x, height)], fill=(r, g, b))
    
    # Draw accent elements
    # Left circle
    circle_size = 300
    draw.ellipse(
        [50, height // 2 - circle_size // 2,
         50 + circle_size, height // 2 + circle_size // 2],
        fill=accent_green,
        outline=None
    )
    
    # Right circle (lighter)
    draw.ellipse(
        [width - 50 - circle_size // 2, height // 2 - circle_size // 4,
         width - 50 + circle_size // 2, height // 2 + circle_size // 4],
        fill=primary_teal,
        outline=None
    )
    
    # Add text
    # Try to use a system font, fallback to default
    try:
        title_font = ImageFont.truetype("arial.ttf", 80)
        subtitle_font = ImageFont.truetype("arial.ttf", 40)
    except:
        title_font = ImageFont.load_default()
        subtitle_font = ImageFont.load_default()
    
    # Title
    title = "MySchema Pro"
    title_bbox = draw.textbbox((0, 0), title, font=title_font)
    title_width = title_bbox[2] - title_bbox[0]
    title_x = (width - title_width) // 2
    draw.text((title_x, 150), title, fill=text_dark, font=title_font)
    
    # Subtitle
    subtitle = "Unlock Your Full Analysis"
    subtitle_bbox = draw.textbbox((0, 0), subtitle, font=subtitle_font)
    subtitle_width = subtitle_bbox[2] - subtitle_bbox[0]
    subtitle_x = (width - subtitle_width) // 2
    draw.text((subtitle_x, 280), subtitle, fill=primary_teal, font=subtitle_font)
    
    # Features text
    features = "• Detailed Schema Analysis\n• Personalized Insights\n• Expert Recommendations"
    try:
        feature_font = ImageFont.truetype("arial.ttf", 32)
    except:
        feature_font = ImageFont.load_default()
    
    draw.text((150, 400), features, fill=text_dark, font=feature_font)
    
    # Save the image
    output_path = os.path.join(
        os.path.dirname(__file__),
        'assets',
        'promotional_image.png'
    )
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    img.save(output_path, 'PNG')
    
    print(f"✓ Promotional image created successfully at {output_path}")
    print(f"  Size: {width}x{height} pixels")
    print(f"  Format: PNG")
    print(f"  Use this image in App Store Connect for in-app purchase promotion")

if __name__ == '__main__':
    create_promotional_image()

