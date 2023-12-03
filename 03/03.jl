function file_as_array()
  s = joinpath(@__DIR__, "input")
  return permutedims(stack(collect(l) for l in eachline(s)))
end

function is_symbol(c)
  return !(c in '0':'9' || c == '.')
end

function check(A, l, s, e)
  tocheck = []
  symbs = []
  if l > 1
    push!(tocheck, l - 1)
  end
  if l < size(A, 1)
    push!(tocheck, l + 1)
  end
  si = max(s - 1, 1)
  ei = min(e + 1, size(A, 2))
  for i in tocheck
    for j in si:ei
      if is_symbol(A[i, j])
        push!(symbs, (i, j))
      end
    end
  end
  if s > 1 && is_symbol(A[l, s - 1])
    push!(symbs, (l, s - 1))
  end
  if e < size(A, 2) && is_symbol(A[l, e + 1])
    push!(symbs, (l, e + 1))
  end

  return length(symbs) != 0, symbs
end

function find_first_number(v, start = 1)
  n = ""
  i = findnext(isnumeric, v, start)
  j = i
  if i == nothing
    return nothing
  end
  while j <= length(v) && isnumeric(v[j])
    j += 1
  end
  return i, j - 1, parse(Int, reduce(*, v[i:(j - 1)]))
end

function part1()
  A = file_as_array()
  res = 0
  for i in 1:size(A, 1)
    s = 1
    l = find_first_number(A[i, :], 1)
    while l != nothing
      si, ei, num = l
      if check(A, i, si, ei)[1]
        res += num
      end
      l = find_first_number(A[i, :], ei + 1)
    end
  end
  return res
end

function part2()
  A = file_as_array()
  res = 0
  part_number_with_symbs = []
  for i in 1:size(A, 1)
    s = 1
    l = find_first_number(A[i, :], 1)
    while l != nothing
      si, ei, num = l
      fl, symbs = check(A, i, si, ei)
      filter!(x ->A[x[1], x[2]] == '*', symbs)
      if length(symbs) > 0 
        push!(part_number_with_symbs, (num, symbs))
      end
      l = find_first_number(A[i, :], ei + 1)
    end
  end
  stars = Set()
  for x in part_number_with_symbs
    for y in x[2]
      push!(stars, y)
    end
  end
  res = zero(BigInt)
  for s in stars
    m = one(BigInt)
    cnt = 0
    for (x, y) in part_number_with_symbs
      if s in y
        cnt += 1
        m *= x
        if cnt > 2
          break
        end
      end
    end
    if cnt == 2
      res += m
    end
  end
  return res
end
