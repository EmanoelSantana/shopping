class AuthException implements Exception {
  static const Map<String, String> erros = {
    'EMAIL_EXISTS': 'E-mail já cadastrado.',
    'OPERATION_NOT_ALLOWED': 'Operaão não permitida!',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Acesso bloquado temporariamente. Tente mais tarde.',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado.',
    'INVALID_PASSWORD': 'Senha infomada não confere.',
    'USER_DISABLED': 'A conta do usuário foi desabilitada.',
  };

  final String Key;

  AuthException(this.Key);

  @override
  String toString() {
    return erros[Key] ?? 'Ocorreu um erro no processo de autenticação,';
  }
}
