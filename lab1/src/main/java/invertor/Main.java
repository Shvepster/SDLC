package invertor;

import invertor.controller.InvertorController;
import invertor.model.InvertorModel;
import invertor.view.MainFrame;

import javax.swing.*;

public class Main {
  public static void main(String[] args) {
    try {
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    } catch (Exception ignored) {}

    SwingUtilities.invokeLater(() -> {
      InvertorModel model = new InvertorModel();
      MainFrame view = new MainFrame();

      // Подключаем Активную Модель: View слушает события от Model
      model.addListener(view);

      // Контроллер слушает клики от View и меняет Model
      new InvertorController(model, view);

      view.setVisible(true);
    });
  }
}