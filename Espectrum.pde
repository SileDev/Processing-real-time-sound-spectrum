/*
 *This sketch uses the Processing Sound library to analyze an audio
 *spectrum of 16 bands and draw an spectrum, based on the original 
 *library example "FFT Spectrum".
 *
 *This sketch load a sound file, so it's takes time to start
 *
 *I reserve these design, but you can made some other based on.
 */

import processing.sound.*;

// Declare the sound source and FFT analyzer variables
SoundFile sample;
FFT fft;

// Define how many bands to use, only can be numbers that are power of two
int bands = 16;

// Define a smoothing factor, this value is used to define the 
//aggressiveness of the animation
float smoothing = 0.2;

// Create a vector to store the smoothed spectrum data in
float[] 
  sum = new float[bands];

// Variables that store the data from the spectrum
float[]
  vx1 = new float[bands], 
  vy1 = new float[bands], 
  vx2 = new float[bands], 
  vy2 = new float[bands], 
  vx3 = new float[bands], 
  vy3 = new float[bands], 
  vx4 = new float[bands], 
  vy4 = new float[bands];

public void setup() {
  fullScreen();
  smooth(3);

  // Load the sound to play (i used a non copyright sound)
  sample = new SoundFile(this, "sound.mp3");
  sample.loop();

  // Create the FFT analyzer and connect the play1ng soundfile to it.
  fft = new FFT(this, bands);
  fft.input(sample);

  //define the color mode
  colorMode(RGB, 255);
}

public void draw() {
  // Set background color, and noStroke
  background(0);
  noStroke();
  // call the analy2is
  fft.analyze();

  //Read and store the data from the bands
  for (int i = 0; i < bands; i++) {
    // Smooth the FFT spectrum data by smoothing factor
    sum[i] += (fft.spectrum[i] - sum[i]) * smoothing;

    //Use the map() function to create a coordinates that describe
    //the circle using conventional maths
    float 
      r1 = map(100+(sum[i]*10*(i+1)/0.8), 0, bands, 0, bands), 
      x1 = r1*cos((360/bands+sqrt(bands)/10)*(i)*2*PI/360), 
      y1 = r1*sin((360/bands+sqrt(bands)/10)*(i)*2*PI/360), 

      r2 = map(110+(sum[i]*30*(i+1)/0.8), 0, bands, 0, bands), 
      x2 = r2*cos((360/bands+sqrt(bands)/10)*(i)*2*PI/360), 
      y2 = r2*sin((360/bands+sqrt(bands)/10)*(i)*2*PI/360), 

      r3 = map(160+(sum[i]*40*(i+1)/0.8), 0, bands, 0, bands), 
      x3 = r3*cos((360/bands+sqrt(bands)/10)*(i)*2*PI/360), 
      y3 = r3*sin((360/bands+sqrt(bands)/10)*(i)*2*PI/360), 

      r4 = map(170+(sum[i]*70*(i+1)/0.6), 0, bands, 0, bands), 
      x4 = r4*cos((360/bands+sqrt(bands)/10)*(i)*2*PI/360), 
      y4 = r4*sin((360/bands+sqrt(bands)/10)*(i)*2*PI/360);

    //Store all the procesed data
    vx1 [i] = x1;
    vy1 [i] = y1;

    vx2 [i] = x2;
    vy2 [i] = y2;

    vx3 [i] = x3;
    vy3 [i] = y3;

    vx4 [i] = x4;
    vy4 [i] = y4;
  }
  //Draw the spectrum
  drawSpectrum();
}

void drawSpectrum() {
  //Create a matrix and translate the shape to the center
  pushMatrix();
  translate(width/2, height/2);
  //Create a shape with the data
  beginShape();
  //Fill with a color defined from the data of the bands
  fill(vx1[0]+vy1[0]/2, vx1[1]+vy1[1]/2, vx1[2]+vy1[2]/2); 
  curveVertex(vx4[12], vy4[12]);
  curveVertex(vx4[13], vy4[13]);
  curveVertex(vx4[14], vy4[14]);
  curveVertex(vx4[15], vy4[15]);
  //All the curveVertex out of the for() are pushed by
  //define (fix or simulate) a circle
  for (int i = 0; i < bands; i++) {
    //Read all the bands to define the circle
    curveVertex(vx4[i], vy4[i]);
  }
  curveVertex(vx4[0], vy4[0]);
  curveVertex(vx4[1], vy4[1]);
  curveVertex(vx4[2], vy4[2]);
  curveVertex(vx4[3], vy4[3]);
  endShape();
  //Ends the first shape and start the second
  beginShape();
  //Filled with black color for simulate there is nothing  
  fill(0);
  curveVertex(vx3[12], vy3[12]);
  curveVertex(vx3[13], vy3[13]);
  curveVertex(vx3[14], vy3[14]);
  curveVertex(vx3[15], vy3[15]);
  for (int i = 0; i < bands; i++) {
    curveVertex(vx3[i], vy3[i]);
  }  
  curveVertex(vx3[0], vy3[0]);
  curveVertex(vx3[1], vy3[1]);
  curveVertex(vx3[2], vy3[2]);
  curveVertex(vx3[3], vy3[3]);
  endShape();

  //Repeat the procces for all the shapes

  beginShape();
  fill(vx1[0]+vy1[0]/2, vx1[1]+vy1[1]/2, vx1[2]+vy1[2]/2);
  curveVertex(vx2[12], vy2[12]);
  curveVertex(vx2[13], vy2[13]);
  curveVertex(vx2[14], vy2[14]);
  curveVertex(vx2[15], vy2[15]);
  for (int i = 0; i < bands; i++) {
    curveVertex(vx2[i], vy2[i]);
  }
  curveVertex(vx2[0], vy2[0]);
  curveVertex(vx2[1], vy2[1]);
  curveVertex(vx2[2], vy2[2]);
  curveVertex(vx2[3], vy2[3]);
  endShape();

  beginShape();
  fill(0);
  curveVertex(vx1[12], vy1[12]);
  curveVertex(vx1[13], vy1[13]);
  curveVertex(vx1[14], vy1[14]);
  curveVertex(vx1[15], vy1[15]);
  for (int i = 0; i < bands; i++) {
    curveVertex(vx1[i], vy1[i]);
  }  
  curveVertex(vx1[0], vy1[0]);
  curveVertex(vx1[1], vy1[1]);
  curveVertex(vx1[2], vy1[2]);
  curveVertex(vx1[3], vy1[3]);
  endShape();
  popMatrix();
}
