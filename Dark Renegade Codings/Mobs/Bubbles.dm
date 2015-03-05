mob/var/bubbles_caught = 0
mob
	NPC
		Bubbles
			name = "{NPC}Bubbles"
			icon_state = "Bubbles"
			density = 1
			dead = 0
			safe = 1
			it_blocked = 1
			itspecialblocked = 1
			New()
				..()
				src.AddName()
				spawn(10)if(src)Runaway()
			proc/Runaway()
				while(src)
					var/Found = FALSE
					for(var/mob/PC/P in oview(8)).
						step_away(src,P)
						Found = TRUE
						break
					if(Found != TRUE)sleep(10)
					sleep(10)
			verb/Catch()
				set src in oview(8)
				set category = "Actions"
				if(src in get_step(usr,usr.dir))
					if(usr.bubbles_caught)
						usr<<"You have already caught Bubbles!"
						return
					else
						usr<<"You have caught Bubbles!"
						usr.powerlevel_max *= 1.2
						usr.kk_quest_training ++
						usr.bubbles_caught = 1
				else return