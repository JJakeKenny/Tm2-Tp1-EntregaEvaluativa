class Rectangulo {

  float x, y, ancho, alto, vx, maxVx, vy, c, velocidadPredeterminada, colorPre, anchoPre, altoPre;
  
  color tinte;

  int id, contador;

  PImage pngId;

  GestorSenial gestorV, gestorAncho, gestorAlto, gestorC;
  GestorSenial gestorVg, gestorAnchog, gestorAltog, gestorCg;

  Rectangulo(float x_, float y_, float vx_, float maxVx_, float ancho_, float alto_, color tinte_, int id_, PImage pngId_) {
    
    c = 255;
    
    contador = 0;

    x = x_;

    y = y_;

    vx = vx_;

    maxVx = maxVx_;

    ancho = ancho_;

    alto = alto_;

    tinte = tinte_;

    id = id_;    

    pngId = pngId_;

    velocidadPredeterminada = vx;

    anchoPre = ancho;

    altoPre = alto;

    colorPre = c;

    gestorV = new GestorSenial(minamp, maxamp, 0.6);

    gestorC = new GestorSenial(minamp, maxamp, 0.9);

    gestorAncho = new GestorSenial(minamp, maxamp, 0.7);

    gestorAlto = new GestorSenial(minamp, maxamp, 0.7);
    
    // graveee
    gestorVg = new GestorSenial(minamgrav, maxamgrav, 0.6);

    gestorCg = new GestorSenial(minamgrav, maxamgrav, 0.9);

    gestorAnchog = new GestorSenial(minamgrav, maxamgrav, 0.7);

    gestorAltog = new GestorSenial(minamgrav, maxamgrav, 0.7);
  }

  void dibujaRectangulo() {

    pushStyle();
    pushMatrix();

    translate(x, y);
    
    tint(c);

    imageMode(CENTER);

    image (pngId, 0, 0, ancho, alto);

    popMatrix();
    popStyle();
  }

  void mueveRectangulo() {

    x += vx;

    if (x>width+ancho/2) {

      x -= width+ancho;
    } else if (x<0-ancho/2) {

      x += width+ancho;
    }
  }

  void mouseRectangulo() {

    gestorV.actualizar(amp);

    gestorC.actualizar(amp);

    gestorAncho.actualizar(amp);

    gestorAlto.actualizar(amp);   
    
    //graveee
    gestorVg.actualizar(amp);

    gestorCg.actualizar(amp);

    gestorAnchog.actualizar(amp);

    gestorAltog.actualizar(amp);   

    float cr = map(gestorC.filtradoNorm(), 0, 1, 190, colorPre);

    float anchor = map(gestorAncho.filtradoNorm(), 0, 1, anchoPre-anchoPre/3, anchoPre);

    float altor = map(gestorAlto.filtradoNorm(), 0, 1, altoPre-altoPre/3, altoPre);
    
    //grave 
    float crg = map(gestorCg.filtradoNorm(), 0, 1, 190, colorPre);

    float anchorg = map(gestorAnchog.filtradoNorm(), 0, 1, anchoPre-anchoPre/3, anchoPre);

    float altorg = map(gestorAltog.filtradoNorm(), 0, 1, altoPre-altoPre/3, altoPre);
    
    boolean hayRuido = false;

    if (amp > ruido) {

      if (velocidadPredeterminada < 0) {

        velocidadPredeterminada = -velocidadPredeterminada;
      }
      
      float vr = map(gestorV.filtradoNorm(), 0, 1, -velocidadPredeterminada*10, velocidadPredeterminada*10);
      float vrg = map(gestorVg.filtradoNorm(), 0, 1, -velocidadPredeterminada*10, velocidadPredeterminada*10);

      if (midi < 60 && id < cantRects/2 && midi>minmidi) {

        vx = vrg;

        ancho = anchorg;

        alto = altorg;

        c = crg;
      } else if (midi > 60 && id >= cantRects/2-1) {

        vx = vr;

        c = cr;

        ancho = anchor;

        alto = altor;
      }
    }
     else {

      vx = velocidadPredeterminada;
    }
    
    
    if(ruidoTimbre >200){
     
     println(contador);
     
     contador ++; 
     
     if(contador <= 1){
       
       hayRuido = true;
       
     }else{
      
       hayRuido = false;
     }
     
     
     println(hayRuido);
     
     
    }
    
    else if (ruidoTimbre < 150){
      
     contador = 0; 
     
     hayRuido = false;
    }
    
    
    if(hayRuido == true){
      
      if(id < cantRects-1){
      pngId = jpgs[int(random(0,5))];
      }else{
        pngId = pngs[int(random(0,2))];
      }
      
      x = random(0, width);
      
      c = 255;
      
      vx = velocidadPredeterminada;
    }
    
    
    
    
    
    /*
    if(hayRuido == false){
    
    if(ruidoTimbre > 150){
      
      hayRuido = true;
     
    }else if (ruidoTimbre < 150){
      
     hayRuido = false;
      
    }
    }if(hayRuido == true){
      
      pngId = jpgs[int(random(0,5))];
      
      hayRuido = false;
      
    }
    */
    
    
    
    
//graveeee
/*
if (midi < 60 && id < cantRects/2 && midi>minmidi) {

        vx = vrg;

        ancho = anchorg;

        alto = altorg;

        c = crg;
      } else {

      vx = velocidadPredeterminada;
    }
    */




    //direccion: amp( fuerte derecha y bajo izquierda) y midi: atras o adelante (agudo adelante, grave atras)

    /*
   if(amp > ruido){
     
     if (midi < 65 && id < cantRects/2 && midi>minmidi) {
     // vx = map(amp, 65, 85, -velocidadPredeterminada, velocidadPredeterminada);
     
     vx = vr; 
     
     c = vt;
     
     // c = map(midi, 0, width, colorP/2, colorP);
     } else if (midi > 65 && id >= cantRects/2-1) {
     // vx = map(amp, 65, 85, -velocidadPredeterminada, velocidadPredeterminada);
     
     vx = vr;
     
     c = vt;
     
     //c = map(amp, 0, width, colorP/2, colorP);
     
     }
     }
     */
  }
}
