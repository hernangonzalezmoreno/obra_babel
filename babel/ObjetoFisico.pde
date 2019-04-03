/* ObjetoFisico.pde
*  Hernán GM
*  hernangonzalezmoreno@gmail.com
*  11/02/2019
*
*  ObjetoFisico para la construccion de espacios 2D.
*  v0.1
*/

final int TAMANO_CUADRANTE = 800;

abstract class ObjetoFisico extends PVector{
  
  int cuadranteX, cuadranteY;
  
  ObjetoFisico( float x, float y ){
    super( x, y );
    calcularCuadrante();
  }
  
  void calcularCuadrante(){
    cuadranteX = (int)x / TAMANO_CUADRANTE;
    cuadranteY = (int)y / TAMANO_CUADRANTE;
  }
  
  void dibujar(){consola.printlnAlerta( "falta definir metodo dibujar()" );}
  
  void dibujar( PVector posicionRelativa ){
    fill( 0, 0, 255 );
    ellipse( posicionRelativa.x, posicionRelativa.y, 50, 50 );
    consola.printlnAlerta( "falta definir metodo dibujar( PVector )" );
  }
  
  void dibujarSegunCamara( Camara camara, PVector posicionRelativa ){
    if( posicionRelativa.x > 0 - camara.widthCamara*0.3 && posicionRelativa.x < camara.widthCamara + camara.widthCamara*0.3
        && posicionRelativa.y > 0-camara.heightCamara*0.3 && posicionRelativa.y < camara.heightCamara+camara.heightCamara*0.3
      ){
        dibujar( posicionRelativa );
      }
  }
  
}
