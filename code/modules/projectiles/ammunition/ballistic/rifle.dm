// 7.62 (Nagant Rifle)

/obj/item/ammo_casing/a762
	name = "7.62 bullet casing"
	desc = "A 7.62 bullet casing."
	icon_state = "762-casing"
	caliber = CALIBER_A762
	projectile_type = /obj/projectile/bullet/a762

/obj/item/ammo_casing/a762/enchanted
	projectile_type = /obj/projectile/bullet/a762_enchanted

// 5.56mm (M-90gl Carbine)

/obj/item/ammo_casing/a556
	name = "5.56mm bullet casing"
	desc = "A 5.56mm bullet casing."
	caliber = CALIBER_A556
	projectile_type = /obj/projectile/bullet/a556

/obj/item/ammo_casing/a556/phasic
	name = "5.56mm phasic bullet casing"
	desc = "A 5.56mm phasic bullet casing."
	projectile_type = /obj/projectile/bullet/a556/phasic

// 40mm (Grenade Launcher)

/obj/item/ammo_casing/a40mm
	name = "40mm HE shell"
	desc = "A cased high explosive grenade that can only be activated once fired out of a grenade launcher."
	caliber = CALIBER_40MM
	icon_state = "40mmHE"
	projectile_type = /obj/projectile/bullet/a40mm

//7.62 (AK47)

/obj/item/ammo_casing/ballistic/a762_39
	name = "7.62x39mm bullet casing"
	desc = "A 7.62x39mm bullet casing."
	caliber = "7.62x39mm"
	variance = 2
	projectile_type = /obj/projectile/bullet/a762_39

//5.45 (AK74)

/obj/item/ammo_casing/ballistic/a545_39
	name = "5.45x39mm bullet casing"
	desc = "A 5.45x39mm bullet casing."
	caliber = "5.45x39mm"
	randomspread = TRUE
	variance = 2
	projectile_type = /obj/projectile/bullet/a545_39
