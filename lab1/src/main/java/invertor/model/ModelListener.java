package invertor.model;

public interface ModelListener {
  // Оповещение View об обновлении данных
  void onDataChanged(String originalText, String invertedText);
}