// Do a rounded cube, using the minkowski
module rounded_cube(x, y, h, r, center=true) {
  rounded_cube_hull(x,y,h,r,center);
}

// Do a rounded cube, using the minkowski
module rounded_cube_minkowski(x, y, h, r, center=true) {
  if (center) {
    translate([-x/2,-y/2,-h/2])
      rounded_cube_minkowski(x, y, h, r, center=false);
  } else {
    translate([r,r,0])
    minkowski() {
      cube([x-2*r,y-2*r,h/2]);
      cylinder(h=h/2, r=r);
    }
  }
}

// Do a rounded cube, using the hull method
module rounded_cube_hull(x, y, h, r, center=true) {

  dx = x-2*r;
  dy = y-2*r;

  if (center) {
    translate([-x/2,-y/2,-h/2])
      rounded_cube(x, y, h, r, false);
  } else {
    translate([r, r, 0]){
      hull() {
        hull() {
          cylinder(r=r,h=h);
          translate([dx,0,0])
          cylinder(r=r,h=h);
        }
        hull() {
          translate([0, dy, 0])
          cylinder(r=r,h=h);
          translate([dx, dy, 0])
          cylinder(r=r,h=h);
        }
      }
    }
  }
}

// Testing
echo("##########");
echo("In rounded_cube.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

/*$fn = 200;*/
p = 1;
if (p==1) {
  cylinder(r=1,h=10);
  rounded_cube(10,10,2,3,center=false);
  translate([0,0,5])
    rounded_cube_minkowski(10,10,2,3,center=false);
  translate([0,0,10])
    rounded_cube_hull(10,10,2,3,center=false);

  translate([20,0,0]) {
    cylinder(r=1,h=10);
    rounded_cube(10,10,2,3,center=true);
    translate([0,0,5])
      rounded_cube_minkowski(10,10,2,3,center=true);
    translate([0,0,10])
      rounded_cube_hull(10,10,2,3,center=true);
  }

  translate([40,0,0]) {
    difference() {
      // minkowski is slighlty bigger than hull (view CGLA in openscad)
      // I think the hull one is more clean
      // when we use a $fn big these differences decrease
      rounded_cube_minkowski(10,10,2,3,center=true);
      rounded_cube_hull(10,10,2,3,center=true);
    }
  }

  translate([60,0,0]) {
    difference() {
      // but it is not the same size than a real cube..
      // when we use a $fn big these differences decrease
      cube([10,10,2], center=true);
      rounded_cube_hull(10,10,2,3,center=true);
    }
  }
}
