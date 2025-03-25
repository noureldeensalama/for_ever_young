import 'package:flutter/material.dart';
import 'package:for_ever_young/cubit/cubit.dart';
import 'package:for_ever_young/layout/services_screen/services_details_screen/book_services_screen/book_services_screen.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';
import 'package:for_ever_young/shared/components.dart';

class ServicesDetailsScreen extends StatefulWidget {
  final int initialTabIndex; // Add initialTabIndex to set the initial tab

  const ServicesDetailsScreen({super.key, this.initialTabIndex = 0});

  @override
  _ServicesDetailsScreenState createState() => _ServicesDetailsScreenState();
}

class _ServicesDetailsScreenState extends State<ServicesDetailsScreen> {
  final List<String> categories = [
    'Injectables',
    'Facial',
    'IV Therapy / Shots',
    'Bloodwork',
    'Biote Hormone Pellet',
    'Weight Loss',
    'Erectile Dysfunction Treatment',
  ];

  final Map<String, List<Map<String, dynamic>>> services = {
    'Injectables': [
      {'title': 'Botox Cosmetic', 'description': 'Turn back the clock with Botox! This FDA-approved treatment relaxes fine lines and wrinkles, giving you a refreshed, natural look with no downtime. Perfect for smoothing frown lines, crow’s feet, and forehead creases while preventing deeper wrinkles over time.', 'price': 10.5},
      {'title': 'Dermal Fillers / Lip Fillers', 'description': '395 per syringe, Experience the artistry of dermal fillers—designed to plump lips, define cheekbones, and soften wrinkles for a naturally youthful look. With precision placement and advanced formulas, we tailor each treatment to your unique features, ensuring long-lasting results.', 'price' : 395},
      {'title': 'Kybella', 'description': 'At 350 for one vial, Achieve a sleek, contoured jawline with Kybella—the only FDA-approved injectable that dissolves stubborn fat under the chin. This non-surgical treatment permanently eliminates fat cells, revealing a more defined and youthful profile.', 'price' : 350},
      {'title': 'PDO Threads Lift', 'description': 'Experience the magic of an instant lift without surgery! Our Threads Lift treatment repositions sagging skin, stimulates collagen production, and enhances facial contours for a naturally youthful appearance.'},
      {'title': 'Platelet-Rich Plasma (PRP)', 'description': 'Experience the ultimate skin rejuvenation. Using your body’s own growth factors, PRP stimulates collagen production, enhances skin texture, and promotes natural healing—leaving you with a youthful, radiant glow.', 'price' : 350},
      {'title': 'Wrinkle Relaxers', 'description': 'Smooth, Youthful Skin—Effortlessly! Experience the power of wrinkle relaxers to soften fine lines and prevent deep creases. This treatment subtly refreshes your look, giving you a naturally youthful and rested appearance.', 'price' : 10.5},
    ],
    'Facial': [
      {'title': 'Dermaplaning', 'description': 'Reveal Radiant Skin Instantly! Experience the magic of Dermaplaning—an advanced exfoliation treatment that gently removes dead skin cells and peach fuzz, unveiling a smooth, luminous complexion. Perfect for achieving a flawless makeup application and enhancing skincare absorption.', 'price': 90},
      {'title': 'Hydra-Facial Platinum', 'description': 'Our most luxurious procedure offering: lymphatic drainage, followed by the Hydra-Facial Signature steps, and elevates your pleasure experience with a booster and LED light therapy for amazing skin renewal.', 'price': 150},
      {'title': 'Hydra-Facial Signature', 'description': 'This procedure offers the fundamental steps of deep cleansing, exfoliation, extraction, and infusion for revitalized skin.', 'price': 100},
      {'title': 'Hydro facial platinum \n with chest', 'description': 'Our most luxurious treatment, now for your chest! Enjoy lymphatic drainage, HydraFacial Signature steps, a booster, and LED light therapy for ultimate skin renewal.', 'price': 200},
      {'title': 'Hydro facial platinum \n with neck', 'description': 'Our most luxurious treatment, now extended to the neck! Enjoy lymphatic drainage, HydraFacial’s signature steps, a custom booster, and LED light therapy for full-face and neck rejuvenation, leaving your skin glowing and refreshed.', 'price': 175},
      {'title': 'Hydro facial signature \n with chest', 'description': 'This treatment provides deep cleansing, exfoliation, extraction, and infusion, leaving the chest skin refreshed and rejuvenated.', 'price': 150},
      {'title': 'Hydro facial signature \n with neck', 'description': 'This treatment combines deep cleansing, exfoliation, extraction, and hydration, extending care to the neck for a refreshed and youthful glow.', 'price': 125},
      {'title': 'MESOTHERAPY', 'description': 'Experience the power of microinjections infused with vitamins, enzymes, and hyaluronic acid to deeply nourish and rejuvenate your skin. This treatment boosts hydration, enhances collagen production, and restores your natural glow for a firmer, youthful complexion.', 'price': 270},
      {'title': 'MESOTHERAPY For Face & Neck', 'description': 'Revitalize your skin with Mesotherapy for the face and neck! This innovative treatment delivers a potent blend of vitamins, antioxidants, and hyaluronic acid directly into the skin, boosting hydration, collagen production, and overall radiance. Experience deep nourishment and a rejuvenated, youthful glow.', 'price': 405},
      {'title': 'MESOTHERAPY For Face & Neck & decollete', 'description': 'Experience the power of Mesotherapy, now enhanced for the face, neck, and décolleté! This advanced treatment delivers a customized cocktail of vitamins, peptides, and hyaluronic acid directly into the skin, boosting hydration, collagen production, and overall radiance for a youthful, glowing complexion.', 'price': 495},
      {'title': 'Microneedling', 'description': 'Experience the power of collagen induction therapy! Microneedling stimulates natural skin renewal, reducing fine lines, acne scars, and hyperpigmentation while enhancing product absorption for a youthful, radiant complexion.', 'price': 270},
      {'title': 'Microneedling/PRP Treatment', 'description': 'This treatment boosts collagen production, improves skin texture, and reduces fine lines, acne scars, and hyperpigmentation.', 'price': 380},
      {'title': 'Vi Peel', 'description': 'Experience the power of medical-grade exfoliation with VI Peel! This advanced chemical peel targets fine lines, acne, hyperpigmentation, and sun damage, revealing a smoother, brighter complexion with minimal downtime. Say hello to refreshed, youthful skin!', 'price': 160},
      {'title': 'Vi Peel/Dermaplaning Treatment.', 'description': 'This powerful combination helps to reveal smoother, brighter skin by removing dead skin cells and stimulating collagen production.', 'price': 200},
      {'title': 'Vi Peel/Microneedling Treatment', 'description': 'Revitalize your skin with our exclusive Vi Peel + Microneedle Treatment package! This powerful combo helps improve skin tone, texture, and overall glow.', 'price': 300},
    ],
    'IV Therapy / Shots': [
      {'title': 'CoQ10 Shot', 'description' : 'Recharge your body at the cellular level with a CoQ10 shot. This powerful antioxidant supports heart health, brain function, and energy production while promoting overall vitality.', 'price' : 25},
      {'title': 'Pepcid Injection', 'description' : 'Soothe heartburn, indigestion, and acid reflux with a fast-acting Pepcid injection. This treatment helps ease stomach irritation, bloating, and nausea, so you can feel comfortable again.', 'price' : 20},
      {'title': 'Amino Blend', 'description' : 'Fuel your body with essential amino acids to support muscle recovery, boost energy, and strengthen your immune system. Perfect for athletes and those with active lifestyles.', 'price' : 25},
      {'title': 'Vitamin B12 Injection', 'description' : 'Recharge your body with a quick B12 boost! This injection enhances energy, supports metabolism, and strengthens immunity—perfect for fighting fatigue and feeling your best.', 'price' : 35},
      {'title': 'Toradol Injection', 'description' : 'Target pain at the source with Toradol, a powerful non-narcotic NSAID injection. Ideal for headaches, muscle and joint pain, and inflammation, this treatment offers quick relief without opioids.', 'price' : 25},
      {'title': 'Biotin + B5 Injection', 'description' : 'Strengthen your hair, skin, and nails with a powerful dose of Biotin and Pantothenic Acid (B5). This injection supports beauty from within while enhancing metabolism and nerve function.', 'price' : 35},
      {'title': 'MIC Plus', 'description' : 'Kickstart your metabolism with MIC Plus, a powerful blend of Methionine, Inositol, and Choline. This injection supports fat breakdown, liver detox, and energy production to help you reach your weight loss goals.', 'price' : 35},
      {'title': 'Zofran IV Drip', 'description' : 'Stop nausea in its tracks with Zofran. This quick and effective IV treatment eases nausea from sickness, surgery, pregnancy, and more—so you can get back to feeling your best.', 'price' : 20},
      {'title': 'Vitamin D3 Injection', 'description' : 'Give your body the essential Vitamin D3 it craves. This injection supports bone health, strengthens immunity, lifts mood, and enhances overall well-being.', 'price' : 35},
      {'title': 'Lipo-C Injection', 'description' : 'Supercharge your metabolism with Lipo-C! This powerful injection supports fat breakdown, energy production, and liver detox, helping you achieve your weight loss goals faster.', 'price' : 35},
      {'title': 'Iron Infusion Venofer', 'description': 'Boost your energy, fight fatigue, and restore healthy iron levels with Venofer! Infused with Vitamin C for better absorption and B12 for enhanced red blood cell production, this IV therapy helps you feel revitalized and ready to take on the day.', 'price': 300},
      {'title': 'Hangover Cure', 'description': 'Bounce back fast with ultimate hydration and essential B vitamins to re-energize your body. Lactated Ringer replenishes lost fluids, while B Complex and B12 boost energy and mental clarity. Upgrade with anti-nausea relief (Zofran), headache relief (Toradol), or an acid reducer (Pepcid) for extra comfort!', 'price': 160},
      {'title': 'IV Drip For Hair & Nails & Skin', 'description': 'Boost your beauty from the inside out! Biotin (B7) and Pantothenic Acid (B5) nourish strong, healthy hair and nails, while Vitamin C and Glutathione brighten and protect your skin. Hydrating normal saline keeps you glowing from within!', 'price': 160},
      {'title': 'Anti-Aging NAD+ 250mg', 'description': 'Recharge at the cellular level! NAD+ boosts energy, sharpens focus, and supports healthy aging by repairing cells from within. Combined with hydrating saline, this IV therapy helps rejuvenate your body and mind for a youthful glow.', 'price': 250},
      {'title': 'Multivitamin Super Boost IV Drip', 'description': 'Hydrate and energize! Packed with B vitamins for all-day energy, vitamin C for glowing skin and immunity, magnesium for muscle relaxation. Plus, essential trace elements to keep your body balanced & thriving!', 'price': 135},
      {'title': 'Cold & Flu IV Drip', 'description': 'Power up your immune system with Vitamin C, essential B vitamins, and Zinc. This potent blend helps fight off sickness, speeds up recovery, and keeps you feeling your best.', 'price': 135},
      {'title': 'Pregnancy Drip', 'description': 'Hydrate, nourish, and ease discomfort with our Pregnancy Drip. Packed with B vitamins for energy, B6 to combat nausea, and Pepcid for gentle digestive relief—all in a soothing saline infusion to keep you feeling your best.', 'price': 145},
      {'title': 'Skin Whitening Cocktail', 'description': 'Brighten and rejuvenate your skin from within! Our Skin Whitening Cocktail blends Glutathione and Vitamin C to promote a radiant, even complexion, while Alpha-Lipoic Acid fights oxidative stress for a youthful glow. Hydrate, refresh, and let your skin shine!', 'price': 135},
      {'title': 'Athletic Performance & Workout Infusion', 'description': 'Enhance muscle recovery, power up your workouts with this performance-packed infusion. L-Arginine and L-Citrulline improve blood flow, Magnesium and Calcium support muscle function, and B vitamins with Vitamin C fuel energy and repair.', 'price': 150},
      {'title': 'Metabolism Booster', 'description': 'Kickstart your metabolism and support weight loss with this energizing IV blend! Packed with B Complex and B12 for sustained energy, L-Taurine to enhance fat metabolism, and hydrating normal saline to keep you feeling refreshed and revitalized.', 'price': 135},
      {'title': 'IV Therapy for Energy', 'description': 'Boost your energy and fight fatigue with this powerful IV blend! Packed with B Complex vitamins for metabolism support, amino acids like Arginine and Citrulline to enhance blood flow, and B12 for lasting vitality—feel recharged and ready to take on the day.', 'price': 149},
      {'title': 'Cognition The Brain Booster', 'description': 'Sharpen your focus and fuel your mind! This IV blend combines Alpha-Lipoic Acid for powerful antioxidant support, B6 for brain function, and L-Taurine to enhance mental clarity—all in hydrating normal saline for peak performance.', 'price': 150},
      {'title': 'IV Hydration', 'description': 'Revitalize & Rehydrate – Our IV Hydration Therapy replenishes your body with essential fluids and electrolytes, restoring energy, enhancing skin glow, and combating dehydration instantly. Feel refreshed from the inside out!', 'price': 99},
      {'title': 'Brain Reboot NAD+ 500mg', 'description': 'Reignite your mind and body with NAD+, the ultimate cellular energizer. This IV fuels brain function, fights fatigue, and supports anti-aging at a deep level. Hydrating saline boosts absorption, leaving you refreshed and revitalized.', 'price': 389},
      {'title': 'Myers’ Cocktail', 'description': 'The ultimate wellness boost! Packed with hydrating electrolytes, energy-boosting B vitamins, immune-strengthening Vitamin C, and muscle-relaxing magnesium, this IV infusion revitalizes your body, enhances recovery, and fights fatigue. Perfect for overall wellness and a natural energy lift!', 'price': 135},
      {'title': 'IMMUNE BOOST', 'description': 'Stay ahead of sickness with this powerful blend! Packed with Vitamin C and Zinc to strengthen immunity, plus B Complex to energize your body and keep you feeling your best. Hydrate, protect, and recharge in one IV!', 'price': 135},

    ],
    'Bloodwork': [
      {'title': 'STD Panel', 'description': 'HIV 1&2 Antibody/Antigen (4th Generation), Herpes 2 IgG Antibody, Chlamydia, Gonorrhea, Syphilis TPA', 'price': 210},
      {'title': 'Fibro Test / FibroSure', 'description': 'CBC, Blood sugar, Hemoglobin A1C, Hepatic (Liver) Function Panel, Hepatitis B Surface Antigen, Hepatitis C Antibody, cholesterol.', 'price': 150},
      {'title': 'Male Cancer Screening Blood Test', 'description': 'A comprehensive blood test for cancer in men includes various markers that help detect potential malignancies and monitor overall health. Key tests include:\nComplete Blood Count (CBC): Evaluates red and white blood cells, hemoglobin, and platelets to detect abnormalities that may indicate leukemia or other cancers.\n Carcinoembryonic Antigen (CEA): A tumor marker used to detect and monitor cancers, especially of the colon and rectum. \nProstate-Specific Antigen (PSA): Measures PSA levels in the blood to screen for prostate cancer and monitor treatment effectiveness.\nCarbohydrate Antigen (CA) 19-9: A marker primarily used to detect and track pancreatic, stomach, and bile duct cancers.\nAlpha-Fetoprotein (AFP): Helps diagnose liver cancer and testicular cancer, as elevated levels can indicate tumor presence.', 'price': 220},
      {'title': 'Female Cancer Screening Blood Test', 'description': 'A comprehensive blood test for cancer in women includes various markers that help detect and monitor cancer.\nComplete Blood Count (CBC): Measures blood cells to detect abnormalities that may indicate cancer.\nCarcinoembryonic Antigen (CEA): A tumor marker used to track cancers like colorectal and breast cancer.\nCancer Antigen (CA) 15-3: Primarily used to monitor breast cancer progression or recurrence.\nCancer Antigen (CA) 125: Elevated in ovarian cancer and used for diagnosis and monitoring.\nCarbohydrate Antigen (CA) 19-9: A marker for pancreatic, gallbladder, and gastrointestinal cancers.\nCancer Antigen (CA) 27.29: Another breast cancer marker, similar to CA 15-3, used for monitoring.\nAlpha-Fetoprotein (AFP): Elevated in liver cancer and some ovarian cancers.', 'price': 250},
      {'title': 'Sperm Test', 'description': 'Liquefaction, Viscosity, Volume, PH, Round Cell Concentration, Concentration, Total Motility, Progressive Motility, Non-Progressive Normal Morphology.', 'price': 380},
      {'title': 'Male Post Pellet Thyroid', 'description': 'Hormone Replacement Therapy Male Post Pellet involves the use of testosterone pellets inserted subcutaneously to provide sustained hormonal support.\nTestosterone, Free, Direct\nTestosterone, Free, Direct measures the unbound testosterone available for immediate use by the body, essential for various physiological functions.\nTotal Testosterone\nTotal testosterone quantifies both free and bound testosterone in the bloodstream, providing a comprehensive overview of overall hormone levels.\n​This therapy aims to alleviate symptoms of low testosterone, enhancing energy, libido, and overall well-being in men.​', 'price': 75},
      {'title': 'Female Post Pellet Thyroid', 'description': '​Hormone Replacement Therapy (HRT) for females post-pellet is designed to alleviate menopausal symptoms by balancing hormone levels.\nTestosterone, Total\nTotal Testosterone measures the combined levels of free and bound testosterone in the blood, essential for energy, libido, and overall well-being.\nFollicle-stimulating Hormone (FSH)\nFollicle-stimulating Hormone (FSH) is critical for reproductive health, stimulating ovarian function and egg production, and is often measured to assess fertility and menopause status.\nEstradiol\nEstradiol is the primary form of estrogen in women, playing a key role in regulating the menstrual cycle and contributing to bone health, mood, and skin elasticity.', 'price': 75},
      {'title': 'Male Post Pellet', 'description': 'Testosterone, Free, Direct with Total.', 'price': 65},
      {'title': 'Female Post Pellet', 'description': 'Testosterone, FSH, Estradiol.', 'price': 65},
      {'title': 'Male Pre Pellet Test', 'description': 'Estradiol, Testosterone, PSA, TSH,  T4, T3, CBC with Differential, TPO Antibodies, Metabolic Panel (14), Comprehensive, Vitamin D, 25-Hydroxy, Vitamin B12.', 'price': 65},
      {'title': 'Female Pre Pellet Test', 'description': 'Estradiol, Testosterone, FSH, TSH, T4,  T3, CBC with Differential, TPO Antibodies, Metabolic Panel (14), Comprehensive, Vitamin D, 25-Hydroxy, Vitamin B12.', 'price': 170},
      {'title': 'Ultimate Vitamin B Tests', 'description': 'Vitamin B1, Vitamin B2 (Riboflavin), Vitamin B3 (Niacin), Vitamin B5 Pantothenic Acid, Vitamin B6, Vitamin B7 (Biotin), Vitamin B9 Folic Acid , Vitamin B12.', 'price': 420},
      {'title': 'Ultimate Hair & Skin Wellness', 'description': 'Vitamin A, Vitamin C, Vitamin B7 (Biotin), Vitamin D, Vitamin E, Vitamin B12, Iron, TIBC, Zinc.', 'price': 225},
      {'title': 'Antioxidants Blood Test', 'description': 'Antioxidant blood tests check how much of certain antioxidants you have in your body. Antioxidants help protect your cells from damage and keep you healthy.​ Two prominent antioxidants often included in these tests are Coenzyme Q10 and Glutathione.\nCoenzyme Q10:nCoenzyme Q10, or CoQ10, is a natural antioxidant crucial for energy production within cells. It plays an essential role in mitochondrial function and has been shown to support heart health, enhance energy levels, and reduce oxidative damage.\nGlutathione:\nGlutathione is known as the “Master Antioxidant” due to its powerful detoxification abilities. It neutralizes free radicals, supports skin health by inhibiting melanin production, and enhances the effectiveness of other antioxidants like vitamins C.', 'price': 170},
      {'title': 'Sleep-Related Blood Analysis', 'description': 'Sleep-related blood tests are increasingly recognized for their role in assessing factors that may impact sleep quality and overall well-being. At 4Ever Young STL, we offer a comprehensive package that includes the following essential tests:\nMagnesium: This mineral is vital for many bodily functions, including muscle relaxation and nerve function. Low magnesium levels have been linked to sleep disturbances, making its assessment crucial for those struggling with sleep issues\nComplete Blood Count (CBC): This test detects a range of disorders, such as anemia, infections, and other medical conditions. Anemia, in particular, can contribute to fatigue and poor sleep quality.\nThyroid Stimulating Hormone (TSH): The TSH test assesses thyroid function. An imbalance in thyroid hormones can disrupt sleep patterns, making it an important factor to evaluate in patients experiencing sleep difficulties.\nVitamin D: Research indicates that low levels of vitamin D may be associated with sleep disorders. This test helps determine if a deficiency could be impacting your sleep quality.\n​By offering these tests in a single package, 4Ever Young STL aims to provide a holistic approach to understanding and improving sleep health, allowing clients to take actionable steps towards better rest and rejuvenation.​', 'price': 120},
      {'title': 'Nutrient Deficiency Test', 'description': 'CMP, Copper, Ferritin, TIBC, Magnesium, Selenium, Vitamin A, Vitamin B12 and Folate, Vitamin B6,  Vitamin C, Vitamin D, Vitamin E, Vitamin K1, Zinc.', 'price': 270},
      {'title': 'Vitamin and Nutrient Test', 'description': 'CBC, CMP, Ferritin, Homocysteine, Iodine (Urine), TIBC, Cholesterol, MMA, TSH, Vitamin B12, Folate, Vitamin D.', 'price': 240},
      {'title': 'Heavy Metals Blood Test', 'description': 'The Heavy Metals Profile II, Blood test is a crucial diagnostic tool that helps assess levels of potentially harmful heavy metals in the body.​ This panel is vital for individuals who might be exposed to these substances through their environment, occupation, or lifestyle. Understanding your heavy metal levels can aid in identifying health risks and guide appropriate interventions.\nHere’s a quick look at the key metals tested:\nArsenic – A toxic element associated with various health issues, including skin lesions and cancer.\Cadmium – Commonly found in batteries and cigarette smoke; exposure can lead to kidney damage and bone loss.\nLead – A highly toxic metal linked to neurological issues, especially in children; even low levels can be harmful.\nMercury – Found in some fish and dental amalgams; affects the nervous system and can lead to serious health problems.\nCobalt – Used in metal alloys and batteries; excessive exposure can cause lung and heart problems.\nChromium – Known for its industrial use; can cause respiratory issues and skin irritation when levels are elevated.', 'price': 170},
      {'title': 'Hormone Panel', 'description': 'The Postmenopausal Bloodwork Panel helps you monitor essential health indicators during and after menopause, allowing you to take control of your well-being.​\nHere’s a quick look at some key tests included in the panel:\nComplete Blood Count (CBC) – Evaluates overall health and detects disorders like anemia.\nComprehensive Metabolic Panel (CMP) – Assesses glucose, liver and kidney function, and electrolyte balance.\nEstradiol (E2) – Measures estrogen levels to understand hormonal balance post-menopause.\nFollicle Stimulating Hormone (FSH) – Indicates menopausal status with increased levels during this phase.\nLipid Panel (Cholesterol) – Evaluates cholesterol levels to assess heart disease risk.\nLuteinizing Hormone (LH) – Hormone level changes signify the menopausal transition.\nThyroid Stimulating Hormone (TSH) – Monitors thyroid function, affecting metabolism and energy levels.\nT3 Free – Measures active thyroid hormone levels; crucial for thyroid health.\nT4 Free – Assesses thyroxine levels; important for metabolism regulation.\nVitamin D – Essential for bone health and immune function, often declining after menopause.', 'price': 190},
      {'title': 'Comprehensive Sports Panel', 'description': 'For bodybuilders and fitness enthusiasts, understanding your body inside and out is key to achieving peak performanceA specialized bloodwork panel tailored to bodybuilders provides critical insights into hormones, organ health, and overall well-being, ensuring you stay on track toward your goals.\nWhat’s Included?\nCBC (Complete Blood Count): Evaluate overall health and detect signs of stress or anemia.\nCMP (Comprehensive Metabolic Panel): Assess kidney and liver function.\nLipid Panel: Monitor cholesterol and cardiovascular health.\nThyroid Panel with TSH: Ensure optimal energy and metabolism.\nEstradiol & Hormones (FSH, LH, Free & Total Testosterone): Fine-tune your hormone balance.\nAdditional Testing for Serious Athletes:\nInsulin: Gauge insulin sensitivity for muscle growth and fat loss.\nIGF-1 & DHEA: Track growth and recovery factors.\nCortisol & CRP (Inflammation Markers): Monitor stress and inflammation levels.\nHomocysteine: Assess cardiovascular health risks.\nAdditional testing options that can provide useful information for bodybuilders include 90:\nInsulin, Homocysteine, IGF-1, DHEA, Cortisol, C-reactive protein High Sensitivity.', 'price': 160},
      {'title': 'Arthritis Blood Tests', 'description': 'The Arthritis Comprehensive Panel is a group of tests designed to help identify and monitor various forms of arthritis, including rheumatoid arthritis, gout, and lupus, These tests assess inflammation levels, autoimmune activity, and other markers that contribute to joint pain and stiffness.\nWhat’s included:\nComprehensive Metabolic Panel (CMP): Evaluates overall health and checks for organ function.\nC-Reactive Protein (CRP): Measures inflammation in the body.\nUric Acid: Helps diagnose gout and monitor uric acid levels.\nSedimentation Rate (ESR): Assesses inflammation over time.\nRheumatoid Factor (RF): Detects rheumatoid arthritis and autoimmune activity.\nAntinuclear Antibodies (ANA): Screens for autoimmune disorders like lupus.', 'price': 120},
      {'title': 'Fertility Test', 'description': 'Understanding your ovarian reserve is essential for women considering pregnancy, especially if they are planning to delay starting a family. The Ovarian Reserve Test assesses the quantity and quality of a woman’s eggs and helps gauge fertility potential. Several key hormones are measured to provide insights into ovarian function.\nAnti-Müllerian Hormone (AMH)\nAMH levels indicate the number of developing follicles and can provide a good estimate of ovarian reserve. Higher AMH levels typically suggest a greater number of available eggs.\nFollicle-Stimulating Hormone (FSH)\nFSH plays a crucial role in the reproductive process. Elevated FSH levels, especially on the third day of your menstrual cycle, may indicate reduced ovarian function.\nEstradiol (E2)\nThis estrogen hormone is essential for the development of eggs and the regulation of the menstrual cycle. Estradiol levels are often assessed alongside FSH to evaluate ovarian function.\nLuteinizing Hormone (LH)\nLH triggers ovulation and is important in regulating the menstrual cycle. An imbalance in LH levels can affect fertility and egg release.\nProgesterone\nThis hormone prepares the uterus for a fertilized egg. Measuring progesterone can help confirm if ovulation has occurred.\nProlactin\nProlactin is involved in milk production and can impact menstrual cycles and ovulation. Abnormally high levels can affect fertility.\nAre you over 35?\nAbout 20 percent of women in the U.S. have their first child after age 35.\nLooking to freeze your eggs?\nAn AMH test is the best measure of ovarian reserve to help women make\ndecisions regarding IVF and egg preservation (egg freezing) treatments.\nCurious about PCOS?\nIn the same way that an AMH test can help predict the likelihood of a\nsuccessful IVF procedure, it can help detect PCOS in women who may not\nhave obvious signs of the syndrome.', 'price': 175},
      {'title': 'Celiac Test', 'description': 'If you’re experiencing symptoms like bloating, fatigue, or stomach discomfort after eating gluten, your doctor might recommend a Celiac Disease Antibody Test. This test helps identify if your immune system reacts to gluten, which could indicate celiac disease.\nKey Tests in the Panel:\nTotal IgA: Ensures your immune system produces enough IgA, crucial for accurate testing.\ntTG-IgA: The most sensitive test for celiac disease, detecting gluten-triggered damage.\ntTG-IgG: Used if IgA levels are low or deficient, offering a backup check.\nDGP-IgG: Looks for specific antibodies to gluten breakdown products, particularly in tricky cases.', 'price': 210},
      {'title': 'Women’s Wellness Check', 'description': 'Taking control of your health starts with understanding your body. Our Women’s Health Test package is designed to provide key insights into your overall wellness, hormones, and risk factors for common conditions like diabetes, thyroid issues, and more. These tests empower you to make informed decisions about your health and well-being.\nWhat’s Included?\nHere’s a quick look at the tests we offer. Each one plays a vital role in identifying imbalances, risks, or underlying conditions:\nComprehensive Metabolic Panel (CMP): Tracks vital organ function, including liver and kidney health, as well as electrolytes and blood sugar levels.\nComplete Blood Count (CBC): Measures red and white blood cells to detect signs of anemia, infections, or overall immune health.\nCholesterol and Lipid Panel: Assesses heart health by measuring cholesterol levels and triglycerides.\nDiabetes Risk (HbA1c): Evaluates long-term blood sugar control to identify prediabetes or diabetes risks.\nThyroid Stimulating Hormone (TSH): Screens for thyroid imbalances, a common issue affecting energy, metabolism, and mood.\nFollicle-Stimulating Hormone (FSH): Provides insights into fertility and ovarian health.\nEstradiol (E2): Monitors estrogen levels, crucial for reproductive health and hormonal balance.\nLuteinizing Hormone (LH): Tracks ovulation and menstrual health.\nProgesterone: Assesses ovulation and supports pregnancy planning or hormonal health.', 'price': 150},
      {'title': 'Men’s Wellness Check', 'description': 'CMP, CBC, Cholesterol and Lipid Panel Test, HbA1c, Total Testosterone Test, PSA.', 'price': 180},
      {'title': 'Heart check-up', 'description': 'Complete Heart Health Test, Total Cholesterol, LDL, Cholesterol, HDL, Triglycerides, Non-HDL Cholesterol, ApoB, GlycA, DRI.', 'price': 100},
      {'title': 'Immune panel', 'description': 'CBC, CMP, CRP, Hemoglobin A1C, Immunoglobulins IgA, IgM, IgG, Iron, Magnesium, Vitamin C, Vitamin D, Zinc', 'price': 240},
      {'title': 'Micronutrient Tests', 'description': 'This package includes a range of essential tests designed to evaluate overall health, nutritional status, and immune function. These tests focus on detecting deficiencies, imbalances, or inflammation that can impact energy, immunity, and wellbeing.\nCore Tests Include:\nComprehensive Metabolic Panel (CMP): Assesses kidney and liver function, blood sugar, and electrolyte balance.\nCopper: Checks copper levels, vital for energy production and immune health.\nFerritin: Measures stored iron to detect deficiency or overload.\nIron & Total Iron Binding Capacity (TIBC): Evaluates iron levels and the body’s capacity to transport it.\nMagnesium: Monitors a mineral critical for muscle, nerve, and heart health.\nPhosphorus: Assesses bone health and kidney function.\nZinc: Essential for immune function, wound healing, and overall health.', 'price': 320},
      {'title': 'Thyroid-stimulating hormone (TSH)', 'description': 'Your thyroid plays a critical role in maintaining energy, metabolism, and overall well-being. The Thyroid Ultimate Panel is designed to give you a complete picture of your thyroid health, helping you uncover issues that may affect your daily life, like unexplained fatigue, weight changes, or mood swings.\nDetails of the Tests in the Panel\nTSH (Thyroid Stimulating Hormone): Assesses thyroid gland activity and hormone regulation.\nT4 (Thyroxine): Measures the primary hormone produced by the thyroid.\nT3 Uptake & Free Thyroxine Index: Evaluates the balance and availability of thyroid hormones.\nFree T3 & Free T4: Provides insights into the hormones actively used by your body.\nReverse T3: Assesses if your body is converting T4 into active or inactive forms of T3.\nThyroid Peroxidase Antibody (TPO): Screens for autoimmune thyroid disorders.\nThyroglobulin Antibody: Detects thyroid inflammation or autoimmune thyroiditis.', 'price': 160},
      {'title': 'Energy Test', 'description': 'Feeling constantly tired? A fatigue test can help uncover the root cause of your exhaustion, whether it’s related to nutrient deficiencies, hormonal imbalances, or underlying health conditions. Take control of your energy levels today.\nThyroid Stimulating Hormone (TSH) Test\nIs your thyroid affecting your energy? The TSH test evaluates how well your thyroid gland is functioning—critical for regulating metabolism and energy. Symptoms like fatigue, weight changes, or hair loss could be linked.\nComplete Blood Count (CBC) Test\nLow energy? A CBC test can detect anemia, infections, or other blood disorders that might be sapping your strength. Get answers quickly and start feeling better.\nDiabetes Risk (HbA1c) Test\nCould your fatigue be related to high blood sugar? The HbA1c test measures your average blood sugar levels over 3 months to assess diabetes risk. Early detection can lead to better energy and health outcomes.\nComprehensive Metabolic Panel (CMP)\nTired for no reason? A CMP test gives a detailed look at your kidney, liver, and electrolyte health, often pinpointing why you’re feeling off. Understand your body’s balance.\nFerritin Test\nIron levels matter. Low ferritin (iron storage) is a common cause of fatigue and weakness. This test can determine if you’re running low on this essential mineral so you can get back to feeling energized.', 'price': 120},
      {'title': 'Weight Management Blood Test', 'description': 'CMP, Amylase, Lipase, Leptin, TSH, Total Cholesterol, LDL, VLDL, HDL, Triglycerides, Hemoglobin A1c.', 'price': 170},
      {'title': 'Iron Test', 'description': 'CBC, Ferritin, Vitamin B12 and Folate (Folic Acid), Hemoglobin Electrophoresis, TIBC, Reticulocyte Count, Transferrin.', 'price': 150},
      {'title': 'Total Health Check-Up', 'description': 'Take charge of your well-being with our Total Health Check-Up, a comprehensive assessment designed to provide a full picture of your overall health. This panel includes:\nComprehensive Metabolic Panel (CMP): Evaluates your organ function, including kidneys, liver, and electrolyte balance.\nComplete Blood Count (CBC): Checks your red and white blood cells, ensuring your immune system and oxygen transport are functioning optimally.\nCholesterol and Lipid Panel Test: Measures your cholesterol levels to assess heart health and cardiovascular risk.\nDiabetes Risk (HbA1c) Test: Provides insight into blood sugar levels and identifies early signs of diabetes or prediabetes.\nWhether you’re optimizing your health or addressing specific concerns, our Total Health Check-Up offers a proactive approach to achieving your wellness goals.', 'price': 120},
    ],
    'Biote Hormone Pellet': [
      {'title': 'Biote Hormone Pellet - Consultation Required!', 'description': 'BioTE® Hormone Therapy is a form of bioidentical hormone replacement therapy (BHRT) that uses tiny, customized pellets inserted under the skin to naturally regulate your hormone levels. These pellets are derived from plant-based hormones that match your body’s natural hormones, providing a safe, effective, and long-lasting solution for hormone imbalances.💊 Balances estrogen, testosterone, and other key hormones💪 Boosts energy, mental clarity, and metabolism🔥 Enhances libido and sexual health💤 Improves sleep and reduces mood swings💆‍♂️ Reduces symptoms of menopause & andropause By delivering a steady, consistent release of hormones, BioTE® avoids the fluctuations and side effects common with synthetic hormone treatments.',},
    ],
    'Weight Loss': [
      {'title': 'Weight Loss', 'description': 'At 4Ever Young STL MedSpa in St. Louis, we offer clinically proven, FDA-approved weight loss solutions that help you achieve real, lasting results. Our medical weight loss treatments include:\n✅ Semaglutide (Ozempic, Wegovy) injections – GLP-1 medication to control hunger and boost metabolism\n✅ Tirzepatide (Mounjaro, Zepbound) injections – A powerful, dual-action weight loss solution\n✅ Phentermine-based prescriptions – A traditional appetite suppressant for rapid results\n✅ Lipotropic injections (Lipo & B12) – Enhance fat-burning and boost energy\n✅ IV therapy for metabolism support – Hydration & nutrients to optimize weight loss\nAll treatments are supervised by our experienced Nurse Practitioners, ensuring a safe, customized weight loss plan tailored to your body’s needs.', 'price' : 275},
    ],
    'Erectile Dysfunction Treatment': [
      {'title': 'Erectile Dysfunction Treatment - Consultation Required!', 'description': 'At 4Ever Young STL MedSpa in St. Louis, MO, we specialize in cutting-edge, non-surgical ED treatments that help men regain natural function, improve blood flow, and restore performance without the need for long-term medications. Whether your ED is caused by age, stress, poor circulation, or hormone imbalances, we offer customized solutions designed to restore vitality and confidence.\n✔ Safe, Non-Surgical Erectile Dysfunction Treatment\n✔ Enhances Natural Blood Flow & Circulation\n✔ Treats the Root Cause of ED – Not Just the Symptoms\n✔ Drug-Free & Long-Lasting Results\n💡 Want to improve your performance naturally? Schedule a confidential consultation today!',}
    ],
  };

  final Map<String, bool> expandedStates = {};

  @override
  Widget build(BuildContext context) {
    final cubit = ForEverYoungCubit.get(context);
    final bool isDarkMode = cubit.isDark;

    return DefaultTabController(
      initialIndex: widget.initialTabIndex, // Set the initial tab index
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: ClipRRect(
            borderRadius: BorderRadius.circular(13), // Adjust for more or less rounding
            child: Image.asset('images/logo_banner.png', height: 50,),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight), // Adjust the height if needed
            child: Padding(
              padding: EdgeInsets.only(top: 10.0), // Add space before the TabBar
              child: TabBar(
                isScrollable: true,
                labelColor: isDarkMode ? Colors.white : Colors.grey[900],
                indicatorColor: secondaryColor,
                tabs: categories.map((category) => Tab(text: category)).toList(),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: categories.map((category) {
            final serviceList = services[category] ?? [];
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: serviceList.length,
              itemBuilder: (context, index) {
                final service = serviceList[index];
                return _buildServiceCard(
                  title: service['title'] ?? 'No Title',
                  description: service['description'] ?? 'No Description',
                  price: service.containsKey('price') ? (service['price'] as num).toDouble() : null,
                );
              },
            );
          }).toList(),
        ),
      ),
    );  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    double? price,
  }) {
    final cubit = ForEverYoungCubit.get(context);
    final bool isDarkMode = cubit.isDark;
    final bool isExpanded = expandedStates[title] ?? false;

    // Define text colors based on dark mode
    final Color titleColor = isDarkMode ? Colors.white : Colors.black;
    final Color descriptionColor = isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;
    final Color priceColor = isDarkMode ? Colors.white : Colors.black;

    return Container(
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: titleColor, // Use titleColor
              ),
              softWrap: true,
            ),
          ),
          SizedBox(width: 10),
          if (price != null)
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                color: priceColor, // Use priceColor
              ),
            ),
        ],
      ),
      SizedBox(height: 12),
      Text(
        description,
        maxLines: isExpanded ? null : 2,
        overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        style: TextStyle(
          color: descriptionColor, // Use descriptionColor
          fontSize: 12,
        ),
      ),
      SizedBox(height: 4),
      TextButton(
        onPressed: () {
          setState(() {
            expandedStates[title] = !isExpanded;
          });
        },
        child: Text(
          isExpanded ? 'Show less' : 'Show more',
          style: TextStyle(color: secondaryColor),
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: () {
            navigateTo(context, BookServicesScreen());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Text(
            'Book',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
          Divider(),
        ],
      ),
    );
  }
}