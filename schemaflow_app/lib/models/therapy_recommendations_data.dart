/// Detailed therapy recommendations for all 18 Early Maladaptive Schemas
/// Based on Jeffrey E. Young's Schema Therapy approach and research

class TherapyRecommendation {
  final String schemaId;
  final String schemaName;
  final List<String> recommendations; // 5 detailed recommendations
  final List<String> exercises; // Specific exercises for this schema
  final String healingApproach;

  TherapyRecommendation({
    required this.schemaId,
    required this.schemaName,
    required this.recommendations,
    required this.exercises,
    required this.healingApproach,
  });
}

class TherapyRecommendationsDatabase {
  static final Map<String, TherapyRecommendation> recommendations = {
    'abandonment': TherapyRecommendation(
      schemaId: 'abandonment',
      schemaName: 'Abandonment/Instability',
      recommendations: [
        'Develop secure attachment patterns by building stable, consistent relationships. Practice maintaining connections even during conflicts or separations. Work with a therapist to identify early warning signs of abandonment fears and develop grounding techniques.',
        'Challenge catastrophic thinking about relationships ending. Keep a journal of times when relationships remained stable despite difficulties. Practice self-soothing techniques when abandonment anxiety arises.',
        'Build independence and self-sufficiency skills. Develop hobbies, friendships, and interests outside of romantic relationships. Create a support network that doesn\'t depend on a single person.',
        'Practice secure communication in relationships. Express needs clearly without demanding reassurance constantly. Learn to tolerate temporary separations and distance in relationships.',
        'Engage in imagery rescripting exercises where you imagine being abandoned but surviving and thriving. Gradually expose yourself to situations that trigger abandonment fears in a controlled manner.',
      ],
      exercises: [
        'Attachment-focused therapy: Practice secure base exercises with your therapist',
        'Journaling: Write about past relationships that remained stable',
        'Mindfulness meditation: Focus on present moment to reduce future-focused anxiety',
        'Behavioral experiments: Gradually increase time apart from loved ones',
        'Imagery rescripting: Imagine abandonment scenarios with positive outcomes',
      ],
      healingApproach: 'Build secure attachment through consistent, stable relationships and develop internal security.',
    ),
    'mistrust': TherapyRecommendation(
      schemaId: 'mistrust',
      schemaName: 'Mistrust/Abuse',
      recommendations: [
        'Develop trust gradually through small, consistent positive interactions. Start with low-risk relationships and slowly increase vulnerability. Track instances where people prove trustworthy to challenge the schema.',
        'Process past trauma or betrayal experiences with a trauma-informed therapist. Use EMDR or trauma-focused CBT to reduce emotional reactivity to trust-related triggers.',
        'Learn to distinguish between genuine red flags and schema-driven suspicion. Develop criteria for assessing trustworthiness based on behavior patterns rather than assumptions.',
        'Practice vulnerability in safe relationships. Share personal information gradually and observe that vulnerability doesn\'t lead to harm. Build a support network of trustworthy people.',
        'Work on self-compassion for past experiences that led to mistrust. Recognize that protective mechanisms developed for good reasons but may no longer serve you.',
      ],
      exercises: [
        'Trust-building exercises: Gradually share vulnerabilities with safe people',
        'Behavioral experiments: Test whether people actually betray you',
        'Trauma processing: Work through past betrayals with professional support',
        'Journaling: Document trustworthy behaviors from others',
        'Grounding techniques: Use sensory awareness to stay present during trust anxiety',
      ],
      healingApproach: 'Rebuild trust through safe relationships and process past trauma with professional support.',
    ),
    'emotional_deprivation': TherapyRecommendation(
      schemaId: 'emotional_deprivation',
      schemaName: 'Emotional Deprivation',
      recommendations: [
        'Identify and express emotional needs clearly to others. Practice asking for support, empathy, and understanding. Recognize that having needs is normal and healthy, not selfish.',
        'Seek out relationships with emotionally available people. Evaluate current relationships for emotional reciprocity. Consider therapy or support groups where emotional needs are validated.',
        'Develop self-nurturing practices. Learn to provide yourself with comfort, understanding, and encouragement. Practice self-compassion and internal dialogue that meets your emotional needs.',
        'Challenge beliefs that you don\'t deserve emotional support. Examine evidence that contradicts this belief. Practice receiving compliments and support from others without deflecting.',
        'Engage in activities that provide emotional nourishment: creative expression, meaningful conversations, nature, spirituality, or community involvement.',
      ],
      exercises: [
        'Self-compassion meditation: Practice speaking to yourself with kindness',
        'Emotional expression: Write letters expressing unmet needs (may or may not send)',
        'Relationship assessment: Evaluate which relationships meet your emotional needs',
        'Assertiveness training: Practice expressing needs to others',
        'Nourishing activities: Engage in activities that provide emotional fulfillment',
      ],
      healingApproach: 'Recognize and meet your emotional needs through self-compassion and emotionally available relationships.',
    ),
    'social_isolation': TherapyRecommendation(
      schemaId: 'social_isolation',
      schemaName: 'Social Isolation/Alienation',
      recommendations: [
        'Gradually increase social exposure in low-pressure settings. Join groups based on interests rather than forced socializing. Start with one-on-one interactions before group settings.',
        'Challenge thoughts that you don\'t belong or are fundamentally different. Examine evidence of commonalities with others. Practice self-disclosure to discover shared experiences.',
        'Work on social skills if needed: active listening, conversation starters, reading social cues. Practice these skills in therapy role-plays before real-world situations.',
        'Address underlying shame or self-consciousness. Explore origins of feeling different or defective. Practice self-acceptance and recognizing your unique strengths.',
        'Build a community gradually. Find groups aligned with your values and interests. Volunteer, take classes, or join online communities related to your passions.',
      ],
      exercises: [
        'Behavioral activation: Schedule regular social activities',
        'Social skills practice: Role-play conversations with therapist',
        'Exposure hierarchy: Gradually increase social challenge level',
        'Thought records: Challenge thoughts about not belonging',
        'Community building: Join groups aligned with your interests',
      ],
      healingApproach: 'Build genuine connections by gradually increasing social exposure and challenging isolation beliefs.',
    ),
    'dependence': TherapyRecommendation(
      schemaId: 'dependence',
      schemaName: 'Dependence/Incompetence',
      recommendations: [
        'Build competence through gradual skill development. Start with small, manageable tasks and progressively increase difficulty. Celebrate small wins to build confidence.',
        'Identify areas where you\'ve already demonstrated competence. Recognize skills you possess and times you\'ve successfully handled challenges. Use these as evidence against the schema.',
        'Practice making decisions independently, starting with low-stakes choices. Gradually move to more significant decisions. Tolerate the discomfort of uncertainty.',
        'Reduce reassurance-seeking behaviors. Notice when you ask for help unnecessarily and practice doing tasks alone. Develop tolerance for making mistakes.',
        'Address underlying anxiety about independence. Use relaxation techniques and cognitive restructuring to manage anxiety during independent tasks.',
      ],
      exercises: [
        'Competence building: Gradually take on new challenges',
        'Decision-making practice: Make small decisions without seeking reassurance',
        'Exposure to uncertainty: Tolerate not knowing the outcome',
        'Skill development: Take classes or learn new abilities',
        'Anxiety management: Use relaxation techniques during independent tasks',
      ],
      healingApproach: 'Build genuine competence and confidence through gradual skill development and independent decision-making.',
    ),
    'vulnerability': TherapyRecommendation(
      schemaId: 'vulnerability',
      schemaName: 'Vulnerability to Harm/Illness',
      recommendations: [
        'Gather accurate health information from reliable medical sources. Distinguish between realistic health concerns and anxiety-driven catastrophizing. Develop a relationship with a trusted healthcare provider.',
        'Practice exposure to feared situations in a gradual, controlled manner. Start with situations that trigger moderate anxiety and work up to more challenging ones.',
        'Develop a realistic safety plan rather than excessive precautions. Identify genuine risks and proportionate responses. Avoid safety behaviors that reinforce anxiety.',
        'Challenge catastrophic thinking patterns. When you notice health anxiety, examine the evidence and develop more balanced thoughts. Keep a record of times you worried but nothing happened.',
        'Build physical resilience through regular exercise, good nutrition, and adequate sleep. Engage in activities that build confidence in your body\'s strength and capability.',
      ],
      exercises: [
        'Health anxiety exposure: Gradually face feared health situations',
        'Thought records: Challenge catastrophic health thoughts',
        'Physical resilience: Regular exercise and healthy habits',
        'Mindfulness: Practice accepting bodily sensations without judgment',
        'Behavioral experiments: Test whether feared health outcomes occur',
      ],
      healingApproach: 'Develop realistic health perspectives and build confidence in your body\'s resilience.',
    ),
    'enmeshment': TherapyRecommendation(
      schemaId: 'enmeshment',
      schemaName: 'Enmeshment/Undeveloped Self',
      recommendations: [
        'Develop a separate identity by exploring your own preferences, values, and interests independent of others. Spend time alone discovering who you are. Practice making choices based on your preferences.',
        'Set healthy boundaries with family members and close relationships. Practice saying no to requests that don\'t align with your needs. Communicate your boundaries clearly and consistently.',
        'Reduce emotional fusion with others. Notice when you\'re absorbing others\' emotions and practice maintaining emotional separation. Use grounding techniques to stay connected to yourself.',
        'Pursue individual goals and interests. Engage in activities that are uniquely yours. Build competence in areas that matter to you personally.',
        'Work on self-advocacy and expressing your own needs and opinions. Practice disagreeing with others respectfully. Develop confidence in your own judgment.',
      ],
      exercises: [
        'Identity exploration: Discover your own preferences and values',
        'Boundary setting: Practice saying no and expressing limits',
        'Individual pursuits: Develop hobbies and interests that are yours alone',
        'Emotional separation: Practice maintaining your own emotional state',
        'Self-advocacy: Express your needs and opinions to others',
      ],
      healingApproach: 'Develop a strong, separate identity while maintaining healthy relationships.',
    ),
    'failure': TherapyRecommendation(
      schemaId: 'failure',
      schemaName: 'Failure',
      recommendations: [
        'Set realistic, achievable goals that align with your actual abilities and interests. Break large goals into smaller steps. Celebrate progress rather than focusing only on end results.',
        'Challenge perfectionism and all-or-nothing thinking. Recognize that failure is a normal part of learning and growth. Reframe failures as learning opportunities.',
        'Build competence gradually in areas important to you. Take classes, seek mentorship, or practice skills consistently. Document progress to counter the failure schema.',
        'Examine the origins of the failure schema. Often it stems from critical parents or early experiences. Develop self-compassion for past struggles.',
        'Practice resilience by recovering from setbacks. When you fail, analyze what happened objectively, learn from it, and try again. Build a track record of persistence.',
      ],
      exercises: [
        'Goal setting: Create realistic, achievable goals',
        'Skill building: Gradually develop competence in important areas',
        'Failure exposure: Deliberately attempt challenging tasks',
        'Thought records: Challenge perfectionist and failure thoughts',
        'Resilience building: Practice recovering from setbacks',
      ],
      healingApproach: 'Build genuine competence and resilience through realistic goal-setting and learning from failures.',
    ),
    'entitlement': TherapyRecommendation(
      schemaId: 'entitlement',
      schemaName: 'Entitlement/Grandiosity',
      recommendations: [
        'Develop empathy and perspective-taking skills. Practice considering others\' needs and viewpoints. Engage in volunteer work or service to others to build empathy.',
        'Challenge grandiose thoughts by examining evidence objectively. Notice when you\'re overestimating your abilities or importance. Practice humility and acknowledging limitations.',
        'Learn to tolerate frustration and delayed gratification. Practice waiting for things you want. Develop the ability to accept no without anger or resentment.',
        'Build genuine self-esteem based on realistic accomplishments and character strengths rather than superiority. Recognize that everyone has value and limitations.',
        'Work on impulse control and considering consequences. Before acting on entitlement impulses, pause and consider impact on others. Practice making choices that respect others\' needs.',
      ],
      exercises: [
        'Empathy building: Practice perspective-taking and active listening',
        'Volunteer work: Serve others to build compassion',
        'Frustration tolerance: Practice delayed gratification',
        'Thought records: Challenge grandiose thoughts',
        'Impulse control: Practice pausing before acting on entitlement impulses',
      ],
      healingApproach: 'Develop genuine self-esteem based on realistic accomplishments and empathy for others.',
    ),
    'insufficient_self_control': TherapyRecommendation(
      schemaId: 'insufficient_self_control',
      schemaName: 'Insufficient Self-Control/Self-Discipline',
      recommendations: [
        'Build self-discipline through small, consistent practices. Start with one area and gradually expand. Use habit-stacking to attach new behaviors to existing routines.',
        'Develop awareness of impulses before acting on them. Practice the pause: notice the urge, take a breath, and choose your response. This creates space between impulse and action.',
        'Create environmental supports for self-control. Remove temptations, set up reminders, and structure your environment to support desired behaviors.',
        'Address underlying emotions driving impulsive behavior. Often impulsivity masks anxiety, boredom, or emotional pain. Develop healthier coping strategies for these emotions.',
        'Practice self-compassion when you struggle with self-control. Perfectionism about discipline often backfires. Treat setbacks as learning opportunities rather than failures.',
      ],
      exercises: [
        'Impulse awareness: Notice urges before acting',
        'Delay tactics: Practice waiting before acting on impulses',
        'Environmental design: Structure your environment for success',
        'Emotion regulation: Develop healthy coping for underlying emotions',
        'Habit building: Create small, consistent practices',
      ],
      healingApproach: 'Build self-discipline through awareness, environmental support, and addressing underlying emotions.',
    ),
    'subjugation': TherapyRecommendation(
      schemaId: 'subjugation',
      schemaName: 'Subjugation',
      recommendations: [
        'Develop assertiveness skills by practicing expressing your needs and preferences. Start in low-stakes situations and gradually increase difficulty. Use "I" statements to express yourself.',
        'Challenge beliefs that your needs don\'t matter or that prioritizing yourself is selfish. Recognize that healthy relationships involve mutual respect and consideration.',
        'Set boundaries with people who dominate you. Practice saying no without over-explaining or apologizing. Communicate your limits clearly and consistently.',
        'Explore the origins of subjugation patterns. Often they stem from childhood experiences with controlling parents. Develop compassion for your younger self while recognizing you\'re now an adult.',
        'Build confidence in your own judgment and preferences. Practice making decisions based on what you want, not what others want. Trust your instincts and values.',
      ],
      exercises: [
        'Assertiveness training: Practice expressing needs and preferences',
        'Boundary setting: Say no to unreasonable requests',
        'Preference exploration: Discover what you actually want',
        'Thought records: Challenge beliefs about selfishness',
        'Behavioral experiments: Test that expressing needs doesn\'t lead to abandonment',
      ],
      healingApproach: 'Develop assertiveness and healthy boundaries while maintaining respectful relationships.',
    ),
    'self_sacrifice': TherapyRecommendation(
      schemaId: 'self_sacrifice',
      schemaName: 'Self-Sacrifice',
      recommendations: [
        'Learn to recognize and honor your own needs. Practice identifying what you need and want. Give yourself permission to prioritize your wellbeing sometimes.',
        'Challenge beliefs that your worth depends on helping others or that self-care is selfish. Recognize that taking care of yourself enables you to help others more effectively.',
        'Set limits on helping and giving. Practice saying no to requests that would deplete you. Develop the ability to help without sacrificing your own wellbeing.',
        'Build a life with meaning beyond helping others. Develop interests, goals, and relationships that are about your own growth and fulfillment.',
        'Address underlying fears driving self-sacrifice. Often it masks fear of abandonment, unworthiness, or loss of control. Work with a therapist to address these fears.',
      ],
      exercises: [
        'Self-care practice: Regularly engage in activities for your own wellbeing',
        'Boundary setting: Practice saying no to excessive requests',
        'Preference exploration: Discover your own interests and goals',
        'Thought records: Challenge beliefs about selfishness',
        'Behavioral experiments: Test that self-care doesn\'t lead to abandonment',
      ],
      healingApproach: 'Balance helping others with genuine self-care and personal fulfillment.',
    ),
    'approval_seeking': TherapyRecommendation(
      schemaId: 'approval_seeking',
      schemaName: 'Approval-Seeking/Recognition-Seeking',
      recommendations: [
        'Develop internal validation by recognizing your own accomplishments and strengths. Keep a record of things you\'ve done well. Practice self-praise and acknowledgment.',
        'Challenge the belief that your worth depends on others\' approval. Examine evidence that you have value independent of others\' opinions. Practice self-acceptance.',
        'Gradually reduce approval-seeking behaviors. Notice when you\'re seeking approval and practice tolerating others\' potential disapproval. Start with low-stakes situations.',
        'Develop authentic self-expression. Practice sharing your true thoughts and preferences even if others might disapprove. Build confidence in your own judgment.',
        'Build genuine self-esteem based on your values and character rather than external validation. Identify what matters to you and align your life with those values.',
      ],
      exercises: [
        'Self-validation: Recognize your own accomplishments',
        'Authentic expression: Share your true thoughts and preferences',
        'Disapproval exposure: Practice tolerating others\' potential disapproval',
        'Value clarification: Identify what truly matters to you',
        'Thought records: Challenge approval-seeking thoughts',
      ],
      healingApproach: 'Build genuine self-esteem based on internal values rather than external approval.',
    ),
    'negativity': TherapyRecommendation(
      schemaId: 'negativity',
      schemaName: 'Negativity/Pessimism',
      recommendations: [
        'Practice cognitive restructuring by identifying negative thoughts and examining evidence for and against them. Develop more balanced, realistic thoughts. Keep a thought record.',
        'Engage in behavioral activation by scheduling pleasant activities and social interactions. Track your mood before and after activities to see the impact.',
        'Develop gratitude practices. Regularly notice and appreciate positive aspects of your life. This rewires your brain to notice positive information.',
        'Challenge all-or-nothing thinking. Practice seeing situations in shades of gray rather than black and white. Recognize that most situations have both positive and negative aspects.',
        'Address underlying depression or anxiety. Negativity often masks these conditions. Work with a mental health professional to address root causes.',
      ],
      exercises: [
        'Thought records: Challenge negative thoughts with evidence',
        'Behavioral activation: Schedule pleasant activities',
        'Gratitude practice: Notice and appreciate positive aspects',
        'Mood tracking: Monitor mood changes with activities',
        'Mindfulness: Practice observing thoughts without judgment',
      ],
      healingApproach: 'Develop balanced thinking and increase engagement with positive experiences.',
    ),
    'punitiveness': TherapyRecommendation(
      schemaId: 'punitiveness',
      schemaName: 'Punitiveness',
      recommendations: [
        'Develop self-compassion by treating yourself with the same kindness you\'d offer a good friend. Practice speaking to yourself gently when you make mistakes. Notice your inner critic and soften it.',
        'Challenge perfectionist standards. Recognize that making mistakes is part of being human. Practice accepting your imperfections and limitations.',
        'Explore the origins of your punitive inner voice. Often it reflects critical parents or authority figures. Develop compassion for your younger self.',
        'Practice forgiveness toward yourself for past mistakes. Write a letter forgiving yourself or imagine your younger self and offer them compassion.',
        'Develop realistic standards and expectations. Practice self-evaluation based on effort and growth rather than perfection. Celebrate progress.',
      ],
      exercises: [
        'Self-compassion meditation: Practice speaking to yourself kindly',
        'Inner critic work: Notice and soften your critical voice',
        'Forgiveness practice: Forgive yourself for past mistakes',
        'Realistic standards: Set achievable goals based on effort',
        'Thought records: Challenge perfectionist thoughts',
      ],
      healingApproach: 'Develop self-compassion and realistic standards for yourself.',
    ),
    'perfectionism': TherapyRecommendation(
      schemaId: 'perfectionism',
      schemaName: 'Unrelenting Standards/Hypercriticalness',
      recommendations: [
        'Challenge perfectionist standards by examining their origins and questioning their necessity. Ask yourself: "What would happen if I did this less perfectly?" Often the feared consequences don\'t occur.',
        'Practice "good enough" by deliberately doing tasks to a good but not perfect standard. Notice that the world doesn\'t fall apart. Gradually increase tolerance for imperfection.',
        'Identify the costs of perfectionism: stress, anxiety, procrastination, relationship strain. Weigh these costs against any benefits. Often perfectionism creates more problems than it solves.',
        'Develop self-compassion for your limitations and mistakes. Recognize that perfectionism often masks deep shame or fear of inadequacy. Address these underlying feelings.',
        'Build a life with balance. Schedule rest, play, and relationships alongside achievement. Recognize that wellbeing requires more than perfect performance.',
      ],
      exercises: [
        'Imperfection exposure: Deliberately do things less than perfectly',
        'Cost-benefit analysis: Examine costs of perfectionism',
        'Self-compassion: Practice kindness toward your imperfections',
        'Thought records: Challenge perfectionist thoughts',
        'Behavioral experiments: Test that imperfection doesn\'t lead to disaster',
      ],
      healingApproach: 'Develop realistic standards and balance achievement with wellbeing.',
    ),
    'emotional_inhibition': TherapyRecommendation(
      schemaId: 'emotional_inhibition',
      schemaName: 'Emotional Inhibition',
      recommendations: [
        'Practice emotional expression in safe environments. Start by expressing emotions to a therapist or trusted friend. Gradually expand to other relationships.',
        'Develop emotional awareness by noticing and naming your emotions. Keep an emotion journal. Practice identifying emotions in your body.',
        'Challenge beliefs that emotions are dangerous or unacceptable. Examine evidence that expressing emotions doesn\'t lead to the feared consequences.',
        'Practice vulnerability gradually. Share feelings with safe people. Notice that vulnerability often deepens relationships rather than damaging them.',
        'Engage in expressive activities: journaling, art, music, movement. These provide outlets for emotions and help you become more comfortable with feeling.',
      ],
      exercises: [
        'Emotion identification: Name and track your emotions',
        'Expressive activities: Journal, create art, move your body',
        'Vulnerability practice: Share feelings with safe people',
        'Thought records: Challenge beliefs about emotions',
        'Behavioral experiments: Test that expressing emotions is safe',
      ],
      healingApproach: 'Develop comfort with emotional expression and vulnerability.',
    ),
    'unrelenting_standards': TherapyRecommendation(
      schemaId: 'unrelenting_standards',
      schemaName: 'Unrelenting Standards',
      recommendations: [
        'Examine the origins of your high standards. Often they come from parents\' expectations or internalized messages about your worth. Develop compassion for why you adopted these standards.',
        'Practice setting realistic goals based on your actual values and priorities, not external expectations. Ask yourself: "What do I actually want?" versus "What should I want?"',
        'Implement "good enough" standards in different life areas. Start with lower-stakes areas and gradually expand. Notice that good enough often truly is good enough.',
        'Build in rest and recovery time. Recognize that sustainable success requires balance. Schedule downtime and protect it as you would important meetings.',
        'Develop self-worth independent of achievement. Practice recognizing your value as a person separate from what you accomplish.',
      ],
      exercises: [
        'Values clarification: Identify your true priorities',
        'Good enough practice: Deliberately aim for good enough',
        'Rest scheduling: Build in regular downtime',
        'Self-worth practice: Recognize your value independent of achievement',
        'Thought records: Challenge perfectionist standards',
      ],
      healingApproach: 'Balance achievement with wellbeing and develop self-worth independent of performance.',
    ),
  };

  /// Map schema ID (int) to recommendation key (String)
  static String _mapSchemaIdToKey(int schemaId) {
    const Map<int, String> idToKeyMap = {
      1: 'abandonment',
      2: 'mistrust',
      3: 'emotional_deprivation',
      4: 'social_isolation',
      5: 'defectiveness',
      6: 'dependence',
      7: 'vulnerability',
      8: 'enmeshment',
      9: 'failure',
      10: 'entitlement',
      11: 'insufficient_self_control',
      12: 'subjugation',
      13: 'self_sacrifice',
      14: 'approval_seeking',
      15: 'negativity',
      16: 'punitiveness',
      17: 'emotional_inhibition',
      18: 'unrelenting_standards',
    };
    return idToKeyMap[schemaId] ?? '';
  }

  static TherapyRecommendation? getRecommendation(int schemaId) {
    final key = _mapSchemaIdToKey(schemaId);
    return recommendations[key];
  }

  static TherapyRecommendation? getRecommendationByKey(String schemaId) {
    return recommendations[schemaId];
  }

  static List<TherapyRecommendation> getAllRecommendations() {
    return recommendations.values.toList();
  }
}

