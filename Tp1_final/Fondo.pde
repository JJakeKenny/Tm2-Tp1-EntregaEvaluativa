class Fondo {
  //propiedades:
  PImage imgFondo;
  float x;
  float velX;

  //constructor:
  Fondo() {
    imgFondo = loadImage ("img08.jpg");
    x = 0;
    velX = -1;
  }

  //funcionalidades:
  void dibujaFondo() {
    //dibujo:
    push();
    tint(255, 190);
    image(imgFondo, x, 0, width, height );
    image(imgFondo, width + x, 0, width, height );
    pop();

    //ademas cambio el valor de x:
    x+=velX; 

    if (x<-width) {
      x = 0;
    }
  }
}
