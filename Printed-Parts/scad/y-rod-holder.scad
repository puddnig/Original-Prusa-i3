// PRUSA iteration4
// Y holder front
// GNU GPL v3
// 2018 <puddnig@gmail.com>
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include<variables.scad>
use<fdmtools.scad>
use<polyholes.scad>


module hole(){
translate([0,0,-1])cylinder(d=m3_through_dia,h=8.5,$fn=20);
translate([0,0,yrh_nut_in])rotate([0,0,90])quad_hole_bottom(m3_through_dia,square_nut_w,square_nut_d,0.4);
translate([-square_nut_w/2,-8+square_nut_w/2,yrh_nut_in])cube([square_nut_w,8,square_nut_d]);}

module add(){
    translate([-yrh_width/2,0,0])cube([yrh_width,yrh_height,yrh_depth]);
    translate([0,0,yrh_depth-3])cube([yrh_ext_slot,4,6],center=true);
}
module cut(){
    translate([0,-2,yrh_depth-6])chamfer(2,yrh_ext_slot+1);
translate([0,-2,yrh_depth])chamfer(2,yrh_ext_slot+1);
    //rod
    translate([0,yrod_to_ext,-1])poly_cylinder(r=rp_dia/2,h=yrh_depth+2);
translate([0,yrod_to_ext,-0.5])cylinder(d1=rp_dia+1.5,d2=rp_dia,h=2);
translate([0,yrod_to_ext,yrh_depth-1.5])cylinder(d2=rp_dia+1.5,d1=rp_dia,h=2);
    //mount
    translate([yrh_hole_spacing/2,yrh_hole_height,0])hole();
    translate([-yrh_hole_spacing/2,yrh_hole_height,0])hole();
    //fillet
    translate([yrh_width/2,yrh_height,yrh_depth/2])rotate([0,0,0])fillet(8,yrh_depth+1);
translate([-yrh_width/2,yrh_height,yrh_depth/2])rotate([0,0,90])fillet(8,yrh_depth+1);
    translate([0,yrh_height,yrh_depth/2])cube([1,5,15],center=true);


}
difference(){add();cut();}









