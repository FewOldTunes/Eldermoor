	/*==============*
	*				*
	*	Anakim		*
	*				*
	*===============*/

//	( + Pain Resist )
//	( + Bleed Resist )
//	( - Hunger )

/mob/living/carbon/human/species/anakim
	race = /datum/species/anakim

/datum/species/anakim
	name = "Anakim"
	id = "anakim"
	desc = "<b>Anakim</b><br> \
	Created by divine hands, the Anakim were sculpted as powerful, immortal warriors, each as strong as five men. \
	10,000 descended upon Psydonia in humanity’s darkest hour, their arrival shaping the fate of the world. \
	Yet, the gods’ will is debated—were they sent by the Pantheon or Psydon? None can say. \
	Now, fewer than 100 remain, their existence thought to be myth, their kind believed long gone. \
	Those that roam are often those discarded, abandoned after serving their purpose, condemned to walk alone. \
	Revered for their celestial origin yet burdened by solitude, many detest the awe they inspire, \
	for it only reminds them of their failure or obsolescence. \
	Their forms vary—some are hewn from stone, others smooth as ceramic, but within, they bleed as mortals do. \
	Though Anakim may have faded from history, their legacy endures; their bloodline runs through the veins of great figures, \
	human champions unknowingly carrying the remnants of gods."

	skin_tone_wording = "Crafted With"
	nutrition_mod = 2 // 200% higher hunger rate. Hungry, hungry anakim
	pain_mod = 0.9 // 10% less pain from wounds
	bleed_mod = 0.8 // 20% less bleed rate from injuries

	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = list("mcolor" = "FFF", "wings" = "None")
	use_skintones = 1
	disliked_food = NONE
	liked_food = NONE
	possible_ages = list(AGE_IMMORTAL)
	max_age = "Unknown"
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mm.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	hairyness = "t1"
	soundpack_m = /datum/voicepack/male/serious
	soundpack_f = /datum/voicepack/female
	offset_features = list(OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_WRISTS = list(0,0),\
	OFFSET_CLOAK = list(0,0), OFFSET_FACEMASK = list(0,0), OFFSET_HEAD = list(0,0), \
	OFFSET_FACE = list(0,0), OFFSET_BELT = list(0,0), OFFSET_BACK = list(0,0), \
	OFFSET_NECK = list(0,0), OFFSET_MOUTH = list(0,0), OFFSET_PANTS = list(0,0), \
	OFFSET_SHIRT = list(0,0), OFFSET_ARMOR = list(0,0), OFFSET_HANDS = list(0,0), OFFSET_UNDIES = list(0,0), \
	OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
	OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
	OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,-1), OFFSET_BACK_F = list(0,-1), \
	OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
	OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0))
	specstats = list("strength" = 0, "perception" = 1, "intelligence" = 2, "constitution" = -1, "endurance" = -1, "speed" = 1, "fortune" = 1)
	specstats_f = list("strength" = 0, "perception" = 1, "intelligence" = 2, "constitution" = -1, "endurance" = -1, "speed" = 1, "fortune" = 1)
	enflamed_icon = "widefire"
	patreon_req = 1

	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
	)
	body_markings = list(
		/datum/body_marking/tonage,
	)

/datum/species/anakim/check_roundstart_eligible()
	return TRUE

/datum/species/anakim/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	C.grant_language(/datum/language/common)

/datum/species/anakim/after_creation(mob/living/carbon/C)
	..()
	C.grant_language(/datum/language/celestial)
	to_chat(C, "<span class='info'>I can speak Celestial with ,c before my speech.</span>")

/datum/species/anakim/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
	C.remove_language(/datum/language/celestial)

/datum/species/anakim/handle_speech(datum/source, list/speech_args)
	. = ..()
	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		if(message[1])
			if(message[1] != "*")
				message = " [message]"
				var/list/accent_words = strings("accent_universal.json", "universal")

				for(var/key in accent_words)
					var/value = accent_words[key]
					if(islist(value))
						value = pick(value)

					message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
					message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
					message = replacetextEx(message, " [key]", " [value]")

	speech_args[SPEECH_MESSAGE] = trim(message)

/datum/species/anakim/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/anakim/get_skin_list()
	return sortList(list(
		"Planetar" = SKIN_COLOR_PLANETAR, // - (Gold)
		"Deva"	   = SKIN_COLOR_DEVA, // - (Sky blue)
		"Solar" = SKIN_COLOR_SOLAR, // - (White stone)
		"Empyrea" = SKIN_COLOR_EMPYREA, // - (Periwinkle blue)
		"Gaeia" = SKIN_COLOR_GAEIA, // - (Orange)
		"Celestial" = SKIN_COLOR_CELESTIAL, // - (Yellow)
		"Olympia" = SKIN_COLOR_OLYMPIA, // - (Seafoam green)
		"Necral" = SKIN_COLOR_NECRAL, // - (Black onyx)
		"Abyssal" = SKIN_COLOR_ABYSSAL, // - (Deep blue)
	))

/datum/species/anakim/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b",

	"white - silver" = "d3d9e3",
	"white - alabaster" = "fffffc",
	"white - skies" = "a1b4d4",

	"yellow - sunlight" = "f3f797",
	"blond - strawberry" = "c69b71",
	"blond - pale" = "9d8d6e",

	"red - flame" = "ab4637",
	"red - sunset" = "bf6821",
	"red - blood" = "822b2b",
	"red - maroon" = "612929"
	))

/datum/species/anakim/random_name(gender,unique,lastname)

	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/aasm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/aasf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/other/aasm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/other/aasf.txt") )
	return randname

/datum/species/anakim/random_surname()
	return

/datum/species/anakim/get_accent_list()
	return strings("proper_replacement.json", "proper")

/* Patron requirement was reactivated; why?
Here's why! Anakim (IN MY OPINION) does not fit the tone or setting of this code.
They are wildly better than any other race and there's no reason to not choose them.
Hunger doesn't even kill, it just causes issues.
So what's the point of keeping them enabled when they give you more benefits then negatives? */
