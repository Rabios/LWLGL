-- Written by Rabia Alhaffar in 2/August/2020
-- Collision detection library,Feel free to use it without problems!
math = require("math")

collision = {

    rect = function(r1, r2)
        return r1.x < r2.x + r2.w and r1.x + r1.w > r2.x and r1.y < r2.y + r2.h and r1.y + r1.h > r2.y
    end,
	
    circle = function(c1, c2)
        return math.sqrt((c1.x - c2.x * c1.x - c2.x) + (c1.y + c2.y * c1.y + c2.y)) < c1.r + c2.r
    end,
	
    circle_rect = function(c, r)
        if math.abs(c.x - r.x - r.w / 2) > (r.w / 2 + c.r) or math.abs(c.y - r.y - r.h / 2) > (r.h / 2 + c.r) then return false end
        if math.abs(c.x - r.x - r.w / 2) <= (r.w / 2) or math.abs(c.y - r.y - r.h / 2) <= (r.h / 2) then return true end
        return math.abs(c.x - r.x - r.w / 2) - r.w / 2 * math.abs(c.x - r.x - r.w / 2) - r.w / 2 + abs(r.y - c.y - r.h / 2) - r.h / 2 * abs(c.y - r.y - r.h / 2) - r.h / 2 <= math.pow(c.r, 2)
    end,
	
    circle_line = function(c, l)
        dist = 0
        u = ((c.x - l.x1) * (l.x2 - l.x1) + (c.y - l.y1) * (l.y2 - l.y1)) / ((l.y2 - l.y1) * (l.y2 - l.y1) + (l.x2 - l.x1) * (l.x2 - l.x1))
        if u >= 0 and u <= 1 then
            dist = math.pow((l.x1 + (l.x2 - l.x1) * u - c.x), 2) + math.pow((l.y1 + (l.y2 - l.y1) * u - c.y), 2)
        else
            if u < 0 then
                dist = math.pow((l.x1 - c.x), 2) + math.pow((l.y1 - c.y), 2)
            else
                dist = math.pow((l.x2 - c.x), 2) + math.pow((l.y2 - c.y), 2)
		    end
	    end
        return dist < math.pow(c.r, 2)
	end,

    cube = function(c1, c2)
        if math.abs(c1.x - c2.x) < c1.s + c2.s then
            if math.abs(c1.y - c2.y) < c1.s + c2.s then
                if math.abs(c1.z - c2.z) < c1.s + c2.s then
                    return true
				end
			end
        else
            return false
		end
	end,
	
    cuboid = function(c1, c2)
        if math.abs(c1.x - c2.x) < c1.w + c2.w then
            if math.abs(c1.y - c2.y) < c1.h + c2.h then
                if math.abs(c1.z - c2.z) < c1.l + c2.l then
                    return true
				end
			end
        else
            return false
		end
    end,

    sphere = function(s1, s2)
        d = math.sqrt((s1.x - s2.x) * (s1.x - s2.x) + (s1.y - s2.y) * (s1.y - s2.y) + (s1.z - s2.z) * (s1.z - s2.z))
        return d < (s1.size + s2.size)
	end,
	
    sphere_cube = function(s, c)

        if math.abs(s.x - c.x) >= (c.w + s.size) then return false end
        if math.abs(s.y - c.y) >= (c.h + s.size) then return false end
        if math.abs(s.z - c.z) >= (c.l + s.size) then return false end

        if math.abs(s.x - c.x) < c.w then return true end 
        if math.abs(s.y - c.y) < c.h then return true end
        if math.abs(s.z - c.z) < c.l then return true end

        d = ((math.abs(s.x - c.x) - c.w) * (math.abs(s.x - c.x) - c.w)) + ((math.abs(s.y - c.y) - c.h) * (math.abs(s.y - c.y) - c.h)) + ((math.abs(s.z - c.z) - c.l) * (math.abs(s.z - c.z) - c.l))

        return d < math.pow(s.size, 2)
    end
}

return collision