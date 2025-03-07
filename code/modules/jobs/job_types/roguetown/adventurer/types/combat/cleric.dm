//shield
/datum/advclass/combat/cleric
	name = "Cleric"
	tutorial = "Clerics are wandering warriors of the Gods, drawn from the ranks of temple acolytes who demonstrated martial talent. Protected by armor and zeal, they are a force to be reckoned with."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Dark Elf",
		"Anakim"
	)
	vampcompat = FALSE
	outfit = /datum/outfit/job/roguetown/adventurer/cleric
	category_tags = list(CTAG_ADVENTURER)
	min_pq = 0
	maximum_possible_slots = 4

/datum/outfit/job/roguetown/adventurer/cleric
	allowed_patrons = ALL_CLERIC_PATRONS

/datum/outfit/job/roguetown/adventurer/cleric/pre_equip(mob/living/carbon/human/H)
	..()
	H.virginity = TRUE

	armor = /obj/item/clothing/suit/roguetown/armor/cuirass // Halfplate has been made heavy armor, billions must make due.
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/mace
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor

	switch(H.patron?.type)
		if(/datum/patron/veneration/lythios)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/lythios
			cloak = /obj/item/clothing/cloak/stabard/templar/lythios
			neck = /obj/item/clothing/neck/roguetown/chaincoif
		if(/datum/patron/veneration/yaakov)	// good helmet but no money
			head = /obj/item/clothing/head/roguetown/helmet/heavy/necked/yaakovhelm
			neck = /obj/item/clothing/neck/roguetown/coif
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/yaakov
			cloak = /obj/item/clothing/cloak/raincloak/furcloak
			beltr = /obj/item/rogueweapon/knife/stone
		if(/datum/patron/veneration/labbeus)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/labbeus
			cloak = /obj/item/clothing/cloak/stabard/templar/labbeus
			neck = /obj/item/clothing/neck/roguetown/gorget
		if(/datum/patron/veneration/nazar)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/nazar
			cloak = /obj/item/clothing/cloak/stabard/templar/nazar
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
			H.virginity = FALSE
		if(/datum/patron/veneration/mathuin)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/mathuin
			cloak =  /obj/item/clothing/cloak/stabard/templar/mathuin
			neck = /obj/item/clothing/neck/roguetown/gorget
		if(/datum/patron/veneration/eosten)
			wrists = /obj/item/clothing/neck/roguetown/psycross/eosten
			cloak = /obj/item/clothing/cloak/stabard/templar/eosten
			neck = /obj/item/clothing/neck/roguetown/chaincoif
		if(/datum/patron/veneration/mikros)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/mikros
			cloak = /obj/item/clothing/cloak/stabard/templar/mikros
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
		if(/datum/patron/veneration/cana)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/cana
			cloak = /obj/item/clothing/cloak/tabard/crusader
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
		if(/datum/patron/veneration/toma)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/toma
			cloak = /obj/item/clothing/cloak/stabard/templar/toma
			neck = /obj/item/clothing/neck/roguetown/gorget
		if(/datum/patron/veneration/julias)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/julius
			cloak = /obj/item/clothing/cloak/tabard/crusader
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
		else // Failsafe
			cloak = /obj/item/clothing/cloak/tabard/crusader // Give us a generic crusade tabard
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver // Give us a silver psycross for protection against lickers
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron


	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC) // Even if it has limited slots, it is a common drifter role available to anyone. Their armor also is not heavy, so medium armor training is enough
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	C.grant_spells_cleric(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

