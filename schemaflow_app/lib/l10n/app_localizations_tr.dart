// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'MySchema';

  @override
  String get startTestButton => 'Teste Başla';

  @override
  String get question1 =>
      'Yakın hissettiğim insanların beni terk edeceği veya bırakacağı konusunda endişelenirim.';

  @override
  String get question2 =>
      'Bir insan olarak temelde kusurlu veya eksik olduğumu hissediyorum.';

  @override
  String get question3 =>
      'İnsanlara güvenmekte zorlanıyorum çünkü beni inciteceklerini veya ihanet edeceklerini bekliyorum.';

  @override
  String get question4 =>
      'Hiçbir yere ait olmadığımı veya hiçbir insan grubuyla uyum sağlayamadığımı hissediyorum.';

  @override
  String get question5 =>
      'Başkalarından ihtiyacım olan sevgi, ilgi ve şefkati nadiren alırım.';

  @override
  String get question6 =>
      'Çoğu insanın sahip olduğu kadar yetenekli veya başarılı olmadığımı hissediyorum.';

  @override
  String get question7 =>
      'Kararlar almakta ve günlük sorumluluklarımı tek başıma yönetmekte zorlanıyorum.';

  @override
  String get question8 =>
      'Olası felaketler veya kötü şeyler olacağı konusunda sürekli endişelenirim.';

  @override
  String get question9 =>
      'Yakın ilişkilerde kendi kimliğimi korumakta zorlanıyorum.';

  @override
  String get question10 =>
      'Başkalarını memnun etmek veya çatışmadan kaçınmak için sık sık kendi ihtiyaçlarımı feda ederim.';

  @override
  String get categoryAbandonment => 'Terk Edilme';

  @override
  String get categoryDefectiveness => 'Kusurluluk';

  @override
  String get categoryMistrust => 'Güvensizlik';

  @override
  String get categorySocialIsolation => 'Sosyal İzolasyon';

  @override
  String get categoryEmotionalDeprivation => 'Duygusal Yoksunluk';

  @override
  String get categoryFailure => 'Başarısızlık';

  @override
  String get categoryDependence => 'Bağımlılık';

  @override
  String get categoryVulnerability => 'Zarar Görme';

  @override
  String get categoryEnmeshment => 'İç İçe Geçme';

  @override
  String get categorySubjugation => 'Teslim Olma';

  @override
  String get notAtAll => 'Hiç';

  @override
  String get completely => 'Tamamen';

  @override
  String get howMuchApplies => 'Bu size ne kadar uyuyor?';

  @override
  String questionProgress(int current, int total) {
    return 'Soru $current/$total';
  }

  @override
  String get analyzingAnswers => 'Cevaplarınız analiz ediliyor...';

  @override
  String get analysisMayTakeTime => 'Bu birkaç dakika sürebilir';

  @override
  String get appTagline => 'Kendini Anlamanın Yolu';

  @override
  String get authCreateAccount => 'Hesap Oluştur';

  @override
  String get authWelcomeBack => 'Tekrar Hoş Geldiniz';

  @override
  String get authFullNameLabel => 'Ad Soyad';

  @override
  String get authEmailLabel => 'E-posta';

  @override
  String get authPasswordLabel => 'Şifre';

  @override
  String get authPleaseEnterName => 'Lütfen adınızı girin';

  @override
  String get authPleaseEnterEmail => 'Lütfen e-postanızı girin';

  @override
  String get authPleaseEnterValidEmail => 'Lütfen geçerli bir e-posta girin';

  @override
  String get authPleaseEnterPassword => 'Lütfen şifrenizi girin';

  @override
  String get authPasswordMin => 'Şifre en az 6 karakter olmalı';

  @override
  String get authSignIn => 'Giriş Yap';

  @override
  String get authSignUp => 'Kayıt Ol';

  @override
  String get authOrContinueWith => 'Veya devam edin';

  @override
  String get authGoogle => 'Google';

  @override
  String get authApple => 'Apple';

  @override
  String get authGoogleSoon => 'Google ile giriş yakında!';

  @override
  String get authAppleSoon => 'Apple ile giriş yakında!';

  @override
  String get authAlreadyHaveAccount => 'Zaten bir hesabınız var mı?';

  @override
  String get authDontHaveAccount => 'Hesabınız yok mu?';

  @override
  String get splashTagline => 'Kendini Anlamanın Yolu';

  @override
  String get mockAnalysisFallback =>
      'Bu şema, kendinizi nasıl algıladığınızı ve başkalarıyla nasıl ilişki kurduğunuzu etkileyen önemli bir örüntüyü temsil eder. Bu örüntüyü anlamak, kişisel gelişim ve iyileşme yolunda ilk adımdır.';

  @override
  String get next => 'Sonraki';

  @override
  String get complete => 'Bitir';

  @override
  String get userDefaultName => 'Kullanıcı';

  @override
  String greetingHello(String name) {
    return 'Merhaba, $name! 👋';
  }

  @override
  String get homeExplorePrompt => 'İç dünyanı keşfetmeye hazır mısın?';

  @override
  String get analysisReady => 'Analiziniz Hazır!';

  @override
  String get analysisAwaits => 'Analiziniz Sizi Bekliyor';

  @override
  String get viewResults => 'Sonuçları Gör';

  @override
  String get beginQuestionnaire => 'Ankete Başla';

  @override
  String get progress => 'İlerleme';

  @override
  String get status => 'Durum';

  @override
  String get premium => 'Premium';

  @override
  String get free => 'Ücretsiz';

  @override
  String get yourJourney => 'Yolculuğunuz';

  @override
  String get schemaAnalysisReport => 'Şema Analizi Raporu';

  @override
  String get completedToday => 'Bugün tamamlandı';

  @override
  String get noReportsYet => 'Henüz rapor yok';

  @override
  String get completeFirstQuestionnaire =>
      'Analizinizi burada görmek için ilk anketinizi tamamlayın.';

  @override
  String get homeCompletedDescription =>
      'Ayrıntılı analiz ve içgörülerinizi keşfedin.';

  @override
  String get homePromptDescription =>
      'Kişiselleştirilmiş bir analiz için ilk anketinizi başlatın.';

  @override
  String get paywallPurchaseFailedPrefix => 'Satın alma başarısız: ';

  @override
  String get paywallPurchaseFailed =>
      'Satın alma tamamlanamadı. Lütfen tekrar deneyin.';

  @override
  String get paywallNoPurchaseAvailable =>
      'Şu anda satın alma seçeneği yok. Lütfen daha sonra tekrar deneyin.';

  @override
  String get paywallHeaderTitle => 'Tam Şema Analizinizi Açın';

  @override
  String get paywallHeaderSubtitle =>
      'İçgörüler, egzersizler ve AI sohbet ile tam raporunuzu alın.';

  @override
  String get paywallFeatureCompleteTitle => 'Tam Rapor';

  @override
  String get paywallFeatureCompleteDesc =>
      'Tüm şemalarınızın ayrıntılı analizi ve kişiselleştirilmiş içgörüler.';

  @override
  String get paywallFeatureRelationshipTitle => 'İlişkiler ve Kariyer';

  @override
  String get paywallFeatureRelationshipDesc =>
      'Şemalarınızın aşk, arkadaşlık ve işi nasıl etkilediğini görün.';

  @override
  String get paywallFeatureOriginsTitle => 'Kökenler ve Örüntüler';

  @override
  String get paywallFeatureOriginsDesc =>
      'Örüntülerinizin nereden geldiğini ve neden sürdüğünü anlayın.';

  @override
  String get paywallFeatureGrowthTitle => 'Gelişim Planı';

  @override
  String get paywallFeatureGrowthDesc =>
      'İyileşmeyi destekleyen uygulanabilir adımlar ve egzersizler.';

  @override
  String get paywallFeatureAiChatTitle => 'AI Sohbet';

  @override
  String get paywallFeatureAiChatDesc =>
      'Sorular sorun ve sonuçlarınıza göre rehberlik alın.';

  @override
  String get paywallSummaryTitle =>
      'Kişiselleştirilmiş rehberliğinize sadece bir adım kaldı';

  @override
  String get paywallSummarySubtitle =>
      'Tek seferlik satın alma. Ömür boyu erişim.';

  @override
  String get paywallPrice => '\$9.99';

  @override
  String get paywallSummaryNote =>
      'Ayarlar üzerinden istediğiniz zaman iptal edin.';

  @override
  String get paywallRecommendedBadge => 'ÖNERİLEN';

  @override
  String get paywallConfirmCta => 'Satın Al ve Tam Raporumu Gör';

  @override
  String get paywallRestorePurchase => 'Satın Alımı Geri Yükle';

  @override
  String get paywallRestoreSoon => 'Satın alım geri yükleme yakında!';

  @override
  String paywallUnlockCta(String price) {
    return 'Tam Raporu Aç ($price)';
  }

  @override
  String get teaserAppBarTitle => 'Analiz Önizlemesi';

  @override
  String get teaserBadgeInitial => 'İlk Analiz Önizlemesi';

  @override
  String get teaserHeaderTitle => 'Kişilik Analiziniz';

  @override
  String get teaserHeaderSubtitle =>
      'Cevaplarınıza göre, birincil psikolojik örüntünüzü belirledik.';

  @override
  String get teaserPrimaryTendency => 'Birincil Eğiliminiz';

  @override
  String get teaserSectionTitle => 'Analiz Önizlemesi';

  @override
  String get teaserUnlockNote => 'Devamını okumak için açın';

  @override
  String get teaserCtaHeading => 'Bu sadece başlangıç';

  @override
  String get teaserCtaIntro => 'Tam rapor şunları ortaya çıkaracak:';

  @override
  String get teaserBenefit1 =>
      'Bu şemanın ilişkilerinizi ve kariyerinizi nasıl etkilediği';

  @override
  String get teaserBenefit2 =>
      'Bu örüntünün geçmiş deneyimlerinizdeki kökenleri';

  @override
  String get teaserBenefit3 =>
      'Büyüme ve iyileşme için kişiselleştirilmiş adımlar';

  @override
  String get teaserBenefit4 =>
      'Ayrıntılı başa çıkma stratejileri ve egzersizler';

  @override
  String get teaserBenefit5 =>
      'Şema terapisi uzmanlarından profesyonel içgörüler';

  @override
  String get resultsFabChatWithAi => 'Yapay Zeka ile Sohbet';

  @override
  String get resultsAppBarTitle => 'Şema Profiliniz';

  @override
  String get resultsShareSoon => 'Paylaşma özelliği yakında!';

  @override
  String get resultsProfileTitle => 'Mükemmeliyetçi';

  @override
  String get resultsProfileSubtitle => 'Yüksek Standartlar ve Başarı Profili';

  @override
  String get resultsCompletedToday => 'Analiz bugün tamamlandı';

  @override
  String resultsScoreLabel(double score) {
    return 'Puan: $score/6.0';
  }

  @override
  String get resultsSectionOverview => 'Genel Bakış';

  @override
  String get resultsSectionEffects => 'Olası Etkiler';

  @override
  String get resultsSectionNextSteps => 'Sonraki Adımlar';

  @override
  String get resultsSeverityLow => 'Düşük';

  @override
  String get resultsSeverityModerate => 'Orta';

  @override
  String get resultsSeverityHigh => 'Yüksek';

  @override
  String get chatWelcomeMessage =>
      'Merhaba! Ben sizin Yapay Zeka Şema Analistinizim. Anket sonuçlarınızı inceledim ve şema profilinizi daha iyi anlamanıza yardımcı olmak için buradayım.\n\nŞu tür sorular sorabilirsiniz:\n• \"Neden mükemmeliyetçiliğim bu kadar yüksek?\"\n• \"Terk edilme korkularımla nasıl çalışabilirim?\"\n• \"Şemalarım arasındaki bağlantı nedir?\"\n• \"Durumuma özel egzersizler verebilir misin?\"\n\nSonuçlarınız hakkında neyi keşfetmek istersiniz?';

  @override
  String get chatRespPerfectionism =>
      'Mükemmeliyetçiliğinizi daha iyi anlamak istediğinizi görüyorum. Bu alandaki yüksek puanınıza göre, bu gerçekten baskın şemalarınızdan biri.\n\nMükemmeliyetçilik genellikle erken yaşta değerimizin kusursuz performansa bağlı olduğuna inandığımızda gelişir. İşte bazı ana noktalar:\n\nNeden gelişti: Çocuklukta hataların eleştirildiği veya sevginin başarıya bağlı hissettirdiği deneyimler.\nNasıl ortaya çıkar: Aşırı yüksek standartlar koyma, delege etmekte zorlanma, her şey \'tam\' olmadığında huzursuzluk.\nNasıl çalışılır: \'Yeterince iyi\' olduğu alanları belirleyin. 80/20 kuralını uygulayın çoğu zaman %80 çaba ihtiyacınızı karşılar.\n\nMükemmeliyetçi eğilimleri yönetmek için size bazı özel egzersizler önermemi ister misiniz?';

  @override
  String get chatRespAbandonment =>
      'Terk edilme korkuları özellikle yakın ilişkilerde zorlayıcı olabilir. Sonuçlarınız bu alanda önemli sıkıntı yaşadığınızı gösteriyor.\n\nÖrüntüyü anlamak: Kendinizi ya ilişkilere çok sıkı sarılırken ya da bırakılmadan önce insanları uzaklaştırırken bulabilirsiniz.\nAlttaki korku: \'Değer verdiğim insanlar kaçınılmaz olarak beni bırakacak veya elimden alınacak.\'\n\nİyileşme yaklaşımları:\n• Panik olduğunuzda kendinizi yatıştırma teknikleri uygulayın\n• İlişkileri test etmek yerine ihtiyaçlarınızı doğrudan ifade edin\n• Tek kişiye bağımlı olmamak için bir destek ağı oluşturun\n\nUnutmayın, bu şema bir korunma mekanizması olarak gelişti. Zihniniz sizi güvende tutmak için terk edilme konusunda aşırı tetikte olmayı öğrendi.\n\nKendinizde fark ettiğiniz belirli ilişki örüntüleri neler?';

  @override
  String get chatRespExercises =>
      'Harika soru! Şema profilinize göre uyarlanmış bazı pratik egzersizler:\n\nMükemmeliyetçilik için:\n1) \'Yeterince İyi\' Meydan Okuması: Her gün bir işi bilinçli olarak %80 hedefleyin\n2) Hata Günlüğü: Her gün bir hata ve öğrendiğiniz bir şeyi yazın\n3) Zaman Kutulaması: Bitmeyen düzeltmeleri önlemek için görevler için katı süreler belirleyin\n\nTerk Edilme Korkuları için:\n1) Yatıştırma Seti: Terk edilmiş hissettiğinizde sizi rahatlatan 5 şeyi listeleyin\n2) Gerçeklik Testi: Birinin uzaklaştığını hissettiğinizde 3 alternatif açıklama yazın\n3) Bağımsızlık Geliştirme: Haftada bir keyifli bir aktiviteyi tek başınıza yapın\n\nGenel Şema Çalışması:\n• Günlük farkındalık (5 dakika bile faydalıdır)\n• Şema günlüğü: Şemalar tetiklendiğinde fark edin\n• Şema modunda kendinizi yakaladığınızda öz-şefkat molaları\n\nHangisi sizinle daha çok rezonans ediyor? Spesifik bir egzersiz için daha ayrıntılı rehberlik sağlayabilirim.';

  @override
  String get chatRespDefault =>
      'Düşünceli bir soru. Şema profilinize göre, kendinizi daha iyi anlamaya gerçekten bağlı olduğunuzu görüyorum.\n\nBaskın şemalarınız (Mükemmeliyetçilik ve Terk Edilme) sıklıkla birlikte çalışır — bırakılma korkusu, terk edilmemek için bir yol olarak mükemmeliyetçi davranışları tetikleyebilir.\n\nŞunları keşfetmenizi öneririm:\n• Bu örüntüler hayatınızda ilk nasıl gelişti\n• Şu anda en güçlü ne tetikliyor\n• Bunlarla çalışmak için küçük, yönetilebilir adımlar\n\nŞema çalışması bir yolculuktur, varış noktası değil. Bu derin örüntüleri keşfederken kendinize sabırlı ve şefkatli olun.\n\nŞemalarınızı daha iyi anlamak istediğiniz belirli bir durum veya ilişki var mı?';

  @override
  String get chatTitle => 'Yapay Zeka Şema Analisti';

  @override
  String get chatOnline => 'Çevrimiçi';

  @override
  String get chatInputHint => 'Şema sonuçlarınız hakkında sorun...';

  @override
  String get profileSignOutTitle => 'Çıkış Yap';

  @override
  String get profileSignOutQuestion =>
      'Çıkış yapmak istediğinize emin misiniz?';

  @override
  String get commonCancel => 'İptal';

  @override
  String get commonSignOut => 'Çıkış Yap';

  @override
  String get profileFailedSignOutPrefix => 'Çıkış yapılamadı: ';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileSubscriptionStatus => 'Abonelik Durumu';

  @override
  String get profileCurrentPlan => 'Mevcut Plan';

  @override
  String get profileMemberSince => 'Üyelik Başlangıcı';

  @override
  String get profileUpgradeSoon => 'Yükseltme özelliği yakında!';

  @override
  String get profileUpgradePremium => 'Premium\'a Yükselt';

  @override
  String get profileEditTitle => 'Profili Düzenle';

  @override
  String get profileEditSubtitle => 'Adınızı ve e-postanızı güncelleyin';

  @override
  String get profileEditSoon => 'Profil düzenleme yakında!';

  @override
  String get profileManageSubTitle => 'Aboneliği Yönet';

  @override
  String get profileManageSubSubtitle =>
      'Faturalamayı görüntüleyin ve aboneliği iptal edin';

  @override
  String get profileManageSubSoon => 'Abonelik yönetimi yakında!';

  @override
  String get profileLanguageTitle => 'Dil / Language';

  @override
  String get profileHelpTitle => 'Yardım ve Destek';

  @override
  String get profileHelpSubtitle => 'Hesabınızla ilgili yardım alın';

  @override
  String get profileHelpSoon => 'Yardım ve destek yakında!';

  @override
  String get profilePrivacyTitle => 'Gizlilik Politikası';

  @override
  String get profilePrivacySubtitle => 'Gizlilik politikamızı okuyun';

  @override
  String get profilePrivacySoon => 'Gizlilik politikası yakında!';

  @override
  String get profileSignOutButton => 'Çıkış Yap';

  @override
  String get citationsTitle => 'Tıbbi ve Araştırma Kaynakları';

  @override
  String get citationsDescription =>
      'Bu analiz, bilimsel olarak kanıtlanmış bir psikoterapi yaklaşımı olan Şema Terapisine dayanmaktadır.';

  @override
  String get citationSchemaTherapy =>
      'Schema Therapy: A Practitioner\'s Guide - Jeffrey E. Young, Janet S. Klosko ve Marjorie E. Weishaar';

  @override
  String get citationResearch =>
      'Şema Terapisinin etkinliği hakkında akran tarafından incelenen dergilerde yayınlanan araştırmalar';

  @override
  String get citationDisclaimer =>
      'Bu uygulama eğitim amaçlı bilgi sağlar ve profesyonel ruh sağlığı tedavisinin yerine geçmez. Tanı ve tedavi için lütfen lisanslı bir terapist veya ruh sağlığı uzmanına danışın.';

  @override
  String get learnMore => 'Daha Fazla Bilgi';

  @override
  String get helpTitle => 'Yardım ve Destek';

  @override
  String get helpFaqTitle => 'Sık Sorulan Sorular';

  @override
  String get helpContactTitle => 'Destek ile İletişime Geçin';

  @override
  String get helpContactEmail => 'support@myschema.app';

  @override
  String get helpFaq1 => 'Şema Terapisi Nedir?';

  @override
  String get helpFaq1Answer =>
      'Şema Terapisi, bilişsel-davranışçı terapi, bağlanma teorisi ve duygu odaklı terapinin unsurlarını birleştiren bütünleştirici bir psikoterapi yaklaşımıdır. Derin köklü düşünce ve davranış örüntülerini tanımlamaya ve değiştirmeye yardımcı olur.';

  @override
  String get helpFaq2 => 'Bu değerlendirme ne kadar doğru?';

  @override
  String get helpFaq2Answer =>
      'Bu değerlendirme, doğrulanmış şema terapi anketlerine dayanmaktadır. Ancak, öz-farkındalık ve eğitim amaçları için tasarlanmıştır. Profesyonel bir tanı için lütfen lisanslı bir terapistle danışın.';

  @override
  String get helpFaq3 => 'Anketi tekrar yapabilir miyim?';

  @override
  String get helpFaq3Answer =>
      'Evet, anket sayfasından istediğiniz zaman anketi tekrar yapabilirsiniz. Yeni sonuçlarınız önceki sonuçların yerini alacaktır.';

  @override
  String get helpFaq4 => 'Verilerim gizli mi?';

  @override
  String get helpFaq4Answer =>
      'Evet, verileriniz şifrelenmiş ve güvenli bir şekilde depolanmaktadır. Kişisel bilgilerinizi asla üçüncü taraflarla paylaşmayız.';

  @override
  String get helpEmailSubject => 'MySchema Destek İsteği';

  @override
  String get helpEmailBody =>
      'Merhaba,\n\nMySchema uygulaması ile ilgili yardıma ihtiyacım var:\n\n[Lütfen sorununuzu burada açıklayın]\n\nTeşekkür ederim!';

  @override
  String get detailedAssessment => 'Detaylı Şema Değerlendirmesi';

  @override
  String get question => 'Soru';

  @override
  String get pleaseAnswerAllQuestions =>
      'Göndermeden önce lütfen tüm soruları cevaplayın';

  @override
  String get previous => 'Önceki';

  @override
  String get submit => 'Gönder';

  @override
  String get completelyDisagree => 'Tamamen Katılmıyorum';

  @override
  String get mostlyDisagree => 'Çoğunlukla Katılmıyorum';

  @override
  String get slightlyDisagree => 'Biraz Katılmıyorum';

  @override
  String get slightlyAgree => 'Biraz Katılıyorum';

  @override
  String get mostlyAgree => 'Çoğunlukla Katılıyorum';

  @override
  String get completelyAgree => 'Tamamen Katılıyorum';

  @override
  String get yourResults => 'Değerlendirme Sonuçlarınız';

  @override
  String get assessmentSummary => 'Değerlendirme Özeti';

  @override
  String get totalQuestions => 'Toplam Sorular';

  @override
  String get completedAt => 'Tamamlandı';

  @override
  String get dominantSchemas => 'Baskın Şemalarınız';

  @override
  String get domainBreakdown => 'Alan Dağılımı';

  @override
  String get backToHome => 'Ana Sayfaya Dön';

  @override
  String get therapyRecommendations => 'Terapi Önerileri';

  @override
  String get personalizedTherapyPlan => 'Kişiselleştirilmiş Terapi Planı';

  @override
  String get recommendedApproach => 'Önerilen Yaklaşım:';

  @override
  String get suggestedPractices => 'Önerilen Uygulamalar:';

  @override
  String get schemaEducation => 'Şema Eğitimi';

  @override
  String get assessmentProgress => 'Değerlendirme İlerleme';

  @override
  String get progressTracking => 'İlerleme Takibi';

  @override
  String get yourAssessmentHistory => 'Değerlendirme Geçmişiniz';

  @override
  String get schemaScoreTrends => 'Şema Puan Trendleri';

  @override
  String get noAssessmentHistory => 'Henüz değerlendirme geçmişi yok';

  @override
  String get completeAssessments =>
      'Zaman içinde ilerlemenizi görmek için değerlendirmeleri tamamlayın';

  @override
  String get exportResults => 'Sonuçları Dışa Aktar';

  @override
  String get exportAsText => 'Metin Olarak Dışa Aktar';

  @override
  String get exportAsCSV => 'CSV Olarak Dışa Aktar';

  @override
  String get shareSummary => 'Özeti Paylaş';

  @override
  String get copiedToClipboard => 'Panoya kopyalandı!';

  @override
  String get viewProgress => 'İlerlemeyi Görüntüle';

  @override
  String get premiumFeatures => 'Premium Özellikler';

  @override
  String get detailedAssessmentTitle => 'Detaylı Değerlendirme';

  @override
  String get detailedAssessmentSubtitle => 'Derin Analiz';

  @override
  String get schemaEducationTitle => 'Şema Eğitimi';

  @override
  String get schemaEducationSubtitle => 'Daha Fazla Bilgi';

  @override
  String get progressTrackingTitle => 'İlerleme Takibi';

  @override
  String get progressTrackingSubtitle => 'Senin Yolculuğun';

  @override
  String get recommendationsTitle => 'Öneriler';

  @override
  String get recommendationsSubtitle => 'Kişiselleştirilmiş';

  @override
  String get schemaChatTitle => 'Şema Sohbeti';

  @override
  String get schemaChatSubtitle => 'AI Asistanı';

  @override
  String get difficultyToHeal => 'İyileşme Zorluğu';

  @override
  String get impactLevel => 'Etki Seviyesi';

  @override
  String whatIsSchema(String schema) {
    return '$schema Nedir?';
  }

  @override
  String get childhoodOrigins => 'Çocukluk Kökleri';

  @override
  String get howThisSchemaAffectsYou => 'Bu Şema Seni Nasıl Etkiliyor';

  @override
  String get pathToHealing => 'İyileşme Yolu';

  @override
  String get overview => 'Genel Bakış';

  @override
  String get origins => 'Kökenler';

  @override
  String get effects => 'Etkiler';

  @override
  String get healing => 'İyileşme';

  @override
  String get completeDetailedAssessmentFirst =>
      'Lütfen önce Detaylı Değerlendirmeyi tamamlayın';

  @override
  String get basedOnAssessmentResults =>
      'Değerlendirme sonuçlarınıza göre, baskın şemalarınız için önerilen terapötik yaklaşımlar aşağıdadır.';

  @override
  String get score => 'Puan';

  @override
  String get localizationInfo => 'Yerelleştirme Bilgisi';

  @override
  String get currentLocale => 'Mevcut Dil';

  @override
  String get defaultLanguage => 'Varsayılan Dil';

  @override
  String get mindfulnessMeditation =>
      'Farkındalık meditasyonu (günde 10-15 dakika)';

  @override
  String get journalingAboutSchemaTriggers =>
      'Şema tetikleyicileri hakkında günlük tutma';

  @override
  String get cognitiveRestructuring =>
      'Bilişsel yeniden yapılandırma egzersizleri';

  @override
  String get behavioralExperiments =>
      'İnançları test etmek için davranışsal deneyler';

  @override
  String get schemaImageryRescripting => 'Şema imajeri yeniden yazma';

  @override
  String get yourScore => 'Senin Puanın';

  @override
  String get askMeAnything => 'Bana her şey sorabilirsin...';

  @override
  String schemaGreeting(String schema) {
    return 'Merhaba! $schema hakkında bilgi sahibi olmana ve onunla çalışmana yardımcı olmak için buradayım.';
  }

  @override
  String basedOnTestResults(String score) {
    return 'Test sonuçlarınıza göre, bu şema için puanınız $score/6.';
  }

  @override
  String get feelFreeToAsk =>
      'Aşağıdaki konular hakkında bana her şey sorabilirsin:';

  @override
  String get whatThisSchemaMeans => 'Bu şema ne anlama geliyor';

  @override
  String get howItAffectsYou => 'Seni nasıl etkiliyor';

  @override
  String get whereItComesFrom => 'Nereden geliyor';

  @override
  String get howToHealFromIt => 'Ondan nasıl iyileşilir';

  @override
  String get whatWouldYouLikeToKnow => 'Ne bilmek istersin?';

  @override
  String get low => 'Düşük';

  @override
  String get moderate => 'Orta';

  @override
  String get significant => 'Önemli';

  @override
  String get high => 'Yüksek';

  @override
  String get veryHigh => 'Çok Yüksek';
}
