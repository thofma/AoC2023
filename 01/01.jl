function part1()
  k = 0
  for l in eachline("input")
    # ASCII, so everything is fine
    n = parse(Int, l[findfirst(isdigit, l)] * l[findlast(isdigit, l)])
    k += n
  end
  return k
end

function part2()
  k = 0
  D = Dict(
           "one" => "1",
           "two" => "2",
           "three" => "3",
           "four" => "4",
           "five" => "5",
           "six" => "6",
           "seven" => "7",
           "eight" => "8",
           "nine" => "9"
          )
  for l in eachline("input")
    k += string_to_number(l)
  end
  return k
end

function string_to_number(l::String)
  D = Dict(
           "one" => "1",
           "two" => "2",
           "three" => "3",
           "four" => "4",
           "five" => "5",
           "six" => "6",
           "seven" => "7",
           "eight" => "8",
           "nine" => "9"
          )
  reg = r"[1-9]|one|two|three|four|five|six|seven|eight|nine"
  c = collect(eachmatch(reg, l, overlap = true))
  f, l =  first(c).match, last(c).match
  if haskey(D, f)
    f = D[f]
  end
  if haskey(D, l)
    l = D[l]
  end
  return parse(Int, f * l)
end

