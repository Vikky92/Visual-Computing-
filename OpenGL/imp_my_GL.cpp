#include <stdio.h>
#include <string.h>
#include <math.h>
#include <iostream>
#include "imp_my_GL.h"

#ifdef WIN32
#include <windows.h>
#endif

#include <GL/gl.h>

// Creating an Identity Matrix
const GLdouble identity[16] =
{ 1, 0, 0, 0,
0, 1, 0, 0,
0, 0, 1, 0,
0, 0, 0, 1 };


void imp_my_glLoadIdentity(void)
{
	glLoadMatrixd(identity);
}

// Implementing the translation matrix
void imp_my_glTranslated(GLdouble x, GLdouble y, GLdouble z)
{
	GLdouble translation_matrix[16] = { 1, 0, 0, 0,
										0, 1, 0, 0,
										0, 0, 1, 0,
										x, y, z, 1 };

	glMultMatrixd(translation_matrix);
}

void imp_my_glTranslatef(GLfloat x, GLfloat y, GLfloat z)
{
	imp_my_glTranslated((GLdouble)x, (GLdouble)y, (GLdouble)z);
}

// Implementing the Scaling Matrix
void imp_my_glScaled(GLdouble x, GLdouble y, GLdouble z)
{
	GLdouble scale_matrix[16] ={  x, 0, 0, 0,
								  0, y, 0, 0,
								  0, 0, z, 0,
								  0, 0, 0, 1 };
	glMultMatrixd(scale_matrix);
}

void imp_my_glScalef(GLfloat x, GLfloat y, GLfloat z)
{
	imp_my_glScaled((GLdouble)x, (GLdouble)y, (GLdouble)z);
}

// Cross of product of vectors b and c such that a = b x c (Requiring for gluLookAt)
void cross_product(GLdouble *ax, GLdouble *ay, GLdouble *az, GLdouble bx, GLdouble by, GLdouble bz,
	GLdouble cx, GLdouble cy, GLdouble cz)
{
	// This is required for gluLookAt
	*ax = by * cz - bz * cy;
	*ay = bz * cx - bx * cz;
	*az = bx * cy - by * cx;
}

// Normalizing the vector xi, yj, zk to get a unit vector in that direction
void normalize(GLdouble *x, GLdouble *y, GLdouble *z)
{
	//Required for Rotation and gluLookAt
	GLdouble length = sqrt(pow(*x, 2) + pow(*y, 2) + pow(*z, 2));
	*x = *x / length;
	*y = *y / length;
	*z = *z / length;
}

/*
Rotation about x,y,z axis for an angle. 
Note: To rotate about any generic axis we first need to convert XYZ into unit vectors.
Thus we first normalize them. Also C/C++ requires sin, cos angles to be in radians so we convert from
degree to radians.
*/

void imp_my_glRotated(GLdouble angle, GLdouble x, GLdouble y, GLdouble z){
	
	//Fidning out the norm2 and normalizing them
	GLdouble norm = sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2));
	x = x / norm;
	y = y / norm;
	z = z / norm;

	//Calculating the angle in radians
	GLdouble angleR = (angle * 3.14159)/180;

	// Generic XYZ Rotation Equation
	//https://en.wikipedia.org/wiki/Rotation_matrix
	GLdouble rotation_product[16] =
	{ x * x * (1 - cos(angleR)) + cos(angleR), y * x * (1 - cos(angleR)) + z * sin(angleR), x * z * (1 - cos(angleR)) - y * sin(angleR), 0,
	x * y * (1 - cos(angleR)) - z * sin(angleR), y * y * (1 - cos(angleR)) + cos(angleR), y * z * (1 - cos(angleR)) + x * sin(angleR), 0,
	x * z * (1 - cos(angleR)) + y * sin(angleR), y * z * (1 - cos(angleR)) - x * sin(angleR), z * z * (1 - cos(angleR)) + cos(angleR), 0,
	0, 0, 0, 1 };
	
	glMultMatrixd(rotation_product);	
}

void imp_my_glRotatef(GLfloat angle, GLfloat x, GLfloat y, GLfloat z)
{
	imp_my_glRotated((GLdouble)angle, (GLdouble)x, (GLdouble)y, (GLdouble)z);
}

void imp_my_gluLookAt(GLdouble eyeX, GLdouble eyeY, GLdouble eyeZ,
	GLdouble refX, GLdouble refY, GLdouble refZ,
	GLdouble upX, GLdouble upY, GLdouble upZ)
{
	// We now create a uvn coordinate system where u- up vector, n-normal vector, v-view vector
	// View Vector Calculation
	GLdouble fx = refX - eyeX;
	GLdouble fy = refY - eyeY;
	GLdouble fz = refZ - eyeZ;

	//Creating a unit vector in the +ve Z direction 
	normalize(&fx, &fy, &fz);

	// Creating and normalizing the up vector +ve Y direction
	GLdouble upx = upX;
	GLdouble upy = upY;
	GLdouble upz = upZ;
	normalize(&upx, &upy, &upz);

	//Creating the X axis vector V = N x U or V = F x U
	GLdouble vx, vy, vz;
	cross_product(&vx, &vy, &vz, fx, fy, fz, upx, upy, upz);

	//s = f * up
	GLdouble sx, sy, sz;
	cross_product(&sx, &sy, &sz, fx, fy, fz, upx, upy, upz);

	//Correcting the Y View Vector 
	//u = v x f
	GLdouble ux, uy, uz;
	cross_product(&ux, &uy, &uz, vx, vy, vz, fx, fy, fz);

	// Perpective View Transformation Matrix
	GLdouble look_at_Matrix[16] =
	{ vx, ux, -fx, 0,
	vy, uy, -fy, 0,
	vz, uz, -fz, 0,
	0, 0, 0, 1 };

	glMultMatrixd(look_at_Matrix);

	// Moving the eye to the camera origin
	imp_my_glTranslated(-eyeX, -eyeY, -eyeZ);
}


void imp_my_glFrustum(GLdouble left, GLdouble right, GLdouble bottom,GLdouble top, GLdouble zNear, GLdouble zFar)
{
	GLdouble a = (right + left) / (right - left);
	GLdouble b = (top + bottom) / (top - bottom);
	GLdouble c = -((zFar + zNear) / (zFar - zNear));
	GLdouble d = -((2 * zFar * zNear) / (zFar - zNear));

	GLdouble frustum_matrix[16] = {
		2 * zNear / (right - left), 0, 0, 0,
		0, 2 * zNear / (top - bottom), 0, 0,
		a, b, c, -1,
		0, 0, d, 0 };
	glMultMatrixd(frustum_matrix);
}

void imp_my_gluPerspective(GLdouble fov, GLdouble aspect,GLdouble zNear, GLdouble zFar)
{
	GLdouble left, right, top, bottom;

	top = zNear * tan(fov * 3.14 / 360);
	bottom = -top;
	left = bottom * aspect;
	right = top * aspect;

	imp_my_glFrustum(left, right, bottom, top, zNear, zFar);
}

// Some other helper functions for vector multiplications. 
void multVector(Vector3f u, const Matrix4f m, const Vector3f v)
{
	int i, j;
	float tmp;

	for (j = 0; j < 3; j++) {
		tmp = 0.0;
		for (i = 0; i < 3; i++)
			tmp += v[i] * m[j][i];
		tmp += m[j][3];
		u[j] = tmp;
	}
}

// Convertint the model view matrix from a column vector to a matrix
void getMatrixFromVector(Matrix4f res, float* M){
	for (unsigned int i = 0; i < 3; ++i){
		res[i][3] = 0;
		res[3][i] = 0;
		for (unsigned int j = 0; j < 3; j++) {
			res[i][j] = M[i * 4 + j];
		}
	}
	res[3][3] = 1;
}



