obj/Equipment
	GiNew
		icon='Goku Suit(NIK).dmi'
		name = "New Gi"
		density = 0
		equiped = 0
		value = 1000
		Click()
			if(src in usr:contents)
				if(!src.item_owner)
					switch(alert("This item is not Bio-Linked. Do you wish to Bio-Link it now?","","Yes","No"))
						if("Yes")src.item_owner=usr.key
				if(!usr.weightgi)
					if(usr.chest == "EMPTY")
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
						usr.chest = src.name
						usr.weightgi = 1
						src.equiped = 1
						usr.Skills_Checker()
						return
					else
						usr<<"Error: You already have something equipped on your Chest or Shoulders!"
						return
				if(usr.weightgi >= 1)
					if(src.equiped)
						usr.overlays -= src.icon
						usr<<"You have unequiped the: <u>[src]</u>."
						suffix = null
						usr.chest = "EMPTY"
						usr.weight-=src.weight
						usr.weightgi = 0
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