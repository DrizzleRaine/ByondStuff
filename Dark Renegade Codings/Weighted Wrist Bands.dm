obj/Equipment
	Wrist
		icon='Wrist Weight.dmi'
		name = "Wrists Weights"
		density = 0
		equiped = 0
		value = 500
		Click()
			if(src in usr:contents)
				if(!src.item_owner)
					switch(alert("This item is not Bio-Linked. Do you wish to Bio-Link it now?","","Yes","No"))
						if("Yes")src.item_owner=usr.key
				if(!usr.weightwrist)
					if(usr.hands == "EMPTY")
						if(src.equiped)
							usr<<"Error: [src] is already equipped!"
							return
						if(src.item_owner!=usr.key&&src.item_owner)
							usr<<"Error: This item is Bio-Linked to someone."
							return
						usr.overlays += src.icon
						usr<<"You have equiped the: <u>[src]</u>."
						suffix = "(Worn)"
						usr.weight+=src.weight
						usr.hands = src.name
						usr.weightwrist = 1
						src.equiped = 1
						usr.Skills_Checker()
						return
					else
						usr<<"Error: You already have something equipped on your Hands!"
						return
				if(usr.weightwrist >= 1)
					if(src.equiped)
						usr.overlays -= src.icon
						usr<<"You have unequiped the: <u>[src]</u>."
						suffix = null
						usr.hands = "EMPTY"
						usr.weight-=src.weight
						usr.weightwrist = 0
						src.equiped = 0
					else
						usr<<"Error: You may only have one of: <u>[src]</u> equipped."
						return
		verb
			Pick_Up()
				set src in oview(0)
				set category = null
				if(usr.CheckInventory()==TRUE)return
				if(Move(usr))
					usr<<"You have picked up the: <u>[src]</u>."
					usr.inven_min += 1
			Drop()
				set category = null
				if(!src.equiped)
					src.loc = usr.loc
					usr<<"You have dropped the: <u>[src]</u>."
					usr.inven_min -= 1
				else usr<<"You are unable to drop: <u>[src]</u>, it's already equipped."
obj/Equipment/F_Armor
	name =  "Freiza Armor"
	icon='Freiza_Armor.dmi'
	density = 0
	equiped = 0
	value = 500
	Click()
		if(src in usr:contents)
			if(!src.item_owner)
				switch(alert("This item is not Bio-Linked. Do you wish to Bio-Link it now?","","Yes","No"))
					if("Yes")src.item_owner=usr.key
			if(!usr.f_armor)
				if(usr.back == "EMPTY")
					if(src.equiped)
						usr<<"Error: </B> [src] is already equipped!"
						return
					if(src.item_owner!=usr.key&&src.item_owner)
						usr<<"Error: This item is Bio-Linked to someone."
						return
					usr.overlays += src.icon
					usr<<"You have equiped the: <u>[src]</u>."
					suffix = "(Worn)"
					usr.weight+=src.weight
					usr.back = src.name
					usr.f_armor = 1
					src.equiped = 1
					return
				else
					usr<<"Error: You already have something equipped on your Shoulders!"
					return
			if(usr.f_armor>=1)
				if(src.equiped)
					usr.overlays -= src.icon
					usr<<"You have unequiped the: <u>[src]</u>."
					usr.weight-=src.weight
					suffix = null
					usr.back = "EMPTY"
					usr.f_armor = 0
					src.equiped = 0
					return
				else
					usr<<"Error:</B> You may only have one of: <u>[src]</u> equipped."
					return
	verb
		Pick_Up()
			set src in oview(0)
			set category = null
			if(usr.CheckInventory()==TRUE)return
			if(Move(usr))
				usr<<"You have picked up the: <u>[src]</u>."
				usr.inven_min += 1
		Drop()
			set category = null
			if(!src.equiped)
				src.loc = usr.loc
				usr.inven_min -= 1
				usr<<"You have dropped the: <u>[src]</u>."
			else usr<<"You are unable to drop: <u>[src]</u>, it's already equipped."