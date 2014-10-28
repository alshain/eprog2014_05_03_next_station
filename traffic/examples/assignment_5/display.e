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

		do

				console.output (t.time_to_station (t.arriving))
				console.output (t.arriving.name)
				console.output (t.time_to_station (Zurich.line (t.line.number).next_station (t.arriving, t.destination)))
				console.output (Zurich.line (t.line.number).next_station (t.arriving, t.destination).name)
				console.output (t.time_to_station (Zurich.line (t.line.number).next_station (t.departed, t.destination)))
				console.output (Zurich.line (t.line.number).next_station (t.departed, t.destination).name)
				console.output (t.time_to_station (t.arriving))

		end

end
