/*
 * OpenGL demonstration program for ICS Computer Graphics courses
 * $Id: inputModule.c,v 1.2 2002/04/03 00:36:06 mshafae Exp $
 *
 */

#include <signal.h>
#include <stdio.h>
//#include <unistd.h>
#include "inputModule.h"
#include "my_GL.h"
#include <math.h>

static int motionMode;
static int startX;
static int startY;
static GLfloat angle = 20;    /* in degrees */
static GLfloat angle2 = 30;   /* in degrees */
GLfloat current_view_position[] = { 0.0, 0.0, 5.0 };
GLfloat xdistance = 0.0;
GLfloat ydistance = 0.0;
GLfloat zdistance = 5.0;
//static GLfloat light_position[] = { 1.0, 0.0, 0.0, 0.0 };

//Defining variables to describe light effects
int lightOn = 1;
int lightToggle = 0;
static GLfloat lightAngle = 20;
static GLfloat lightAngle2 = 30;
GLfloat current_light_position[] = { 0, 0, 5 };


void readKeyboard( unsigned char key, int x, int y ){
  switch( key ){
  case  0x1B: /* esc */
  case  'q':
//    kill( getpid(), SIGHUP );
    break;
  case ' ':

    break;
  case ',':

    break;
  case '.':
    break; 
 case 'r':
	  printf("\n Resetting Parameters");
    /* Reset View Parameters */
    angle = 20;
    angle2 = 30;
	current_view_position[0] = 0.0;
	current_view_position[1] = 0.0;
	current_view_position[2] = 5.0;

	/* Reset Light Parameters */
	lightAngle = 20;
	lightAngle2 = 30;
	current_light_position[0] = 0;
	current_light_position[1] = 0;
	current_light_position[2] = 5;
	current_light_position[3] = 0;	
    break;

  case 't': lightToggle = (lightToggle + 1) % 2; 	
	  if (lightToggle == 1){
			  printf("\nLight Mode Toggled ON");			 
		  }
		  else{
			  printf("\nUser View Mode Toggled ON");
			  
		  }
	  
	break;

  case 'l': lightOn = (lightOn + 1) % 2;
			  if (lightOn == 1){
				  printf("\nLights ON");
				  glEnable(GL_LIGHTING);
			  }
			  else{
				  printf("\nLights OFF");
				  glDisable(GL_LIGHTING);
			  }
	  break;

  default:
    break;
  }
  glutPostRedisplay( );
}

void readSpecialKeys( int key, int x, int y ){
  switch( key ){
  case GLUT_KEY_UP:

    break;
  case GLUT_KEY_DOWN:

    break;
  case GLUT_KEY_RIGHT:

    break;
  case GLUT_KEY_LEFT:

    break;
  }
  glutPostRedisplay( );
}

void mouseButtHandler(int button, int state, int x, int y)
{
  motionMode = 0;

  switch( button ){
  case GLUT_LEFT_BUTTON:
    if( state == GLUT_DOWN ){
      /* Rotate object */
      motionMode = 1;
      startX = x;
      startY = y;
    }
    break;
  case GLUT_MIDDLE_BUTTON:
    if( state == GLUT_DOWN ){
      /* Translate object */
      motionMode = 2;
      startX = x;
      startY = y;
    }
    break;
  case GLUT_RIGHT_BUTTON:
    if( state == GLUT_DOWN ){
      /* Zoom */
      motionMode = 3;
      startX = x;
      startY = y;
    }
    break;
  }
  glutPostRedisplay( );
}

void mouseMoveHandler( int x, int y ){
  switch(motionMode){
  case 0:
    /* No mouse button is pressed... do nothing */
    /* return; */
    break;

  case 1:
	  if (lightToggle){
		  lightAngle = lightAngle + (x - startX);
		  lightAngle2 = lightAngle2 + (y - startY);
	  }
	  else{
		  /* Calculate the rotations */
		  angle = angle + (x - startX);
		  angle2 = angle2 + (y - startY);		
	  }  
	  startX = x;
	  startY = y;
    break;

  case 2:
	  if (lightToggle){
		  current_light_position[0] = current_light_position[0] - (x - startX) / 100.0;
		  current_light_position[1] = current_light_position[1] - (y - startY) / 100.0;
	  }
	  else{
		  current_view_position[0] = current_view_position[0] - (x - startX) / 100.0;
		  current_view_position[1] = current_view_position[1] - (y - startY) / 100.0;
	  }
	  startX = x;
	  startY = y;    
    break;

  case 3:
	  if (lightToggle){
		  current_light_position[2] = current_light_position[2] - (y - startY) / 10.0;
	  }
	  else{
		  current_view_position[2] = current_view_position[2] - (y - startY) / 10.0;
	  }    
    startX = x;
    startY = y;
    break;
  }

  glutPostRedisplay( );
}

void setUserView( ){
  GLdouble distance = 5;

    my_glLoadIdentity( );	
	my_glTranslatef(-current_view_position[0], current_view_position[1], -current_view_position[2]);
    my_glRotatef( angle2, 1.0, 0.0, 0.0 );
    my_glRotatef( angle, 0.0, 1.0, 0.0 );

	/*
	GLdouble theta = angle2 * 3.414 / 180;
	GLdouble phi = angle * 3.414 / 180;

	GLfloat eyeX = zdistance * cos(theta) * sin(phi);
	GLfloat eyeY = zdistance * sin(theta) * sin(phi);
	GLfloat eyeZ = zdistance * cos(phi);
	gluLookAt(eyeX, eyeY, eyeZ, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);*/
}

void setLightView(){
	glLoadIdentity();
	glTranslatef(-current_light_position[0], current_light_position[1], -current_light_position[2]);
	glRotatef(lightAngle2, 1.0, 0.0, 0.0);
	glRotatef(lightAngle, 0.0, 1.0, 0.0);
}
