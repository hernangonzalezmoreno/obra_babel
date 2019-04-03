class Biblioteca{
  
  Hexagono[] hexas = new Hexagono[ 46656 ];
  
  String titulo1 = "Ley I", titulo2 = "Ley II";
  String texto1 = "No hay dos\nhexágonos iguales.",
  texto2 = "Existen todos\nlos hexágonos\nposibles.";
  
  Biblioteca( float tamano ){
    for( int i = 0; i < 216; i++ ){
      for( int j = 0; j < 216; j++ ){
        hexas[ i*216 + j ] = new Hexagono( i*216+j, j*tamano*3.0 + (i%2)*tamano*1.5, i*tamano*sin( radians( 60 ) ), tamano );
      }
    }
  }
  
  void dibujar( Camara camara ){
    pushMatrix();
    scale( camara.zoom );
    float seno = sin( radians( 60 ) );
    for( int j = 0; j < 9; j++ ){
      for( int i = 0; i < hexas.length; i++ ){
        Hexagono h = hexas[ i ];
        PVector p = new PVector( h.x, h.y );
        p.x = p.x - 216 * h.radioExterno * 3.0 + 216 * (j%3) * h.radioExterno * 3.0;
        p.y = p.y - 216 * h.radioExterno * seno + 216 * (j/3) * h.radioExterno * seno;
        PVector posicionRelativa = camara.posicionRelativa( p );
        h.dibujarSegunCamara( camara, posicionRelativa );
        if( i == 23327 ) texto( posicionRelativa.x, posicionRelativa.y, h.radio*.5, titulo1, texto1, color(255) );
        else if( i == 23328 ) texto( posicionRelativa.x, posicionRelativa.y, h.radio*.5, titulo2, texto2, color(0) );
      }
    }
    popMatrix();
  }
  
  void texto( float x, float y, float tamano, String titulo, String texto, color col ){
    pushStyle();
    fill( col );
    //textFont( fuente );
    textSize( tamano );
    textAlign( CENTER );
    text( titulo, x, y - tamano*.5 );
    
    textSize( tamano*.3 );
    text( texto, x, y + tamano*.4 );
    
    popStyle();
  }
  
  Hexagono getHexasPorCord( int[] codigo ){
    int index=0;
    for( int i = 0; i < codigo.length; i++ ){
      index += codigo[1]*pow( 6, i );
    }
    if( index < 0 || index >= hexas.length ) return null; else
    return hexas[index];
  }
  
}
