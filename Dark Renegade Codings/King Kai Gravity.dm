turf/Planet_Gravitys
	King_Kai
		Entered(mob/M)
			if(istype(M,/mob/PC))
				if(M.stamina<M.stamina_max)
					M.exp+=rand(2,4)
					M.stamina+=rand(1,3)
					if(M.stamina>M.stamina_max)M.stamina=M.stamina_max
					M.Level_Up()