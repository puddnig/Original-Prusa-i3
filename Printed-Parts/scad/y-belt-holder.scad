// PRUSA iteration4
// Y belt holder
// GNU GPL v3
// Rewritten 2018 <puddnig@gmail.com>
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <polyholes.scad>
use<fdmtools.scad>
include <variables.scad>


module bolthole(){
    rotate([0,90,0]){
        translate([-ybelth_thickn/2,(ybelth_bolt_distance-ybelth_bolt_adjust)/2,0]){
            translate ([0,0,-ybelth_bolt_clamplen])mirror([0,0,1])rotate([0,0,90])longhole(ybelth_bolt_adjust,1.94*m3_through_dia,30);
            translate ([0,0,1])mirror([0,0,1])rotate([0,0,90])longhole(ybelth_bolt_adjust,m3_through_dia,30);
            
        }
    }
}
module toothedslot(dist){
    translate([-dist,ybelth_grabwidth/2+0.5,(ybelth_thickn-belt_width)/2])rotate([0,0,270])toothslot(ybelth_grabwidth+2,belt_slot_height,belt_tooth_height);
    
}
module add(){
    translate([-ybelth_flange,-(ybelth_bolt_distance+ybelth_bolt_adjust+9)/2,0]) cube([ybelth_flange,ybelth_bolt_distance+ybelth_bolt_adjust+9,ybelth_thickn]);
    translate([-ybelth_lower-belt_slot_height-ybelth_flange/2,-ybelth_grabwidth/2,0])cube([ybelth_lower+belt_slot_height+ybelth_flange/2,ybelth_grabwidth,ybelth_thickn/2-belt_width/2+8]);
}
module cut(){
    bolthole();
    mirror([0,1,0])bolthole();
    toothedslot(ybelth_upper);
    toothedslot(ybelth_lower);
    
    translate([-ybelth_flange,0,ybelth_thickn])rotate([0,0,90])chamfer(1,200);
        translate([-ybelth_lower-belt_slot_height-ybelth_flange/2,0,ybelth_thickn/2-belt_width/2+8])rotate([0,0,90])chamfer(2,200);
    translate([-ybelth_flange,-(ybelth_bolt_distance+ybelth_bolt_adjust+9)/2,0])rotate([0,90,0])chamfer(1,50);
    translate([-ybelth_flange,(ybelth_bolt_distance+ybelth_bolt_adjust+9)/2,0])rotate([0,90,0])chamfer(1,50);
       translate([-ybelth_lower-belt_slot_height-ybelth_flange/2,-ybelth_grabwidth/2,0])rotate([0,90,0])chamfer(2,50);
    translate([-ybelth_lower-belt_slot_height-ybelth_flange/2,ybelth_grabwidth/2,0])rotate([0,90,0])chamfer(2,50);

}
    difference(){add(); cut();}
