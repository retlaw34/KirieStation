/obj/item/ammo_casing/energy/ion
	projectile_type = /obj/projectile/ion
	select_name = "ion"
	fire_sound = 'sound/weapons/ionrifle.ogg'

/obj/item/ammo_casing/energy/ion/hos
	projectile_type = /obj/projectile/ion/weak
	e_cost = 300

/obj/item/ammo_casing/energy/declone
	projectile_type = /obj/projectile/energy/declone
	select_name = "declone"
	fire_sound = 'sound/weapons/pulse3.ogg'

/obj/item/ammo_casing/energy/declone/weak
	projectile_type = /obj/projectile/energy/declone/weak

/obj/item/ammo_casing/energy/flora
	fire_sound = 'sound/effects/stealthoff.ogg'
	harmful = FALSE

/obj/item/ammo_casing/energy/flora/yield
	projectile_type = /obj/projectile/energy/florayield
	select_name = "yield"

/obj/item/ammo_casing/energy/flora/mut
	projectile_type = /obj/projectile/energy/floramut
	select_name = "mutation"

/obj/item/ammo_casing/energy/flora/revolution
	projectile_type = /obj/projectile/energy/florarevolution
	select_name = "revolution"
	e_cost = 250

/obj/item/ammo_casing/energy/temp
	projectile_type = /obj/projectile/temp
	select_name = "freeze"
	e_cost = 250
	fire_sound = 'sound/weapons/pulse3.ogg'

/obj/item/ammo_casing/energy/temp/hot
	projectile_type = /obj/projectile/temp/hot
	select_name = "bake"

/obj/item/ammo_casing/energy/meteor
	projectile_type = /obj/projectile/meteor
	select_name = "goddamn meteor"

/obj/item/ammo_casing/energy/net
	projectile_type = /obj/projectile/energy/net
	select_name = "netting"
	pellets = 6
	variance = 40
	harmful = FALSE

/obj/item/ammo_casing/energy/trap
	projectile_type = /obj/projectile/energy/trap
	select_name = "snare"
	harmful = FALSE

/obj/item/ammo_casing/energy/instakill
	projectile_type = /obj/projectile/beam/instakill
	e_cost = 0
	select_name = "DESTROY"

/obj/item/ammo_casing/energy/instakill/blue
	projectile_type = /obj/projectile/beam/instakill/blue

/obj/item/ammo_casing/energy/instakill/red
	projectile_type = /obj/projectile/beam/instakill/red

/obj/item/ammo_casing/energy/tesla_cannon
	fire_sound = 'sound/magic/lightningshock.ogg'
	e_cost = 30
	select_name = "shock"
	projectile_type = /obj/projectile/energy/tesla_cannon

/obj/item/ammo_casing/energy/shrink
	projectile_type = /obj/projectile/beam/shrink
	select_name = "shrink ray"
	e_cost = 200

/obj/item/ammo_casing/energy/vortex
	projectile_type = /obj/projectile/beam/vortex_bullet
	select_name = "death"
	e_cost = 200
	fire_sound = 'sound/weapons/marauder.ogg'

/obj/projectile/beam/vortex_bullet
	name = "compressed singularity"
	desc = "Well, you are dead."
	icon = 'ModularTegustation/Teguicons/bhole_projector.dmi'
	icon_state = "dark_bullet"
	impact_effect_type = /obj/effect/projectile/impact/wormhole
	light_color = LIGHT_COLOR_PURPLE
	damage = 55
	irradiate = 100
	range = 11
	projectile_piercing = PASSMOB
	projectile_phasing = (ALL & (~PASSMOB))

/obj/projectile/beam/vortex_bullet/on_hit(atom/target, blocked = FALSE)
	if(ishuman(target))
		var/mob/living/carbon/human/dead_man = target
		dead_man.Sleeping(6 SECONDS)
	return ..()

/obj/projectile/beam/vortex_bullet/Moved(atom/OldLoc, Dir)
	. = ..()
	grav(rand(0,3), rand(2,3), 25, 25)

	//Godless copy-pasta from vortex anomaly.
	for(var/obj/O in range(2,src))
		if(O == src)
			return
		if(!O.anchored)
			var/mob/living/target = locate() in view(2,src)
			if(target && !target.stat)
				O.throw_at(target, 5, 3)

/obj/projectile/beam/vortex_bullet/proc/grav(r, ex_act_force, pull_chance, turf_removal_chance)
	for(var/t = -r, t < r, t++)
		affect_coord(x+t, y-r, ex_act_force, pull_chance, turf_removal_chance)
		affect_coord(x-t, y+r, ex_act_force, pull_chance, turf_removal_chance)
		affect_coord(x+r, y+t, ex_act_force, pull_chance, turf_removal_chance)
		affect_coord(x-r, y-t, ex_act_force, pull_chance, turf_removal_chance)

/obj/projectile/beam/vortex_bullet/proc/affect_coord(x, y, ex_act_force, pull_chance, turf_removal_chance)
	var/turf/T = locate(x, y, z)
	if(isnull(T))
		return

	if(prob(pull_chance))
		for(var/obj/O in T.contents)
			if(istype(O,/obj/machinery/atmospherics)) // Please don't kill atmos, thanks.
				continue
			if(O.anchored)
				switch(ex_act_force)
					if(EXPLODE_DEVASTATE)
						SSexplosions.high_mov_atom += O
					if(EXPLODE_HEAVY)
						SSexplosions.med_mov_atom += O
					if(EXPLODE_LIGHT)
						SSexplosions.low_mov_atom += O
			else
				step_towards(O,src)
		for(var/mob/living/M in T.contents)
			step_towards(M,src)

	//Damaging the turf
	if(T && prob(turf_removal_chance) )
		switch(ex_act_force)
			if(EXPLODE_DEVASTATE)
				SSexplosions.highturf += T
			if(EXPLODE_HEAVY)
				SSexplosions.medturf += T
			if(EXPLODE_LIGHT)
				SSexplosions.lowturf += T
