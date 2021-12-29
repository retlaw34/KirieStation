/obj/item/clothing/shoes/magboots
	desc = "Magnetic boots, often used during extravehicular activity to ensure the user remains safely attached to the vehicle."
	name = "magboots"
	icon_state = "magboots0"
	var/magboot_state = "magboots"
	var/magpulse = FALSE
	var/slowdown_active = 2
	permeability_coefficient = 0.05
	actions_types = list(/datum/action/item_action/toggle)
	strip_delay = 70
	equip_delay_other = 70
	resistance_flags = FIRE_PROOF

/obj/item/clothing/shoes/magboots/verb/toggle()
	set name = "Toggle Magboots"
	set category = "Object"
	set src in usr
	if(!can_use(usr))
		return
	attack_self(usr)


/obj/item/clothing/shoes/magboots/attack_self(mob/user)
	if(magpulse)
		clothing_flags &= ~NOSLIP
		slowdown = SHOES_SLOWDOWN
	else
		clothing_flags |= NOSLIP
		slowdown = slowdown_active
	magpulse = !magpulse
	icon_state = "[magboot_state][magpulse]"
	to_chat(user, "<span class='notice'>You [magpulse ? "enable" : "disable"] the mag-pulse traction system.</span>")
	user.update_inv_shoes()	//so our mob-overlays update
	user.update_gravity(user.has_gravity())
	user.update_equipment_speed_mods() //we want to update our speed so we arent running at max speed in regular magboots
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/shoes/magboots/negates_gravity()
	return clothing_flags & NOSLIP

/obj/item/clothing/shoes/magboots/examine(mob/user)
	. = ..()
	. += "Its mag-pulse traction system appears to be [magpulse ? "enabled" : "disabled"]."


/obj/item/clothing/shoes/magboots/advance
	desc = "Advanced magnetic boots that have a lighter magnetic pull, placing less burden on the wearer."
	name = "advanced magboots"
	icon_state = "advmag0"
	magboot_state = "advmag"
	slowdown_active = SHOES_SLOWDOWN
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/clothing/shoes/magboots/syndie
	desc = "Reverse-engineered magnetic boots that have a heavy magnetic pull. Property of Gorlex Marauders."
	name = "blood-red magboots"
	icon_state = "syndiemag0"
	magboot_state = "syndiemag"

/obj/item/clothing/shoes/magboots/noslow
	desc = "Pair of magnetic boots using a gravity core to reduce the weight and slowdown."
	name = "dormant anomalous magboots"
	icon = 'ModularTegustation/Teguicons/teguclothing.dmi'
	slowdown_active = SHOES_SLOWDOWN
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	throw_speed = 2
	throw_range = 3
	var/anomaly_core = FALSE

/obj/item/clothing/shoes/magboots/noslow/attack_self(mob/user)
	if(!anomaly_core)
		to_chat(user, "<span class='warning'>[src] require a gravity anomaly core to operate!</span>")
		return
	. = ..()

/obj/item/clothing/shoes/magboots/noslow/attackby(obj/item/C, mob/user)
	if(istype(C, /obj/item/assembly/signaler/anomaly/grav) && !anomaly_core)
		name = "anomalous magboots"
		to_chat(user, "<span class='notice'>You insert [C] into [src] and they start to feel much lighter.</span>")
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
		anomaly_core = TRUE
		throw_speed = 3
		throw_range = 7
		qdel(C)
		return
	. = ..()

/obj/item/clothing/shoes/magboots/atmos
	desc = "Atmospheric Technicians wear these magboots to stop them from getting tossed around in the wind."
	name = "atmos magboots"
	icon_state = "atmosmag0"
	magboot_state = "atmosmag1"
	resistance_flags = FIRE_PROOF

/obj/item/clothing/shoes/magboots/eva
	desc = "EVA Magboots are for general use on and off station.."
	name = "eva magboots"
	icon_state = "evamag0"
	magboot_state = "evamag1"
	resistance_flags = FIRE_PROOF
