// GNU GPL v3
// 2018 <puddnig@gmail.com>


use <polyholes.scad>

infill_width=0.2;
infill_distance=0.9;

function nfills(x1,x2)=floor((x1-x2)/infill_distance);
function xdiff(x1,x2)=(x1-x2)-(nfills(x1,x2)-1)*infill_distance-infill_width;
module hollow_cube(y,z){
    cube([infill_width,y,z]);
}

module infill_cube(x,y,z){
    for (a=[0:infill_distance:nfills(x,0)*infill_distance-0.0001]) 
    translate(v=[a+xdiff(x,0)/2,infill_width,infill_width] )hollow_cube(y-2*infill_width,z-2*infill_width);
}


module wall_cylinder(dd1,hh){
    difference() {
       
        cylinder (d=dd1+2*infill_width,h=hh, $fn=sides(dd1/2));
        translate ([0,0,-hh/2]) cylinder (d=dd1,h=2*hh, $fn=sides(dd1/2) );
        }
    }
    
module infill_cylinder (dd1,dd2,hh) //dd1>dd2
    {
    rout=dd1/2;
    rin=dd2/2;
    for (a=[rin:infill_distance:nfills(rout,0)*infill_distance-0.0001]) translate([0,0,infill_width])
        wall_cylinder(2*a+xdiff(rout,0)/2,hh-2*infill_width);
    }
    
//infill_cylinder(21,14,10);  
//infill_cube(16,10,10);
module longhole(length,dia,hh){
    union(){
    cylinder(d=dia,h=hh,$fn=25);
    translate([length,0,0])cylinder(d=dia,h=hh,$fn=25);
    translate([0,-dia/2,0])cube([length,dia,hh]);
    }
}

module longhole_taper(length,dia1,dia2,hh){
    cylinder(d1=dia1,d2=dia2,h=hh,$fn=25);
    translate([length,0,0])cylinder(d1=dia1,d2=dia2,h=hh,$fn=25);
    rotate([90,0,90]) linear_extrude(height=length) polygon( points=[[-dia1/2,0],[dia1/2,0],[dia2/2,hh],[-dia2/2,hh]] );
}

module chamfer(xx,width){
    rotate([45,0,0])cube([width,1.41*xx,1.41*xx],center=true);
}

module toothslot(length,sh,th){
    module tooth(){
        rotate([90,0,90])translate([0,0,1])difference(){
            linear_extrude(height=2.001,center=true) polygon([[0,0],[0,9],[sh+2.693,9],[sh+0.215,6.523],[sh,4.062],[sh,0]]);
            linear_extrude(height=1.5) polygon([[th,-1],[th,4.642],[0.815*th,7.18],[0.16,8],[-0.843,8],[-0.843,-1]]);
        }
    }
    for(a=[0:2:length-2]) translate([a,-sh,0]) tooth();
}
//toothslot(30,1.95,1.25);


module fillet(radius,height){
    translate([-radius,-radius,0]){
    difference(){
    translate([0,0,-height/2])cube([1.2*radius,1.2*radius,height]);
    cylinder(r=radius,h=height*1.1,center=true,$fn=sides(2*radius));
    }
}
}

//fillet(10,30);

module hexhole_bottom(din,dout,dep,lh){
module layer(){
translate([din/2,-dout/2,dep])cube([dout-din,dout,2.1*lh]);
translate([-3*din/2,-dout/2,dep])cube([dout-din,dout,2.1*lh]);
}
module corner(){
translate([0.05*dout,0,-1])cylinder(d=dout*0.99,h=dep+1+2*lh,$fn=3);
}
difference(){
    union(){
        cylinder(d=din,h=30,$fn=25);
translate([0,0,-1])cylinder(d=dout,h=dep+1+2*lh,$fn=6);
        for(a=[1:1:6])rotate([0,0,a*60])corner();
    }
layer();
rotate([0,0,90])translate([0,0,lh])layer();
}

translate([0,0,-1.01])cylinder(d1=dout*1.3,d2=dout*0.99,h=2.3,$fn=6);
}
module hole_bottom(din,dout,dep,lh){
module layer(){
translate([din/2,-dout/2,dep])cube([dout-din,dout,2.1*lh]);
translate([-3*din/2,-dout/2,dep])cube([dout-din,dout,2.1*lh]);
}
difference(){
translate([0,0,-1])cylinder(d=dout,h=dep+1+2*lh,$fn=20);
layer();
rotate([0,0,90])translate([0,0,lh])layer();
}

translate([0,0,-1.01])cylinder(d1=dout*1.3,d2=dout*0.99,h=2.3,$fn=20);
}
hole_bottom(3.2,6.4,6,0.25);


