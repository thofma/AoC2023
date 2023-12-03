function parse_line(s::String)
  id = parse(Int, split(split(s, ":")[1], " ")[2])
  s = split(s, ":")[2]
  s = strip(s) 
  res = [] 
  for ss in split(s, ";")
    ss = strip(ss)
    r = 0
    g = 0
    b = 0
    for sss in split(ss, ",")
      sss = strip(sss)
      n = parse(Int, split(sss, " ")[1])
      if contains(sss, "red")
        r += n
      elseif contains(sss, "green")
        g += n
      elseif contains(sss, "blue")
        b += n
      end
    end
    push!(res, (red = r, green = g, blue = b))
  end
  id, res
end

function part1()
  tr = 12
  tg = 13
  tb = 14
  cnt = 0

  for s in eachline("input")
    id, r = parse_line(s)
    if all(rr -> rr.red <= tr && rr.green <= tg && rr.blue <= tb, r)
      cnt += id
    end
  end
  return cnt 
end

function part2()
  cnt = BigInt(0)

  for s in eachline("input")
    id, r = parse_line(s)
    rmax = maximum(x -> x.red, r)
    gmax = maximum(x -> x.green, r)
    bmax = maximum(x -> x.blue, r)
    power = prod(BigInt.([rmax, gmax, bmax]))
    cnt += power
  end
  return cnt
end
