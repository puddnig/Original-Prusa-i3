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



module zat(){
module cut(){
    translate([zrod_frame_distance,-zat_bolt_to_rod,zat_bolt_frame_top-zat_bolt_to_rp]){poly_cylinder(r=rp_dia/2,h=20,n=25);//rod holder
        translate([0,nut_offset,0])cylinder(d=zat_tr_dia,h=20,$fn=25);//cutout for threaded rod
        translate([0,zat_bolt_to_rod,10])cube([2,nut_offset,20],center=true);//stress relieve betweet holes
    }
    
    module bolthole(){
        rotate([0,90,0]){
            cylinder(d=m3_through_dia,h=30,center=true,$fn=25);
            translate([0,0,zat_bolt_clamping]){
                cylinder(d=1.8*m3_through_dia,h=15,$fn=25);
                translate([-20,-0.9*m3_through_dia,0])cube([20,1.8*m3_through_dia,15]);
            }
        }
    }
    
    translate([0,0,zat_bolt_frame_top])bolthole();
    translate([0,zat_bolt_distance,zat_bolt_frame_top])bolthole();
    
    translate([zat_frame_flange,-(zat_pocket_outer/2+zat_bolt_to_rod-zat_brace),zat_brace]){
        difference(){
            cube([50,50,50]); rotate([90,180,0])fillet(2.5,100);
             rotate([90,180,90])fillet(2.5,100); 
            rotate([0,180,90])fillet(3.5,100);//fillet top to flange
            }
      
            
    }
    
            translate([zat_bolt_clamping,-(zat_pocket_outer/2+zat_bolt_to_rod+zat_brace),zat_bolt_frame_top+zat_bolt_to_register]){
        difference(){
            cube([50,50,50]); rotate([90,180,0])fillet(1,100);
            } 
        } 
                    translate([zat_frame_flange,nut_offset-zat_bolt_to_rod+zat_pocket_outer/2,-1]){
        difference(){
            cube([50,50,50]); rotate([0,0,180])fillet(4,100);
            } 
        }
        //Front_corners_rounded
        translate([zrod_frame_distance+zat_pocket_outer/2,-zat_bolt_to_rod-zat_pocket_outer/2,0])rotate([0,0,-90])fillet(zat_pocket_outer/2,40);
translate([zrod_frame_distance+zat_pocket_outer/2,-zat_bolt_to_rod+zat_pocket_outer/2+nut_offset,0])rotate([0,0,])fillet(zat_pocket_outer/2,40);
        rotate([0,90,0])translate([0,zat_bolt_distance+10,0])rotate([0,0,])fillet(5,40);
        translate([zrod_frame_distance,-25,zat_brace])cube([50,50,50]);
        //Oval cut
        ch=zat_bolt_frame_top-zat_brace+zat_bolt_to_register;
translate([zrod_frame_distance,0,ch+zat_brace])rotate([90,0,0])linear_extrude(height=50,center=true)scale([(zrod_frame_distance-zat_frame_flange)/ch,1]) circle(r=ch,$fn=30);
        
        //chamfer_to_frame
        module chamfer1(){
            
            
translate([-20,-25,-10])cube([20,50,40]);
}
translate([0,-zat_bolt_frame_side,0])rotate([0,0,60])chamfer1();


module chamfer2(){
        module chamfer1(){
translate([-20,-25,-15])cube([20,50,40]);
}
translate([0,-zat_bolt_frame_side,0])rotate([0,-45,60])chamfer1();}
translate([0,0,5])chamfer2();

module chamfer3(){
        module chamfer1(){
translate([-20,-25,-15])cube([20,50,40]);
}
translate([0,-zat_bolt_frame_side,0])rotate([0,45,60])chamfer1();}
translate([0,0,zat_bolt_frame_side+2])chamfer3();
}

module add(){
    translate([0,-zat_pocket_outer/2-zat_bolt_to_rod,0])cube([zrod_frame_distance+zat_pocket_outer/2,10+zat_bolt_distance+zat_pocket_outer/2+zat_bolt_to_rod,zat_bolt_frame_top+5]);
}

difference(){ add();cut();}

translate([zrod_frame_distance,-zat_bolt_to_rod,zat_brace]) difference(){
cylinder(r=correctedRadius(rp_dia/2+3,25),h=zat_brace-1.5,$fn=25);
translate([0,0,-0.005])cylinder(r1=correctedRadius(rp_dia/2,25),$fn=sides(rp_dia/2),r2=correctedRadius(rp_dia/2,25)+0.2,h=zat_brace-1.5+0.01);
    translate([-1,0,-1]) cube([2,10,10]);
    }
}
module zat_left(){translate([0,zat_pocket_outer/2+zat_bolt_to_rod+3,0]) zat();}
module zat_right(){mirror([0,1,0])zat_left();
    
   }
zat_left();
zat_right();
//missing:
//cutout for faster printing
