function x = upadte_chatoic(x)

n = length(x);
for ii = 1:n
    obj = x(1,ii);
    x(1,ii) = 4 * obj * (1 - obj);
end
