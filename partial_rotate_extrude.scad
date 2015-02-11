/*
This file has been modified from http://www.thingiverse.com/thing:34027

Technical comments:

I added two dimensions to axial_range, so we can select the height of the pie slice too (with previous version this was a fixed value or a value dependand on the radius, which is not good)

I modified the pie_slice parameter used in partial_rotate_extrude. If angle never go above 360 (which seems logical), we can use a 4 side pie_slice is the minimum needed for a proper partial extrude. With 4 slice, we also need to have a pie_slice of radius at least sqrt(2)*(radius+axial_range[0]).
sqrt(2) is about 1.42, I used 1.5 to simplify.

*/

module pie_slice(radius, height, angle, step) {
  for(theta = [0:step:angle-step]) {
      linear_extrude(2*height, center=true)
        polygon( points = [ [0, 0],
                            [radius*cos(theta+step), radius*sin(theta+step)],
                            [radius*cos(theta), radius*sin(theta)] ]);
  }
}

module partial_rotate_extrude(angle, radius, axial_range, convex) {
  // axial_range is a vector [max_x, max_y]
  // It represent the extremum in x and y of the extrude 2D shape
  intersection () {
    rotate_extrude(convexity=convex)
      translate([radius,0,0])
        children(0);
    pie_slice(1.5*(radius+axial_range[0]), axial_range[1], angle, angle/4);
  }
}


// Testing
echo("##########");
echo("In partial_rotate_extrude.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");
