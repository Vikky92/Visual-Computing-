/*
 * OpenGL demonstration program for ICS Computer Graphics courses
 * $Id: sceneModule.h,v 1.1 2002/04/03 00:00:47 mshafae Exp $
 *
 */

#ifndef  __SCENEMODULE_H
#define  __SCENEMODULE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <GL/glut.h>

#ifdef __cplusplus
extern "C" {
#endif

void drawScene( int r, int g, int b, int alpha);
double Normal3dv(double *v);

#ifdef __cplusplus
}
#endif

#endif
