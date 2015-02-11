//Draw a line with given width in XY plane with given height
//in Z direction from point 1 to point 2
module thickLine(pt1=[0,0], pt2=[1,0], width=1, height=1) {
        dist = sqrt(
                (pt1[0]-pt2[0])*(pt1[0]-pt2[0])+
                (pt1[1]-pt2[1])*(pt1[1]-pt2[1]));
        translate([pt1[0],pt1[1],0])
        rotate(atan2(pt2[1]-pt1[1], pt2[0]-pt1[0]))
        translate([0,-width/2,0])
        cube([dist, width, height]);
}

// Testing
echo("##########");
echo("In thickLine.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

p=1;
if (p==1){
  thickLine(pt1=[0,0], pt2=[0,2], width=1, height=1);
  thickLine(pt1=[0,0], pt2=[2,0], width=1, height=1);
  thickLine(pt1=[10,0], pt2=[0,10], width=2, height=1);
}
