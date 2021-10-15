$fa = 1;
$fs = 0.1;

iota = 1;
thickness = 8;
screw_space_x = 40;
screw_space_z = 56;
screw_diameter = 5.5;
plate_x = screw_space_x + screw_diameter + thickness * 2;
plate_z = screw_space_z + screw_diameter + thickness * 2;
plate_y = thickness;

tool_diameter = 20;
tool_z = 30;
support_z = 2;

label_size = 6;
label_font = "Tahoma";
label_thickness = 1;
label1_z = tool_diameter + 30;
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
  hpx = plate_x / 2;
  ht = thickness / 2;

  difference() {
    union() {
      // Rectangular back half of tool
      translate([0, (r + thickness) / 2, hz])
        scale([tool_diameter + thickness, tool_diameter / 2 + thickness, tool_z])
          cube(center = true);
      // Extra surface area for bed adhesion
      linear_extrude(support_z)
        polygon(points = [
          [-hpx, ht],
          [-(screw_diameter + thickness) / 2, tool_diameter + thickness * 2],
          [(screw_diameter + thickness) / 2, tool_diameter + thickness * 2],
          [hpx, ht]
        ]);
      // Screw hole rectangle in front of tool
      translate([0, tool_diameter + thickness * 1.5, hz])
        scale([screw_diameter + thickness, thickness, tool_z])
          cube(center = true);
      // Outer cylinder of tool
      translate([0, r + thickness, hz])
        scale([tool_diameter + thickness, tool_diameter + thickness, 1])
          cylinder(d = 1, h = tool_z, center = true);
    }
    translate([0, r + thickness, hz])
      scale([tool_diameter, tool_diameter, 1])
        cylinder(d = 1, h = tool_z + iota, center=true);
  }
}

module tool_screws() {
  translate([0, thickness * 1.5 + tool_diameter, tool_z / 3])
    rotate([90, 0, 0])
      cylinder(d = screw_diameter, h = thickness + iota*2, center = true);
  translate([0, thickness * 1.5 + tool_diameter, tool_z * 2 / 3])
    rotate([90, 0, 0])
      cylinder(d = screw_diameter, h = thickness + iota*2, center = true);
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

