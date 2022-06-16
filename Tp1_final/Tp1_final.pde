import oscP5.* ;

OscP5 osc;
GestorSenial gestorAmp;
GestorSenial gestorMidi;

Rectangulo [] rects;

Fondo fondo;

float velocidades[];

float limitesV[];

int cantRects;

PImage[] pngs = new PImage [2]; 

PImage[] jpgs = new PImage [6];

float amp;
float midi;
int ruidoTimbre;
float ruido = 60 ;
float minamp = 70;
float maxamp = 80;
float amort = 0.9;
float minmidi = 45;
float maxmidi = 70;
float minamgrav = 70;
float maxamgrav = 80;

void setup() {

  size(1000, 600, P2D);

  osc = new OscP5(this, 12345);

  gestorAmp = new GestorSenial(60, maxamp, 100, amort, 40);

  gestorMidi = new GestorSenial(minmidi, maxmidi, amort);

  fondo = new Fondo();

  cantRects = 30;

  rects = new Rectangulo[cantRects];

  velocidades = new float [cantRects];

  for ( int i=0; i<pngs.length; i++) {

    pngs[i]  = loadImage ("png" + nf(i, 2) + ".png");
  }

  for ( int i=0; i<jpgs.length; i++) {

    jpgs[i]  = loadImage ("jpg" + nf(i, 2) + ".png");
  }

  for ( int i=0; i<velocidades.length; i++) {

    if (i < cantRects/2) {
      velocidades[i] = random(0.1, 1);
    } else if (i < cantRects-1) {
      velocidades[i] = random(0.1, 1);
    } else {
      velocidades[i] = random(0.1, 1);
    }

    //cambia el signo del valor de velocidad cuando el numero es impar
    if ( 1 == i%2) {
      velocidades[i] = -velocidades[i];
    }
  }

  limitesV = new float [cantRects];

  for ( int i=0; i<limitesV.length; i++) {

    limitesV[i] = velocidades[i]*2;
  }

  for ( int i=0; i<rects.length; i++) {

    // 0 < 8 = hace 7 cuadrados verdes
    if (i < cantRects-12) {
      rects[i] = new Rectangulo(random(0, width), random(0, height), velocidades[i], limitesV[i], random(150, 200), random(100, 200), color(255,255,255), i, jpgs[0]);
    } 
    // 7 < 12 == hace 4 cuadrados azulsitos
    else if (i < cantRects-8) {
      rects[i] = new Rectangulo(random(0, width), random(0, height), velocidades[i], limitesV[i], random(140, 180), random(100, 140), color(255,255,255), i, jpgs[5]);
    }
    //11 < 14 == hace 2 cuadrados verde cortado
    else if (i < cantRects-6) {
      rects[i] = new Rectangulo(random(0, width), random(0, height), velocidades[i], limitesV[i], random(140, 200), random(120, 180), 255, i, jpgs[4]);
    }
    //13 < 16 == hace 2 cuadrados amarillo con cortes
    else if (i < cantRects-4) {
      rects[i] = new Rectangulo(random(0, width), random(0, height), velocidades[i], limitesV[i], random(180, 220), random(170, 210), 255, i, jpgs[3]);
    }
    // 15 < 19 == hace 3 cuadrados azul con lineas
    else if (i < cantRects-1) {
      rects[i] = new Rectangulo(random(0, width), random(0, height), velocidades[i], limitesV[i], random(200, 260), random(160, 220), 255, i, jpgs[1]);
    } 
    // hace el ultimo cuadrado grande 
    else {
      rects[i] = new Rectangulo(random(0, width), random(0, 150), velocidades[i], limitesV[i], random(600, 900), random(200, 400), 255, i, pngs[int(random(0,2))]);
    }
  }
}

void draw() {

  background(0, 25, 15);

  fondo.dibujaFondo();

  for ( int i=0; i<rects.length; i++) {
    rects[i].dibujaRectangulo();
    rects[i].mueveRectangulo();
    rects[i].mouseRectangulo();
  }

  gestorAmp.actualizar(amp);

  gestorMidi.actualizar(midi);

  //gestorAmp.imprimir(100, 100, 400, 200, true, true);

  //println(rects[1].vx + "....." + rects[1].velocidadPredeterminada + "-----" + amp + "----" + midi);

//println(rects[15].vx + "....." + rects[18].velocidadPredeterminada);
  
  println("ruidoooo:" + ruidoTimbre);
}

void oscEvent( OscMessage a) {

  if (a.addrPattern().equals("/amp")) {

    amp = a.get(0).floatValue();
  }

  if (a.addrPattern().equals("/pitch")) {

    midi = a.get(0).floatValue();
  }
  
  if (a.addrPattern().equals("/ruido")) {

    ruidoTimbre = a.get(0).intValue();
  }
}
