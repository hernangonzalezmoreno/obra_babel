class Buscar{
  
  int x, y, ancho, alto;
  
  boolean abierto;
  Boton lupa, cruz;
  Hexagono h;
  BotonRectangular botonBuscar;
  
  Boton[] b = new Boton[ 6 ];
  int[] codigo = new int[ 6 ];
  
  Buscar(){
    x = width - 400;
    y = 0;
    ancho = 400;
    alto = height;
    lupa = new Boton( width-40, 40, 50, "lupa.svg" );
    cruz = new Boton( width-40, 40, 50, "cruz.svg" );
    h = new Hexagono( 0, 0, 0, ancho * .25 );
    botonBuscar = new BotonRectangular( x + ancho*.5, y + height*.6, 150, 30, "Buscar!" );
    
    float angulo = -150;
    float dist = h.radio * .55;
    float bxx = x + ancho *.5, byy = y + height*.4;
    for( int i = 0; i < b.length; i++ ){
      float bx = bxx + dist * cos( radians( angulo ) );
      float by = byy + dist * sin( radians( angulo ) );
      b[ i ] = new Boton( bx, by, ancho * .125 );
      angulo += 60;
    }
    
  }
  
  void setCodigo( int[] codigo ){
    this.codigo = codigo;
    h.setCodigo( codigo );
  }
  
  void ejecutar(){
    consola.println( "abierto: " + abierto );
    
    if( abierto ) dibujar();
    
    if( !abierto ){
      lupa.dibujar();
    }else{
      cruz.dibujar();
    }

  }
  
  void dibujar(){
    pushStyle();
    fill( #EFEFEF );
    noStroke();
    rect( width - 400, 0, 400, height );
    fill( #222222 );
    textFont( fuente );
    textAlign( CENTER );
    textSize( 30 );
    text( "Buscar", width - 200, 55 );
    
    h.dibujar( new PVector(  x + ancho *.5, y + height*.4 ) );
    //for( Boton b : this.b ) b.dibujarDebug();
    
    botonBuscar.dibujar();
    
    String txt = "cod: ";
    for( int i = 0; i < codigo.length; i++ ) txt += codigo[i] + ", ";
    consola.println( txt );
    
    popStyle();
  }
  
  void mousePressed(){
    if( !abierto )
      abierto = lupa.mousePressed();
    else{
      abierto = !cruz.mousePressed();
      
      for( int i = 0; i < b.length; i++ ){
        if( b[i].mousePressed() ){
          codigo[ i ]++;
          codigo[ i ]%=6;
          h.setCodigo( codigo );
        }
      }
      
      if( botonBuscar.mousePressed() ){
        int valor = 0;
        for( int i = 0; i < codigo.length; i++ ){
          valor += codigo[ i ] * pow( 6, i );
        }
        abierto = false;
        camara.objeto = valor;
        camara.siguiendoObjeto = true;
      }
            
    }
  }
  
}

class Boton{
  
  int x, y, tamano;
  PShape icono;
  
  Boton( float x, float y, float tamano, String rutaIcono ){
    this.x = round(x);
    this.y = round(y);
    this.tamano = round(tamano);
    icono = loadShape( rutaIcono );
    float escala = tamano*.55/(float)icono.width;
    icono.scale( escala );
  }
  
  Boton( float x, float y, float tamano ){
    this.x = round(x);
    this.y = round(y);
    this.tamano = round(tamano);
  }
  
  void dibujar(){
    fill( 255 );
    noStroke();
    ellipse( x, y, tamano, tamano );
    shape( icono, x, y );
  }
  
  void dibujarDebug(){
    fill( 0, 0, 255 );
    noStroke();
    ellipse( x, y, tamano, tamano );
  }
  
  boolean mousePressed(){
    if( dist( mouseX, mouseY, x, y ) < tamano*.5 ) return true; else return false;
  }
}

class BotonRectangular{
  
  int x, y, ancho, alto;
  String texto;
  
  BotonRectangular( float x, float y, float ancho, float alto, String texto ){
    this.x = round(x);
    this.y = round(y);
    this.ancho = round(ancho);
    this.alto = round(alto);
    this.texto = texto;
  }
  
  void dibujar(){
    pushStyle();
    fill( 255 );
    rectMode( CENTER );
    rect( x, y, ancho, alto );
    fill( 0 );
    textSize( alto * .7 );
    //textAlign( CENTER );
    text( texto, x, y + alto*.32 );
    popStyle();
  }
  
  boolean mousePressed(){
    if( mouseX > x - ancho*.5 && mouseX < x + ancho*.5
     && mouseY > y - alto*.5 && mouseY < y + alto*.5
    ) return true; else return false;
  }
  
}
