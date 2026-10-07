package invertor.view;

import invertor.model.ModelListener;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;

public class MainFrame extends JFrame implements ModelListener {
  private final JLabel originalLabel;
  private final JTextArea invertedArea;
  private final JButton inputButton;
  private String lastInputData = "";

  public MainFrame() {
    super("Инвертор слов");
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setSize(500, 300);
    setLocationRelativeTo(null);
    setLayout(new BorderLayout(15, 15));

    JPanel resultsPanel = new JPanel(new GridLayout(4, 1, 5, 5));
    resultsPanel.setBorder(BorderFactory.createEmptyBorder(15, 15, 10, 15));

    resultsPanel.add(new JLabel("Исходное предложение:"));
    originalLabel = new JLabel("— (Данные не введены)");
    originalLabel.setForeground(new Color(50, 50, 50));
    resultsPanel.add(originalLabel);

    resultsPanel.add(new JLabel("Результат инвертирования:"));
    invertedArea = new JTextArea("—");
    invertedArea.setEditable(false);
    invertedArea.setLineWrap(true);
    invertedArea.setWrapStyleWord(true);
    invertedArea.setBackground(new Color(245, 245, 245));
    resultsPanel.add(new JScrollPane(invertedArea));

    add(resultsPanel, BorderLayout.CENTER);

    JPanel buttonPanel = new JPanel();
    inputButton = new JButton("Ввести данные");
    inputButton.setPreferredSize(new Dimension(160, 35));
    buttonPanel.add(inputButton);
    add(buttonPanel, BorderLayout.SOUTH);
  }

  public void setInputButtonListener(ActionListener listener) {
    inputButton.addActionListener(listener);
  }

  public String showInputDialog() {
    InputDialog dialog = new InputDialog(this, lastInputData);
    dialog.setVisible(true);

    if (dialog.isConfirmed()) {
      return dialog.getInputText();
    }
    return null;
  }

  public void setLastInputData(String text) {
    this.lastInputData = text;
  }

  public void showError(String message) {
    JOptionPane.showMessageDialog(this, message, "Ошибка валидации", JOptionPane.ERROR_MESSAGE);
  }

  @Override
  public void onDataChanged(String originalText, String invertedText) {
    originalLabel.setText(originalText);
    invertedArea.setText(invertedText);
  }
}