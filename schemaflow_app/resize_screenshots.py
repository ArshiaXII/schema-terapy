#!/usr/bin/env python3
"""
Ekran görüntülerini App Store Connect için doğru boyutlara getirir.
Kullanım: python resize_screenshots.py
Gereksinim: pip install pillow
"""

import os
from pathlib import Path
from PIL import Image

# App Store Connect gereksinimleri
TARGET_SIZES = {
    "iphone_65": (1242, 2688),  # 6.5-inch iPhone (iPhone XS Max, 11 Pro Max, 12 Pro Max, etc.)
    "ipad_13": (2048, 2732),    # 12.9-inch iPad Pro (3rd gen and later)
}

def resize_image(input_path, output_path, target_size):
    """Görseli belirtilen boyuta resize eder."""
    try:
        img = Image.open(input_path)
        print(f"📸 {os.path.basename(input_path)}")
        print(f"   Mevcut: {img.size[0]} x {img.size[1]}")
        
        # Resize et (LANCZOS en kaliteli interpolasyon)
        resized = img.resize(target_size, Image.Resampling.LANCZOS)
        
        # Kaydet
        resized.save(output_path, "PNG", optimize=True, quality=95)
        print(f"   ✅ Yeni: {target_size[0]} x {target_size[1]} → {output_path}\n")
        
    except Exception as e:
        print(f"   ❌ Hata: {e}\n")

def main():
    """Ana fonksiyon."""
    print("🎨 MySchema Screenshot Resizer\n")
    print("App Store Connect için ekran görüntülerini yeniden boyutlandırıyor...\n")
    
    # Mevcut dizindeki tüm PNG dosyalarını bul
    current_dir = Path(".")
    png_files = list(current_dir.glob("*.png"))
    
    if not png_files:
        print("❌ Hiç PNG dosyası bulunamadı!")
        print("💡 Bu scripti ekran görüntülerinin olduğu klasörde çalıştırın.")
        return
    
    # Çıktı klasörü oluştur
    output_dir = Path("resized_screenshots")
    output_dir.mkdir(exist_ok=True)
    
    print(f"📁 {len(png_files)} adet PNG dosyası bulundu.\n")
    
    for png_file in png_files:
        # Dosya adından cihaz tipini tahmin et
        filename_lower = png_file.stem.lower()
        
        if "ipad" in filename_lower:
            target_size = TARGET_SIZES["ipad_13"]
            device_type = "iPad 13-inch"
        else:
            # Varsayılan olarak iPhone 6.5-inch
            target_size = TARGET_SIZES["iphone_65"]
            device_type = "iPhone 6.5-inch"
        
        print(f"🎯 Hedef: {device_type} ({target_size[0]} x {target_size[1]})")
        
        output_path = output_dir / png_file.name
        resize_image(png_file, output_path, target_size)
    
    print(f"✨ Tamamlandı! Yeniden boyutlandırılmış dosyalar '{output_dir}' klasöründe.")
    print(f"\n📋 App Store Connect'e yüklemeden önce kontrol edin:")
    print(f"   • iPhone 6.5-inch: 1242 x 2688 piksel")
    print(f"   • iPad 13-inch: 2048 x 2732 piksel")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n⚠️  İşlem iptal edildi.")
    except Exception as e:
        print(f"\n❌ Hata: {e}")

