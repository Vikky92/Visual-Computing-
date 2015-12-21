/* Here we define the function we want to implement*/
#include <GL/glut.h>

typedef float Vector3f[3];
typedef double Vector3d[3];

typedef float Vector4f[4];
typedef double Vector4d[4];

typedef float Matrix3f[3][3];
typedef double Matrix3d[3][3];

typedef float Matrix4f[4][4];
typedef double Matrix4d[4][4];

// apply 4x4 matrix to 3D vector
void multVector(Vector3f u, const Matrix4f m, const Vector3f v);
void getMatrixFromVector(Matrix4f res, float* M);
void imp_my_glLoadIdentity(void);
void imp_my_glTranslated(GLdouble x, GLdouble y, GLdouble z);
void imp_my_glTranslatef(GLfloat x, GLfloat y, GLfloat z);
void imp_my_glRotated(GLdouble angle, GLdouble x, GLdouble y, GLdouble z);
void imp_my_glRotatef(GLfloat angle, GLfloat x, GLfloat y, GLfloat z);
void imp_my_glScaled(GLdouble x, GLdouble y, GLdouble z);
void imp_my_glScalef(GLfloat x, GLfloat y, GLfloat z);
void imp_my_glFrustum(GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);
void imp_my_gluPerspective(GLdouble fov, GLdouble aspect, GLdouble zNear, GLdouble zFar);
void imp_my_gluLookAt(GLdouble eyeX, GLdouble eyeY, GLdouble eyeZ, GLdouble refX, GLdouble refY, GLdouble refZ,
	GLdouble upX, GLdouble upY, GLdouble upZ);

