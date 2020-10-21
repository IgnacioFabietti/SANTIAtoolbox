function[closer_pos] = closer_point(vect, value)
% find and return the position of the element presents inside the vector vect closer
% to the given value.

N = length(vect);
diff = zeros(N,1);

for a = 1:N
    diff(a) = abs(vect(a)-value);
end
closer_pos = find(diff == min(diff), 1);