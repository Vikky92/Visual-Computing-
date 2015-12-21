/* Function Definition in the header file */
void my_glMatrixMode(GLenum mode);
void my_glPushMatrix(void);
void my_glPopMatrix(void);
void my_glLoadMatrixf(const GLfloat *m);
void my_glLoadMatrixd(const GLdouble *m);
void my_glLoadIdentity(void);
void my_glScaled(GLdouble x, GLdouble y, GLdouble z);
void my_glScalef(GLfloat x, GLfloat y, GLfloat z);
void my_glTranslated(GLdouble x, GLdouble y, GLdouble z);
void my_glTranslatef(GLfloat x, GLfloat y, GLfloat z);
void my_glRotated(GLdouble angle, GLdouble x, GLdouble y, GLdouble z);
void my_glRotatef(GLfloat angle, GLfloat x, GLfloat y, GLfloat z);
void my_gluPerspective(GLdouble fov, GLdouble aspect,GLdouble zNear, GLdouble zFar);
void my_gluLookAt(GLdouble eyeX, GLdouble eyeY, GLdouble eyeZ, GLdouble refX, GLdouble refY, GLdouble refZ,
	GLdouble upX, GLdouble upY, GLdouble upZ);


