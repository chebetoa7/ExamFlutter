import 'package:flutter/material.dart';
import '../constants/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedStore = "Terminal del Norte";

  int _selectedCategoryIndex = 1; // Frutas/Verduras seleccionado por defecto
  final List<String> _categories = ['Todo', 'Frutas/Verduras', 'Carnes', 'Abarrotes'];
  final List<bool> _favorites = [false, false, false, false]; // Estado de favoritos

  static const List<BottomNavigationBarItem> _bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Inicio',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_offer_outlined),
      activeIcon: Icon(Icons.local_offer),
      label: 'Descuentos',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      activeIcon: Icon(Icons.shopping_cart),
      label: 'Carrito',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline),
      activeIcon: Icon(Icons.favorite),
      label: 'Wishlist',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Mi Cuenta',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildStoreSelector(),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        actions: [
          _buildMenuButton(),
        ],
      ),
      body: Column(
        children: [
          _buildSearchHeader(),
          const SizedBox(height: 16),
          // Banner de ofertas
          _buildOffersBanner(),
          _buildCategoriesSubmenu(),
          _buildProductsGrid(),  
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Botón de cambio de sucursal con icono de ubicación
  Widget _buildStoreSelector() {
    return GestureDetector(
      onTap: () {
        // Aquí iría la funcionalidad para cambiar sucursal
        print('Cambiar sucursal');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.secondary, 
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            Icon(
              Icons.location_on, // Icono de ubicación
              color: AppColors.secondary, 
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              _selectedStore,
              style: TextStyle(
                color: AppColors.secondary, 
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'HelveticaNeue',
              
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              color: AppColors.secondary, 
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // Botón de menú circular 
  Widget _buildMenuButton() {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: AppColors.primary, 
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () {
          print('Menú presionado');
        },
      ),
    );
  }

  // Header con buscador y filtros
  Widget _buildSearchHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          // Indicador de sucursal con mejor estilo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.secondary, 
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'Sucursal: $_selectedStore',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontFamily: 'HelveticaNeue',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Fila de búsqueda y filtros
          Row(
            children: [
              // Botón de búsqueda
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColors.textSecondary.withOpacity(0.3),
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar productos',
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary.withOpacity(0.6),
                        fontFamily: 'HelveticaNeue',
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: AppColors.primary, // Naranja
                      ),
                    ),
                    style: const TextStyle(fontFamily: 'HelveticaNeue'),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
             
              _buildFilterButton(),
            ],
          ),
        ],
      ),
    );
  }

  
  Widget _buildFilterButton() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.primary, 
          width: 1.5,
        ),
      ),
      child: IconButton(
        icon: Icon(
          Icons.tune,
          color: AppColors.primary, 
          size: 22,
        ),
        onPressed: () {
          print('Filtros presionado');
        },
        padding: EdgeInsets.zero,
      ),
    );
  }


  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: _bottomNavItems,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary, // Naranja #F85E11
      unselectedItemColor: AppColors.textSecondary,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'HelveticaNeue',
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'HelveticaNeue',
      ),
      backgroundColor: Colors.white,
      elevation: 8,
    );
  }

  

  // Banner de ofertas
  Widget _buildOffersBanner() {
  return Container(
    width: 250,
    height: 150,
    margin: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: AppColors.textSecondary.withOpacity(0.3),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Stack(
      children: [
        // Imagen de fondo (banner.png)
        
        Positioned(
          bottom: 0,
          right: 2,
           width: 145, 
            height: 90,
          child: SizedBox(
            child: Image.asset(
              'assets/images/banner.png', 
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
              errorBuilder: (context, error, stackTrace) {
            
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.local_offer,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        
        // Contenido de texto y botón
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Text(
                  'Hasta 35% off en frutas y verduras seleccionadas',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              _buildOffersButton(),
            ],
          ),
        ),
      ],
    ),
  );
} 
  Widget _buildOffersButton() {
    return GestureDetector(
      onTap: () {
        print('Ver ofertas presionado');
      },
      child: Container(
        alignment: Alignment.center,
        width: 85,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          
          border: Border.all(
            color: AppColors.secondary, 
            width: 2,
          ),
        ),
        
        child: Text(
          'Ver ofertas',
          
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Submenú de categorías
Widget _buildCategoriesSubmenu() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_categories.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _selectedCategoryIndex == index 
                        ? AppColors.secondary 
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                _categories[index],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: _selectedCategoryIndex == index 
                      ? FontWeight.bold 
                      : FontWeight.normal,
                  color: _selectedCategoryIndex == index 
                      ? AppColors.secondary 
                      : AppColors.textSecondary, 
                ),
              ),
            ),
          );
        }),
      ),
    ),
  );
}


Widget _buildProductsGrid() {

  return Container(
    height: 400,
    width: 370,
    child: GridView.builder(
      
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.65,
        
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        
        return _buildProductCard(index);
      },
    ),
  );
}


// Tarjeta de producto individual 
Widget _buildProductCard(int index) {
  return Container(
    width: 80,
    height: 20,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 2),
          
        ),
      ],
    ),
    child: Stack(
      children: [
    
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _favorites[index] = !_favorites[index];
              });
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: _favorites[index] ? Colors.white : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _favorites[index] ? AppColors.primary : Colors.grey[300]!, // Borde visible
                  width: 1.5,
                ),
              ),
              child: Icon(
                _favorites[index] ? Icons.favorite : Icons.favorite_border,
                color: _favorites[index] ? AppColors.primary : Colors.grey[600],
                size: 16,
              ),
            ),
          ),
        ),
        
        // Contenido principal 
        Padding(
          padding: const EdgeInsets.all(10), // Menos padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del producto 
              Center(
                child: Image.asset(
                  'assets/images/limones.png',
                  width: 70, 
                  height: 70,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.shopping_bag, size: 50, color: Colors.grey[400]);
                  },
                ),
              ),
              
              const SizedBox(height: 6), 
              
              // Nombre del producto
              Text(
                'Limón sin semilla',
                style: TextStyle(
                  fontSize: 13, 
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 3), 
              
              // Peso
              Text(
                '1 kg',
                style: TextStyle(
                  fontSize: 9,
                  color: AppColors.textSecondary,
                ),
              ),
              
              const Spacer(),
              
              // Precio y botón de agregar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Precio
                  Text(
                    '\$25.00',
                    style: TextStyle(
                      fontSize: 12, 
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  
                  // Botón de agregar 
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Botón de agregar al carrito
Widget _buildAddButton(int index) {
  return GestureDetector(
    onTap: () {
      // Aquí iría la lógica para agregar al carrito
      print('Agregar producto $index');
    },
    child: Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: AppColors.primary, // Naranja
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 18,
      ),
    ),
  );
}

// Botón de cantidad (para cuando se agrega al carrito)
Widget _buildQuantityButton(int index) {
  return Container(
    width: 80,
    height: 30,
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        
        GestureDetector(
          onTap: () {
            print('Disminuir cantidad');
          },
          child: const Text(
            '-',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        
        // Cantidad
        Text(
          '1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        // Botón más
        GestureDetector(
          onTap: () {
            print('Aumentar cantidad');
          },
          child: const Text(
            '+',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}

}