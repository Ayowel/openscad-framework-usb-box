// unit: millimeter

/* [Render] */
// Level of detail for final render - smaller is better but slower.
render_fs = 0.01; // [0.01:0.01:5]
// Level of detail for preview window - smaller is better but slower.
preview_fs = 3; // [0.1:0.1:5]
$fs = $preview ? preview_fs : render_fs;
// Which parts to render
rendered_parts = "all"; // ["all", "body", "lid"]
render_body = rendered_parts == "all" || rendered_parts == "body";
render_lid = rendered_parts == "all" || rendered_parts == "lid";
// Whether to show the cars in the slot in the preview (will be removed from the final render)
render_preview_occupied_slots = false;

/* [Printer] */
// Dimensions of the filament - used to adapt tolerances.
filament_size = 0.6; // [0.05:0.01:1]

/* [Box] [Layout] */
// Number of slot rows.
card_rows = 3; // [1:20]
// Number of slot columns.
card_cols = 2; // [1:20]
// [row, column] Where the RJ45 slot should be located.
rj45_slot_location = [0,0];

/* [Box] [Design] */
// Whether the lid/body should have a border to keep the lid in place.
has_lid_border = true;
// Whether the lid should be hollow.
has_empty_lid_volume = false;
// Whether the box should have holes all the way through.
has_box_holes = false;
// whether the hole should be centered on the height of the a or the effective height of the current line.
box_hole_center_on = "slots"; // ["slots", "row_size"]
// Whether the box should have notches to hold the lid - requires lid borders.
has_notches = true;
// Whether the box should have a slot for a RJ45 adapter.
has_rj45_slot = true;
// Whether you should be able to stack the body on the lid once it is taken off.
is_stackable_on_lid = true;

/* [Box] [Measurements] [Internal layout]*/
// [horizontal, vertical] Space between the slots and the box's outside.
inset = [5, 5]; // [0:0.1:100]
// [horizontal, vertical] Space between each slot.
spacings = [5, 4]; // [0:0.1:100]
// Initial offset for rows.
row_offset = 8; // [0:0.1:100]

// [start line, increment, end ignore] On which lines the holes should be placed.
box_holes_location = [0, 1, 0];

/* [Box] [Measurements] [Shape]*/
// Radius of the box's corners.
box_radius = 4;
// Proportion of the bottom part relative to the total box height.
bottom_ratio = 0.65;
// How thick below the bottom of the slots the box should be.
box_bottom_thickness = 3;
// How thick above the top of the slots the box should be.
box_top_thickness = 2;

// How thick the lid's border should be.
lid_border_thickness = 1;
// How high the lid's border should be.
lid_border_height = 3;

// How high the lid's notchs should be.
lid_notch_size = 0.5;
// How wide the lid's notchs should be.
lid_notch_width = 2;
// How high the box's notchs' indents should be.
box_notch_size = 1.;
// How wide the box's notchs' indents should be.
box_notch_width = 3;

/* [Box] [Measurements] [Misc]*/
// Size of the box's holes.
box_holes_size = 5;

// How much bigger than other lines the RJ45 slot's line should be.
rj45_line_height_increase = 5;
// Relative height of the RJ45 card when in the slot.
rj45_slot_z_offset = 0;

/* [Hardware] */
// This is from the dimensions in https://github.com/FrameworkComputer/ExpansionCards/blob/main/Mechanical/OpenSCAD/ExpansionCard.scad
// Dimensions of a single slot's body (not counting the usb-c port size).
card_dimensions_base = [30., 6.8, 32.];
// Height of the USB-C plug.
usbc_slot_height = 7.5;
// Length of the USB-C plug's base. This should be >= to 8 mm and <= to the usbc slot height * the usbc slot area ratio.
usbc_slot_bottom_length = 11;
// Part of the card's length/width to use as a base for the usbc plug hole. Be carefull if you change this, the slot might be too small to accomodate the USB plug.
usbc_slot_area_ratio = [0.8, 1.]; // [0.5:0.001:1]

// The RJ45 section of the adapter.
rj45_slot_section_big = [17, 13];
// The RJ45 middle section of the adapter.
rj45_slot_section_medium = [29, 8.5];
// The RJ45 usb-c section of the adapter.
rj45_slot_section_small = [3, 6];
// The usb-c plug of the adapter - keep wider than the actual adapter to prevent snapping.
rj45_slot_section_c = [8, 2.75];
// The height of the RJ45 slot.
rj45_slot_height = 30;

/* [Hidden] */
// The points that draw the shape of the RJ45 slot
rj45_slot_shape = [
    /*
     * Shape sections
     * 11--10
     * |   9-------------8
     * | B           SM  7-6
     * | I   MEDIUM  ALL 4-5
     * | G           2---3
     * 0-------------1
     */
    [0,0],
    [rj45_slot_section_big[0] + rj45_slot_section_medium[0] + filament_size, 0],
    // 2 - start small section
    [rj45_slot_section_big[0] + rj45_slot_section_medium[0] + filament_size, rj45_slot_section_medium[1] - rj45_slot_section_small[1] - filament_size],
    [rj45_slot_section_big[0] + rj45_slot_section_medium[0] + rj45_slot_section_small[0] + filament_size, rj45_slot_section_medium[1] - rj45_slot_section_small[1] - filament_size],
    // 4 - start usb-c section
    [rj45_slot_section_big[0] + rj45_slot_section_medium[0] + rj45_slot_section_small[0] + filament_size, rj45_slot_section_medium[1] - (rj45_slot_section_small[1] + rj45_slot_section_c[1])/2 - filament_size],
    [rj45_slot_section_big[0] + rj45_slot_section_medium[0] + rj45_slot_section_small[0] + rj45_slot_section_c[0] + filament_size, rj45_slot_section_medium[1] - (rj45_slot_section_small[1] + rj45_slot_section_c[1])/2 - filament_size],
    [rj45_slot_section_big[0] + rj45_slot_section_medium[0] + rj45_slot_section_small[0] + rj45_slot_section_c[0] + filament_size, rj45_slot_section_medium[1] - (rj45_slot_section_small[1] - rj45_slot_section_c[1])/2 + filament_size],
    [rj45_slot_section_big[0] + rj45_slot_section_medium[0] + rj45_slot_section_small[0] + filament_size, rj45_slot_section_medium[1] - (rj45_slot_section_small[1] - rj45_slot_section_c[1])/2 + filament_size],
    // 8 - end usb-c section
    [rj45_slot_section_big[0] + rj45_slot_section_medium[0] + rj45_slot_section_small[0] + filament_size, rj45_slot_section_medium[1] + filament_size],
    [rj45_slot_section_big[0] + filament_size, rj45_slot_section_medium[1] + filament_size],
    [rj45_slot_section_big[0] + filament_size, rj45_slot_section_big[1] + filament_size],
    [0, rj45_slot_section_big[1] + filament_size],
];

// If we do not add an arbitrary thickness, we might end up with 0-thick walls in the preview/final render.
render_thickness_offset = $preview ? 0.01 : 0;

// The actual dimensions of the card slots.
card_dimensions = [card_dimensions_base[0]+filament_size, card_dimensions_base[1]+filament_size, card_dimensions_base[2]];

// The dimension of the box.
box_dimensions = [
    card_dimensions[0] * card_cols + spacings[0] * (card_cols - 1) + inset[0] * 2 + row_offset,
    card_dimensions[1] * card_rows + spacings[1] * (card_rows - 1) + inset[1] * 2 + (has_rj45_slot && rj45_slot_location[0] < card_rows && rj45_slot_location[1] < card_cols?rj45_line_height_increase:0),
    card_dimensions[2] + usbc_slot_height + box_bottom_thickness + box_top_thickness + filament_size,
];

slots_layout_offset = [inset[0], inset[1], box_bottom_thickness];

include <utils/roundedcube.scad>;

module rj45_card_slot(height = rj45_slot_height) {
    linear_extrude(height)
    polygon(rj45_slot_shape);
}

// A single slot's shape
module simple_card_slot() {
    translate([card_dimensions[0]/2, card_dimensions[1]/2])
    union() {
        // Remove the square for the slot's body
        translate([0,0,usbc_slot_height+card_dimensions[2]/2])
        cube(card_dimensions, center = true);
        // Free-up space for the usb plug
        scale([1., card_dimensions[1] * usbc_slot_area_ratio[1] / card_dimensions[0] / usbc_slot_area_ratio[0], 1.])
        cylinder(usbc_slot_height + filament_size + render_thickness_offset, usbc_slot_bottom_length/2, card_dimensions[0]*usbc_slot_area_ratio[0]/2);
    }
};

// All the slots in the box
module slots_layout(rows, cols, spacing = [5, 5], r_offset = 0, t_offset = slots_layout_offset) {
    translate(t_offset)
    for (i = [0:rows-1], j = [0:cols-1]) {
        if (!has_rj45_slot || i != rj45_slot_location[0] || (j != rj45_slot_location[1] && j - 1 != rj45_slot_location[1])) {
            translate([
                j * (card_dimensions[0] + spacing[0]) + (i%2) * r_offset,
                i * (card_dimensions[1] + spacing[1]) + (has_rj45_slot && i >= rj45_slot_location[0] ? rj45_line_height_increase : 0)/(i == rj45_slot_location[0]?2:1),
                0,
            ]) simple_card_slot();
        } else if (j == rj45_slot_location[1]) {
            translate([
                j * (card_dimensions[0] + spacing[0]) + (i%2) * r_offset,
                i * (card_dimensions[1] + spacing[1]),
                usbc_slot_height + filament_size + card_dimensions[2] - rj45_slot_height + rj45_slot_z_offset,
            ])
            rj45_card_slot(height = rj45_slot_height);
        }
    }
}

module notch(width = 10, size = 5) {
    translate([-width/2, 0])
    difference() {
        hull() {
            sphere(size);
            translate([width, 0, 0]) sphere(size);
        };

        translate([-size, -size*2 - width - render_thickness_offset, -size])
        cube(size*2 + width);
    }
}

module notch_row(width = 10, size = 5, count = 3, spacing = 20) {
    for (i = [0:count - 1]) {
        translate([i*spacing, 0]) notch(width = width, size = size);
    }
}

module box_notches(width = 10, size = 5) {
    // Front row
    translate([
        inset[0] + card_dimensions[0]/2 + row_offset/2/card_cols,
        lid_border_thickness,
        box_dimensions[2]*bottom_ratio - lid_border_height/2
    ])
    notch_row(width, size, count = card_cols, spacing = spacings[0] + card_dimensions[0] + row_offset / card_cols);
    // Back row
    translate([
        box_dimensions[0] - (inset[0] + card_dimensions[0]/2 + row_offset/2/card_cols),
        box_dimensions[1] - lid_border_thickness,
        box_dimensions[2]*bottom_ratio - lid_border_height/2
    ])
    rotate([0,0,180])
    notch_row(width, size, count = card_cols, spacing = spacings[0] + card_dimensions[0] + row_offset / card_cols);
}

module box_cutouts() {
    slots_layout(card_rows, card_cols, spacing = spacings, r_offset = row_offset, t_offset = slots_layout_offset);

    if (has_box_holes) {
        for(i = [box_holes_location[0]:box_holes_location[1]:card_rows-1-box_holes_location[2]]) {
            translate([
                i%2 ? row_offset : box_dimensions[0] - row_offset,
                i * (card_dimensions[1] + spacings[1]) + slots_layout_offset[1] + (box_hole_center_on == "slots" || !has_rj45_slot || i != rj45_slot_location[0] ? card_dimensions[1] : card_dimensions[1] + rj45_line_height_increase)/2 + (has_rj45_slot && i > rj45_slot_location[0] ? rj45_line_height_increase : 0),
                -0.5
            ])
            cylinder(h = box_dimensions[2]+1, r = box_holes_size/2, center = false);
        }
    }
}

// The whole box's overall shape
module box() {
    roundedcube([box_dimensions[0], box_dimensions[1], box_dimensions[2]], radius = box_radius);
}

// The box's lid
module box_lid() {
    difference() {
        box();
        // Empty internal area
        if (has_empty_lid_volume) {
            translate([box_top_thickness, box_top_thickness, box_top_thickness])
            scale([1-box_top_thickness/box_dimensions[0]*2, 1-box_top_thickness/box_dimensions[1]*2, 1-box_top_thickness/box_dimensions[2]*2])
            box();
        }
        if (has_lid_border) {
            difference() {
                // lid borders internal area
                translate([lid_border_thickness, lid_border_thickness, -(1-bottom_ratio)*box_dimensions[2]])
                scale([1-lid_border_thickness*2/box_dimensions[0], 1-lid_border_thickness*2/box_dimensions[1], 1.])
                roundedcube(box_dimensions, radius = box_radius, apply_to = "zmin");
                // Remove notches from the mask
                if (has_notches) {
                    box_notches(size = lid_notch_size, width = lid_notch_width);
                }
            }
        }
        // Remove everything below the lid border bottom
        translate([-0.05 * box_dimensions[0], -0.05 * box_dimensions[1], -(1-bottom_ratio)*box_dimensions[2]-(has_lid_border?lid_border_height:0)])
        scale([1.1, 1.1, 1.])
        cube(box_dimensions);
    };
}

// The box's body
module box_body() {
    difference() {
        box();

        // Remove lid area from body
        translate([-0.05 * box_dimensions[0], -0.05 * box_dimensions[1], box_dimensions[2]*bottom_ratio])
        cube(box_dimensions * 1.1);

        // Carve lid indent
        if (has_lid_border) {
            difference() {
                // Outside lid indent
                translate([-0.5 * box_dimensions[0], -0.5 * box_dimensions[1], box_dimensions[2]*bottom_ratio-lid_border_height])
                cube(box_dimensions*2);
                // Remove box's inside from outside lid indent
                translate([lid_border_thickness, lid_border_thickness, -(1-bottom_ratio)*box_dimensions[2]])
                scale([1-lid_border_thickness*2/box_dimensions[0], 1-lid_border_thickness*2/box_dimensions[1], 1.])
                roundedcube([box_dimensions[0], box_dimensions[1], box_dimensions[2]], radius = box_radius, apply_to = "zmin");
            }
            if (has_notches) {
                box_notches(size = box_notch_size, width = box_notch_width);
            }
        }

        // Remove lid borders from box bottom
        if (is_stackable_on_lid) {
            // For some reason, we don't get 0-thick wall when re-using the lid here
            translate([box_dimensions[0], 0, box_dimensions[2]*bottom_ratio])
            rotate([0, 180, 0])
            box_lid();
        }
    };
}

module main() {
    // Box body
    if (render_body) {
        difference() {
            box_body();
            box_cutouts();
        };
    }

    // Box lid
    if (render_lid) {
        translate([0, box_dimensions[1] + (render_body?box_dimensions[1]+10:0), box_dimensions[2]])
        rotate([0, 180, 180])
        difference() {
            box_lid();
            box_cutouts();
        };
    }

    // Fill slots with items
    if ($preview && render_body && render_preview_occupied_slots) {
        slots_layout(card_rows, card_cols, spacing = spacings, r_offset = row_offset, t_offset = slots_layout_offset);
    }
}

main();
