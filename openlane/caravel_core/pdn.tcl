# Copyright 2020-2022 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

source $::env(SCRIPTS_DIR)/openroad/common/set_global_connections.tcl
set_global_connections

set secondary []
foreach vdd $::env(VDD_NETS) gnd $::env(GND_NETS) {
    if { $vdd != $::env(VDD_NET)} {
        lappend secondary $vdd

        set db_net [[ord::get_db_block] findNet $vdd]
        if {$db_net == "NULL"} {
            set net [odb::dbNet_create [ord::get_db_block] $vdd]
            $net setSpecial
            $net setSigType "POWER"
        }
    }

    if { $gnd != $::env(GND_NET)} {
        lappend secondary $gnd

        set db_net [[ord::get_db_block] findNet $gnd]
        if {$db_net == "NULL"} {
            set net [odb::dbNet_create [ord::get_db_block] $gnd]
            $net setSpecial
            $net setSigType "GROUND"
        }
    }
}

set_voltage_domain -name CORE -power $::env(VDD_NET) -ground $::env(GND_NET) \
    -secondary_power $secondary


##### Stripes
    define_pdn_grid \
        -name stdcell_grid \
        -starts_with POWER \
        -voltage_domain CORE \
        -pins "$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)"


    #std cells stripes

    #Metal4
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer $::env(FP_PDN_LOWER_LAYER) \
        -width $::env(FP_PDN_VWIDTH) \
        -pitch $::env(FP_PDN_VPITCH) \
        -offset 83.5 \
        -spacing $::env(FP_PDN_VSPACING) \
        -number_of_straps 37 \
        -starts_with POWER -extend_to_core_ring
    
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer $::env(FP_PDN_LOWER_LAYER) \
        -width $::env(FP_PDN_VWIDTH) \
        -pitch 27.54 \
        -offset 3076.5 \
        -spacing 6 \
        -number_of_straps 2 \
        -starts_with POWER -extend_to_core_ring
    
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer $::env(FP_PDN_LOWER_LAYER) \
        -width $::env(FP_PDN_VWIDTH) \
        -pitch 24.86 \
        -offset 13.5 \
        -spacing 6 \
        -number_of_straps 2 \
        -starts_with POWER -extend_to_core_ring

    #Metal5
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer $::env(FP_PDN_UPPER_LAYER) \
        -width $::env(FP_PDN_HWIDTH) \
        -pitch $::env(FP_PDN_HPITCH) \
        -offset $::env(FP_PDN_HOFFSET) \
        -spacing $::env(FP_PDN_HSPACING) \
        -starts_with POWER -extend_to_core_ring

    #2 Stripes for user programming id
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer Metal4 \
        -width $::env(FP_PDN_VWIDTH) \
        -pitch 100 \
        -offset 2308.5 \
        -spacing 19 \
        -number_of_straps 1 \
        -starts_with POWER -extend_to_core_ring

    #2 Stripes for por
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer Metal4 \
        -width $::env(FP_PDN_VWIDTH) \
        -pitch 100 \
        -offset 2858 \
        -spacing 9 \
        -number_of_straps 1 \
        -starts_with POWER -extend_to_core_ring

    #for gpio_defaults
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer Metal4 \
        -width $::env(FP_PDN_VWIDTH) \
        -pitch 100 \
        -offset 2140.5 \
        -spacing 4 \
        -number_of_straps 1 \
        -starts_with POWER -extend_to_core_ring
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer Metal4 \
        -width $::env(FP_PDN_VWIDTH) \
        -pitch 100 \
        -offset 1893.8 \
        -spacing 4 \
        -number_of_straps 1 \
        -starts_with POWER -extend_to_core_ring
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer Metal4 \
        -width $::env(FP_PDN_VWIDTH) \
        -pitch 100 \
        -offset 1336.8 \
        -spacing 4 \
        -number_of_straps 1 \
        -starts_with POWER -extend_to_core_ring
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer Metal4 \
        -width $::env(FP_PDN_VWIDTH) \
        -pitch 100 \
        -offset 1093.9 \
        -spacing 4 \
        -number_of_straps 1 \
        -starts_with POWER -extend_to_core_ring
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer Metal4 \
        -width $::env(FP_PDN_VWIDTH) \
        -pitch 100 \
        -offset 842.2 \
        -spacing 4 \
        -number_of_straps 1 \
        -starts_with POWER -extend_to_core_ring
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer Metal4 \
        -width $::env(FP_PDN_VWIDTH) \
        -pitch 100 \
        -offset 533.7 \
        -spacing 4 \
        -number_of_straps 1 \
        -starts_with POWER -extend_to_core_ring
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer Metal4 \
        -width $::env(FP_PDN_VWIDTH) \
        -pitch 100 \
        -offset 284 \
        -spacing 4 \
        -number_of_straps 1 \
        -starts_with POWER -extend_to_core_ring
    ##

add_pdn_connect \
    -grid stdcell_grid \
    -layers "$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)"

# Adds the standard cell rails if enabled.
if { $::env(FP_PDN_ENABLE_RAILS) == 1 } {
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer $::env(FP_PDN_RAILS_LAYER) \
        -width $::env(FP_PDN_RAIL_WIDTH) \
        -followpins \
        -starts_with POWER

    add_pdn_connect \
        -grid stdcell_grid \
        -layers "$::env(FP_PDN_RAILS_LAYER) $::env(FP_PDN_LOWER_LAYER)"
}


# Adds the core ring if enabled.
if { $::env(FP_PDN_CORE_RING) == 1 } {
    add_pdn_ring \
        -grid stdcell_grid \
        -layers "$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)" \
        -widths "$::env(FP_PDN_CORE_RING_VWIDTH) $::env(FP_PDN_CORE_RING_HWIDTH)" \
        -spacings "$::env(FP_PDN_CORE_RING_VSPACING) $::env(FP_PDN_CORE_RING_HSPACING)" \
        -core_offset "$::env(FP_PDN_CORE_RING_VOFFSET) $::env(FP_PDN_CORE_RING_HOFFSET)"
}

define_pdn_grid \
    -macro \
    -default \
    -name macro \
    -starts_with POWER \
    -halo "$::env(FP_PDN_HORIZONTAL_HALO) $::env(FP_PDN_VERTICAL_HALO)"

add_pdn_connect \
    -grid macro \
    -layers "Metal3 Metal4"

add_pdn_connect \
    -grid macro \
    -layers "Metal4 Metal5"
