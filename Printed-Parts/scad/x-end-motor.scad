// PRUSA iteration4
// X end motor
// GNU GPL v3
// 2018 <puddnig@gmail.com>
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <x-end.scad>
include<variables.scad>
use<fdmtools.scad>
use<polyholes.scad>

xstepper_z_distance=-rod_xz_distance+belt_offset+cube_width/2;
module xstepper_holes(hh,dd){
    rotate([-90,0,90]){
        for (a=nema17_pattern) translate(a) longhole(tighten_range,dd,hh);     
    }
}
module xstepper_holes_chamfer(hh,dd1,dd2){
    rotate([-90,0,90]){
        for (a=nema17_pattern) translate(a) longhole_taper(tighten_range,dd1,dd2,hh);     
    }
}

module cut(){
    translate([0,xstepper_setback,xstepper_height]){
        xstepper_holes(50,m3_through_dia);
        translate ([xstepper_z_distance+0.02,0,0])xstepper_holes_chamfer(cube_width+belt_offset-xstepper_guide_setback+xstepper_bolt_depth-xstepper_bolt_length,10,6);
        
        rotate([-90,0,90]) longhole(5,xstepper_cutout_dia,50);
    }
    translate([-50,rear_flange_distance,-0.1]) cube([100,50,100]);
    translate([-50,xstepper_setback,xstepper_height+5]) cube(100,100,100);
    rf=-rod_xz_distance-cube_width/2;
    sg=xstepper_guide_setback+0.01;
    translate([0,0,8])linear_extrude(height=100) polygon( points=[[rf+sg,bearing_diameter/2],[rf+sg,100],[rf+sg-10,100],[rf+sg-10,-30]] );

    //adding chamfers
    translate([0,xstepper_setback,cube_height])chamfer(6,100);
    translate([0,xstepper_setback,xstepper_height+xstepper_cutout_dia*0.45])chamfer(4,100);
    translate([0,rear_flange_distance,xstepper_height+5])chamfer(2,100);
    translate([0,xstepper_setback+tighten_range+xstepper_cutout_dia/2-2,xstepper_height+5])chamfer(5,100);

}
module add(){
    x_end(rear_flange_distance,-3,xstepper_height);
    translate([xstepper_z_distance,xstepper_setback,xstepper_height])xstepper_holes(17,10);
    translate([-belt_offset+xstepper_z_distance-cube_width-0.01,bearing_diameter/2,0])cube([belt_offset+0.01,rear_flange_distance,cube_height]);
    translate([-belt_offset+xstepper_z_distance,bearing_diameter/2,0])cube([belt_offset+0.01,rear_flange_distance,cube_height]);
    
    
    translate([-cube_width+xstepper_z_distance-belt_offset,rear_flange_distance-1.5*cube_width+0.001,0])cube([cube_width,1.5*cube_width,cube_height]);
}

difference(){
    add();
    cut();
}