/**
 *based on:
 *
 * ControlP5 Controlframe
 * with controlP5 2.0 all java.awt dependencies have been removed
 * as a consequence the option to display controllers in a separate
 * window had to be removed as well. 
 * this example shows you how to create a java.awt.frame and use controlP5
 *
 * by Andreas Schlegel, 2012
 * www.sojamo.de/libraries/controlp5
 *
 */

//using this sketch to troubleshoot controlframe issues for TwoWindowsTwo
//This is what success looks like!!!!!
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;//P5
import java.util.Date;
private ControlP5 cp5;//P5
String textValue = "";
String timestamp;
ControlFrame cf;
int def;
PImage img_1; //P5
PImage img_2; //P5
PImage img_3;//P5
//String textValue = "";//P5
//String timestamp;//P5
//int i;
int cell = 10; // diameter of particles

// UNDO: SPHERE MYSPHERE | CONTROLPOINT.CP |CP = NEW | SPHERE - NEW | SHPERE.ADD |CP SET |CP TOGGLE

float radius = 140; // radius of large sphere
int num = 300; // number of spheres

//color bg = color(212, 237, 244); // default background color
color bg = color(0, 0, 0); // default background color
PImage[] backdrop = new PImage[2]; // array of background images
int backdropIndex = 0; // start with the first backdrop in the array

//Sphere mySphere; // the main actor, container for all the little particles
float xPos, yPos, zPos; // coordinates of centre of large sphere
//ControlPoint cp; // its position at any point determines position of the sphere
//   In LOOPING mode, the control point:
//   -- turns on a fixed circle
//   -- does not respond to mouse movements
//   In CONTROLLING mode, the control point:
//   -- works like a bouncing ball (reflecting off the sides of the frame)
//   -- responds to mouse movements
int LOOPING = 0;
int CONTROLLING = 1;

int movCounter = 1501;

void setup() {
  size(1500, 800);
  background(255);
  img_1 = loadImage("roar2.png");
  img_2 = loadImage("theQuestion.png");
  img_3 = loadImage("instructions.png");
 
  cf = addControlFrame("extra", 1920,1200);
  cp5 = new ControlP5(this);
  PFont font = createFont("arial",20);//P5
  cp5 = new ControlP5(this);//P5
  Date d = new Date();
  println(d.getTime());
  
  cp5 = new ControlP5(this);
  cp5.addTextfield("input")//P5
     .setPosition(800,600)//P5
    .setSize(600,40)//P5
     .setFont(font)//P5
     .setFocus(true)//P5
    .setColor(color(255));//P5
     textFont(font);//P5 
     

  // add Controllers to the 'extra' Frame inside 
  // the ControlFrame class setup() method below.
  
  
}


void draw() {
  image(img_1, 5, 0);
  image(img_2, 650,215);
  image(img_3, 850,645);
  fill(0,255,0);
  text(textValue, 360,180);
}
public void clear() {
  cp5.get(Textfield.class,"textValue").clear();//P5 
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}
public void input(String theText) {
  //public void enteryourphrase(String theText) {
  // automatically receives results from controller input
  println("a mf textfield event for controller 'input' : "+theText);//P5
   Table table = loadTable("zooMockUpCSV.csv","header");//P5
  //String s = table.getString(1, 1);   // s now has the value//P5
  //println(s);//P5
  timestamp =  nf(month(),2) + "-" + nf(day(),2)  + "-" + year()+ "-"  
  + nf(hour(),2) + nf(minute(),2); 
  ///+ nf(second(),2);
  println(timestamp); //P5
  TableRow newRow = table.addRow(); //P5
// Set the values of that row
//newRow.setInt("Year", 2013);
//newRow.setFloat("PercentCurrentSmokers", 25.6);
newRow.setString("PHRASE", theText);//P5
newRow.setString("TIMESTAMP", timestamp);//P5
saveTable(table, "data/zooMockUpCSV.csv");//P5

    } 

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}


// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {

  int w, h;

  int abc = 100;
  
  public void setup() {
    size(w, h,P3D);
    smooth();
    noStroke();
    lights();
    //backdrop[0] = loadImage("201011-tagline-00-1024x768.png");
    //backdrop[1] = loadImage("20100920-1024x768.png");

    xPos = 550;
    yPos = 330;
    zPos = 370;
    //mySphere = new Sphere(xPos, yPos, zPos, radius);
    for (int i = 0; i < num; i++) {
     //mySphere.addSphereItem( cell );
  }   
  //cp = new ControlPoint();
  }

  public void draw() {
     background(bg);
  //cp.update();
// Uncomment the next line to visualise the control point as a black circle
//  cp.render();
  //mySphere.render( cp.getX(), cp.getY() );
//  if (movCounter-- > 0) {
//    saveFrame("frames/logo-#####.png");
//  } else {
//    exit();
//  }
  }
  void mouseMoved() {
  //cp.setTarget( (float) mouseX, (float) mouseY );
}
  void keyPressed() {
  if (key == 'c' || key == 'C') {
    // toggles the control point between looping and mouse-controlled
    //cp.toggleMode();
  }
}
class ControlPoint {
  PVector loc, vel, target;
  float easing = 0.05;
  final int LOOPING = 0;
  final int CONTROLLING = 1;
  int mode;

  // three variables used when looping
  float angle = -PI; // start angle to loop
  float dA = TWO_PI / 1500; // step for each cycle of the loop
  float radius = width / 4; // radius of looping circle

  ControlPoint() {
    loc = new PVector( (float) width/2, (float) height/2 );
    vel = new PVector( 0.3, 0.4 );
    target = new PVector( -1, -1);
    mode = CONTROLLING;
    //    vel = new PVector( random(0.5, 1.5),   random(0.5, 1.5) );
  }

  void update() {
    switch(mode) {
    case LOOPING: 
      updateLooper(); 
      break;
    case CONTROLLING: 
      updateController(); 
      break;
    }
  }

  void updateLooper() {
    angle += dA;
    loc.x = width/2 + radius * cos(angle);
    loc.y = height/2 + radius * sin(angle);
  }

  void updateController() {
    // if the control point is tracking the mouse, then ease it towards the target
    // if not tracking, then just keep going until mouse moves
    if (target.x == -1) {
      loc.add(vel);
      // do some boundary checks 
      // if the control point is going to cross its limits, then reflect it
      if (loc.x + vel.x < 0) { 
        vel.x = -vel.x;
      }
      if (loc.x + vel.x > width) { 
        vel.x = -vel.x;
      }
      if (loc.y + vel.y < 0) { 
        vel.y = -vel.y;
      }
      if (loc.y + vel.y > height) { 
        vel.y = -vel.y;
      }
    } 
    else {
      float dx = (target.x - loc.x) * easing;
      loc.x += dx;
      float dy = (target.y - loc.y) * easing;
      loc.y += dy;
      // if the control point gets within 20 pixels of the mouse, 
      // stop tracking the mouse till it moves again.
      // Note: the 20 pixels is arbitrary, determined by trial 
      // and error to reduce sudden changes in velocity when contro point reaches mouse
      if (loc.x - target.x < 20 && loc.y - target.y < 20) {
        target = new PVector( -1, -1);
      }
    }
  }

  void toggleMode() {
    switch(mode) {
    case LOOPING: 
      mode = CONTROLLING; 
      break;
    case CONTROLLING: 
      mode = LOOPING; 
      break;
    }
  }

  float getX() {
    return loc.x;
  }

  float getY() {
    return loc.y;
  }

  void setLoc(float x, float y) {
    loc = new PVector(x, y);
  }

  void setTarget(float x, float y) {
    target = new PVector(x, y);
    float dx = x - loc.x;
    float dy = y - loc.y;
    float denom = max(dx, dy);
    float vx = dx / abs( denom );
    float vy = dy / abs( denom );
    while ( max(abs(vx), abs(vy)) > 0.8 ) {
      vx *= 0.9;
      vy *= 0.9;
    }
    vel = new PVector( vx, vy );
  }

  void render() {
    // used for visualisation of the control point during debugging
    pushStyle();
    pushMatrix();
    translate( loc.x, loc.y );
    fill(0);
    ellipse(0,0, 5, 5);
    popMatrix();
    popStyle();
  }
}

  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return cp5;
  }
  
  
  ControlP5 cp5;

  Object parent;

  
}
