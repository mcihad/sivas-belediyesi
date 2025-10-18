# Sivas Belediyesi Keycloak Teması

Bu proje, Sivas Belediyesi için özelleştirilmiş modern bir Keycloak tema koleksiyonudur. Bootstrap tabanlı responsive tasarım ile kullanıcı dostu giriş, kayıt ve hata sayfaları sunar.

## Özellikler

- **Modern Tasarım**: Bootstrap 5 ile responsive ve mobil uyumlu arayüz
- **Koyu Mod Desteği**: Otomatik koyu/açık mod geçişi
- **Türkçe Yerelleştirme**: Tam Türkçe destek
- **Güvenlik**: Keycloak'un güvenlik özelliklerini korur
- **Özelleştirilebilir**: Kolay tema özelleştirmesi

## Kurulum

### Gereksinimler

- Keycloak 26.4.1 veya üzeri
- Java 17+

### Tema Kurulumu

1. Bu tema klasörünü Keycloak'un `themes` dizinine kopyalayın:
   ```
   cp -r sivas-belediyesi /path/to/keycloak/themes/
   ```

2. Keycloak'u yeniden başlatın.

3. Yönetim konsolu üzerinden realm ayarlarından bu temayı seçin:
   - Realm Settings > Themes > Login Theme: `sivas-belediyesi`

## Kullanım

### Tema Seçimi

Realm'iniz için temayı seçmek için:

1. Keycloak Admin Console'a giriş yapın
2. Sol menüden "Realm Settings" seçin
3. "Themes" sekmesine gidin
4. "Login Theme" dropdown'ından `sivas-belediyesi` seçin
5. Kaydedin

### Özelleştirme

#### Renkler ve Stiller

`login/resources/css/styles.css` dosyasını düzenleyerek renkleri ve stilleri değiştirebilirsiniz.

#### Logo

`login/resources/img/sivaslogo.png` dosyasını kendi logonuzla değiştirin.

#### Metinler

Türkçe metinleri `login/messages_tr.properties` dosyasında özelleştirebilirsiniz.

## Dosya Yapısı

```
sivas-belediyesi/
├── login/
│   ├── template.ftl          # Ana şablon
│   ├── login.ftl             # Giriş sayfası
│   ├── register.ftl          # Kayıt sayfası
│   ├── error.ftl             # Hata sayfası
│   ├── theme.properties      # Tema ayarları
│   ├── resources/
│   │   ├── css/
│   │   │   ├── styles.css    # Özel stiller
│   │   │   ├── bootstrap.min.css
│   │   │   └── ...
│   │   ├── js/
│   │   │   ├── bootstrap.bundle.min.js
│   │   │   └── ...
│   │   └── img/
│   │       └── sivaslogo.png # Logo
│   └── messages_tr.properties # Türkçe mesajlar
└── README.md
```

## Geliştirme

### Yerel Geliştirme

1. Keycloak'u development modunda çalıştırın:
   ```bash
   ./bin/kc.sh start-dev
   ```

2. Tema dosyalarını düzenleyin ve değişiklikleri test edin.

### Test

- Farklı tarayıcılarda test edin
- Mobil uyumluluğu kontrol edin
- Koyu mod geçişini test edin

## Katkıda Bulunma

1. Fork edin
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit edin (`git commit -m 'Add amazing feature'`)
4. Push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için `LICENSE` dosyasına bakın.

## İletişim

Sorularınız için [mcihad](https://github.com/mcihad) ile iletişime geçin.

## Sürüm Geçmişi

### v1.0.0
- İlk sürüm
- Bootstrap 5 entegrasyonu
- Koyu mod desteği
- Türkçe yerelleştirme
