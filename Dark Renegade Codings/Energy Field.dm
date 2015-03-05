obj/Technique/EnergyField
	verb
		Energy_Field()
			set category = "Techniques"
			if(usr.tech_cooldown)
				usr<<"You must cooldown."
				return
			if(usr.doing)
				usr<<"You are doing something."
				return
			if(usr.frozen)
				return
			if(usr.ki<50000)
				usr<<"Your ki is too low."
				return
			if(usr.ki_lock)
				src<<"You can't use ki right now."
				return
			if(usr.safe)
				usr<<"You can't attack right now."
				return
			if(!usr.pk)
				usr<<"You are not a combatant!"
				return
			usr.icon_state = "enrage"
			usr.tech_cooldown=1
			usr.frozen = 1
			usr.using=1
			usr.doing=1
			sleep(15)
			usr.overlays += new/obj/techs/Overlays/Field_Center
			sleep(30)
			usr.overlays -= new/obj/techs/Overlays/Field_Center
			for(var/turf/Floors/Safe_Zone/S in view(8))
				if(S in oview(8))
					usr<<"Safe Zone!"
					usr.FIELD()
					return
			var/damage = usr.ki*2
			for(var/mob/M in oview(8,usr))
				new/obj/techs/Overlays/Crater_Center(src.loc)
				if(!M.dead&&!M.safe&&M.pk)
					var/turf/CL=M.loc
					for(var/turf/Floors/Safe_Zone/SZ in CL)continue
					var/chance1 = rand(1,100)
					var/chance2= rand(1,100)
					var/damage1=(damage*chance1*0.01)-(M.kidefense*chance2*0.01)/(((2+get_dist(usr,M))/2))
					if(damage1 < 0)damage1 = (damage*0.0001)*chance1
					if(damage1 < 1)damage1 = 1
					M.powerlevel-=damage1
					M.DeathCheck(usr)
			usr.using=0
			usr.FIELD()
mob/proc
	FIELD()
		src.powerlevel=src.powerlevel/2
		src.rest = 0
		src.frozen = 0
		src.boxing = 0
		src.doing = 0
		src.icon_state = ""
		src.density = 1
		src.attack_lock = 0
		src.ki_lock = 0
		src.ki = 0
		src.rage = 0
		spawn(70)if(src)src.tech_cooldown=0
		src.overlays -= new/obj/techs/Overlays/Field_Center
		for(var/obj/techs/Overlays/O in src)del(O)