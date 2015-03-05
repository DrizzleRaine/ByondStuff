var
	const//Some nice and lengthy mathematical constants.  BYOND rounds them off, but I like to have 'em handy anyway.
		pi =	3.1415926535897932384626433832795
		sqrt2 =	1.4142135623730950488016887242097	//Square root of 2
		e =		2.7182818284590452353602874713527


proc
	xrange(atom/center, range)
		var/startx = center.x - range
		var/starty = center.y - range
		var/endx = center.x + range
		var/endy = center.y + range
		if(startx < 1) startx = 1
		if(starty < 1) starty = 1
		if(endx > world.maxx) endx = world.maxx
		if(endy > world.maxy) endy=world.maxy
		var/contents[] = list()
		for(var/turf/T in block(locate(startx, starty, center.z), locate(endx, endy, center.z)))
			contents += T
			contents += T.contents
		return contents

	get_steps(atom/ref,dir,num)
		var/x
		var/turf/T=ref:loc
		if(isturf(ref))
			T=ref
		for(x=0;x<num;x++)
			ref=get_step(ref,dir)
			if(!ref)break
			T=ref
		return T

	allclear(turf/T)
		if(isturf(T))
			if(T.density) return 0
		var/mob/M
		for(M as mob|obj in T)
			if(M.density)
				return 0
		return 1

	cardinal(atom/ref)
		return (list(get_step(ref,NORTH),get_step(ref,SOUTH),get_step(ref,EAST),get_step(ref,WEST)))

	cardinal_stuff(atom/ref)
		var/turfs[]=list(get_step(ref,NORTH),get_step(ref,SOUTH),get_step(ref,EAST),get_step(ref,WEST))
		var/stuff[]=list()
		var/turf/T
		for(T in turfs)
			stuff+=T.contents
		return stuff

	midpoint(atom/M,atom/N)
		var/turf/T = locate((N.x + M.x)/2, (N.y + M.y)/2, (N.z + M.z)/2)
		return T

	distance(atom/M,atom/N)
		return sqrt((N.x-M.x)**2 + (N.y-M.y)**2)

	getring(atom/M, radius)
		var/ring[] = list()
		var/turf/T
		for(T as turf in range(radius+1,M))
			if(abs(distance(T, M)-radius) < 0.5)//The < 0.5 check is to make sure the ring is smooth
				ring += T
		return ring

	getcircle(atom/M, radius)
		var/list/circle = list()
		var/turf/T
		for(T as turf in range(radius+3,M))		//The < 0.5 check is to ensure it has the same shape as
			if(distance(T, M) < radius + 0.5) 	//a get_ring() of the same radius
				circle += T
		return circle

	sign(x) //Should get bonus points for being the most compact code in the world!
		return ((x<0)?-1:((x>0)?1:0))

	getline(atom/M,atom/N)//Ultra-Fast Bresenham Line-Drawing Algorithm
		var/px=M.x		//starting x
		var/py=M.y
		var/line[] = list(locate(px,py,M.z))
		var/dx=N.x-px	//x distance
		var/dy=N.y-py
		var/dxabs=abs(dx)//Absolute value of x distance
		var/dyabs=abs(dy)
		var/sdx=sign(dx)	//Sign of x distance (+ or -)
		var/sdy=sign(dy)
		var/x=dxabs>>1	//Counters for steps taken, setting to distance/2
		var/y=dyabs>>1	//Bit-shifting makes me l33t.  It also makes getline() unnessecarrily fast.
		var/j			//Generic integer for counting
		if(dxabs>=dyabs)	//x distance is greater than y
			for(j=0;j<dxabs;j++)//It'll take dxabs steps to get there
				y+=dyabs
				if(y>=dxabs)	//Every dyabs steps, step once in y direction
					y-=dxabs
					py+=sdy
				px+=sdx		//Step on in x direction
				line+=locate(px,py,M.z)//Add the turf to the list
		else
			for(j=0;j<dyabs;j++)
				x+=dxabs
				if(x>=dyabs)
					x-=dyabs
					px+=sdx
				py+=sdy
				line+=locate(px,py,M.z)
		return line