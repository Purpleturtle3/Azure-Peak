/datum/job/roguetown/manorguard
	title = "Town Watch"
	flag = MANATARMS
	department_flag = GARRISON
	faction = "Station"
	total_positions = 8
	spawn_positions = 8

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	tutorial = "For reasons only known to yourself, you have joined the volunteer forces of the town's watch. \
				Having proven competent at the basics of combat, you recieved training and equipment from your betters. \
				Obey your captain, and show the nobles your respect. Don't forget, serving is a privilege, and you may as well hold it over others."
	display_order = JDO_CASTLEGUARD
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/manorguard
	advclass_cat_rolls = list(CTAG_MENATARMS = 20)

	give_bank_account = 30 //thirty coins
	min_pq = 3
	max_pq = null
	round_contrib_points = 2

	cmode_music = 'sound/music/combat_ManAtArms.ogg'

/datum/outfit/job/roguetown/manorguard
	job_bitflag = BITFLAG_GARRISON

/datum/job/roguetown/manorguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/outfit/job/roguetown/manorguard/pre_equip(mob/living/carbon/human/H)
    ..()  // Moved the pre equip thingy up here so we don't need to repeat cloak code for every subclass

	// Choice of drip
    var/livery_options = list(
        "Guardhood" = /obj/item/clothing/cloak/stabard/guardhood,
        "Jupon"   = /obj/item/clothing/cloak/stabard/surcoat/guard,
		"Surcoat"	= /obj/item/clothing/cloak/stabard/guard,
		"Tabard"	= /obj/item/clothing/cloak/tabard/knight/guard
    )
    var/choice = input(H, "Choose your uniform.", "GUARD LIVERY") as anything in livery_options

    var/typepath = livery_options[choice]
    if(typepath)
        var/obj/item/clothing/C = new typepath(H)  

        // Get first name for display
        var/index = findtext(H.real_name, " ")
        var/fname
        if(index)
            fname = copytext(H.real_name, 1, index)
        else
            fname = H.real_name

        C.name = "[choice] ([fname])"

        // Equip into cloak slot
        H.equip_to_slot_or_del(C, SLOT_CLOAK)


/datum/outfit/job/roguetown/manorguard
	wrists = /obj/item/clothing/wrists/roguetown/bracers/iron
	gloves = /obj/item/clothing/gloves/roguetown/chain/iron
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/iron
	beltl = /obj/item/flashlight/flare/torch/lantern/prelit
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	id = /obj/item/scomstone/bad/garrison

// Melee goon
/datum/advclass/manorguard/footsman
	name = "Woodsman"
	tutorial = "You are a professional soldier of the realm, specializing in melee warfare. Stalwart and hardy, your body can both withstand and dish out powerful strikes.."
	outfit = /datum/outfit/job/roguetown/manorguard/footsman

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/manorguard/footsman/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/lumberjacking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

	H.change_stat("strength", 3)
	H.change_stat("constitution", 2)
	H.change_stat("perception", 2)
	H.change_stat("speed", -1)
	H.change_stat("intelligence", 1)

	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord	//Bit worse shirt protection than the archer
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/iron	//Makes up for worse shirt protection with kinda better armor protection
	pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	neck = /obj/item/clothing/neck/roguetown/chaincoif/iron

	H.adjust_blindness(-3)
	var/weapons = list("Axe & Shield","Halberd","Greataxe")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Axe & Shield")
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel
			backl = /obj/item/rogueweapon/shield/iron
		if("Halberd")
			r_hand = /obj/item/rogueweapon/halberd
			backl = /obj/item/gwstrap
		if("Greataxe")
			r_hand = /obj/item/rogueweapon/greataxe
			backl = /obj/item/gwstrap
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/keyring/guardcastle,
		)
	H.verbs |= /mob/proc/haltyell

	var/helmets = list(
	"Skull cap" 	= /obj/item/clothing/head/roguetown/helmet/skullcap,
	"Kettle Helmet" 	= /obj/item/clothing/head/roguetown/helmet/kettle/iron,
	"Sallet Helmet"		= /obj/item/clothing/head/roguetown/helmet/sallet/iron,
	"Horned Helmet" 	= /obj/item/clothing/head/roguetown/helmet/horned,
	"None"
	)
	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

// Ranged weapons and daggers on the side - lighter armor, but fleet!
/datum/advclass/manorguard/skirmisher
	name = "Hunter"
	tutorial = "You are a professional soldier of the realm, specializing in ranged implements. You sport a keen eye, looking for your enemies weaknesses."
	outfit = /datum/outfit/job/roguetown/manorguard/skirmisher

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/manorguard/skirmisher/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)		//Only effects draw and reload time.
	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)			//Only effects draw times.
	H.adjust_skillrank(/datum/skill/combat/slings, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // A little better; run fast, weak boy.
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)

	//Garrison ranged/speed class. Time to go wild
	H.change_stat("constitution", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("perception", 3)
	H.change_stat("speed", 1)

	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord			// Cant wear chainmail anymoooree
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded		//Helps against arrows; makes sense for a ranged-type role.
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	pants = /obj/item/clothing/under/roguetown/trou/leather

	H.adjust_blindness(-3)
	var/weapons = list("Crossbow","Bow","Sling")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Crossbow")
			H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			beltr = /obj/item/quiver/bolts
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
		if("Bow") 
			H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			beltr = /obj/item/quiver/arrows
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
		if("Sling")
			H.adjust_skillrank(/datum/skill/combat/slings, 2, TRUE)
			beltr = /obj/item/quiver/sling/iron
			r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/sling // Both are belt slots and it's not worth setting where the cugel goes for everyone else, sad.

	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/keyring/guardcastle,
		)
	H.verbs |= /mob/proc/haltyell

	var/helmets = list(
	"Skull cap" 	= /obj/item/clothing/head/roguetown/helmet/skullcap,
	"Kettle Helmet" 	= /obj/item/clothing/head/roguetown/helmet/kettle/iron,
	"Sallet Helmet"		= /obj/item/clothing/head/roguetown/helmet/sallet/iron,
	"Horned Helmet" 	= /obj/item/clothing/head/roguetown/helmet/horned,
	"None"
	)
	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

/datum/advclass/manorguard/cavalry
	name = "Brawler"
	tutorial = "You are a professional soldier of the realm, specializing in the steady beat of hoof falls. Lighter and more expendable then the knights, you charge with lance in hand."
	outfit = /datum/outfit/job/roguetown/manorguard/cavalry
	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/manorguard/cavalry/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE) 		// Still have a cugel.
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)	//Best whip training out of MAAs, they're strong.
	H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)			// We discourage horse archers, though.
	H.adjust_skillrank(/datum/skill/combat/slings, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) 
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

	//Garrison mounted class; charge and charge often.
	H.change_stat("strength", 1)
	H.change_stat("constitution", 2) 
	H.change_stat("endurance", 2) // Your name is speed, and speed is running.
	H.change_stat("intelligence", 1) // No strength to account for the nominally better weapons. We'll see.

	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord		//Bit worse shirt protection than the archer -- as foot soldier.
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale			//Makes up for worse shirt protection with kinda better armor protection
	pants = /obj/item/clothing/under/roguetown/chainlegs
	neck = /obj/item/clothing/neck/roguetown/gorget

	H.adjust_blindness(-3)
	var/weapons = list("Bardiche","Sword & Shield")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Bardiche")
			r_hand = /obj/item/rogueweapon/halberd/bardiche
			backl = /obj/item/gwstrap
		if("Sword & Shield")
			beltr = /obj/item/rogueweapon/sword/sabre
			backl = /obj/item/rogueweapon/shield/wood
	
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/keyring/guardcastle,
		)
	H.verbs |= /mob/proc/haltyell

	var/helmets = list(
	"Skull cap" 	= /obj/item/clothing/head/roguetown/helmet/skullcap,
	"Kettle Helmet" 	= /obj/item/clothing/head/roguetown/helmet/kettle/iron,
	"Sallet Helmet"		= /obj/item/clothing/head/roguetown/helmet/sallet/iron,
	"Horned Helmet" 	= /obj/item/clothing/head/roguetown/helmet/horned,
	"None"
	)
	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]
