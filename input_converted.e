--------------------------------------------
--------------------------------------------
--------eiffel is case-insensitive----------
--integer, integer, integer are all same----
--------------------------------------------
--------------------------------------------


class application
	create
		make
	feature
		i: string
		j: integer
		k: real

	feature
		l: string
		m: integer
		func:boolean
		do
			print("hello" + yourname + "! hope allwell")
			inspect 2<3
				when 2 then
					x:=y
				when 3, 4 then
					z:=45
					if 3>5 then 
						from i := 0
						until i <= 10
						loop
							x := i
						end
					else
						_t:=(false or true and true)
					end
				when 2..4 then
					s:=i
				else
					s:=x
			end
			x := (false xor true or true and false)
		end
		fun(x: real):double
		do
			temp := "hello"
		end

	feature
		n: real
		q(x: integer; i:real y: boolean)
		local
			j: integer
			k: boolean
		do
			if "hello" < "world" then
				x:=y
			elseif true = false then
				x :="world" 
			else
				x := "hello"
			end
			from
				x := 3
				x := h
			until
				i > 5
			loop
				lang:="eiffel"
				if 4<5 then
					is_correct := "yes"
				end
			end

			from 
				i := 3
				x := i
			invariant
				x > 6
			until 
				i >= 10
			loop
				if 3<4 then 
					x := (-a+b*(c*5/(-5))/f-3)+8*(-45)
				else
					d := (true or temp xor (false and bool_temp or false) and false)
				end
			variant 
				x - i
			end
		end
end
