// PRUSA iteration4
// Einsy doors
// GNU GPL v3
// 2018 <puddnig@gmail.com>
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org


include<variables.scad>
include<variables_einsy.scad>
use<fdmtools.scad>
use<polyholes.scad>
use<Einsy-base.scad>


    module add_door(){
        cube([case_width,case_height,case_thickn]);

        translate([0,hinge_lower_height,0])support();
        translate([0,hinge_upper_height-supp_width-case_thickn_top,0])support();
                translate([0,hinge_lower_height,case_thickn])support();
        translate([0,hinge_upper_height-supp_width-case_thickn_top,case_thickn])support();
        //Walls
        translate([0,case_height-case_thickn_top,0])cube([case_width, case_thickn_top,door_height])    ;
        translate([case_width-case_thickn,0,0])cube([case_thickn,case_height,door_height])    ;
        //Wall Reinforcements
         translate([hinge_to_frame,case_height-case_thickn_top,0])rotate([0,0,270])quarter_eighth(door_height);   
 translate([case_width-case_thickn,case_height-case_thickn_top,0])rotate([0,0,180])quarter_eighth(door_height); 
 translate([case_width-case_thickn,closing_hole_height,0])rotate([0,0,180])quarter_eighth(door_height); 
 translate([case_width-case_thickn,closing_hole_height,0])rotate([0,0,90])quarter_eighth(door_height); 
translate([case_width-case_thickn,center_lower,0])rotate([0,0,180])quarter_eighth(door_height);
       translate([case_width-case_thickn,center_lower,0])rotate([0,0,90])quarter_eighth(door_height); 
//Center cylinders
        
translate([case_width-center_in,center_lower,door_height-center.z-0.1])cylinder(d2=center.x+0.1,d1=center.y+0.1,h=center.z+0.2,$fn=20);
translate([case_width-center_in,case_height-center_in,door_height-center.z-0.1])cylinder(d2=center.x+0.1,d1=center.y+0.1,h=center.z+0.2,$fn=20);
   
    //upper corner support
        translate([case_width-case_thickn,case_height-25-case_thickn_top,case_thickn])rotate([0,0,90])intersection(){
    cube([25,9,9]);
    translate([12.5,0,0])chamfer(9,25);}
        //hinge_support
    difference(){
      cube([2*hinge_to_frame,case_height,2*hinge_to_frame]);
            translate([2*hinge_to_frame,case_height/2+1,2*hinge_to_frame])rotate([0,0,90])chamfer(4,case_height);
    }
    }  

    module cut_door(){
        difference(){
        translate(vent_coord)vent();
            translate([0,vent_coord.y+vent_n_door*vent_spacing,2*vent_rib_height])cube([case_width,50,(vent_n-vent_n_door)*vent_spacing]);
        }
 //Center cylinders
        
translate([case_width-center_in,center_lower,door_height-center.z-0.1])cylinder(d2=center.x+0.1,d1=center.y+0.1,h=center.z+0.2,$fn=20);
translate([case_width-center_in,case_height-center_in,door_height-center.z-0.1])cylinder(d2=center.x+0.1,d1=center.y+0.1,h=center.z+0.2,$fn=20);
 

        //closing hole
        translate([case_width-closing_hole_in,closing_hole_height,1]){
            cylinder(h=door_height+2,d=closing_hole,$fn=25);
        }
     
        //lower_corner
        translate([case_width,corner_cut,0])cutcube();
        translate([case_width-corner_cut,case_height-corner_cut,-3])cutcube2();
        //lower wide cut
        translate([-1,-1,-1])cube([case_width+2,hinge_lower_height+1,door_height+2]);
        //door_radius
        translate([0,(case_height+2)/2,0])rotate([-90,90,0])fillet(hinge_to_frame,case_height);
        //upper hinge
         translate([-1,hinge_upper_height,-0.5])cube([hinge_to_frame+1,case_height-hinge_upper_height+1,door_height+1]);
           translate([hinge_to_frame,hinge_upper_height-hinge_pocket,hinge_to_frame])rotate([-90,0,0])cylinder(d=hinge_inner,h=case_height-hinge_upper_height+1+hinge_pocket,$fn=25);
        //lower_hinge
                   translate([hinge_to_frame,hinge_lower_height-1,hinge_to_frame])rotate([-90,0,0])cylinder(d=hinge_inner,h=1+hinge_pocket,$fn=25);
           translate([-3*square_nut_w/2+case_width-closing_hole_in,-square_nut_w/2+closing_hole_height,-square_nut_d+door_height-closing_nut_down])cube([2*square_nut_w,square_nut_w,1.3*square_nut_d]);
  
    }
mirror([1,0,0])   difference(){add_door(); cut_door();}
   // 
   


 
    

    
    
    
    
    
    
    
    