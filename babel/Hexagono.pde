final int[] COLORES = { -2565928, -4934476, -7303024, -9671572, -12040120, -14408668 };

class Hexagono extends ObjetoFisico{
  
  int id;
  int radioExterno, radio;
  int[] codigo = new int[ 6 ];
  
  Hexagono( int id, float x, float y, float radioExterno){
    super( x, y );
    this.id = id;
    this.radioExterno = round( radioExterno );
    radio = floor( radioExterno * 0.95 );
    //radio = this.radioExterno;
    calcularCodigo();
  }
  
  void calcularCodigo(){
    float division = (float) id;
    for( int i = 0; i < codigo.length; i++ ){
      codigo[ i ] = (int)division % 6;
      division = floor( division / 6.0 );
    }  
  }
  
  void setCodigo( int[] codigo ){
    this.codigo = codigo;
  }
  
  void dibujar( PVector posicionRelativa ){
    
    float x = posicionRelativa.x;
    float y = posicionRelativa.y;
    float coseno = cos( radians( 60 ) );
    float seno = sin( radians( 60 ) );
    
    stroke( 0 );
    //noStroke();
    fill( 255 );
    
    fill( COLORES[ codigo[ 0 ] ] );
    triangle( x, y, x - radio, y, x - coseno * radio, y - seno * radio );
    
    fill( COLORES[ codigo[ 1 ] ] );
    triangle( x, y, x - coseno * radio, y - seno * radio, x + coseno * radio, y - seno * radio );
    
    fill( COLORES[ codigo[ 2 ] ] );
    triangle( x, y, x + coseno * radio, y - seno * radio, x + radio, y );
    
    fill( COLORES[ codigo[ 3 ] ] );
    triangle( x, y, x + radio, y, x + coseno * radio, y + seno * radio );
    
    fill( COLORES[ codigo[ 4 ] ] );
    triangle( x, y, x + coseno * radio, y + seno * radio, x - coseno * radio, y + seno * radio );
    
    fill( COLORES[ codigo[ 5 ] ] );
    triangle( x, y, x - coseno * radio, y + seno * radio, x - radio, y );
    
  }
  
}
