import g4p_controls.*;
import processing.net.*; 


Client mountClient; 
int dataIn; 
int speed;
boolean abortRequired=false;
PImage logo;
void setup() { 
  size(1024, 600, P3D); 
  frameRate(30);
  mountClient = new Client(this, "192.168.1.2", 11000); 
  createGUI();
  DEC_pos.fireAllEvents(true);
  DEC_neg.fireAllEvents(true);
  AR_pos.fireAllEvents(true);
  AR_neg.fireAllEvents(true);
  
  logo = loadImage("logo.png");
} 
 
void draw() { 
  background (10);
  fill (100);
  textSize(15);
  text("Telescope position controls", 20, 130);
  text("Autoguide speed",390,130);
  text("Park & homing controls", 390,210);
  text("Tracking settings", 390,510);
  text("Side of pier settings", 390, 420);
  image(logo, 20, 5, 600, 100);
} 

void mouseReleased(){
  if(abortRequired){
    String msg = command.AbortSlew +"#" ;
    sendMsg(msg);
    abortRequired=false;
  }
}

void sendMsg (String msg){
  while (msg.length() < 50)
  {
    msg += "0";
  }
  
  println("SENT: " +msg );
  mountClient.write(msg);
}

void exit(){
  println("stop ");
    String msg = "closeConnection#";
    sendMsg(msg);
  super.exit();//let processing carry with it's regular exit routine
}
/*
void stop(){
  println("stop ");
    String msg = "closeConnection#";
    sendMsg(msg);
}*/
