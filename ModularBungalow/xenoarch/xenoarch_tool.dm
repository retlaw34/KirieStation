/obj/item/xenoarch
	name = "parent dev item"
	icon = 'ModularBungalow/xenoarch/icons/xenoarch_items.dmi'

// HAMMERS

/obj/item/xenoarch/hammer
	name = "parent dev item"
	var/dig_amount = 1
	var/dig_speed = 1 SECONDS
	var/advanced = FALSE

/obj/item/xenoarch/hammer/examine(mob/user)
	. = ..()
	if(advanced)
		to_chat(user, "This is an advanced hammer. It can change its digging depth from 1 to 30. Click to change depth.")
	to_chat(user, "Current Digging Depth: [dig_amount]cm")

/obj/item/xenoarch/hammer/attack_self(mob/user, modifiers)
	. = ..()
	if(!advanced)
		to_chat(user, "This is not an advanced hammer, it cannot change its digging depth.")
		return
	var/user_choice = input(user, "Choose the digging depth. 1 to 30", "Digging Depth Selection") as null|num
	if(!user_choice)
		dig_amount = 1
		dig_speed = 1
		return
	if(dig_amount <= 0)
		dig_amount = 1
		dig_speed = 1
		return
	var/round_dig = round(user_choice)
	if(round_dig >= 30)
		dig_amount = 30
		dig_speed = 30
		return
	dig_amount = round_dig
	dig_speed = round_dig
	to_chat(user, "You change the hammer's digging depth to [round_dig]cm.")

/obj/item/xenoarch/hammer/cm1
	name = "Hammer (1cm)"
	desc = "A hammer that can be used to remove dirt from strange rocks."
	icon_state = "hammer1"
	dig_amount = 1
	dig_speed = 0.5 SECONDS

/obj/item/xenoarch/hammer/cm2
	name = "Hammer (2cm)"
	desc = "A hammer that can be used to remove dirt from strange rocks."
	icon_state = "hammer2"
	dig_amount = 2
	dig_speed = 1 SECONDS

/obj/item/xenoarch/hammer/cm3
	name = "Hammer (3cm)"
	desc = "A hammer that can be used to remove dirt from strange rocks."
	icon_state = "hammer3"
	dig_amount = 3
	dig_speed = 1.5 SECONDS

/obj/item/xenoarch/hammer/cm5
	name = "Hammer (5cm)"
	desc = "A hammer that can be used to remove dirt from strange rocks."
	icon_state = "hammer5"
	dig_amount = 5
	dig_speed = 2.5 SECONDS

/obj/item/xenoarch/hammer/cm10
	name = "Hammer (10cm)"
	desc = "A hammer that can be used to remove dirt from strange rocks."
	icon_state = "hammer10"
	dig_amount = 10
	dig_speed = 5 SECONDS

/obj/item/xenoarch/hammer/adv
	name = "advanced hammer"
	desc = "A hammer that can be used to remove dirt from strange rocks."
	icon_state = "adv_hammer"
	dig_amount = 1
	dig_speed = 0.5
	advanced = TRUE

// BRUSHES

/obj/item/xenoarch/brush
	name = "brush"
	desc = "A brush that is used to uncover the secrets of the past from strange rocks."
	var/dig_speed = 3 SECONDS
	icon_state = "brush"

/obj/item/xenoarch/brush/adv
	name = "advanced brush"
	dig_speed = 3
	icon_state = "adv_brush"

// MISC.

/obj/item/xenoarch/tape_measure
	name = "measuring tape"
	desc = "A measuring tape specifically produced to measure the depth that has been dug into strange rocks."
	icon_state = "tape"

/obj/item/storage/belt/utility/xenoarch
	name = "xenoarch toolbelt" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "Holds tools."
	content_overlays = FALSE
	custom_premium_price = PAYCHECK_MEDIUM * 2

/obj/item/storage/belt/utility/xenoarch/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 21
	STR.max_items = 8
	STR.set_holdable(list(
		/obj/item/xenoarch/hammer,
		/obj/item/xenoarch/brush,
		/obj/item/xenoarch/tape_measure,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/mining_scanner
		))

/obj/item/storage/bag/xenoarch
	name = "xenoarch mining satchel"
	desc = "This little bugger can be used to store and transport strange rocks."
	icon = 'ModularBungalow/xenoarch/icons/xenoarch_items.dmi'
	icon_state = "satchel"
	worn_icon_state = "satchel"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	var/insert_speed = 1 SECONDS
	var/mob/listeningTo
	var/range = null

	var/spam_protection = FALSE //If this is TRUE, the holder won't receive any messages when they fail to pick up ore through crossing it

/obj/item/storage/bag/xenoarch/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_GIGANTIC
	STR.allow_quick_empty = TRUE
	STR.max_combined_w_class = 1000
	STR.max_items = 10
	STR.display_numerical_stacking = FALSE
	STR.can_hold = typecacheof(list(/obj/item/xenoarch/strange_rock))

/obj/item/storage/bag/xenoarch/equipped(mob/user)
	. = ..()
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/pickup_rocks)
	listeningTo = user

/obj/item/storage/bag/xenoarch/dropped(mob/user)
	. = ..()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	listeningTo = null

/obj/item/storage/bag/xenoarch/proc/pickup_rocks(mob/living/user)
	var/show_message = FALSE
	var/turf/tile = user.loc
	if (!isturf(tile))
		return

	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		for(var/A in tile)
			if (!is_type_in_typecache(A, STR.can_hold))
				continue
			else if(SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, A, user, TRUE))
				show_message = TRUE
			else
				if(!spam_protection)
					to_chat(user, "<span class='warning'>Your [name] is full and can't hold any more!</span>")
					spam_protection = TRUE
					continue
	if(show_message)
		playsound(user, "rustle", 50, TRUE)
		user.visible_message("<span class='notice'>[user] scoops up the rocks beneath [user.p_them()].</span>", \
			"<span class='notice'>You scoop up the rocks beneath you with your [name].</span>")
	spam_protection = FALSE

/obj/item/storage/bag/xenoarch/adv
	name = "advanced xenoarch mining satchel"
	icon_state = "adv_satchel"
	insert_speed = 1

/obj/item/storage/bag/xenoarch/adv/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 25

/obj/structure/closet/xenoarch
	name = "xenoarchaeology equipment locker"
	icon_state = "science"

/obj/structure/closet/xenoarch/PopulateContents()
	. = ..()
	new /obj/item/xenoarch/hammer/cm1(src)
	new /obj/item/xenoarch/hammer/cm2(src)
	new /obj/item/xenoarch/hammer/cm3(src)
	new /obj/item/xenoarch/hammer/cm5(src)
	new /obj/item/xenoarch/hammer/cm10(src)
	new /obj/item/xenoarch/brush(src)
	new /obj/item/xenoarch/tape_measure(src)
	new /obj/item/storage/bag/xenoarch(src)
	new /obj/item/storage/belt/utility/xenoarch(src)
	new /obj/item/t_scanner/adv_mining_scanner(src)
	new /obj/item/pickaxe(src)
	new /obj/item/clothing/suit/neocoat/xeno(src)
