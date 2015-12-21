#ifdef WIN32
#include <windows.h>
#endif

#include <GL/gl.h>
#include <GL/glut.h>
#include <iostream>

#include "my_GL.h"
#include "inputModule.h"
#include "imp_my_GL.h"

extern int openglFlag;



void my_glMatrixMode(GLenum mode)
{	
	glMatrixMode(mode);		
}

void my_glLoadIdentity(void)
{
	if (openglFlag){
		imp_my_glLoadIdentity();
	}
	else{
		glLoadIdentity();
	}
}

void my_glPushMatrix(void)
{
	glPushMatrix();
}

void my_glPopMatrix(void)
{
	glPopMatrix();	
}


void my_glLoadMatrixf(const GLfloat *m)
{
	glLoadMatrixf(m);
}

void my_glLoadMatrixd(const GLdouble *m)
{
	glLoadMatrixd(m);	
}

void my_glTranslated(GLdouble x, GLdouble y, GLdouble z)
{
	if (openglFlag){
		imp_my_glTranslated(x, y, z);
		
	}
	else{
		glTranslated(x, y, z);
	}
}

void my_glTranslatef(GLfloat x, GLfloat y, GLfloat z)
{
	if (openglFlag){
		imp_my_glTranslatef(x, y, z);
		
	}
	else{
		glTranslatef(x, y, z);
	}
}

void my_glRotated(GLdouble angle, GLdouble x, GLdouble y, GLdouble z)
{
	if (openglFlag){
		imp_my_glRotated(angle, x, y, z);
		
	}
	else
	{
		glRotated(angle, x, y, z);
	}
}

void my_glRotatef(GLfloat angle, GLfloat x, GLfloat y, GLfloat z)
{
	if (openglFlag){
		imp_my_glRotatef(angle, x, y, z);
		
	}
	else
	{
		glRotatef(angle, x, y, z);
	}
}

void my_glScaled(GLdouble x, GLdouble y, GLdouble z)
{
	if (openglFlag){
		imp_my_glScaled(x, y, z);
		
	}
	else{
		glScaled(x, y, z);
	}
}

void my_glScalef(GLfloat x, GLfloat y, GLfloat z)
{
	if (openglFlag){
		imp_my_glScalef(x, y, z);
		
	}
	else{
		glScalef(x, y, z);
	}
}

void my_gluPerspective(GLdouble fov, GLdouble aspect, GLdouble zNear, GLdouble zFar){
	if (openglFlag){
		imp_my_gluPerspective(fov, aspect, zNear, zFar);
		
	}
	else{
		gluPerspective(fov, aspect, zNear, zFar);
	}
}

void my_gluLookAt(GLdouble eyeX, GLdouble eyeY, GLdouble eyeZ, GLdouble refX, GLdouble refY, GLdouble refZ,
	GLdouble upX, GLdouble upY, GLdouble upZ)
{
	if (openglFlag){
		gluLookAt(eyeX, eyeY, eyeZ,  refX,  refY,  refZ,
			 upX,  upY,  upZ);
	}
	else{
		imp_my_gluLookAt(eyeX, eyeY, eyeZ, refX, refY, refZ,
			upX, upY, upZ);
	}
}