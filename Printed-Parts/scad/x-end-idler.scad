// PRUSA iteration4
// X end idler
// GNU GPL v3
//// 2018 <puddnig@gmail.com>
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <x-end.scad>
include <variables.scad>
use <fdmtools.scad>


module pulley(){
translate([-rod_xz_distance+cube_width/2+belt_offset,idler_inward,idler_height]) rotate([0,-90,0]){
    translate([0,0,1])mirror([0,0,1])cylinder(r=3.1,h=10,$fn=30);
    cylinder(r=m3_through_dia/2,h=60,$fn=30);

    translate([0,0,cube_width/2])cylinder(d=pulley_dia,h=bs_w,center=true);  
    translate([0,0,10+cube_width-1.5])rotate([180,0,0])hexhole_bottom(m3_through_dia,lock_nut_od,10,0);
    
    //stress relief
    
    translate([-stress_relieve_height/2,-stress_relieve_offset,-0.1]) cube([stress_relieve_height,1,cube_width*1.1]);
}
}
module x_end_idler(){
    difference(){
    mirror([0,1,0])x_end(0,1,idler_height);
        pulley();
}    
}
x_end_idler();

 
