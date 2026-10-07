package invertor.controller;

import invertor.model.InvertorModel;
import invertor.view.MainFrame;

public class InvertorController {
  private final InvertorModel model;
  private final MainFrame view;

  public InvertorController(InvertorModel model, MainFrame view) {
    this.model = model;
    this.view = view;
    this.view.setInputButtonListener(e -> handleInputData());
  }

  private void handleInputData() {
    String input = view.showInputDialog();

    if (input == null) {
      return;
    }

    // Проверка: пустая ли строка
    if (input.trim().isEmpty()) {
      view.showError("Введена пустая строка! Введите предложение.");
      return;
    }

    // Проверка: есть ли хоть одна буква или цифра
    if (!input.matches(".*[a-zA-Zа-яА-Я0-9Ёё].*")) {
      view.showError("Строка должна содержать хотя бы одно слово.");
      return;
    }

    // Сохраняем введенный текст в форме
    view.setLastInputData(input);

    // Отправляем в модель
    model.processSentence(input);
  }
}