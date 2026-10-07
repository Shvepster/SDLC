package invertor.view;

import javax.swing.*;
import java.awt.*;

public class InputDialog extends JDialog {
  private final JTextField textField;
  private boolean confirmed = false;

  public InputDialog(JFrame parent, String initialText) {
    super(parent, "Ввод данных", true); // Модальное окно
    setLayout(new BorderLayout(10, 10));
    setSize(420, 150);
    setLocationRelativeTo(parent);

    JPanel inputPanel = new JPanel(new BorderLayout(5, 5));
    inputPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
    inputPanel.add(new JLabel("Введите предложение для инвертирования:"), BorderLayout.NORTH);

    // Подставляем ранее введенный текст
    textField = new JTextField(initialText);
    inputPanel.add(textField, BorderLayout.CENTER);
    add(inputPanel, BorderLayout.CENTER);

    JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
    JButton okButton = new JButton("OK");
    JButton cancelButton = new JButton("Отмена");

    okButton.addActionListener(e -> {
      confirmed = true;
      dispose();
    });

    cancelButton.addActionListener(e -> dispose());

    buttonPanel.add(okButton);
    buttonPanel.add(cancelButton);
    add(buttonPanel, BorderLayout.SOUTH);
  }

  public boolean isConfirmed() {
    return confirmed;
  }

  public String getInputText() {
    return textField.getText();
  }
}