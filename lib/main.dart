import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

// Paleta verde-petróleo para dar uma identidade própria ao cadastro.
const _corFundo = Color(0xFFF2F6F4);
const _corAzul = Color(0xFF167D72);
const _corCampo = Color(0xFFF5F8F7);
const _corTexto = Color(0xFF19332F);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Usuário',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: _corAzul,
        useMaterial3: true,
      ),
      home: const CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  bool _ocultarSenha = true;
  bool _ocultarConfirmacao = true;

  static final RegExp _emailRegExp = RegExp(
    r'^[\w.+-]+@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}$',
  );

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  // ---------- Validators ----------

  String? _validarNome(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe o nome completo';
    return null;
  }

  String? _validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe o e-mail';
    if (!value.contains('@')) return 'O e-mail deve conter @';
    if (!_emailRegExp.hasMatch(value.trim())) return 'Informe um e-mail válido';
    return null;
  }

  String? _validarCpf(String? value) {
    if (value == null || value.isEmpty) return 'Informe o CPF';
    if (value.length != 11) return 'O CPF deve ter 11 números';
    return null;
  }

  String? _validarTelefone(String? value) {
    if (value == null || value.isEmpty) return 'Informe o telefone';
    if (value.length < 10 || value.length > 11) {
      return 'O telefone deve ter 10 ou 11 números';
    }
    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Informe a senha';
    if (value.length < 6) return 'A senha deve ter no mínimo 6 caracteres';
    return null;
  }

  String? _validarConfirmacao(String? value) {
    if (value == null || value.isEmpty) return 'Confirme a senha';
    if (value != _senhaController.text) return 'As senhas não coincidem';
    return null;
  }

  // ---------- Ação do botão ----------

  void _cadastrar() {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    if (_formKey.currentState!.validate()) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Cadastro realizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Corrija os campos destacados e tente novamente.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ---------- Estilo dos campos (cinza claro, cantos arredondados) ----------

  InputDecoration _decoracao(String hint, IconData icone, {Widget? sufixo}) {
    OutlineInputBorder borda([Color cor = Colors.transparent]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: cor),
        );

    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: Colors.black45),
      prefixIcon: Icon(icone, size: 20, color: _corTexto),
      suffixIcon: sufixo,
      filled: true,
      fillColor: _corCampo,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      border: borda(),
      enabledBorder: borda(),
      focusedBorder: borda(_corAzul),
      errorBorder: borda(Colors.red),
      focusedErrorBorder: borda(Colors.red),
    );
  }

  Widget _botaoSocial(String letra, Color cor) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: cor,
      child: Text(
        letra,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  // ---------- UI ----------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _corFundo,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              // Mantém o layout de "celular" também no navegador/desktop
              constraints: const BoxConstraints(maxWidth: 420),
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  20,
                  MediaQuery.of(context).padding.top + 24,
                  20,
                  24,
                ),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x160E493F),
                      blurRadius: 24,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Cabeçalho
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE4F2EF),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.person_add_alt_1_rounded,
                          color: _corAzul,
                          size: 28,
                        ),
                      ),
                    ),
                    const Text(
                      'Seu próximo passo começa aqui',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        color: _corTexto,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Preencha seus dados para criar sua conta.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Dados pessoais',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _corTexto,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Nome
                    TextFormField(
                      controller: _nomeController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: _decoracao('Nome completo', Icons.person),
                      validator: _validarNome,
                    ),
                    const SizedBox(height: 16),

                    // E-mail
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: _decoracao('E-mail', Icons.email),
                      validator: _validarEmail,
                    ),
                    const SizedBox(height: 16),

                    // CPF
                    TextFormField(
                      controller: _cpfController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      decoration:
                          _decoracao('CPF (apenas números)', Icons.badge),
                      validator: _validarCpf,
                    ),
                    const SizedBox(height: 16),

                    // Telefone
                    TextFormField(
                      controller: _telefoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      decoration:
                          _decoracao('Telefone (apenas números)', Icons.phone),
                      validator: _validarTelefone,
                    ),
                    const SizedBox(height: 16),

                    // Senha
                    TextFormField(
                      controller: _senhaController,
                      obscureText: _ocultarSenha,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      decoration: _decoracao(
                        'Senha (mínimo 6 caracteres)',
                        Icons.lock,
                        sufixo: IconButton(
                          tooltip:
                              _ocultarSenha ? 'Mostrar senha' : 'Ocultar senha',
                          icon: Icon(
                            _ocultarSenha
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20,
                          ),
                          onPressed: () =>
                              setState(() => _ocultarSenha = !_ocultarSenha),
                        ),
                      ),
                      validator: _validarSenha,
                    ),
                    const SizedBox(height: 16),

                    // Confirmar senha
                    TextFormField(
                      controller: _confirmarSenhaController,
                      obscureText: _ocultarConfirmacao,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      decoration: _decoracao(
                        'Confirmar senha',
                        Icons.lock_outline,
                        sufixo: IconButton(
                          tooltip: _ocultarConfirmacao
                              ? 'Mostrar senha'
                              : 'Ocultar senha',
                          icon: Icon(
                            _ocultarConfirmacao
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20,
                          ),
                          onPressed: () => setState(
                              () => _ocultarConfirmacao = !_ocultarConfirmacao),
                        ),
                      ),
                      validator: _validarConfirmacao,
                    ),
                    const SizedBox(height: 24),

                    // Botão CADASTRAR
                    ElevatedButton(
                      onPressed: _cadastrar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _corAzul,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'CADASTRAR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Registrar com...
                    const Text(
                      'Ou, registre-se com',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _botaoSocial('A', const Color(0xFFF5A942)),
                        const SizedBox(width: 16),
                        _botaoSocial('B', _corAzul),
                        const SizedBox(width: 16),
                        _botaoSocial('C', const Color(0xFF8BC34A)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Rodapé
                    const Text(
                      'Já tem uma conta?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Voltar ao login',
                        style: TextStyle(
                          fontSize: 12,
                          color: _corAzul,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: _corAzul,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
