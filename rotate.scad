/*
This function respond to an issue when rotating by multiples of 90 degree.
See this issue on github: https://github.com/openscad/openscad/issues/517
*/

function cos_n(a) = a%90?cos(a):round(cos(a));
function sin_n(a) = a%90?sin(a):round(sin(a));

module rotate(a) {
  cx = cos_n(a[0]);
  cy = cos_n(a[1]);
  cz = cos_n(a[2]);
  sx = sin_n(a[0]);
  sy = sin_n(a[1]);
  sz = sin_n(a[2]);

  multmatrix([  [cy*cz,cz*sx*sy-cx*sz,cx*cz*sy+sx*sz,0],
                [cy*sz,cx*cz+sx*sy*sz,-cz*sx+cx*sy*sz,0],
                [-sy,cy*sx,cx*cy,0],
                [0,0,0,1] ])

  for(i = [0 : $children - 1])
    children(i);
}

// Testing
echo("##########");
echo("In rotate.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");
