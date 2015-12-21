/*
 * OpenGL demonstration program for ICS Computer Graphics courses
 * $Id: cube.c,v 1.1 2002/04/03 00:00:35 mshafae Exp $
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <GL/glut.h>
#include <signal.h>
#include "imp_my_GL.h"
#include "sceneModule.h"
#include "viewModule.h"
#include "inputModule.h"

#include "my_GL.h"

extern GLfloat current_light_position[];
extern GLfloat current_view_position[];
extern int lightOn;
int window;
int updateFlag;


int openglFlag = 0;
GLfloat revolverAngle = 0;
GLfloat spinnerAngle = 0;
GLfloat degreeInc = 0.005;
perspectiveData pD;

Vector3f light_position_vector, viewer_position;

GLfloat white[] = { 0.8f, 0.8f, 0.8f, 1.0f };
GLfloat shininess[] = { 50 };
GLfloat diffuse[] = { 1.0f, 1.0f, 0.8f, 1.0f };
GLfloat ambient[] = { 0.1f, 0.1f, 0.05f, 1.0f };
GLfloat specular[] = { 1.0f, 1.0f, 1.0f, 1.0f };


#ifdef __cplusplus
extern "C"
#endif
void cleanup( int sig ){
  // insert cleanup code here (i.e. deleting structures or so)
  exit( 0 );
}

void setMaterial(){
	float MatAmbient[] = { 0.1f, 0.1f, 0.1f, 1.0f };
	float MatDiffuse[] = { 1.0f, 1.0f, 1.0f, 1.0f };
	float MatSpecular[] = { 0.6f, 0, 0, 0.1f };
	float MatShininess = 50;
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, MatAmbient);
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, MatDiffuse);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, MatSpecular);
	glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, MatShininess);	
}


void renderLight(){
	GLfloat lmodel_ambient[] = { 0.2, 0.2, 0.2, 1.0 };
	glLightModelfv(GL_LIGHT_MODEL_AMBIENT, lmodel_ambient); // Ambient Component
	glEnable(GL_NORMALIZE); // automatically convert normals to unit normals	
	glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuse); // set color of diffuse component
	glLightfv(GL_LIGHT0, GL_AMBIENT, ambient); // set color of ambient component
	glLightfv(GL_LIGHT0, GL_SPECULAR, specular); // set color of specular component
	glLightfv(GL_LIGHT0, GL_POSITION, current_light_position); // Direction of Light
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);

}

void spinnerRotation(){	
	my_glRotatef(spinnerAngle, 0, 1, 0);
}

void revolverRotation(){
	my_glRotatef(spinnerAngle, 0, 1, 0);
	my_glTranslatef(5, 0, 0);
	my_glScalef(0.5, 0.5, 0.5);
	my_glRotatef(revolverAngle, 1, 1, 0);
}

//##########################################3
// OpenGL Display function
#ifdef __cplusplus
extern "C"
#endif
void display( void ){	
	float M[16];
	Matrix4f m;
	glutSetWindow(window);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glColor3f(1.0, 1.0, 1.0);

	/* Set Up the Camera View*/
	setUserView();	
	
	glGetFloatv(GL_MODELVIEW_MATRIX, M);
	getMatrixFromVector(m, M);
	multVector(viewer_position, m, current_view_position);
	
	// Set up the Light Positions
	glPushMatrix();
	setLightView();
	glGetFloatv(GL_MODELVIEW_MATRIX, M);
	getMatrixFromVector(m, M);
	multVector(light_position_vector, m, current_light_position);
	// Make the light_position_vector a source at infinity.
	light_position_vector[3] = 0;
	glPopMatrix();
	//Display the light at that position
	glLightfv(GL_LIGHT0, GL_POSITION, light_position_vector);
	
	// Spinning Cube	
	my_glPushMatrix();
	spinnerRotation();
	drawScene(1.0, 0, 1.0, 1.0);
	my_glPopMatrix();

	// Revolving Cube	
	my_glPushMatrix();
	revolverRotation();
	drawScene(0, 1.0, 1.0, 1.0);
	my_glPopMatrix();

	/* Swap the front buffer with the back buffer - assumes double buffering */
	glutSwapBuffers();

}

//##########################################
// Init display settings
#ifdef __cplusplus
extern "C"
#endif
void initDisplay( ){

  /* Perspective projection parameters */
  pD.fieldOfView = 90.0;
  pD.aspect      = (float)IMAGE_WIDTH/IMAGE_HEIGHT;
  pD.nearPlane   = 0.1;
  pD.farPlane    = 50.0;

  /* setup context */
  my_glMatrixMode(GL_PROJECTION);
  my_glLoadIdentity( );
  my_gluPerspective( pD.fieldOfView, pD.aspect, pD.nearPlane, pD.farPlane );

  glEnable( GL_DEPTH_TEST );
  glDisable( GL_CULL_FACE ); 

  glClearColor( 0.0, 0.0, 0.0, 1.0 );
  glClearIndex( 0 );
  glClearDepth( 1 );
  my_glMatrixMode( GL_MODELVIEW );

 }

//Idle Function
void idleFunction(){
	if (revolverAngle < 360){
		revolverAngle += degreeInc;
	}
	else{
		revolverAngle += -revolverAngle + degreeInc;
	}

	if (spinnerAngle < 360){
		spinnerAngle += degreeInc;
	}
	else{
		spinnerAngle += -spinnerAngle + degreeInc;
	}
	
	glutPostRedisplay();
}

//##########################################
// Main function

int main( int argc, char **argv ){
//  signal( SIGHUP, cleanup );

  glutInit( &argc, argv );
  glutInitDisplayMode( GLUT_DOUBLE | GLUT_RGB |
                       GLUT_DEPTH | GLUT_MULTISAMPLE );

  glutInitWindowSize( IMAGE_WIDTH,IMAGE_HEIGHT );

  /* glutInitWindowPosition(0,0); */
  window = glutCreateWindow( argv[0] );

  /* Register the appropriate callback functions with GLUT */
  glutDisplayFunc( display );
  glutKeyboardFunc( readKeyboard );
  glutMouseFunc( mouseButtHandler );
  glutMotionFunc( mouseMoveHandler );
  glutPassiveMotionFunc( mouseMoveHandler );
  glutIdleFunc(idleFunction);

  initDisplay();
  setMaterial();
  renderLight();
  /* This function doesn't return - put all clean up code in
   * the cleanup function */
  glutMainLoop();

  /* ANSI C requires main to return an int. */
  return( 0 );
}

