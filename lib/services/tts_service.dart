import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:openlabel/providers/language_provider.dart';

final ttsServiceProvider = Provider<TtsService>((ref) {
  final lang = ref.watch(languageProvider);
  return TtsService(lang);
});

final ttsPlayingProvider = StateProvider<bool>((ref) => false);

class TtsService {
  TtsService(this._languageCode) {
    _initTts();
  }

  final String _languageCode;
  final FlutterTts _flutterTts = FlutterTts();
  bool _isInit = false;

  Future<void> _initTts() async {
    try {
      await _flutterTts.setSharedInstance(true);
      if (!kIsWeb) {
        await _flutterTts.setIosAudioCategory(
            IosTextToSpeechAudioCategory.playback,
            [
              IosTextToSpeechAudioCategoryOptions.allowBluetooth,
              IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
              IosTextToSpeechAudioCategoryOptions.mixWithOthers
            ],
            IosTextToSpeechAudioMode.defaultMode);
      }

      String ttsLang = 'en-IN';
      if (_languageCode == 'hi') {
        ttsLang = 'hi-IN';
      } else if (_languageCode == 'mr') {
        ttsLang = 'mr-IN'; // Note: Some local TTS engines may fallback to 'hi-IN' if Marathi is missing
      } else {
        ttsLang = 'en-US';
      }

      await _flutterTts.setLanguage(ttsLang);
      await _flutterTts.setSpeechRate(0.45); // Slightly slower for clear dictation
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
      _isInit = true;
    } catch (e) {
      debugPrint("TTS Initialization error: $e");
    }
  }

  Future<void> speakVerdict(String text, WidgetRef ref) async {
    if (!_isInit) return;
    
    // Strict requirement: Never auto-play, only triggered by user action manually
    ref.read(ttsPlayingProvider.notifier).state = true;
    
    _flutterTts.setCompletionHandler(() {
      ref.read(ttsPlayingProvider.notifier).state = false;
    });

    _flutterTts.setErrorHandler((msg) {
      ref.read(ttsPlayingProvider.notifier).state = false;
    });

    await _flutterTts.speak(text);
  }

  Future<void> stop(WidgetRef ref) async {
    await _flutterTts.stop();
    ref.read(ttsPlayingProvider.notifier).state = false;
  }
}
