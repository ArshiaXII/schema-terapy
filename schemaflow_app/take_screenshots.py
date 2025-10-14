#!/usr/bin/env python3
"""
App Store ekran görüntülerini otomatik olarak doğru boyutlarda alır.
Gereksinimler: pip install selenium pillow
Chrome WebDriver: https://chromedriver.chromium.org/downloads
"""

import os
import time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from PIL import Image

# Ekran görüntüsü konfigürasyonları
SCREENSHOTS = [
    # iPhone 6.5-inch (1242 x 2688)
    {
        "name": "iphone_65_home_en",
        "url": "http://localhost:62518/?lang=en",
        "width": 1242,
        "height": 2688,
    },
    {
        "name": "iphone_65_home_tr",
        "url": "http://localhost:62518/?lang=tr",
        "width": 1242,
        "height": 2688,
    },
    {
        "name": "iphone_65_paywall_en",
        "url": "http://localhost:62518/?screen=paywall&lang=en",
        "width": 1242,
        "height": 2688,
    },
    {
        "name": "iphone_65_paywall_tr",
        "url": "http://localhost:62518/?screen=paywall&lang=tr",
        "width": 1242,
        "height": 2688,
    },
    # iPad 13-inch (2048 x 2732)
    {
        "name": "ipad_13_home_en",
        "url": "http://localhost:62518/?lang=en",
        "width": 2048,
        "height": 2732,
    },
    {
        "name": "ipad_13_home_tr",
        "url": "http://localhost:62518/?lang=tr",
        "width": 2048,
        "height": 2732,
    },
    {
        "name": "ipad_13_paywall_en",
        "url": "http://localhost:62518/?screen=paywall&lang=en",
        "width": 2048,
        "height": 2732,
    },
    {
        "name": "ipad_13_paywall_tr",
        "url": "http://localhost:62518/?screen=paywall&lang=tr",
        "width": 2048,
        "height": 2732,
    },
]

OUTPUT_DIR = "screenshots"


def setup_driver(width, height):
    """Chrome WebDriver'ı belirtilen boyutlarda başlatır."""
    chrome_options = Options()
    chrome_options.add_argument(f"--window-size={width},{height}")
    chrome_options.add_argument("--force-device-scale-factor=1")
    chrome_options.add_argument("--high-dpi-support=1")
    chrome_options.add_argument("--disable-gpu")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")
    
    driver = webdriver.Chrome(options=chrome_options)
    driver.set_window_size(width, height)
    
    return driver


def take_screenshot(config):
    """Belirtilen konfigürasyona göre ekran görüntüsü alır."""
    print(f"📸 Alınıyor: {config['name']} ({config['width']}x{config['height']})")
    
    driver = setup_driver(config["width"], config["height"])
    
    try:
        # Sayfayı yükle
        driver.get(config["url"])
        
        # Flutter uygulamasının yüklenmesini bekle
        time.sleep(5)
        
        # Ekran görüntüsü al
        temp_path = os.path.join(OUTPUT_DIR, f"{config['name']}_temp.png")
        driver.save_screenshot(temp_path)
        
        # Görseli tam olarak istenen boyuta kırp/resize et
        img = Image.open(temp_path)
        
        # Eğer boyut farklıysa, resize et
        if img.size != (config["width"], config["height"]):
            print(f"   ⚠️  Boyut uyumsuz: {img.size} → {config['width']}x{config['height']}")
            img = img.resize((config["width"], config["height"]), Image.Resampling.LANCZOS)
        
        # Nihai dosyayı kaydet
        final_path = os.path.join(OUTPUT_DIR, f"{config['name']}.png")
        img.save(final_path, "PNG", optimize=True)
        
        # Geçici dosyayı sil
        os.remove(temp_path)
        
        print(f"   ✅ Kaydedildi: {final_path}")
        
    except Exception as e:
        print(f"   ❌ Hata: {e}")
    
    finally:
        driver.quit()


def main():
    """Ana fonksiyon."""
    print("🚀 MySchema App Store Ekran Görüntüsü Aracı\n")
    
    # Çıktı klasörünü oluştur
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    # Tüm ekran görüntülerini al
    for i, config in enumerate(SCREENSHOTS, 1):
        print(f"\n[{i}/{len(SCREENSHOTS)}]")
        take_screenshot(config)
        time.sleep(2)  # Tarayıcı kapanması için bekle
    
    print(f"\n✨ Tamamlandı! Tüm ekran görüntüleri '{OUTPUT_DIR}' klasöründe.")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n⚠️  İşlem kullanıcı tarafından iptal edildi.")
    except Exception as e:
        print(f"\n❌ Beklenmeyen hata: {e}")

