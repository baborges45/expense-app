import '../commons/commons.dart';

class TransactionTypeColor with ThemeInjector {
  Color getColor(String type) {
    switch (type) {
      case 'Alimentação':
        return aliasTokens.color.positive.placeholderColor;
      case 'Transporte':
        return aliasTokens.color.elements.negativeColor;
      case 'Entretenimento':
        return aliasTokens.color.informative.bgColor;
      case 'Educação':
        return aliasTokens.color.informative.onPlaceholderColor;
      case 'Finanças':
        return aliasTokens.color.positive.onIconColor;
      case 'Compras':
        return aliasTokens.color.promote.placeholderColor;
      case 'Saúde':
        return aliasTokens.color.promote.bgColor;
      case 'Casa':
        return aliasTokens.color.warning.bgColor;
      case 'Presentes':
        return aliasTokens.color.warning.iconColor;
      case 'Renda Extra':
        return aliasTokens.color.elements.bgColor03;
      case 'Outros':
        return aliasTokens.color.elements.bgColor06;
      default:
        return aliasTokens.color.elements.bgColor06;
    }
  }
}
