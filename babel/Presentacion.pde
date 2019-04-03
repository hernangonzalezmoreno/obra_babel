class Presentacion{
  
  String nombre = "Babel";
  PFont fuenteTitulo;
  
  String estado;
  static final String
  ESTADO_INICIO = "Inicio",
  ESTADO_ESPERA = "Espera",
  ESTADO_FINAL = "Final",
  ESTADO_ELIMINAR = "Eliminar";
  
  int tiempo;
  static final int 
  TIEMPO_INICIO = 1000,
  TIEMPO_ESPERA = 3000,
  TIEMPO_FINAL = 500;
  
  Presentacion(){
    fuenteTitulo = loadFont( "Roboto-Bold-255.vlw" );
    estado = ESTADO_INICIO;
    reloj.actualizar();
  }
  
  void ejecutar(){
    
    tiempo += reloj.getDeltaMillis();
    
    switch( estado ){
      case ESTADO_INICIO:
        dibujar( 255 );
        inicio();
        break;
      case ESTADO_ESPERA:
        espera();
        dibujar( 255 );
        break;
      case ESTADO_FINAL:
        dibujar( floor( constrain( map( tiempo, 0, TIEMPO_FINAL, 255, 0 ), 0, 255 ) ) );
        finalizar();
        break;
    }
    
    
  }
  
  void actualizarTiempo(){
    tiempo += reloj.getDeltaMillis();
    
    if( tiempo > TIEMPO_INICIO ){
      tiempo = 0;
    }
  }
  
  void inicio(){
    fill( 255, map( tiempo, 0, TIEMPO_INICIO, 255, 0 ) );
    rect( -1, -1, width+2, height+2);
    
    if( tiempo > TIEMPO_INICIO ){
      tiempo = 0;
      estado = ESTADO_ESPERA;
    }
  }
  
  void espera(){
    if( tiempo > TIEMPO_ESPERA ){
      tiempo = 0;
      estado = ESTADO_FINAL;
    }
  }
  
  void finalizar(){
    if( tiempo > TIEMPO_FINAL ){
      //tiempo = 0;
      estado = ESTADO_ELIMINAR;
      fuenteTitulo = null;
    }
  }
  
  void dibujar( int alfa ){
    pushStyle();
    
    beginShape();
    fill( #EFEFEF, alfa );
    vertex( 0, 0 );
    vertex( width, 0 );
    fill( #999999, alfa );
    vertex( width, height );
    vertex( 0, height );
    endShape();
    
    textFont( fuenteTitulo );
    textSize( height*.3 );
    textAlign( CENTER, CENTER );
    fill( 0, alfa );
    text( nombre, width*.5, height*.5 );
    
    popStyle();
  }
}
