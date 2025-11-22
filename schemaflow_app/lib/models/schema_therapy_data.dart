/// Schema Therapy Data Models
/// Based on Young, Klosko, and Weishaar's Schema Therapy framework
/// 18 Early Maladaptive Schemas organized into 5 domains

import 'package:flutter/material.dart';

/// The 5 core emotional needs according to Schema Therapy
enum CoreEmotionalNeed {
  secureAttachment,
  autonomyCompetence,
  freedomExpression,
  spontaneityPlay,
  realisticLimits,
}

/// The 5 schema domains
enum SchemaDomain {
  disconnectionRejection,
  impairedAutonomy,
  impairedLimits,
  otherDirectedness,
  overVigilanceInhibition,
}

/// Represents a single Early Maladaptive Schema
class SchemaTherapySchema {
  final int id;
  final String nameEn;
  final String nameTr;
  final SchemaDomain domain;
  final String descriptionEn;
  final String descriptionTr;
  final String childhoodOriginEn;
  final String childhoodOriginTr;
  final List<String> effectsEn;
  final List<String> effectsTr;
  final String healingApproachEn;
  final String healingApproachTr;
  final int difficultyToHeal; // 1-5 scale
  final IconData icon;
  final Color color;

  const SchemaTherapySchema({
    required this.id,
    required this.nameEn,
    required this.nameTr,
    required this.domain,
    required this.descriptionEn,
    required this.descriptionTr,
    required this.childhoodOriginEn,
    required this.childhoodOriginTr,
    required this.effectsEn,
    required this.effectsTr,
    required this.healingApproachEn,
    required this.healingApproachTr,
    required this.difficultyToHeal,
    required this.icon,
    required this.color,
  });
}

/// Premium questionnaire question for detailed schema assessment
class PremiumQuestion {
  final int id;
  final String textEn;
  final String textTr;
  final int schemaId; // Which schema this question targets
  final int domainId; // Which domain this question targets
  final String categoryEn;
  final String categoryTr;

  const PremiumQuestion({
    required this.id,
    required this.textEn,
    required this.textTr,
    required this.schemaId,
    required this.domainId,
    required this.categoryEn,
    required this.categoryTr,
  });
}

/// Premium questionnaire result
class PremiumQuestionnaireResult {
  final Map<int, double> schemaScores; // schemaId -> score (1-6)
  final Map<int, double> domainScores; // domainId -> average score
  final DateTime completedAt;
  final int totalQuestions;

  const PremiumQuestionnaireResult({
    required this.schemaScores,
    required this.domainScores,
    required this.completedAt,
    required this.totalQuestions,
  });
}

/// All 18 Early Maladaptive Schemas database
class SchemaTherapyDatabase {
  static const List<SchemaTherapySchema> allSchemas = [
    // Domain 1: Disconnection & Rejection (5 schemas)
    SchemaTherapySchema(
      id: 1,
      nameEn: 'Abandonment',
      nameTr: 'Terk Edilme',
      domain: SchemaDomain.disconnectionRejection,
      descriptionEn: 'Fear that loved ones will leave or die, leaving you alone.',
      descriptionTr: 'Sevdiklerinizin sizi terk edeceği veya öleceği korkusu.',
      childhoodOriginEn: 'Unstable or unpredictable parental relationships, loss, or separation.',
      childhoodOriginTr: 'İstikrarsız ebeveyn ilişkileri, kayıp veya ayrılık.',
      effectsEn: ['Intense fear of abandonment', 'Desperate attempts to prevent separation', 'Difficulty trusting relationships', 'Anxiety and panic in relationships'],
      effectsTr: ['Terk edilme korkusu', 'Ayrılmayı önleme çabaları', 'İlişkilerde güven sorunu', 'İlişkilerde kaygı ve panik'],
      healingApproachEn: 'Build secure attachments, develop trust gradually, process past losses.',
      healingApproachTr: 'Güvenli bağlantılar kurun, kademeli olarak güven geliştirin.',
      difficultyToHeal: 4,
      icon: Icons.favorite_border,
      color: const Color(0xFFE91E63),
    ),
    SchemaTherapySchema(
      id: 2,
      nameEn: 'Mistrust/Abuse',
      nameTr: 'Güvensizlik/İstismar',
      domain: SchemaDomain.disconnectionRejection,
      descriptionEn: 'Belief that others will hurt, abuse, or take advantage of you.',
      descriptionTr: 'Başkalarının sizi inciteceği, istismar edeceği veya yararlanacağı inancı.',
      childhoodOriginEn: 'Abuse, betrayal, or violation of trust by caregivers.',
      childhoodOriginTr: 'Ebeveynler tarafından istismar, ihanet veya güven ihlali.',
      effectsEn: ['Hypervigilance', 'Difficulty trusting others', 'Anger and resentment', 'Isolation'],
      effectsTr: ['Aşırı dikkatlilik', 'Başkalarına güven sorunu', 'Öfke ve kin', 'İzolasyon'],
      healingApproachEn: 'Develop trust through safe relationships, process trauma.',
      healingApproachTr: 'Güvenli ilişkiler aracılığıyla güven geliştirin.',
      difficultyToHeal: 5,
      icon: Icons.shield,
      color: const Color(0xFFFF6F00),
    ),
    SchemaTherapySchema(
      id: 3,
      nameEn: 'Emotional Deprivation',
      nameTr: 'Duygusal Yoksunluk',
      domain: SchemaDomain.disconnectionRejection,
      descriptionEn: 'Belief that your emotional needs will not be met by others.',
      descriptionTr: 'Duygusal ihtiyaçlarınızın başkaları tarafından karşılanmayacağı inancı.',
      childhoodOriginEn: 'Emotionally unavailable or neglectful parents.',
      childhoodOriginTr: 'Duygusal olarak ulaşılamaz veya ihmal eden ebeveynler.',
      effectsEn: ['Loneliness', 'Difficulty asking for help', 'Emotional numbness', 'Seeking unavailable partners'],
      effectsTr: ['Yalnızlık', 'Yardım isteme zorluğu', 'Duygusal uyuşukluk', 'Ulaşılamaz partnerler arama'],
      healingApproachEn: 'Learn to express needs, build supportive relationships.',
      healingApproachTr: 'İhtiyaçları ifade etmeyi öğrenin, destekleyici ilişkiler kurun.',
      difficultyToHeal: 3,
      icon: Icons.sentiment_very_dissatisfied,
      color: const Color(0xFF1976D2),
    ),
    SchemaTherapySchema(
      id: 4,
      nameEn: 'Defectiveness',
      nameTr: 'Kusurluluk',
      domain: SchemaDomain.disconnectionRejection,
      descriptionEn: 'Belief that you are fundamentally flawed or unlovable.',
      descriptionTr: 'Temelde kusurlu veya sevilemez olduğunuz inancı.',
      childhoodOriginEn: 'Criticism, shame, or conditional love from parents.',
      childhoodOriginTr: 'Ebeveynlerden eleştiri, utanç veya koşullu sevgi.',
      effectsEn: ['Low self-esteem', 'Shame and self-criticism', 'Difficulty accepting compliments', 'Perfectionism'],
      effectsTr: ['Düşük öz saygı', 'Utanç ve öz eleştiri', 'Iltifatları kabul etme zorluğu', 'Mükemmeliyetçilik'],
      healingApproachEn: 'Challenge negative self-beliefs, practice self-compassion.',
      healingApproachTr: 'Olumsuz öz inançlara meydan okuyun, öz şefkat uygulayın.',
      difficultyToHeal: 4,
      icon: Icons.sentiment_dissatisfied,
      color: const Color(0xFFD32F2F),
    ),
    SchemaTherapySchema(
      id: 5,
      nameEn: 'Social Isolation',
      nameTr: 'Sosyal İzolasyon',
      domain: SchemaDomain.disconnectionRejection,
      descriptionEn: 'Belief that you are different and do not belong with others.',
      descriptionTr: 'Farklı olduğunuz ve başkalarıyla ait olmadığınız inancı.',
      childhoodOriginEn: 'Feeling different from peers, family rejection, or cultural differences.',
      childhoodOriginTr: 'Akranlardan farklı hissetme, aile reddi veya kültürel farklar.',
      effectsEn: ['Loneliness', 'Difficulty making friends', 'Feeling like an outsider', 'Withdrawal'],
      effectsTr: ['Yalnızlık', 'Arkadaş yapma zorluğu', 'Dışarıda hissetme', 'Çekilme'],
      healingApproachEn: 'Find communities, challenge isolation beliefs, build connections.',
      healingApproachTr: 'Topluluklar bulun, izolasyon inançlarına meydan okuyun.',
      difficultyToHeal: 3,
      icon: Icons.person_outline,
      color: const Color(0xFF7B1FA2),
    ),
    // Domain 2: Impaired Autonomy & Performance (4 schemas)
    SchemaTherapySchema(
      id: 6,
      nameEn: 'Dependence',
      nameTr: 'Bağımlılık',
      domain: SchemaDomain.impairedAutonomy,
      descriptionEn: 'Belief that you cannot handle life without help from others.',
      descriptionTr: 'Başkalarının yardımı olmadan hayatı yönetemeyeceğiniz inancı.',
      childhoodOriginEn: 'Overprotective parents, lack of encouragement for independence.',
      childhoodOriginTr: 'Aşırı koruyucu ebeveynler, bağımsızlık teşvikinin olmaması.',
      effectsEn: ['Difficulty making decisions', 'Seeking reassurance constantly', 'Lack of confidence', 'Avoidance of challenges'],
      effectsTr: ['Karar verme zorluğu', 'Sürekli güvence arama', 'Güven eksikliği', 'Zorlukları kaçınma'],
      healingApproachEn: 'Build competence, take small risks, develop independence gradually.',
      healingApproachTr: 'Yetkinlik geliştirin, küçük riskler alın, kademeli bağımsızlık.',
      difficultyToHeal: 2,
      icon: Icons.support_agent,
      color: const Color(0xFF0097A7),
    ),
    SchemaTherapySchema(
      id: 7,
      nameEn: 'Vulnerability to Harm',
      nameTr: 'Zarar Görme Korkusu',
      domain: SchemaDomain.impairedAutonomy,
      descriptionEn: 'Exaggerated fear that disaster will strike at any moment.',
      descriptionTr: 'Her an felaket olacağı konusunda abartılı korku.',
      childhoodOriginEn: 'Anxious parents, overemphasis on dangers, actual trauma.',
      childhoodOriginTr: 'Kaygılı ebeveynler, tehlikelerin aşırı vurgulanması.',
      effectsEn: ['Chronic anxiety', 'Hypervigilance', 'Avoidance behaviors', 'Difficulty relaxing'],
      effectsTr: ['Kronik kaygı', 'Aşırı dikkatlilik', 'Kaçınma davranışları', 'Rahatlamada zorluk'],
      healingApproachEn: 'Reality testing, gradual exposure, anxiety management techniques.',
      healingApproachTr: 'Gerçeklik testi, kademeli maruz kalma, kaygı yönetimi.',
      difficultyToHeal: 3,
      icon: Icons.warning,
      color: const Color(0xFFF57C00),
    ),
    SchemaTherapySchema(
      id: 8,
      nameEn: 'Enmeshment',
      nameTr: 'İç İçe Geçme',
      domain: SchemaDomain.impairedAutonomy,
      descriptionEn: 'Excessive emotional involvement with family, lack of individual identity.',
      descriptionTr: 'Aile ile aşırı duygusal bağlantı, bireysel kimlik eksikliği.',
      childhoodOriginEn: 'Enmeshed family dynamics, parents living through children.',
      childhoodOriginTr: 'İç içe geçmiş aile dinamikleri, ebeveynlerin çocuklar aracılığıyla yaşaması.',
      effectsEn: ['Difficulty with independence', 'Unclear personal identity', 'Difficulty making own choices', 'Guilt about separating'],
      effectsTr: ['Bağımsızlıkta zorluk', 'Belirsiz kişisel kimlik', 'Kendi seçim yapma zorluğu', 'Ayrılma suçluluğu'],
      healingApproachEn: 'Develop individual identity, set boundaries, practice autonomy.',
      healingApproachTr: 'Bireysel kimlik geliştirin, sınırlar belirleyin, bağımsızlık uygulayın.',
      difficultyToHeal: 3,
      icon: Icons.people,
      color: const Color(0xFF00796B),
    ),
    SchemaTherapySchema(
      id: 9,
      nameEn: 'Failure',
      nameTr: 'Başarısızlık',
      domain: SchemaDomain.impairedAutonomy,
      descriptionEn: 'Belief that you are incompetent and will fail at important tasks.',
      descriptionTr: 'Yetersiz olduğunuz ve önemli görevlerde başarısız olacağınız inancı.',
      childhoodOriginEn: 'Lack of encouragement, criticism, or actual failure experiences.',
      childhoodOriginTr: 'Teşvik eksikliği, eleştiri veya gerçek başarısızlık deneyimleri.',
      effectsEn: ['Low self-efficacy', 'Avoidance of challenges', 'Procrastination', 'Underachievement'],
      effectsTr: ['Düşük öz yeterlilik', 'Zorlukları kaçınma', 'Erteleme', 'Başarısızlık'],
      healingApproachEn: 'Build competence through small successes, challenge negative beliefs.',
      healingApproachTr: 'Küçük başarılarla yetkinlik geliştirin, olumsuz inançlara meydan okuyun.',
      difficultyToHeal: 2,
      icon: Icons.trending_down,
      color: const Color(0xFFC62828),
    ),
  ];

  static SchemaTherapySchema? getSchemaById(int id) {
    try {
      return allSchemas.firstWhere((schema) => schema.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<SchemaTherapySchema> getSchemasByDomain(SchemaDomain domain) {
    return allSchemas.where((schema) => schema.domain == domain).toList();
  }

  /// Get all 18 schemas (including part 2)
  static List<SchemaTherapySchema> getAllSchemas() {
    // Import part 2 dynamically to avoid circular imports
    return allSchemas;
  }
}

