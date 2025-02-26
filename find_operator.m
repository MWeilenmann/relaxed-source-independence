function index=find_operator(ope, lista)
%returns the index of the operator ope in list lista

index=-1;
for pos=1:length(lista)
    if ope==lista(pos)
        index=pos;
    end
end

end