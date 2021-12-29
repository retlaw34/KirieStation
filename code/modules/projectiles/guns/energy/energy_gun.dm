/obj/item/gun/energy/e_gun
	name = "X-06 Energy Rifle"
	desc = "A basic hybrid energy gun with two settings: disable and kill."
	icon_state = "energy"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = null	//so the human update icon uses the icon_state instead.
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)
	modifystate = 1
	can_flashlight = TRUE
	ammo_x_offset = 3
	flight_x_offset = 15
	flight_y_offset = 10
	dual_wield_spread = 60

/obj/item/gun/energy/e_gun/mini
	name = "X-26 Energy Pistol"
	desc = "A small, pistol-sized energy gun with a built-in flashlight. It has two settings: disable and kill."
	icon_state = "mini"
	inhand_icon_state = "gun"
	w_class = WEIGHT_CLASS_SMALL
	cell_type = /obj/item/stock_parts/cell/mini_egun
	ammo_x_offset = 2
	charge_sections = 3
	can_flashlight = FALSE // Can't attach or detach the flashlight, and override it's icon update
	gunlight_state = "mini-light"
	flight_x_offset = 19
	flight_y_offset = 13

/obj/item/gun/energy/e_gun/mini/Initialize()
	set_gun_light(new /obj/item/flashlight/seclite(src))
	return ..()

/obj/item/gun/energy/e_gun/stun
	name = "XX-01 Tactical Energy Rifle"
	desc = "Military issue energy gun, is able to fire stun rounds."
	icon_state = "energytac"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/spec, /obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)

/obj/item/gun/energy/e_gun/old
	name = "NT-P 01 Protoype energy gun"
	desc = "NT-P:01 Prototype Energy Gun. Early stage development of a unique laser rifle that has multifaceted energy lens allowing the gun to alter the form of projectile it fires on command."
	icon_state = "protolaser"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/laser, /obj/item/ammo_casing/energy/electrode/old)

/obj/item/gun/energy/e_gun/mini/practice_phaser
	name = "practice phaser"
	desc = "A modified version of the basic phaser gun, this one fires less concentrated energy bolts designed for target practice."
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser/practice)
	icon_state = "decloner"

/obj/item/gun/energy/e_gun/hos
	name = "\improper X-01 MultiPhase Energy Gun"
	desc = "This is an expensive, modern recreation of an antique laser gun. This gun has several unique firemodes, but lacks the ability to recharge over time."
	cell_type = /obj/item/stock_parts/cell/hos_gun
	icon_state = "hoslaser"
	w_class = WEIGHT_CLASS_NORMAL
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hos, /obj/item/ammo_casing/energy/laser/hos, /obj/item/ammo_casing/energy/ion/hos)
	shaded_charge = TRUE
	ammo_x_offset = 4
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/gun/energy/e_gun/dragnet
	name = "\improper DRAGnet"
	desc = "The \"Dynamic Rapid-Apprehension of the Guilty\" net is a revolution in law enforcement technology."
	icon_state = "dragnet"
	inhand_icon_state = "dragnet"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/net, /obj/item/ammo_casing/energy/trap)
	w_class = WEIGHT_CLASS_NORMAL
	can_flashlight = FALSE
	ammo_x_offset = 1

/obj/item/gun/energy/e_gun/dragnet/snare
	name = "Energy Snare Launcher"
	desc = "Fires an energy snare that slows the target down."
	ammo_type = list(/obj/item/ammo_casing/energy/trap)

/obj/item/gun/energy/e_gun/turret
	name = "hybrid turret gun"
	desc = "A heavy hybrid energy cannon with two settings: Stun and kill."
	icon_state = "turretlaser"
	inhand_icon_state = "turretlaser"
	slot_flags = null
	w_class = WEIGHT_CLASS_HUGE
	ammo_type = list(/obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	weapon_weight = WEAPON_HEAVY
	can_flashlight = FALSE
	trigger_guard = TRIGGER_GUARD_NONE
	ammo_x_offset = 2

/obj/item/gun/energy/e_gun/nuclear
	name = "X-07 Nuclear Energy Rifle"
	desc = "An energy gun with an experimental miniaturized nuclear reactor that automatically charges the internal power cell."
	icon_state = "nucgun"
	inhand_icon_state = "nucgun"
	charge_delay = 10
	can_charge = FALSE
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/laser, /obj/item/ammo_casing/energy/disabler)
	selfcharge = 1
	var/reactor_overloaded
	var/fail_tick = 0
	var/fail_chance = 0

/obj/item/gun/energy/e_gun/nuclear/process(delta_time)
	if(fail_tick > 0)
		fail_tick -= delta_time * 0.5
	..()

/obj/item/gun/energy/e_gun/nuclear/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
	failcheck()
	update_icon()
	..()

/obj/item/gun/energy/e_gun/nuclear/proc/failcheck()
	if(prob(fail_chance) && isliving(loc))
		var/mob/living/M = loc
		switch(fail_tick)
			if(0 to 200)
				fail_tick += (2*(fail_chance))
				M.rad_act(40)
				to_chat(M, "<span class='userdanger'>Your [name] feels warmer.</span>")
			if(201 to INFINITY)
				SSobj.processing.Remove(src)
				M.rad_act(80)
				reactor_overloaded = TRUE
				to_chat(M, "<span class='userdanger'>Your [name]'s reactor overloads!</span>")

/obj/item/gun/energy/e_gun/nuclear/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	fail_chance = min(fail_chance + round(15/severity), 100)

/obj/item/gun/energy/e_gun/nuclear/update_overlays()
	. = ..()
	if(reactor_overloaded)
		. += "[icon_state]_fail_3"
	else
		switch(fail_tick)
			if(0)
				. += "[icon_state]_fail_0"
			if(1 to 150)
				. += "[icon_state]_fail_1"
			if(151 to INFINITY)
				. += "[icon_state]_fail_2"

/obj/item/gun/energy/e_gun/cyborg
	name = "\improper Integrated Energy Gun"
	desc = "An integrated energy gun that draws from a cyborg's power cell."
	can_charge = FALSE
	use_cyborg_cell = TRUE
	ammo_type = list(/obj/item/ammo_casing/energy/disabler)

//Where we check to see if station is on red alert and the lethal mode can be used.

/obj/item/gun/energy/e_gun/cyborg/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(!check_alert_level())
		return
	return ..()

/obj/item/gun/energy/e_gun/cyborg/proc/check_alert_level()
	var/mob/living/silicon/robot/R = loc
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	if(!R || !iscyborg(R))
		return FALSE

	if((GLOB.security_level < SEC_LEVEL_RED && shot.harmful) && !R.emagged) //If we're emagged we don't care about alert level
		playsound(loc, 'sound/machines/buzz-two.ogg', get_clamped_volume(), TRUE, -1)
		to_chat(loc,"<span class='warning'>ERROR: Weapon cannot fire on lethal modes while the alert level is less than red.</span>")
		return FALSE

	return TRUE

/obj/item/gun/energy/e_gun/e_bola/cyborg
	name = "\improper Integrated E-BOLA Launcher"
	desc = "An integrated e-bola launcher that draws from a cyborg's power cell."
	icon_state = "dragnet"
	can_charge = FALSE
	use_cyborg_cell = TRUE
	charge_delay = 8
	ammo_type = list(/obj/item/ammo_casing/energy/bola)

/obj/item/borg/upgrade/e_gun_lethal
	name = "cyborg lethal mode unlock"
	desc = "A module that unlocks the lethal mode for a cyborg's integrated energy gun for use during red alert."
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/security)

/obj/item/borg/upgrade/e_gun_lethal/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		var/obj/item/gun/energy/e_gun/cyborg/T = locate() in R.model.modules
		if(!T)
			to_chat(user, "<span class='warning'>There's no [T] in this unit!</span>")
			return FALSE
		if(T.ammo_type.len > 1)
			to_chat(R, "<span class='warning'>Lethals are already unlocked for your [T]!</span>")
			to_chat(user, "<span class='warning'>Lethals are already unlocked for [R]'s [T]!</span>")
			return FALSE

		T.ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)
		T.update_ammo_types()

/obj/item/borg/upgrade/e_gun_lethal/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		var/obj/item/gun/energy/e_gun/cyborg/T = locate() in R.model.modules
		if(!T)
			return FALSE
		if(!R.emagged) //If we're emagged, don't revert.
			T.ammo_type = initial(T.ammo_type)

/obj/item/borg/upgrade/e_gun_cooler
	name = "cyborg energy gun cooling module"
	desc = "Used to cool an integrated energy gun, increasing the potential current in it and thus its recharge rate."
	icon_state = "cyborg_upgrade3"
	require_model = 1
	model_type = list(/obj/item/robot_model/security)

/obj/item/borg/upgrade/e_gun_cooler/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		var/obj/item/gun/energy/e_gun/cyborg/T = locate() in R.model.modules
		if(!T)
			to_chat(user, "<span class='warning'>There's no [T] in this unit!</span>")
			return FALSE
		if(T.charge_delay <= 2)
			to_chat(R, "<span class='warning'>A cooling unit is already installed!</span>")
			to_chat(user, "<span class='warning'>There's no room for another cooling unit!</span>")
			return FALSE

		T.charge_delay = max(2 , T.charge_delay - 4)

/obj/item/borg/upgrade/e_gun_cooler/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		var/obj/item/gun/energy/e_gun/cyborg/T = locate() in R.model.modules
		if(!T)
			return FALSE
		T.charge_delay = initial(T.charge_delay)

