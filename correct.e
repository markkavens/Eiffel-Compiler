class APPLICATION
	create
		make1
	feature
		i: STRING
		j: INTEGER
		k: REAL

	feature
		l: STRING
		m: INTEGER
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
						_t:=(false or true and t)
					END
				when 2..4 then
					s:=i
				else
					s:=x
			end
			x := (false xor true or true and false)
		end

	feature
		n: REAL
		q: REAL
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
					x := (a+b*(c*d/e)/f-g)
				else
					d := (true or false xor (false and true or true) and false)
				end
			variant 
				n < 4
			end
		end
end
