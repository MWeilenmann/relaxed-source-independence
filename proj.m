function v=proj(k,d)
%generates the projector |k><k| in B(C^d)

v=ket(k,d)*bra(k,d);


end
