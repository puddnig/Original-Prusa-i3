// PRUSA iteration4
// Z axis bottom holder
// GNU GPL v3
// 2018 <puddnig@gmail.com>
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include<variables.scad>
use<fdmtools.scad>
use<polyholes.scad>


module stepbolt(){
translate([-1,0,-1])longhole(2,m3_through_dia,15);
translate([-1,0,ymh_bolt_clamping_length_stepper])longhole(2,1.8*m3_through_dia,10);
    }
module hexhole(){
rotate([0,90,0]){
cylinder(d=m3_through_dia,h=30,center=true,$fn=25);
translate([0,0,ymh_bolt_clamping_length_frame])cylinder(d=hex_nut_od,h=20,$fn=6);
translate([0,0,ymh_bolt_clamping_length_frame+2])cylinder(d1=hex_nut_od,d2=hex_nut_od+2,h=5,$fn=6);}
}
module add(){
translate([-ymh_stepper_in,-ymh_stepper_down,0])cube([xstepper_width,ymh_height,ymh_width]);
}
module cut(){
    translate([-ymh_stepper_in+ymh_flange,-50,ymh_flange])difference(){
    cube([100,100,40]);
        rotate([90,180,0])fillet(5,250);
    }
    translate([xstepper_bolt_distance/2,xstepper_bolt_distance/2,0]) stepbolt();
    translate([-xstepper_bolt_distance/2,-xstepper_bolt_distance/2,0]) stepbolt();
    translate([0,0,-1])cylinder(d=xstepper_cutout_dia+1,h=50);
    translate([-8,-50+8,-1])cube([50,50,50]);
    //upper notch
    translate([-30,ymh_bolt_height-ymh_stepper_down-5,ymh_flange])difference(){
translate([0,-50,0])cube([50,50,50]);
rotate([0,90,0])fillet(3,100);
        
}
translate([xstepper_width-ymh_stepper_down,ymh_height-ymh_stepper_down,0])rotate([0,0,0])fillet(7,50);
translate([xstepper_width-ymh_stepper_down,8,0])rotate([0,0,-90])fillet(4,50);
translate([-8,-ymh_stepper_down,0])rotate([0,0,-90])fillet(4,50);
//chamfers
translate([-xstepper_width/2,ymh_bolt_height-ymh_stepper_down-5,ymh_width])chamfer(4,30);
translate([-xstepper_width/2,ymh_height-ymh_stepper_down,ymh_width])chamfer(4,30);
        translate([-ymh_stepper_in,-ymh_stepper_down+ymh_bolt_height,ymh_stepper_side])hexhole();
        translate([-ymh_stepper_in,-ymh_stepper_down+ymh_bolt_height+ymh_bolt_distance,ymh_stepper_side])hexhole();
}

difference(){add(); cut();}






    
    
