/*
 * OpenGL demonstration program for ICS Computer Graphics courses
 * $Id: sceneModule.c,v 1.1 2002/04/03 00:00:43 mshafae Exp $
 *
 */

#include "sceneModule.h"
#include "my_GL.h"

/**
static float cubeColors[6][4] =
{
  {0.8, 0.8, 0.8, 1.0},
  {0.8, 0.0, 0.0, 1.0},
  {0.0, 0.8, 0.0, 1.0},
  {0.0, 0.0, 0.8, 1.0},
  {0.0, 0.8, 0.8, 1.0},
  {0.8, 0.0, 0.8, 1.0},
};**/

GLfloat n[6][3] = {  /* Normals for the 6 faces of a cube. */
	{ -1.0, 0.0, 0.0 }, { 0.0, 1.0, 0.0 }, { 1.0, 0.0, 0.0 },
	{ 0.0, -1.0, 0.0 }, { 0.0, 0.0, 1.0 }, { 0.0, 0.0, -1.0 } };


static float cubeVertexes[6][4][4] =
{
  {
    {-1.0, -1.0, -1.0, 1.0},
    {-1.0, -1.0, 1.0, 1.0},
    {-1.0, 1.0, 1.0, 1.0},
    {-1.0, 1.0, -1.0, 1.0}},

  {
    {1.0, 1.0, 1.0, 1.0},
    {1.0, -1.0, 1.0, 1.0},
    {1.0, -1.0, -1.0, 1.0},
    {1.0, 1.0, -1.0, 1.0}},

  {
    {-1.0, -1.0, -1.0, 1.0},
    {1.0, -1.0, -1.0, 1.0},
    {1.0, -1.0, 1.0, 1.0},
    {-1.0, -1.0, 1.0, 1.0}},

  {
    {1.0, 1.0, 1.0, 1.0},
    {1.0, 1.0, -1.0, 1.0},
    {-1.0, 1.0, -1.0, 1.0},
    {-1.0, 1.0, 1.0, 1.0}},

  {
    {-1.0, -1.0, -1.0, 1.0},
    {-1.0, 1.0, -1.0, 1.0},
    {1.0, 1.0, -1.0, 1.0},
    {1.0, -1.0, -1.0, 1.0}},

  {
    {1.0, 1.0, 1.0, 1.0},
    {-1.0, 1.0, 1.0, 1.0},
    {-1.0, -1.0, 1.0, 1.0},
    {1.0, -1.0, 1.0, 1.0}}
};

double Normal3dv(double *v)
{
	return sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2]);
}

/*
void drawScene(int r, int g, int b, int alpha ){

  glColor4f(r, g, b, alpha);	
  int i; 
  for (i = 0; i < 6; ++i) {
    glBegin(GL_POLYGON);	
    //glColor3fv(&cubeColors[i][0]);
	glNormal3fv(&n[i][0]);
    glVertex4fv(&cubeVertexes[i][0][0]);
    glVertex4fv(&cubeVertexes[i][1][0]);
    glVertex4fv(&cubeVertexes[i][2][0]);
    glVertex4fv(&cubeVertexes[i][3][0]);
    glEnd();
  }
}*/

void drawScene(int r, int g, int b, int alpha){
	glBegin(GL_QUADS);
	glNormal3f(0, 0, 1);
	glColor3f(r, g, b);
	glVertex3f(-1, 1, 1);
	glVertex3f(-1, -1, 1);
	glVertex3f(1, -1, 1);
	glVertex3f(1, 1, 1);

	// back
	glNormal3f(0, 0, -1);
	glColor3f(r, g, b);
	glVertex3f(-1, 1, -1);
	glVertex3f(1, 1, -1);
	glVertex3f(1, -1, -1);
	glVertex3f(-1, -1, -1);

	// top
	glNormal3f(0, 1, 0);
	glColor3f(r, g, b);
	glVertex3f(-1, 1, -1);
	glVertex3f(-1, 1, 1);
	glVertex3f(1, 1, 1);
	glVertex3f(1, 1, -1);

	// bottom
	glNormal3f(0, -1, 0);
	glColor3f(r, g, b);
	glVertex3f(-1, -1, -1);
	glVertex3f(1, -1, -1);
	glVertex3f(1, -1, 1);
	glVertex3f(-1, -1, 1);

	// left
	glNormal3f(-1, 0, 0);
	glColor3f(r, g, b);
	glVertex3f(-1, 1, -1);
	glVertex3f(-1, -1, -1);
	glVertex3f(-1, -1, 1);
	glVertex3f(-1, 1, 1);

	// right
	glNormal3f(1, 0, 1);
	glColor3f(r, g, b);
	glVertex3f(1, 1, 1);
	glVertex3f(1, -1, 1);
	glVertex3f(1, -1, -1);
	glVertex3f(1, 1, -1);
	glEnd();
}




