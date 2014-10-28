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
			i: INTEGER
			s: STATION
		do
			console.clear
			console.append_line (t.line.number.out + " Willkommen/Welcome")
			from
				i := 1
				s := t.arriving
			until
				i > 3 or s = Void
			loop
				console.append_line (stop_info (t, s))
				s := t.line.next_station (s, t.destination)
				i := i + 1
			end
			if s /= Void then
				if s /= t.destination then
					console.append_line ("...")
				end
				console.append_line (stop_info (t, t.destination))
			end
		end

	stop_info (t: PUBLIC_TRANSPORT; s: STATION): STRING
			-- Information about stop `s' of transportation unit `t'.
		require
			t_exists: t /= Void
			s_on_line: t.line.has_station (s)
		local
			time_min: INTEGER
			l: LINE
		do
			time_min := t.time_to_station (s) // 60
			if time_min = 0 then
				Result := "<1"
			else
				Result := time_min.out
			end
			Result := Result + "  Min.%T" + s.name			
			
			-- Optional task:
			across
				s.lines as i
			loop
				l := i.item
				if l /= t.line and
					((l.next_station (s, l.first) /= Void and not
						t.line.has_station (l.next_station (s, l.first))) or
					(l.next_station (s, l.last) /= Void and not
						t.line.has_station (l.next_station (s, l.last)))) then
					Result := Result + " " + i.item.number.out
				end
			end
		end

end
