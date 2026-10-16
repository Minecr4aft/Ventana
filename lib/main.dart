import 'package:flutter/material.dart';

void main() {
  runApp(const MiAppMovil());
}

class MiAppMovil extends StatelessWidget {
  const MiAppMovil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abrir y cerrar la ventana',
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  bool _ventanaAbierta = false;

  void _alternarVentana() {
    setState(() {
      _ventanaAbierta = !_ventanaAbierta;
    });
  }

  Widget _buildReflejo(double w) {
    return Transform.rotate(
      angle: -0.5,
      child: Container(width: w, height: 3, color: Colors.white.withOpacity(0.5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Abrir y cerrar la ventana'),
        backgroundColor: Colors.brown[400],
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 280,
          height: 360,
          decoration: BoxDecoration(
            color: Colors.brown[900],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.brown.shade900, width: 10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.brown[700],
                  border: Border(
                    bottom: BorderSide(color: Colors.brown[900]!, width: 4),
                  ),
                ),
                padding: const EdgeInsets.all(6),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100]?.withOpacity(0.6),
                    border: Border.all(color: Colors.brown[800]!, width: 2),
                  ),
                  child: Stack(
                    children: [
                      Positioned(top: 10, left: 20, child: _buildReflejo(40)),
                      Positioned(top: 25, left: 50, child: _buildReflejo(30)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.brown[700],
                  padding: const EdgeInsets.all(6),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final double totalWidth = constraints.maxWidth;
                      final double halfWidth = (totalWidth - 2) / 2;

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(color: Colors.brown[800]),
                          // HOJA IZQUIERDA (Apertura normal)
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                            left: _ventanaAbierta ? -halfWidth - 15 : 0,
                            top: 0,
                            bottom: 0,
                            width: halfWidth,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue[100]?.withOpacity(0.6),
                                border: Border.all(color: Colors.brown[900]!, width: 3),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(top: 30, left: 20, child: _buildReflejo(50)),
                                  Positioned(top: 90, left: 40, child: _buildReflejo(40)),
                                ],
                              ),
                            ),
                          ),
                          // HOJA DERECHA (Apertura normal)
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                            right: _ventanaAbierta ? -halfWidth - 15 : 0,
                            top: 0,
                            bottom: 0,
                            width: halfWidth,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue[100]?.withOpacity(0.6),
                                border: Border.all(color: Colors.brown[900]!, width: 3),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(top: 30, right: 20, child: _buildReflejo(50)),
                                  Positioned(top: 90, right: 40, child: _buildReflejo(40)),
                                  if (!_ventanaAbierta)
                                    Center(
                                      child: Transform.rotate(
                                        angle: 0.785,
                                        child: Container(
                                          width: 12,
                                          height: 38,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: Colors.grey[700]!, width: 1.5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                blurRadius: 2,
                                                offset: const Offset(1, 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              onPressed: _alternarVentana,
              child: Text(
                _ventanaAbierta ? 'Cerrar' : 'Abrir',
                style: const TextStyle(
                  color: Color(0xFF0D3B0E),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
