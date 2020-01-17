
import processing.serial.*;

Serial myPort;
float value=0;
int xspacing = 50;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave


//Vrednosti za izračun valovanja krivulj
float theta = 0.0;  // Start angle at 0
float amplitude = 75.0;  // Height of wave
float period = 500.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] yvalues;  // Using an array to store height values for the wave

//Nastavitve za komunikacijo Arduino - Processing
void serialEvent(Serial myPort) { 
 
String inString = new String(myPort.readBytesUntil('\n'));
if (inString != null) {
   inString = trim(inString);
   float col = float(inString);
   value=col*1;
}
}

void setup() {
  size(740, 560); //Velikost platna
  w = width+16;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[4], 9600); //Nastavi port, na katerega je povezan arduino --> Spremeni številko v [] 
  myPort.bufferUntil('\n');
}

void draw() {
  background(255);
  calcWave();
  renderWave();
}

//Izračun koordinat točk v valu
void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.02;

  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    println(value);
    yvalues[i] = sin(x)*60;
    x+=dx;
  }
}

//Izrisovanje valov
void renderWave() {
  noStroke();
   //barve od 30 do 35
  // A simple way to draw the wave with an ellipse at each location
  for (int x = 0; x < yvalues.length; x++) {
    fill(70, value%255, 70, 170);
    ellipse(x*xspacing, height/2+yvalues[x], 16, 16);
    //ellipse(x*xspacing, height/2+yvalues[x]+20, 16, 16);
    fill(70, value%255, 170, 170);
    ellipse(x*xspacing+20, height/2+yvalues[x]+20, 16, 16);
    fill(170, value%255, 70, 170);
    ellipse(height/2+yvalues[x], x*xspacing, 16, 16);
  }
}