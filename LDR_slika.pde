import processing.serial.*;

Serial myPort;
float value=0;
PImage img;
int y;


//Nastavitve za komunikacijo med Arduinom (Serial.monitor) in Processingom, branje podatkov iz Serial.monitorja
void serialEvent(Serial myPort) { 
 
String inString = new String(myPort.readBytesUntil('\n'));
if (inString != null) {
   inString = trim(inString);
   float col = float(inString);
   value=col*1;
}
}

void setup() {
  size(1000, 667); //Velikost platna
  println(Serial.list()); //Seznam vseh portov 
  myPort = new Serial(this, Serial.list()[4], 9600); //Nastavi port, na katerega je povezan arduino --> Spremeni številko v [] 
  myPort.bufferUntil('\n');
  img = loadImage("slika.JPG");  // Naloži sliko v program
}

void draw() { 
  //tint(200, 170, 0, 127);  // Barvni filter
  image(img, 0, 0, 1000, 677);  // Prikaže sliko (img, x1, y1, x2, y2)
 
  
  stroke(226, 204, 0);
  line(0, y, width, y);
  
  //line(0, height-y, width, height-y);
  
  fill(130, value%255, 30, 100);
  rect(0, 0, 1000 , y);
  
  y++;
  if(y > height){y = 0;}
}