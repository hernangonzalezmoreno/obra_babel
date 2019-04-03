PFont fuente;
Reloj reloj;
Consola consola;
Camara camara;
Biblioteca biblio;
Buscar buscar;
Presentacion presentacion;

void setup(){
  
  fullScreen( P2D );
  shapeMode( CENTER );
  fuente = loadFont( "Roboto-Bold-48.vlw" );
  
  reloj = new Reloj();
  consola = new Consola();
  consola.setDebug( !consola.getDebug() );
  camara = new Camara( 0, 0 );
  biblio = new Biblioteca( 200 );
  buscar = new Buscar();
  
  //camara.irAobjeto( biblio.hexas[ 0 ] );
  int[] cord = { 2, 2, 2, 2, 2, 2 };
  Hexagono h = biblio.getHexasPorCord( cord );
  if( h != null ){ camara.irAobjeto( h ); buscar.setCodigo( cord ); }
  
  presentacion = new Presentacion();
  background( 255 );
}

void draw(){
  reloj.actualizar();
  background( 255 );

  camara.actualizar();
  biblio.dibujar( camara );
  buscar.ejecutar();
  
  if( presentacion != null ){
    presentacion.ejecutar();
    if( presentacion.estado.equals( Presentacion.ESTADO_ELIMINAR ) ) presentacion = null;
  }
    
  consola.ejecutar();
}

void keyPressed(){
  if( presentacion != null ) return;
  camara.keyPressed();
  if( keyCode == ENTER ) consola.setDebug( !consola.getDebug() );
}

void keyReleased(){
  if( presentacion != null ) return;
  camara.keyReleased();
}

void mouseWheel( MouseEvent event ){
  if( presentacion != null ) return;
  camara.mouseWheel( event );
}

void mousePressed(){
  if( presentacion != null ) return;
  buscar.mousePressed();
}
