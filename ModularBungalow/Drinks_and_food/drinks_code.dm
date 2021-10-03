// ==You need to add the icons in "icons/obj/drinks.dmi" or you will have problems with the broken glass==
/datum/reagent/consumable/ethanol/pisco
	name = "Pisco"
	description = "Burns with every sip."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 65
	quality = DRINK_NICE
	taste_description = "bitterness and mild dryness"
	glass_icon_state = "piscoglass"
	glass_name = "Pisco"
	glass_desc = "Burns with every sip."

/datum/reagent/consumable/ethanol/piscola

	name = "Piscola"
	description = "Simple and yet, effective"
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 50
	quality = DRINK_NICE
	taste_description = "bitterness , mild dryness"
	glass_icon_state = "piscolaglass"
	glass_name = "piscola"
	glass_desc = "Simple and yet, effective"

/datum/reagent/consumable/ethanol/terremoto

	name = "Terremoto"
	description = "A earthquake in a glass."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 60
	nutriment_factor = 1 * REAGENTS_METABOLISM
	quality = DRINK_NICE
	overdose_threshold = 60
	taste_description = "earthquake"
	glass_icon_state = "terremotoglass"
	glass_name = "Terremoto"
	glass_desc = "A earthquake in a glass."

/datum/reagent/consumable/ethanol/terremoto/on_mob_life(mob/living/carbon/M)
	M.drowsyness = max(0,M.drowsyness-7)
	M.AdjustSleeping(-40)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	if(!HAS_TRAIT(M, TRAIT_ALCOHOL_TOLERANCE))
		M.Jitter(5)
	return ..()

/datum/reagent/consumable/ethanol/terreoto/overdose_start(mob/living/M)
	to_chat(M, "<span class='userdanger'>You feel like in a earthquake!</span>")
	M.Jitter(20)
	M.Stun(15)

/datum/reagent/consumable/ethanol/terremoto/overdose_process(mob/living/M)
	if(prob(7) && iscarbon(M))
		var/obj/item/I = M.get_active_held_item()
		if(I)
			M.dropItemToGround(I)
			to_chat(M, "<span class='notice'>Your hands shake like in a earthquake and you drop what you were holding!</span>")
			M.Jitter(10)

/datum/reagent/consumable/tula
	name = "Tula"
	description = "Surprisingly it doesnt taste weird!"
	color = "##8bcc41"
	quality = DRINK_VERYGOOD
	taste_description = "the 00s in Chile"
	glass_icon_state = "glass_green"
	glass_name = "glass of Tula"
	glass_desc = "Surprisingly it dosnt taste weird!"

/datum/reagent/consumable/tula/on_mob_life(mob/living/carbon/M)
	M.Jitter(20)
	M.dizziness +=1
	M.drowsyness = 0
	M.AdjustSleeping(-40)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()
