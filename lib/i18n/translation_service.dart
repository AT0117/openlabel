/// Lightweight localization dictionary for OpenLabel.
///
/// No `flutter_localizations`, no `.arb` files; just an in-code map.
class TranslationService {
  static const Map<String, Map<String, String>> _dict = {
    'en': {
      'scan_package': 'Scan package',
      'scan_package_subtitle': 'Camera or gallery: front & back labels',
      'cart_cop': 'Cart-Cop',
      'cart_cop_subtitle': 'Paste a product link',
      'scan_barcode': 'Scan barcode',
      'trust_score': 'TRUST',
      'draft_complaint': 'Draft FSSAI Complaint',
      'analyzing_label': 'OSINT + rule checks running in the background',
      'settings': 'Settings',
      'action_step_1': 'Extracting text via Vision OCR...',
      'action_step_2': 'De-obfuscating ingredient splitting...',
      'action_step_3': 'Cross-referencing FSSAI database...',
      'action_step_4': 'Checking wholesale market arbitrage...',
      'action_step_5': 'Finalizing Tech-Justice verdict...',
    },
    'hi': {
      'scan_package': 'पैकेज स्कैन करें',
      'scan_package_subtitle': 'कैमरा या गैलरी: आगे और पीछे के लेबल',
      'cart_cop': 'कार्ट-कोप',
      'cart_cop_subtitle': 'उत्पाद का लिंक पेस्ट करें',
      'scan_barcode': 'बारकोड स्कैन करें',
      'trust_score': 'विश्वास',
      'draft_complaint': 'FSSAI शिकायत का ड्राफ्ट',
      'analyzing_label': 'पर्दे के पीछे OSINT + नियम जाँच चल रही है',
      'settings': 'सेटिंग्स',
      'action_step_1': 'Vision OCR के जरिए टेक्स्ट निकाल रहे हैं...',
      'action_step_2': 'सामग्री के विभाजन को डिकोड/डी-ऑबफस्केट कर रहे हैं...',
      'action_step_3': 'FSSAI डेटाबेस से मिलान कर रहे हैं...',
      'action_step_4': 'थोक बाजार के आर्बिट्राज की जाँच कर रहे हैं...',
      'action_step_5': 'टेक-न्याय फैसले को अंतिम रूप दे रहे हैं...',
    },
    'mr': {
      'scan_package': 'पॅकेज स्कॅन करा',
      'scan_package_subtitle': 'कॅमेरा किंवा गॅलरी: पुढचे आणि मागचे लेबल',
      'cart_cop': 'कार्ट-कोप',
      'cart_cop_subtitle': 'उत्पादन लिंक पेस्ट करा',
      'scan_barcode': 'बारकोड स्कॅन करा',
      'trust_score': 'विश्वास',
      'draft_complaint': 'FSSAI तक्रारीचा ड्राफ्ट',
      'analyzing_label': 'पडद्यामागे OSINT + नियम तपासणी सुरू आहे',
      'settings': 'सेटिंग्स',
      'action_step_1': 'Vision OCR द्वारे मजकूर काढत आहोत...',
      'action_step_2': 'घटकांचे विभाजन उलगडत आहोत...',
      'action_step_3': 'FSSAI डेटाबेसशी क्रॉस-रेफरन्स करत आहोत...',
      'action_step_4': 'घाऊक बाजारातील आर्बिट्राज तपासत आहोत...',
      'action_step_5': 'टेक-न्याय निकाल अंतिम करत आहोत...',
    },
  };

  static String t(String key, String languageCode) {
    return _dict[languageCode]?[key] ??
        _dict['en']?[key] ??
        key;
  }
}

