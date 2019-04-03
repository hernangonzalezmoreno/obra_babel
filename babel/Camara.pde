/* Camara.pde
*  Hernán GM
*  hernangonzalezmoreno@gmail.com
*  11/02/2019
*
*  Camara para un espacio 2D. Se necesita de la clase ObjetoFisico
*  v0.1
*/

interface TransformadaDePosicion{
  PVector posicionRelativa( PVector posicionObjetiva );
}

class Camara extends ObjetoFisico implements TransformadaDePosicion {
  
  float zoom = 1.0;
  
  float widthCamara, heightCamara;
  
  //------ Mover camara
  PVector movimiento;
  float velocidad = 0.4;
  boolean arriba, abajo, izquierda, derecha;
  //------
  
  boolean siguiendoObjeto;
  int objeto;
  
  Camara( float posicion_x, float posicion_y ){
    super( posicion_x, posicion_y );
    widthCamara = width;
    heightCamara = height;
    movimiento = new PVector();
  }
  
  //sobreescritura
  void calcularCuadrante(){
    cuadranteX = (int)(x + width*0.5) / TAMANO_CUADRANTE;
    cuadranteY = (int)(y + height*0.5) / TAMANO_CUADRANTE;
  }
   
  void irAobjeto( ObjetoFisico objeto ){
    //set( objeto.x - (width*0.5)/zoom, objeto.y - (height*0.5)/zoom );//----> Divido el tamaño de la pantalla por zoom
    set( objeto.x - widthCamara*0.5, objeto.y - heightCamara*0.5  );
    calcularCuadrante();
  }
   
  void seguirObjeto( ObjetoFisico objeto ){
    zoom = PApplet.lerp( zoom, 1.0, 0.05 );
    widthCamara = width / zoom;
    heightCamara = height / zoom;
    
    PVector direccion = new PVector( objeto.x-widthCamara*0.5, objeto.y-heightCamara*0.5 );
    lerp( direccion, 0.05);
    if( abs( direccion.x - x ) <= 10.0 && abs( direccion.y - y ) <= 10.0 ) siguiendoObjeto = false;
    calcularCuadrante();
  }
  
  void actualizar(){
    consola.println( "zoom: " + camara.zoom ); 
    consola.println( "c.x: " + camara.x + ", c.y: " + camara.y );
    if( !siguiendoObjeto ){
      camara.calcularMovimiento();
      camara.mover();
      camara.x = ( camara.x < 0 )? camara.x + 216 * 200 * 3 : ( camara.x > 216 * 200 * 3 )? camara.x -(216 * 200 * 3) : camara.x ;
      camara.y = ( camara.y < 0 )? camara.y + 216*200*sin( radians( 60 ) )  : ( camara.y > 216 * 200 * sin( radians( 60 ) ) )? camara.y - 216 * 200 * sin( radians( 60 ) ) : camara.y ;
    }else{
      seguirObjeto( biblio.hexas[ objeto ] );
    }
  }
  
  void calcularMovimiento(){
    movimiento.set( 0, 0 );
    if( arriba ) movimiento.add( new PVector(0,-1) );
    if( abajo ) movimiento.add( new PVector(0,1) );
    if( izquierda ) movimiento.add( new PVector(-1,0) );
    if( derecha ) movimiento.add( new PVector(1,0) );
    movimiento.normalize();
    movimiento.mult( velocidad * reloj.getDeltaMillis() );
  }
  
  void mover(){
    add( movimiento );
  }
   
  PVector posicionRelativa( PVector posicionObjetiva ){
    return new PVector( posicionObjetiva.x - x, posicionObjetiva.y - y );
  }
  
  void mouseWheel( MouseEvent event ){
    float z = event.getCount() * -0.02;

    if( (z > 0 && zoom < 1.3) || (z < 0.0 && zoom > 0.2) ){//0.3
      zoom += z;
      widthCamara = width / zoom;
      heightCamara = height / zoom;
      
      PVector vector = new PVector( -widthCamara*0.5, -heightCamara*0.5 );
      vector.mult( event.getCount()*0.02 );
      add( vector );
    }
    
  }
  
  void keyPressed(){
    teclasMovimiento( true );
  }

  void keyReleased(){
    teclasMovimiento( false );
  }

  void teclasMovimiento( boolean valor ){
    if( key == 'w' || key == 'W' )
      arriba = valor;
    else if( key == 's' || key == 'S' )
      abajo = valor;
    else if( key == 'a' || key == 'A' )
      izquierda = valor;
    else if( key == 'd' || key == 'D' )
      derecha = valor;
  }
   
}
