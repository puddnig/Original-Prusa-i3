use <polyholes.scad>
use <fdmtools.scad>
include <variables.scad>

cg_offset=14;

//translate([0,-nozzle_to_stepper,-1])cube([2,2,2]);
 module cgmount(){
translate([-cg_offset,-25,25]){ 
translate([-3,-3,-2])cube([6,8,2]);
cylinder(d=m3_through_dia,h=10,$fn=20,center=true);
 rotate([0,0,90])quad_hole_bottom(m3_through_dia,6,0,0.4);
}}
module add() {
translate([-cr_width/2,-bearing_holder_od/2-rod_distance+(nozzle_to_top_rod-nozzle_to_stepper),0])cube([cr_width,rod_distance+bearing_holder_od,rod_to_face]);
    //lower bearing_holder
    translate([0,-rod_distance+htr,rod_to_face]){
        translate([0,0,-rod_to_face/2])cube([cr_width,bearing_holder_od,rod_to_face],center=true);
        rotate([0,90,0])cylinder(d=bearing_holder_od,h=cr_width,center=true);
    }
    //upper_bearing_holder
        translate([0,htr,rod_to_face]){
        translate([0,0,-rod_to_face/2])cube([bearing_height,bearing_holder_od,rod_to_face],center=true);
        rotate([0,90,0])cylinder(d=bearing_holder_od,h=bearing_height,center=true);
    }
     //belt_tunnel reinf
 translate([0,-belt_to_stepper+10,rod_to_face-belt_offset+1])rotate([-10,0,0])cube([cr_width-0.01,50,10],center=true);
    //upper cable_guide_mount
     translate([-cg_offset,e_stepper_width/2+4,2+26-7])cube([10,8,14],center=true);
    //lower cable guide mount
         translate([-cg_offset,-e_stepper_width/2-4,2+26-7])cube([10,8,14],center=true);
}

module cut(){
    //lower bearing holder
translate([0,-rod_distance+htr,rod_to_face]){
    translate([0,0,10])cube([cr_width+3,6,10],center=true);//slot
    rotate([0,90,0])difference(){
    poly_cylinder(r=bearing_dia_carri/2,h=cr_width+2,center=true);
    translate([10,-0,0])cube([10,bearing_dia_carri,cr_width-2*bearing_height],center=true);
}
 }
 //upper bearing holder
 translate([0,htr,rod_to_face]){
    translate([0,0,10])cube([cr_width+3,6,10],center=true);//slot
    rotate([0,90,0])difference(){
    poly_cylinder(r=bearing_dia_carri/2,h=cr_width+2,center=true);

    }}
 //stepper_mount
 translate([0,0,25+face_thickn])difference(){
     cube([e_stepper_width,e_stepper_width,50],center=true);
     translate([e_stepper_width/2,e_stepper_width/2,0])rotate([0,90,0])chamfer(2,52);
     translate([-e_stepper_width/2,e_stepper_width/2,0])rotate([0,90,0])chamfer(2,52);
     translate([-e_stepper_width/2,-e_stepper_width/2,0])rotate([0,90,0])chamfer(2,52);
     translate([e_stepper_width/2,-e_stepper_width/2,0])rotate([0,90,0])chamfer(2,52);
 }
 translate([0,0,-1])cylinder(d=xstepper_cutout_dia,h=15);
 translate([0,0,-1]){for (a=nema17_pattern) translate(a) cylinder(d=m3_through_dia,h=15,$fn=25);}
 //belt_tunnel
 translate([0,-belt_to_stepper+1,rod_to_face-belt_offset])cube([cr_width+2,3.5,8],center=true);
 //idler belt holder
 module belt_holder(hh){
  translate([-cr_width/2+2,-5-14.6+hh,rod_to_face-belt_width/2-belt_offset])rotate([0,0,90])toothslot(20,1.95,1.25);
 translate([-cr_width/2,-belt_to_stepper-1+hh,rod_to_face-belt_offset])cube([15,2,belt_width],center=true);
 translate([-e_stepper_width/2-1.99,-2-belt_to_stepper+hh,rod_to_face-belt_offset-belt_width/2])rotate([0,0,5])cube([3,8,10]);}
 belt_holder(idler_dia_belt);
 mirror([1,0,0])belt_holder(pulley_dia_belt);
 //top chamfer
  translate([0,htr+bearing_holder_od/2,0])chamfer(8,cr_width+2);
 //bottom chamfer
   translate([0,htr-bearing_holder_od/2-rod_distance,0])chamfer(8,cr_width+2);

//top bearing_sides
  translate([bearing_height/2,htr-bearing_dia_carri/2,-1])cube([25,25,25]);
 difference(){
 translate([-bearing_height/2-25,htr-bearing_dia_carri/2,-1])cube([25,25,25]);
          translate([-cg_offset,e_stepper_width/2+4,rod_to_face+5])cube([10,8,10],center=true);}

 //cut off bottom
    translate([0,htr-rod_distance-bearing_holder_od/2])cube([60,2.2,40],center=true);
//cutout threaded rod
           translate([4.5+cr_width/2-3,0,rod_to_face-rod_xz_distance])rotate([90,0,0])cylinder(h=90,d=9,center=true,$fn=25);
          cgmount();
          mirror([0,1,0]) cgmount();
          //pinda mount
           translate([-cr_width/2,-nozzle_to_stepper+15,0]){
 translate([-1,0,4])rotate([0,90,0])cylinder(d=m3_through_dia,h=13,$fn=25);
 translate([2.5,-3,-1])cube([2,6,8]);}
 
 //chamfers
 translate([cr_width/2,htr-bearing_dia_carri/2,20])rotate([0,90,0])chamfer(3,52);
  translate([-cr_width/2,htr-bearing_dia_carri/2,20])rotate([0,90,0])chamfer(3,52);

 }

 difference(){add();cut();}


