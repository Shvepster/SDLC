package invertor.model;

import java.util.ArrayList;
import java.util.List;

public class InvertorModel {
  private String originalText = "";
  private String invertedText = "";
  private final List<ModelListener> listeners = new ArrayList<>();

  // Подписка интерфейса (View) на Модель
  public void addListener(ModelListener listener) {
    listeners.add(listener);
  }

  // Логика инвертирования слов в предложении
  public void processSentence(String sentence) {
    this.originalText = sentence;
    this.invertedText = invertWords(sentence);
    notifyListeners();
  }

  private String invertWords(String input) {
    StringBuilder result = new StringBuilder();
    StringBuilder word = new StringBuilder();

    for (int i = 0; i < input.length(); i++) {
      char c = input.charAt(i);
      if (Character.isLetterOrDigit(c)) {
        word.append(c);
      } else {
        if (word.length() > 0) {
          result.append(word.reverse());
          word.setLength(0);
        }
        result.append(c);
      }
    }
    if (word.length() > 0) {
      result.append(word.reverse());
    }

    return result.toString();
  }

  private void notifyListeners() {
    for (ModelListener listener : listeners) {
      listener.onDataChanged(originalText, invertedText);
    }
  }

  public String getOriginalText() {
    return originalText;
  }

  public String getInvertedText() {
    return invertedText;
  }
}