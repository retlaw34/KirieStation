/datum/job/tegu/ordinance_technician
	title = "Ordinance Technician"
	department_head = list("Logistics Officer")
	faction = "Syndicate"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the logistics officer"
	selection_color = "#DDDD33"
	exp_requirements = 60
	exp_type = EXP_TYPE_LOGISTICS
	maptype = "syndicate"

	outfit = /datum/outfit/job/ordinance_technician

	access = list(ACCESS_SYNDICATE)
	minimal_access = list(ACCESS_SYNDICATE)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_ENG
	liver_traits = list(TRAIT_ENGINEER_METABOLISM)
	display_order = JOB_DISPLAY_ORDER_STATION_ENGINEER
	bounty_types = CIV_JOB_ENG

/datum/outfit/job/ordinance_technician
	name = "Mechanic"
	jobtype = /datum/job/tegu/ordinance_technician

	id = /obj/item/card/id/black
	belt = /obj/item/storage/belt/utility
	ears = /obj/item/radio/headset/syndicate
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/hazardvest
	shoes = /obj/item/clothing/shoes/workboots
	box = /obj/item/storage/box/survival/engineer



//Spawn Point
/obj/effect/landmark/start/ordinance_technician
	name = "Ordinance Technician"
	icon_state = "ordinance_technician"
