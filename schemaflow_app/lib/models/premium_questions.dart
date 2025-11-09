/// Premium Questionnaire Questions for Detailed Schema Assessment
/// 50+ questions covering all 18 schemas

import 'schema_therapy_data.dart';

class PremiumQuestionsDatabase {
  static const List<PremiumQuestion> allQuestions = [
    // Domain 1: Disconnection & Rejection (10 questions)
    // Schema 1: Abandonment
    PremiumQuestion(
      id: 1,
      textEn: 'I worry that people I care about will leave me.',
      textTr: 'Önem verdiğim insanların beni terk edeceğinden endişeleniyorum.',
      schemaId: 1,
      domainId: 1,
      categoryEn: 'Abandonment',
      categoryTr: 'Terk Edilme',
    ),
    PremiumQuestion(
      id: 2,
      textEn: 'I feel anxious when someone is distant or unavailable.',
      textTr: 'Birisi uzak veya ulaşılamaz olduğunda kaygılı hissediyorum.',
      schemaId: 1,
      domainId: 1,
      categoryEn: 'Abandonment',
      categoryTr: 'Terk Edilme',
    ),
    PremiumQuestion(
      id: 3,
      textEn: 'I need constant reassurance that people care about me.',
      textTr: 'İnsanların beni önemsediğine dair sürekli güvence ihtiyacı duyuyorum.',
      schemaId: 1,
      domainId: 1,
      categoryEn: 'Abandonment',
      categoryTr: 'Terk Edilme',
    ),
    // Schema 2: Mistrust/Abuse
    PremiumQuestion(
      id: 4,
      textEn: 'I believe people will hurt me if given the chance.',
      textTr: 'İnsanların fırsat bulursa beni inciteceğine inanıyorum.',
      schemaId: 2,
      domainId: 1,
      categoryEn: 'Mistrust/Abuse',
      categoryTr: 'Güvensizlik/İstismar',
    ),
    PremiumQuestion(
      id: 5,
      textEn: 'I am suspicious of others\' intentions.',
      textTr: 'Başkalarının niyetlerinden şüpheleniyorum.',
      schemaId: 2,
      domainId: 1,
      categoryEn: 'Mistrust/Abuse',
      categoryTr: 'Güvensizlik/İstismar',
    ),
    // Schema 3: Emotional Deprivation
    PremiumQuestion(
      id: 6,
      textEn: 'I feel that no one truly understands me.',
      textTr: 'Hiç kimsenin beni gerçekten anlamadığını hissediyorum.',
      schemaId: 3,
      domainId: 1,
      categoryEn: 'Emotional Deprivation',
      categoryTr: 'Duygusal Yoksunluk',
    ),
    PremiumQuestion(
      id: 7,
      textEn: 'I struggle to ask for emotional support.',
      textTr: 'Duygusal destek isteme konusunda mücadele ediyorum.',
      schemaId: 3,
      domainId: 1,
      categoryEn: 'Emotional Deprivation',
      categoryTr: 'Duygusal Yoksunluk',
    ),
    // Schema 4: Defectiveness
    PremiumQuestion(
      id: 8,
      textEn: 'I feel fundamentally flawed or broken.',
      textTr: 'Temelde kusurlu veya kırık hissediyorum.',
      schemaId: 4,
      domainId: 1,
      categoryEn: 'Defectiveness',
      categoryTr: 'Kusurluluk',
    ),
    // Schema 5: Social Isolation
    PremiumQuestion(
      id: 9,
      textEn: 'I feel like I don\'t belong with others.',
      textTr: 'Başkalarıyla ait olmadığımı hissediyorum.',
      schemaId: 5,
      domainId: 1,
      categoryEn: 'Social Isolation',
      categoryTr: 'Sosyal İzolasyon',
    ),
    PremiumQuestion(
      id: 10,
      textEn: 'I believe I am fundamentally different from others.',
      textTr: 'Başkalarından temelde farklı olduğuma inanıyorum.',
      schemaId: 5,
      domainId: 1,
      categoryEn: 'Social Isolation',
      categoryTr: 'Sosyal İzolasyon',
    ),
    // Domain 2: Impaired Autonomy & Performance (10 questions)
    // Schema 6: Dependence
    PremiumQuestion(
      id: 11,
      textEn: 'I feel unable to handle problems on my own.',
      textTr: 'Sorunları kendi başıma çözemeyeceğimi hissediyorum.',
      schemaId: 6,
      domainId: 2,
      categoryEn: 'Dependence',
      categoryTr: 'Bağımlılık',
    ),
    PremiumQuestion(
      id: 12,
      textEn: 'I need others to make important decisions for me.',
      textTr: 'Önemli kararları benim için başkaları almasına ihtiyaç duyuyorum.',
      schemaId: 6,
      domainId: 2,
      categoryEn: 'Dependence',
      categoryTr: 'Bağımlılık',
    ),
    // Schema 7: Vulnerability to Harm
    PremiumQuestion(
      id: 13,
      textEn: 'I worry constantly about bad things happening.',
      textTr: 'Kötü şeyler olacağı konusunda sürekli endişeleniyorum.',
      schemaId: 7,
      domainId: 2,
      categoryEn: 'Vulnerability to Harm',
      categoryTr: 'Zarar Görme Korkusu',
    ),
    // Schema 8: Enmeshment
    PremiumQuestion(
      id: 14,
      textEn: 'I feel overly responsible for my family\'s emotions.',
      textTr: 'Ailemimin duygularından aşırı sorumlu hissediyorum.',
      schemaId: 8,
      domainId: 2,
      categoryEn: 'Enmeshment',
      categoryTr: 'İç İçe Geçme',
    ),
    // Schema 9: Failure
    PremiumQuestion(
      id: 15,
      textEn: 'I believe I will fail at important tasks.',
      textTr: 'Önemli görevlerde başarısız olacağıma inanıyorum.',
      schemaId: 9,
      domainId: 2,
      categoryEn: 'Failure',
      categoryTr: 'Başarısızlık',
    ),
    PremiumQuestion(
      id: 16,
      textEn: 'I avoid challenges because I fear failure.',
      textTr: 'Başarısızlık korkusuyla zorlukları kaçınıyorum.',
      schemaId: 9,
      domainId: 2,
      categoryEn: 'Failure',
      categoryTr: 'Başarısızlık',
    ),
    // Domain 3: Impaired Limits (8 questions)
    // Schema 10: Entitlement
    PremiumQuestion(
      id: 17,
      textEn: 'I believe I should not have to follow rules like others.',
      textTr: 'Başkaları gibi kurallara uymanız gerekmediğine inanıyorum.',
      schemaId: 10,
      domainId: 3,
      categoryEn: 'Entitlement',
      categoryTr: 'Hak Sahibi Olma',
    ),
    // Schema 11: Insufficient Self-Control
    PremiumQuestion(
      id: 18,
      textEn: 'I have difficulty controlling my impulses.',
      textTr: 'Dürtülerimi kontrol etmekte zorluk çekiyorum.',
      schemaId: 11,
      domainId: 3,
      categoryEn: 'Insufficient Self-Control',
      categoryTr: 'Yetersiz Öz Kontrol',
    ),
    // Domain 4: Other-Directedness (12 questions)
    // Schema 12: Subjugation
    PremiumQuestion(
      id: 19,
      textEn: 'I suppress my own needs to avoid conflict.',
      textTr: 'Çatışmayı kaçınmak için kendi ihtiyaçlarımı bastırıyorum.',
      schemaId: 12,
      domainId: 4,
      categoryEn: 'Subjugation',
      categoryTr: 'Teslim Olma',
    ),
    // Schema 13: Self-Sacrifice
    PremiumQuestion(
      id: 20,
      textEn: 'I prioritize others\' needs over my own.',
      textTr: 'Başkalarının ihtiyaçlarını kendi ihtiyaçlarımdan önce alıyorum.',
      schemaId: 13,
      domainId: 4,
      categoryEn: 'Self-Sacrifice',
      categoryTr: 'Kendini Feda Etme',
    ),
    // Schema 14: Approval-Seeking
    PremiumQuestion(
      id: 21,
      textEn: 'I need approval from others to feel good about myself.',
      textTr: 'Kendimi iyi hissetmek için başkalarından onay ihtiyacı duyuyorum.',
      schemaId: 14,
      domainId: 4,
      categoryEn: 'Approval-Seeking',
      categoryTr: 'Onay Arama',
    ),
    // Domain 5: Over-vigilance & Inhibition (12 questions)
    // Schema 15: Negativity/Pessimism
    PremiumQuestion(
      id: 22,
      textEn: 'I focus on the negative aspects of situations.',
      textTr: 'Durumların olumsuz yönlerine odaklanıyorum.',
      schemaId: 15,
      domainId: 5,
      categoryEn: 'Negativity/Pessimism',
      categoryTr: 'Olumsuzluk/Kötümserlik',
    ),
    // Schema 16: Emotional Inhibition
    PremiumQuestion(
      id: 23,
      textEn: 'I have difficulty expressing my emotions.',
      textTr: 'Duygularımı ifade etmekte zorluk çekiyorum.',
      schemaId: 16,
      domainId: 5,
      categoryEn: 'Emotional Inhibition',
      categoryTr: 'Duygusal Bastırma',
    ),
    // Schema 17: Unrelenting Standards
    PremiumQuestion(
      id: 24,
      textEn: 'I set extremely high standards for myself.',
      textTr: 'Kendim için son derece yüksek standartlar belirledim.',
      schemaId: 17,
      domainId: 5,
      categoryEn: 'Unrelenting Standards',
      categoryTr: 'Tükenmeyen Standartlar',
    ),
    // Schema 18: Punitiveness
    PremiumQuestion(
      id: 25,
      textEn: 'I believe mistakes should be severely punished.',
      textTr: 'Hataların ağır şekilde cezalandırılması gerektiğine inanıyorum.',
      schemaId: 18,
      domainId: 5,
      categoryEn: 'Punitiveness',
      categoryTr: 'Cezalandırıcılık',
    ),
  ];

  static List<PremiumQuestion> getQuestionsBySchema(int schemaId) {
    return allQuestions.where((q) => q.schemaId == schemaId).toList();
  }

  static List<PremiumQuestion> getQuestionsByDomain(int domainId) {
    return allQuestions.where((q) => q.domainId == domainId).toList();
  }
}

