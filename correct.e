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
					x: boolean
				when 3, 4 then
					y: real
					z: real
					if 3>5 then 
						x: real
					else
						_t: integer
					END
				when 2..4 then
					s: real
				else
					s: real
			end
			t: boolean
		end

	feature
		n: REAL
		q: REAL
		do
			if 3<4 then
				x: integer
			elseif 4<3 then
				x: boolean
			else
				x: double
			end
			from
				x:=3
				x:=h
			until
				i > 5
			loop
				he: boolean
				if 4<5 then
					b: boolean
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
					x : boolean
				else
					d: real
				end
			variant 
				n < 4
			end
		end
end
