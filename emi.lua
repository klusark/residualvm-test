writevec3 = function(file, actor, func)
	local x,y,z = func(actor)
	local text = "(" .. x .. "," .. y .. "," .. z .. ")\n"
	write(file, text)
end


attachTest = function(file, p1, p2, p3)
	local actor1 = LoadActor("testactor1")
	local actor2 = LoadActor("testactor2")
	local actor3 = LoadActor("testactor3")
	PutActorAt(actor1, 0, 0, 0)
	PutActorAt(actor2, 0, 0, 0)
	PutActorAt(actor3, 0, 0, 0)
	SetActorRot(actor1, p1["x"], p1["y"], p1["z"])
	SetActorRot(actor2, p2["x"], p2["y"], p2["z"])
	SetActorRot(actor3, p3["x"], p3["y"], p3["z"])
	AttachActor(actor2, actor1, nil)
	AttachActor(actor3, actor2, nil)
	writevec3(file, actor3, GetActorRot)
	--DetachActor(actor3)
	--writepos(file, actor3)
end

attachtestcoord = function(file, p1, p2, coord1, coord2)
	local i = 0
	local angle = -120
	while i < 17 do
		local p3 = { x = 0, y = 0, z = 0 }
		p3[coord1] = angle
		if coord2 then
			p3[coord2] = angle
		end
		attachTest(file, p1, p2, p3)
		angle = angle + 15
		i = i + 1
	end
end

attachcoords = function(file, p1, p2)
	attachtestcoord(file, p1, p2, "x")
	attachtestcoord(file, p1, p2, "y")
	attachtestcoord(file, p1, p2, "z")
	attachtestcoord(file, p1, p2, "x", "y")
	attachtestcoord(file, p1, p2, "x", "z")
	attachtestcoord(file, p1, p2, "y", "z")
end

test1 = function(file)
	write(file, "test1 start\n")
	attachcoords(file, { x = 0, y = 0, z = 0 }, { x = 20, y = 20, z = 20 })
	attachcoords(file, { x = 20, y = 20, z = 20 }, { x = 30, y = 30, z = 30 })
	attachcoords(file, { x = 0, y = 0, z = 0 }, { x = -20, y = -20, z = -20 })
	write(file, "test1 end\n")
end

test2simpleattach = function(file, r1, r2)
	local actor1 = LoadActor("testactor1")
	local actor2 = LoadActor("testactor2")
	PutActorAt(actor1, 1, 2, 3)
	PutActorAt(actor2, 2, 4, 6)
	SetActorRot(actor1, r1["x"], r1["y"], r1["z"])
	SetActorRot(actor2, r2["x"], r2["y"], r2["z"])
	AttachActor(actor2, actor1, nil)
	writevec3(file, actor1, GetActorPos)
	writevec3(file, actor1, GetActorWorldPos)
	writevec3(file, actor1, GetActorRot)
	writevec3(file, actor2, GetActorPos)
	writevec3(file, actor2, GetActorWorldPos)
	writevec3(file, actor2, GetActorRot)
end

test2 = function(file)
	write(file, "test2 start\n")
	test2simpleattach(file, { x = 0, y = 90, z = 0 }, { x = 0, y = 0, z = 0 })
	test2simpleattach(file, { x = 0, y = 90, z = 0 }, { x = 20, y = 0, z = 0 })
	write(file, "test2 end\n")
end



runtests = function()
	local file, err = writeto("testoutput.txt")
	
	test1(file)
	test2(file)
	
	writeto()
end
runtests()