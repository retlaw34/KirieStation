//Home Defender pistol
/obj/item/gun/energy/e_gun/homedef
	name = "\improper E-220 Home Defender Beam Revolver"
	desc = "Nanotrasen’s experiment to re-invent portable, self-recharging batteries and combine it with their special multi-phase technology."
	icon = 'ModularBungalow/bungalowWeapons/_icon/energy.dmi'
	icon_state = "homedefender"
	inhand_icon_state = "gun"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hitscan, /obj/item/ammo_casing/energy/ion)
	w_class = WEIGHT_CLASS_SMALL
	cell_type = /obj/item/stock_parts/cell/mini_egun
	selfcharge = 1


//Rob's Special Version
/obj/item/gun/energy/e_gun/homedef/special
	name = "\improper Custom E-220 Home Defender"
	desc = "An old but well kept E-220. Someone painted a purple H on it. It looks well kept, if a little dustied."
	icon_state = "homedefender-special"
	selfcharge = 1


//X-02 Pulse Disabler Rifle
/obj/item/gun/energy/e_gun/hop
	name = "\improper X-02 Disabler Beam Rifle"
	desc = "A classic, the successor to the X-01 Multiphase, this rifle trades the ion and kill modes for a concentrated, but weak disabler beam and scattershot blasts."
	cell_type = /obj/item/stock_parts/cell/hos_gun
	icon = 'ModularBungalow/bungalowWeapons/_icon/energy.dmi'
	icon_state = "hoprifle"
	inhand_icon_state = "energydisable3"
	w_class = WEIGHT_CLASS_BULKY
	force = 5
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hitscan, /obj/item/ammo_casing/energy/laser/scatter/disabler, /obj/item/ammo_casing/energy/laser/scatter/close)
	ammo_x_offset = 2


// Svet's Disabler
/obj/item/gun/energy/disabler/svet_disabler
	name = "Brass Ray"
	desc = "A self-defense weapon that exhausts organic targets, weakening them until they collapse. This one has a wooden vernished purple stock, assembled with a brass frame and trimed with silver linings. It also has been modified to be self rechargeable and have rays instant, at the cost of the capacity."
	icon = 'ModularBungalow/zbungalowicons/weapons/energy.dmi'
	icon_state = "svet_disabler"
	lefthand_file = 'ModularBungalow/zbungalowicons/weapons/energy_lefthand.dmi'
	righthand_file = 'ModularBungalow/zbungalowicons/weapons/energy_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hitscan)
	ammo_x_offset = 2
	can_flashlight = TRUE
	flight_x_offset = 15
	flight_y_offset = 10
	selfcharge = 1
	w_class = WEIGHT_CLASS_SMALL


//Wetwork Energy Sniper
/obj/item/gun/energy/sniper/security
	name = "L-733 Anti-Personnel Rifle"
	desc = "An advanced piece of weaponry forged by NT to terminate troublemakers."
	ammo_type = list(/obj/item/ammo_casing/energy/sniper/disable)

/obj/item/gun/energy/sniper/security/Initialize()
	. = ..()
	fire_delay = 30
