note
	description: "Route information displays."

class
	DISPLAY

inherit
	ZURICH_OBJECTS

feature -- Explore Zurich

	add_public_transport
			-- Add a public transportation unit per line.
		do
				-- Your code here
				across
					zurich.lines as i
				loop
					i.item.add_transport
				end
		end

	update_transport_display (t: PUBLIC_TRANSPORT)
			-- Update route information display inside transportation unit `t'.

		require
			t_exists: t /= Void
		local
			s: STATION
			i: INTEGER
		do
				-- Your code here
			console.clear
			console.output ("Willkommen!")
			from
				s:= t.arriving
				i:= 0
			until
				i = 3 or s = Void
			loop
				console.append_line (stop_info(t,s))
				s:= t.line.next_station (s, t.destination)
				i:= i + 1
			end

			if s /= Void then
				if s /= t.destination then
					console.append_line ("   ")
				end
				console.append_line (stop_info (t, t.destination).out)
				end
		end

	stop_info(t: PUBLIC_TRANSPORT; s: STATION): STRING
		local
			time_min: INTEGER

		do
			time_min:= t.time_to_station (s) // 60
			if time_min <=1
			then Result:= "<1"
			else Result:= time_min.out
		end
			Result:= Result + "Min." + s.name
		end
end
