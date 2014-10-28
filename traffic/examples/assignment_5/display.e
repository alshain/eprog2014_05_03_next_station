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
			-- Struktur (Zurich lines) wird als Variable i definiert (ein neuer Cursor i erstellent)
			loop
				i.item.add_transport
			--Schleife auf ein element (item) wird das feature add_transport angewendet (zu jeder linie ein Transportmittel hinzugefügt)
			--Schleife wird wiederholt für alle Linien von Zurich
			end

		end

	update_transport_display (t: PUBLIC_TRANSPORT)
			-- Update route information display inside transportation unit `t'.
		require
			t_exists: t /= Void
			--Vorbedingung t darf nicht void sein ( es muss Transportmittel geben)
		local
			i: INTEGER
			s: STATION
			-- i und s als lokale Variabeln des Typs INTEGER bzw STATION definiert
		do

			console.append_line (t.line.number.out + "Wilkommen")
			--zur Konsole werden Linien hinzugefügt für jedes ausgewählte Transportmittel t und die Liniennummer und "Willkommen" wird ausgegeben
		from
			i:= 1
			--start der Iteration mit 1
			s:= t.arriving
			-- s ist ankunftszeit (feature arriving auf objekt t)
			--feature update_transport_display wird immer wenn man  ein Transportmittel auswählt und das Programm ausführt

		until
			i>3 or s=Void
			-- Iteration geht bis es mehr i grösser als 3 ist oder bis s void ist ( also bis die 3 nächsten stationen vorbei sind oder es hört schon vorher auf wenn es keine Stationen s mehr hat)

		loop
			-- Info über Haltestelle (Transportmittel und Linie) in Konsole ausgeben
			console.append_line (stop_info (t,s))
			--Konsole gibt Informationen über Stop aus (ruft feature stop_information mit Argumenten t und s auf)
			s:= t.line.next_station (s, t.destination)
			-- s ist das feature next_station  auf Objekt t, mit der Zielstation t und der Station s
			--es wird immer ein transportmittel für die nächste station genommen mit argument Stationen und Ziel des Transportmittels (letztes Transportmittel)



			i:= i+1
			-- i um eins erhöht--> Schleife wird wiederholt für 2. Station und dann für 3. Station
			end
		if s/= Void then	--wenn station s nicht void ist dann
		if s/=t.destination then	--wenn station s nicht gleich Zieltransportmittel t ist dann
			console.append_line (stop_info (t,s))
			--dann in der Konsole Infos über den nächsten Stop ausgeben (feature stop_info aufrufen und in Konsole ausgeben)
			--infos über transportmitel und linie
			end
			console.append_line (stop_info (t,t.destination))
			-- wenn station s= t (gleich viele Linien wie Transportmittel) ist (s ist Zielstation) dann nochmals Stopinfo ausgeben (feature stop_information aufrufen)
		end

	end


stop_info (t:PUBLIC_TRANSPORT; s: STATION): STRING
	-- feature das informationen über den Stop (Haltestelle ) s des Typs STATION gibt und und über die A
	require
		t_exists: t/= Void -- t darf nicht void sein
		s_exists: s/= Void
	local
		time_minutes: INTEGER		-- lokale Variable für Zeit in Minuten ist ein INTEGER
		l: LINE						--lokale Variable für die Liniennummer ist vom Typ LINE
	do

		time_minutes:= t.time_to_station (s)//60 --rechnet time in seconds zu time in minutes
		if time_minutes =0 then
			Result:= "<1" -- wenn die Zeit in Minuten null ist gibt es < 1 zurück
		else
			Result:= time_minutes.out 		-- sonst gibt es die Zeit in Minuten aus
		end
		Result:=Result + "Minutes.%T"+s.name
		--gibt das resultat (zeit in minuten an) plus den String Minutes mit einem Tabulator und dann den Namen der Station s
		--

		end

		end


