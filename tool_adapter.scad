$fa = 1;
$fs = 0.1;

iota = 5;
thickness = 8;
screw_space_x = 40;
screw_space_z = 56;
screw_diameter = 5.5;
plate_x = 70;
plate_z = 80;
plate_y =  thickness;

tool_diameter = 20;
tool_z = 30;

label_size = 8;
label_font = "Tahoma";
label_thickness = 1;
label1_z = tool_diameter + 40;
label1_text = "Jaded";
label2_z = tool_diameter + 20;
label2_text = "Jabberwocky";

union() {
  difference() {
    plate();
    screw_holes();
  }
  difference() {
    tool();
    tool_screws();
  }
  label();
}

module plate() {
  scale([plate_x, plate_y, plate_z])
    translate([0, 0, 0.5])
      cube(center=true);
}

module screw_holes() {
  phz = plate_z / 2;
  shx = screw_space_x / 2;
  shz = screw_space_z / 2;

  translate([shx, 0, phz + shz])
    rotate([90, 0, 0])
      cylinder(d = screw_diameter, h = plate_y + iota, center = true);
  translate([shx, 0, phz - shz])
    rotate([90, 0, 0])
      cylinder(d = screw_diameter, h = plate_y + iota, center = true);
  translate([-shx, 0, phz + shz])
    rotate([90, 0, 0])
      cylinder(d = screw_diameter, h = plate_y + iota, center = true);
  translate([-shx, 0, phz - shz])
    rotate([90, 0, 0])
      cylinder(d = screw_diameter, h = plate_y + iota, center = true);
}

module tool() {
  r = tool_diameter / 2;
  hz = tool_z / 2;

  difference() {
    union() {
      translate([0, (r + thickness) / 2, hz])
        scale([tool_diameter + thickness, tool_diameter / 2 + thickness, tool_z])
          cube(center = true);
      translate([0, r + thickness, hz])
        cylinder(d = tool_diameter + thickness, h = tool_z, center = true);
    }
    translate([0, r + thickness, hz])
      cylinder(d = tool_diameter, h = tool_z + iota, center=true);
  }
}

module tool_screws() {
  translate([0, thickness + tool_diameter, tool_z / 3])
    rotate([90, 0, 0])
      cylinder(d = screw_diameter, h = thickness + iota, center = true);
  translate([0, thickness + tool_diameter, tool_z * 2 / 3])
    rotate([90, 0, 0])
      cylinder(d = screw_diameter, h = thickness + iota, center = true);
}

module label() {
  translate([0, thickness/2, label1_z])
    scale([-1, -1, 1])
      rotate([90, 0, 0])
        linear_extrude(label_thickness)
          text(
            text = label1_text,
            size = label_size,
            font = label_font,
            valign = "center",
            halign = "center");

  translate([0, thickness/2, label2_z])
    scale([-1, -1, 1])
      rotate([90, 0, 0])
        linear_extrude(label_thickness)
          text(
            text = label2_text,
            size = label_size,
            font = label_font,
            valign = "center",
            halign = "center");
}

