import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    cameras = await availableCameras();
    print('Câmeras encontradas: ${cameras.length}');
    for (int i = 0; i < cameras.length; i++) {
      print('Câmera $i: ${cameras[i].name} - ${cameras[i].lensDirection}');
    }
  } catch (e) {
    print('Erro ao inicializar câmeras: $e');
    cameras = [];
  }
  
  runApp(TimecardApp());
}class TimecardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PointCam Pro - Registro de Ponto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: TimecardHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TimecardHome extends StatefulWidget {
  @override
  _TimecardHomeState createState() => _TimecardHomeState();
}

class _TimecardHomeState extends State<TimecardHome> {
  CameraController? controller;
  bool isRecognizing = false;
  String cameraStatus = 'Inicializando câmera...';

  // Apenas 1 usuário para confirmação
  final Map<String, dynamic> employee = {
    'id': 1,
    'name': 'João Silva',
    'department': 'TI',
    'position': 'Desenvolvedor'
  };

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      setState(() {
        cameraStatus = 'Procurando câmeras...';
      });

      if (cameras.isEmpty) {
        setState(() {
          cameraStatus = 'Nenhuma câmera encontrada.\nVerifique se a webcam está conectada.';
        });
        return;
      }

      setState(() {
        cameraStatus = 'Inicializando câmera...';
      });

      // Usar a primeira câmera disponível
      controller = CameraController(
        cameras[0],
        ResolutionPreset.high,
        enableAudio: false,
      );

      await controller!.initialize();

      if (mounted) {
        setState(() {
          cameraStatus = 'Câmera ativa - ${cameras[0].name}';
        });
      }
    } catch (e) {
      print('Erro detalhado ao inicializar câmera: $e');
      setState(() {
        cameraStatus = 'Erro na câmera: ${e.toString()}\n\nTentativas:\n- Verifique permissões\n- Reinicie o app\n- Verifique se outra aplicação está usando a câmera';
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void startRecognition() {
    setState(() {
      isRecognizing = true;
    });

    // Simula reconhecimento facial após 2 segundos
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isRecognizing = false;
        });
        _confirmTimeRecord();
      }
    });
  }

  void _confirmTimeRecord() {
    DateTime now = DateTime.now();
    String time =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    String action = "Registro de Ponto";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Registro'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                child: Text(employee['name'][0],
                    style: TextStyle(fontSize: 24, color: Colors.white)),
              ),
              SizedBox(height: 16),
              Text(employee['name'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('${employee['position']} - ${employee['department']}',
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16),
              Text(action, style: TextStyle(fontSize: 16)),
              Text(time,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSuccess();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ponto registrado com sucesso!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Icon(Icons.people, color: Colors.blue),
                title: Text('Gerenciar Funcionários'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmployeeManagementScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.assessment, color: Colors.green),
                title: Text('Relatórios'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReportsScreen()),
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Tela inteira para câmera
          if (controller != null && controller!.value.isInitialized)
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: CameraPreview(controller!),
              ),
            )
          else
            // Placeholder quando câmera não está pronta
            Container(
              color: Colors.grey[900],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 80,
                      color: Colors.white54,
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cameraStatus,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: initializeCamera,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Tentar Novamente'),
                    ),
                  ],
                ),
              ),
            ),

          // Status indicator no topo
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isRecognizing
                          ? 'Reconhecendo...'
                          : 'PointCam Pro - ${employee['name']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _showMenu(),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Indicador de reconhecimento no centro
          if (isRecognizing)
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.blue,
                      strokeWidth: 3,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Reconhecendo face...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Botão centralizado na parte inferior
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: isRecognizing ? null : startRecognition,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  decoration: BoxDecoration(
                    color: isRecognizing
                        ? Colors.grey.withOpacity(0.7)
                        : Colors.blue.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Text(
                    'Registrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Tela de Gerenciamento de Funcionários
class EmployeeManagementScreen extends StatefulWidget {
  @override
  _EmployeeManagementScreenState createState() => _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  List<Map<String, dynamic>> employees = [
    {'id': 1, 'name': 'João Silva', 'department': 'TI', 'position': 'Desenvolvedor'},
    {'id': 2, 'name': 'Maria Santos', 'department': 'Vendas', 'position': 'Vendedora'},
    {'id': 3, 'name': 'Pedro Oliveira', 'department': 'RH', 'position': 'Analista'},
  ];

  final _nameController = TextEditingController();
  final _departmentController = TextEditingController();
  final _positionController = TextEditingController();

  void _showAddDialog() {
    _nameController.clear();
    _departmentController.clear();
    _positionController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicionar Funcionário'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _departmentController,
              decoration: InputDecoration(labelText: 'Departamento'),
            ),
            TextField(
              controller: _positionController,
              decoration: InputDecoration(labelText: 'Cargo'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty) {
                setState(() {
                  employees.add({
                    'id': employees.length + 1,
                    'name': _nameController.text,
                    'department': _departmentController.text.isEmpty ? 'Geral' : _departmentController.text,
                    'position': _positionController.text.isEmpty ? 'Funcionário' : _positionController.text,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Funcionário adicionado!')),
                );
              }
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Funcionários'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(employee['name'][0].toUpperCase()),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              title: Text(employee['name']),
              subtitle: Text('${employee['position']} - ${employee['department']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Confirmar'),
                      content: Text('Excluir ${employee['name']}?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              employees.removeAt(index);
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Funcionário excluído!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: Text('Excluir'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}

// Tela de Relatórios
class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List<Map<String, dynamic>> mockRecords = [
    {'name': 'João Silva', 'time': '08:30', 'action': 'Entrada', 'date': 'Hoje'},
    {'name': 'João Silva', 'time': '12:00', 'action': 'Saída Almoço', 'date': 'Hoje'},
    {'name': 'João Silva', 'time': '13:30', 'action': 'Volta Almoço', 'date': 'Hoje'},
    {'name': 'Maria Santos', 'time': '09:00', 'action': 'Entrada', 'date': 'Hoje'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatórios de Hoje'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: mockRecords.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Nenhum registro hoje'),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: mockRecords.length,
              itemBuilder: (context, index) {
                final record = mockRecords[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(record['name'][0]),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    title: Text(record['name']),
                    subtitle: Text(record['action']),
                    trailing: Text(
                      record['time'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
