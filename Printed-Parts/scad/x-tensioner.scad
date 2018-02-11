// GNU GPL v3
// 2018 <puddnig@gmail.com>

include<variables.scad>
use<fdmtools.scad>
use<polyholes.scad>

tens_block_width=18;
tens_block_height=18;
tens_block_depth=10;
tens_bolt_height=11;
wh=xstepper_height-xstepper_guide_height;//width half
dt=rear_flange_distance-xstepper_setback;//depth tensioner
module bolthole(){
    cylinder(d=m3_through_dia,h=50,center=true,$fn=25);
translate([0,0,-1])cylinder(d=6,h=5.5,$fn=25);
translate([-square_nut_w/2,-square_nut_w/2,6.5])cube([square_nut_w,20,square_nut_d]);
}

module cut(){
translate([0,0,-1]){for (a=nema17_pattern) translate(a) cylinder(d=m3_through_dia,h=15,$fn=25);
cylinder(d=xstepper_cutout_dia,h=15);
   
    }
     translate([dt+tens_block_depth,0,tens_bolt_height])rotate([90,0,270])bolthole();
    translate([dt+tens_block_depth/2,tens_block_width/2,tens_block_height])chamfer(5,20);
     translate([dt+tens_block_depth/2,-tens_block_width/2,tens_block_height])chamfer(5,20);
    translate([-wh,wh,0])rotate([0,90,0])chamfer(5,20);
    translate([-wh,-wh,0])rotate([0,90,0])chamfer(5,20);
    translate([-wh,0,0])rotate([0,0,90])chamfer(1,40);
    translate([-wh,0,tens_height])rotate([0,0,90])chamfer(1,40);
    translate([0,wh,0])chamfer(1,80);
    translate([0,-wh,0])chamfer(1,80);
    translate([0,wh,tens_height])chamfer(1,80);
    translate([0,-wh,tens_height])chamfer(1,80);
    translate([dt+tens_block_depth,0,0])rotate([0,0,90])chamfer(2,40);


}
module add(){
translate([0,0,tens_height/2])cube([2*(wh),2*(wh),tens_height],center=true);
    translate([dt,-9,0])cube([tens_block_depth,tens_block_width,tens_block_height]);
    linear_extrude(height=tens_height)polygon([[wh,wh],[wh,-wh],[tens_block_depth+dt,-tens_block_width/2],[tens_block_depth+dt,+tens_block_width/2]]);
    translate([dt,0,tens_height])rotate([0,0,90])chamfer(3,tens_block_width);
}

difference(){add(); cut();}

