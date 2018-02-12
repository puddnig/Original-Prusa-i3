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


zab_height=zab_lower_bolt+zab_bolt_spacing+zab_stepper_flange;

module bolthole(){
    rotate([0,270,0])
    
    translate([0,0,-10+zab_bolt_clamping_length+zrod_frame_distance-zab_frame_flange]){
            cylinder(d=2.1*m3_through_dia,h=10,$fn=25);
            cylinder(d=m3_through_dia,h=60,center=true,$fn=25);
        }
}
 module corner(){
     rotate([0,0,235])translate([0,-25,-1]) cube([20,50,100]);
}
 
 module zab_left(){
    translate([0,xstepper_width/2+2*zab_reinf_outer,0]) 
     difference(){
    translate([-zrod_frame_distance,-xstepper_width/2-zab_reinf_outer,0])cube([zrod_frame_distance+xstepper_width/2,xstepper_width+zab_reinf_inner+zab_reinf_outer,zab_height]); //outer cube
    difference(){
        translate([-zrod_frame_distance+zab_frame_flange,-xstepper_width/2,zab_stepper_flange])
            cube([zrod_frame_distance+xstepper_width/2,xstepper_width,zab_lower_bolt+zab_bolt_spacing+zab_frame_flange]);
            
            translate([-zrod_frame_distance+zab_frame_flange,-xstepper_width/2,zab_stepper_flange])rotate([0,90,0])chamfer(2,200);
            
        translate([-zrod_frame_distance+zab_frame_flange,xstepper_width/2,zab_stepper_flange])rotate([0,90,0])chamfer(2,200);

    }
    
    translate([0,0,-1]){
        for (a=nema17_pattern) translate(a) cylinder(d=m3_through_dia,h=15,$fn=25);
        cylinder(d=xstepper_cutout_dia,h=15);
        translate([0,-nut_offset,0]) {poly_cylinder(r=rp_dia/2,h=2*zab_stepper_flange);
            
            cylinder(d1=rp_dia+2,d2=rp_dia-2,h=4);
        }
   
    }
    translate([0,-xstepper_cutout_dia/2,0]) cube([1,3,20],center=true);
    translate([xstepper_width/2,0,zab_height])rotate([90,0,0])linear_extrude(height=2*xstepper_width,center=true)scale([(xstepper_width/2+zrod_frame_distance-zab_frame_flange)/(zab_height-zab_stepper_flange),1])circle(r=zab_height-zab_stepper_flange,$fn=50);
    
    translate([0,-zab_bolt_spacing/2,zab_lower_bolt]) bolthole();
    translate([0,zab_bolt_spacing/2,zab_lower_bolt]) bolthole();
    translate([0,0,zab_lower_bolt+zab_bolt_spacing]) bolthole();
    translate([-zrod_frame_distance+zab_frame_flange,0,zab_height])cube([2*(zab_frame_flange-zab_bolt_clamping_length),2.1*m3_through_dia,2*(zab_height-zab_lower_bolt-zab_bolt_spacing)],center=true);
    
    translate([xstepper_width/2,xstepper_width/2+zab_reinf_inner,0])rotate([0,0,0])fillet(8,30);
translate([xstepper_width/2,-xstepper_width/2-zab_reinf_outer,0])rotate([0,0,270])fillet(8,30);
    
    translate([-zrod_frame_distance,-zab_reinf_outer-xstepper_width/2,zab_height])rotate([180,-90,0])fillet(10,20);
translate([-zrod_frame_distance,zab_reinf_inner+xstepper_width/2,zab_height])rotate([0,-90,0])fillet(5,20);
    
   
translate([-zrod_frame_distance,-xstepper_width/2-zab_reinf_outer+5,0]) corner();
    
    translate([xstepper_width/2,0,0])cube([20,9,20],center=true);
}
}
module zab_right(){
    mirror([0,1,0]) zab_left();
}
zab_left();
zab_right();
