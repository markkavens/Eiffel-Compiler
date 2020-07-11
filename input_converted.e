class application
	create
		make1
	feature
		i: string
		j: integer
		k: real

	feature
		l: string
		m: integer
		func:boolean
		do
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

	feature
		n: real
		q: real
		do
			if "hello" < "you" then
				x:=y
			elseif true = false then
				x :="hello" 
			else
				x:=r
			end
			from
				x:=3
				x:=h
			until
				i > 5
			loop
				he:="yup"
				if 4<5 then
					b:="no"
				end
			end

			from x:=3
				x:=h
			invariant
				x > 6
			until 
				i >= 10
			loop
				if 3<4 then 
					x := (-a+b*(c*5/(-5))/f-3)+8*(-45)
				else
					d := (true or temp xor (false and de or false) and false)
				end
			variant 
				n < 4
			end
		end
end
