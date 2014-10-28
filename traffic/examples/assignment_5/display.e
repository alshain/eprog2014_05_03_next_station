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
		across
			Zurich.lines as i
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
			i, time: INTEGER
			last_three: BOOLEAN
		do
			Console.output ("Welcome")
			from
				s:= Zurich.station (t.departed.name)
			until
				last_three or else i= 3
			loop
				s:= Zurich.line (t.line.number).next_station (s, t.destination)
				time:= t.time_to_station (s)//60

				if time=0 then
					Console.append_line ("<1 Min.%T" + Zurich.station (s.name).name + stop_info(t,s))
				else
					Console.append_line (time.out + "Min.%T" + Zurich.station (s.name).name + stop_info(t,s))
				end
			--	Console.append_line ( "%T" + stop_info(t,s))
				if s ~ t.destination then
					last_three:= True
				end
				i:= i + 1
			end
			If not last_three then
				time:= t.time_to_station (t.destination)//60
				Console.append_line ("...")
				if time=0 then
					Console.append_line ("<1 Min.%T" + Zurich.station (t.destination.name).name + stop_info(t,t.destination))
				else
					Console.append_line (time.out + "Min.%T" + Zurich.station (t.destination.name).name + stop_info(t,t.destination))
				end
			end

		end

	stop_info (t: PUBLIC_TRANSPORT; s:STATION): STRING
		require
			t_exists: t /= Void
			s_exists: s /= Void
		local
			pre_station, post_station: STATION
			station1,station2: STATION
			connections: STRING
			condition1, condition2: BOOLEAN
			i: like Zurich.lines.new_cursor
		do
			connections:= "%T"
			if t.is_towards_last then
				pre_station:= Zurich.line (t.line.number).next_station (s, t.line.first)
			else
				pre_station:= Zurich.line (t.line.number).next_station (s, t.line.last)
			end
			post_station:= Zurich.line (t.line.number).next_station (s, t.destination)

			from
				i:= Zurich.station (s.name).lines.new_cursor
			until
				i.after
			loop
				if not(s ~ i.item.first) then
					station1:= i.item.next_station (s, i.item.first)
				else
					station1:= i.item.first
				end
				if not(s ~ i.item.last) then
					station2:= i.item.next_station (s, i.item.last)
				else
					station2:= i.item.last
				end

				if not (i.item ~ t.line) then
					if (not (pre_station ~ station1) and not (pre_station ~ station2))
				 	or else (not (post_station ~ station1) and not (post_station ~ station2))then

						if  post_station /= Void or else (post_station = Void and
						(not (t.line.has_station (station1))or else not(t.line.has_station (station2)))) then
							connections:= connections + i.item.number.out + " "
						end
					end
				end

				i.forth
			end
			result:= connections

		end

end
