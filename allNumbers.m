function vecto = allNumbers(num, d)
%given a list of integers d = [d_1,...,d_n] and a number num between 1 and prod(d), it
%returns the vector [s_1, ..., s_n] with 1<=s_j<=d_j.
%useful to eliminate nested loops
vecto = [];
num2 = num -1;

for k=1:length(d)
    %remainder of division by d(k)
    remain = mod(num2, d(k));
    %update vecto
    vecto = [vecto, remain + 1];
    %update number
    num2 = (num2-remain)/d(k);
    
    
end