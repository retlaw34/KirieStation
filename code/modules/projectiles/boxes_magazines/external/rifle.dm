/obj/item/ammo_box/magazine/m10mm/rifle
	name = "rifle magazine (10mm)"
	desc = "A well-worn magazine fitted for the surplus rifle."
	icon_state = "75-8"
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 10

/obj/item/ammo_box/magazine/m10mm/rifle/update_icon()
	..()
	if(ammo_count())
		icon_state = "75-8"
	else
		icon_state = "75-0"

/obj/item/ammo_box/magazine/m556
	name = "toploader magazine (5.56mm)"
	icon_state = "5.56m"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = CALIBER_A556
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m556/phasic
	name = "toploader magazine (5.56mm Phasic)"
	ammo_type = /obj/item/ammo_casing/a556/phasic

/obj/item/ammo_box/magazine/ak47
	name = "AK-47 Magazine (7.62x39mm)"
	icon = 'ModularTegustation/Teguicons/magazines.dmi'
	icon_state = "ak_mag_item"
	ammo_type = /obj/item/ammo_casing/ballistic/a762_39
	caliber = "7.62x39mm"
	max_ammo = 30

/obj/item/ammo_box/magazine/ak47/expanded
	name = "AK-47 Expanded Magazine (7.62x39mm)"
	icon_state = "ak_mag_large_item"
	max_ammo = 50

/obj/item/ammo_box/magazine/aks74u
	name = "AKS-74U Magazine (5.45x39mm)"
	icon = 'ModularTegustation/Teguicons/magazines.dmi'
	icon_state = "ak_mag_item"
	ammo_type = /obj/item/ammo_casing/ballistic/a545_39
	caliber = "5.45x39mm"
	max_ammo = 30

/obj/item/ammo_box/magazine/aks74u/expanded
	name = "AKS-74U Expanded Magazine (5.45x39mm)"
	icon_state = "ak_mag_large_item"
	max_ammo = 50
