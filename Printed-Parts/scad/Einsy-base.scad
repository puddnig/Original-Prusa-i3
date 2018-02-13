// PRUSA iteration4
// einsy base
// GNU GPL v3
// 2018 <puddnig@gmail.com>
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include<variables.scad>
include<variables_einsy.scad>
use<fdmtools.scad>
use<polyholes.scad>



module quarter_eighth(hh){
intersection(){
rotate([0,0,360/16])cylinder(d=11,h=hh,$fn=8);
translate([0,0,0.5])cube([11,11,hh]);}
}  
module mount_hole(){
translate([0,0,12])chamfer(4,15);
rotate([0,-90,0])translate([case_mount_height,0,]){
cylinder(d=m3_through_dia,$fn=25,h=15,center=true);
translate([5,0,0])cube([10,m3_through_dia-0.2,15],center=true);
}
}
module cutcube(){
rotate([0,0,-30])translate([0,-20,-1])cube([20,20,side_height+2]);}
module cutcube2(){
rotate([-60,0,-55])translate([-15,0,-1])cube([40,15,30]);}
module nylonfila(dout,thickn){
translate([-dout/2+3,0,-10-thickn])rotate([0,0,270])difference(){
    union(){
translate([0.12*dout,0,0])cylinder(d=2.2*nylon_fila,h=7,$fn=6);
        //translate([-3.5,-2.5,0])cube([7,2,7]);
    }
    translate([0.12*dout,0,-0.5])cylinder(d=nylon_fila,h=8,$fn=20);
    translate([0,8.2,5])rotate([20,0,0])cube([10,10,10],center=true);
    
}
}
module cable_add(dia,thickn,down){
    cylinder(h=5,d=13+dia,$fn=6);
translate([0,0,5])cylinder(h=4,d1=dia+13,d2=2*dia-6,$fn=6);
    translate([0,0,-10-thickn])cylinder(d1=1.3*dia,d2=2*dia,$fn=6,h=10);
    nylonfila(dia,thickn);
    translate([0,-dia/2-4.5])intersection(){
chamfer(5.3,15);
    translate([-dia/4-3.25,-6,0])cube([dia/2+6.5,6,6]);}
}

module cable_cut(dia,thickn,down) {
    difference(){union(){
        translate([-dia,4,0.01])cube([2*dia,dia/2+5,12]);
    translate([0,0,0.5])difference(){
        cylinder(d=dia+7.5,h=zip_height);
        cylinder(d=dia+2.5,h=zip_height);
    }
    cylinder(d=dia,h=35,center=true);
    translate([-dia/2+3,-dia,-13-thickn])cube([1.3*dia,2*dia,13]);
    translate([0,10,0])cube([6,20,25],center=true);
    translate([-10,down,-12])cube([20,10,25]);
    translate([-15,0,-20-thickn])cube(20,1,10);
        translate([3,down,0])rotate([90,90,])chamfer(2,10);
translate([-3,down,0])rotate([90,90,])chamfer(2,20);
}nylonfila(dia,thickn);}
}
    module vent(){
        difference(){
            for(a=[0:1:vent_n-1])
            translate([0,a*vent_spacing,-0.1])cube([vent_width,vent_height,5]);
            for(b=[1:1:vent_rib_n])
            translate([(b*vent_width/(vent_rib_n+1))-vent_rib_width/2,-0.5,vent_rib_height])cube([vent_rib_width,(vent_n-1)*vent_spacing+1+vent_height,5]);
        }
    }
    module hexmount(a=0){
        translate(einsy_mount_coord)translate([0,0,case_thickn-0.1])rotate([0,0,a])cylinder(h=einsy_mount_height+0.1,d=einsy_mount_dia,$fn=6);}
    module support(){
        difference(){
        translate([0,0,case_thickn])cube([case_width,supp_width,case_thickn]);
        translate([case_width/2,supp_width/2,case_thickn])cube([einsy_bolt_width-16,supp_width-2*case_thickn,2.1*case_thickn],center=true);
        }
}

    module add_base(){
        cube([case_width,case_height,case_thickn]);
        translate([0,0,0])hexmount();
        translate([einsy_bolt_width,0,0])hexmount();
        translate([0,einsy_bolt_height,0])hexmount(30);
        translate([einsy_bolt_width,einsy_bolt_height,0])hexmount(30);
        translate([0,einsy_mount_coord.x-supp_width/2,0])support();
        translate([0,case_height-supp_width-case_thickn_top,0])support();
        //Walls
        translate([0,case_height-case_thickn_top,0])cube([case_width, case_thickn_top,side_height])    ;
        translate([case_width-case_thickn,0,0])cube([case_thickn,case_height,side_height])    ;
        cube([2*case_thickn,case_height,11]);
        //Wall Reinforcements
         translate([0,case_height-case_thickn_top,0])rotate([0,0,270])quarter_eighth(side_height);   
 translate([case_width-case_thickn,case_height-case_thickn_top,0])rotate([0,0,180])quarter_eighth(side_height); 
 translate([case_width-case_thickn,closing_hole_height,0])rotate([0,0,180])quarter_eighth(side_height); 
 translate([case_width-case_thickn,closing_hole_height,0])rotate([0,0,90])quarter_eighth(side_height); 
translate([case_width-case_thickn,center_lower,0])rotate([0,0,180])quarter_eighth(side_height);
       translate([case_width-case_thickn,center_lower,0])rotate([0,0,90])quarter_eighth(side_height); 
//Center cylinders
        
translate([case_width-center_in,center_lower,side_height])cylinder(d1=center.x,d2=center.y,h=center.z,$fn=20);
translate([case_width-center_in,case_height-center_in,side_height])cylinder(d1=center.x,d2=center.y,h=center.z,$fn=20);

 
translate([3,x_cable_height,2.5])difference(){
rotate([0,0,30])cylinder(d=x_cable_out+2*case_thickn,h=5,center=true,$fn=6);
    translate([-5,0,-0.05])cube([10,15,6],center=true);}

    //e_cable_reinf
            translate([e_cable_in,case_height,side_height-e_cable_out_back])rotate([90,0,180])cable_add(e_cable_out,case_thickn_top,e_cable_out_back);
    
    //Heater_cable_out
    translate([case_width,h_cable_up,side_height-h_cable_out_back])rotate([90,0,90])cable_add(h_cable_out,case_thickn,h_cable_out_back);
    
    //upper corner support
        translate([case_width-case_thickn,case_height-25-case_thickn_top,case_thickn])rotate([0,0,90])intersection(){
    cube([25,8,8]);
    translate([12.5,0,0])chamfer(8,25);}

    }
    
    module cut_base(){
        translate(vent_coord)vent();
        translate(vent_thinning_coord)cube([vent_thinning_width,vent_thinning_height,2]);
        //Einsy mount holes
     translate([einsy_mount_coord.x,einsy_mount_coord.y])hexhole_bottom(m3_through_dia,hex_nut_od,einsy_mount_bolt_recess,layer_height);
translate([einsy_mount_coord.x,einsy_mount_coord.y+einsy_bolt_height])hexhole_bottom(m3_through_dia,hex_nut_od,einsy_mount_bolt_recess,layer_height);
translate([einsy_mount_coord.x+einsy_bolt_width,einsy_mount_coord.y])hexhole_bottom(m3_through_dia,hex_nut_od,einsy_mount_bolt_recess,layer_height);
translate([einsy_mount_coord.x+einsy_bolt_width,einsy_mount_coord.y+einsy_bolt_height])hexhole_bottom(m3_through_dia,hex_nut_od,einsy_mount_bolt_recess,layer_height);   
    //mounting holes
        translate([0,case_mount_lower,0])mount_hole();
        translate([0,case_mount_lower+case_mount_dist]){
            mount_hole();
            translate([10,0,-1])longhole(24,4,5);
        }
        
       //cutout to frame
        translate([-1,case_mount_lower+15,5])cube([6,case_mount_dist-30,10]);
translate([2,case_mount_lower+15,11])chamfer(6,7);
translate([2,case_mount_lower+case_mount_dist-15,11])chamfer(6,7);
        
            translate([3,x_cable_height,3])rotate([0,0,30])cylinder(d=x_cable_out,h=15,center=true,$fn=6); 
      //e cable out
              translate([e_cable_in,case_height,side_height-e_cable_out_back])rotate([90,0,180])cable_cut(e_cable_out,case_thickn_top,e_cable_out_back);  
        
        translate([usb_port_coord.x,case_height-1.5*case_thickn_top,usb_port_coord.y])cube([usb_port.x,2*case_thickn_top,usb_port.y]);
        translate([round_port_coord.x,case_height,round_port_coord.y])rotate([90,0,0])cylinder(h=10,d=round_port,$fn=20,center=true);
        //closing hole
        translate([case_width-closing_hole_in,closing_hole_height,-1]){
            cylinder(h=side_height+2,d=closing_hole,$fn=25);
            hole_bottom(closing_hole,1.6*closing_hole,closing_hole_up,layer_height);
        }
        
        //Heater_cable out
        translate([case_width,h_cable_up,side_height-h_cable_out_back])rotate([90,0,90])cable_cut(h_cable_out,case_thickn,h_cable_out_back);
        //lower_corner
        translate([case_width,corner_cut,0])cutcube();
        translate([case_width-corner_cut,case_height-corner_cut,-3])cutcube2();
    }
    difference(){add_base(); cut_base();}