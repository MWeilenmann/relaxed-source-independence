classdef Seq
    %class for operator monomials of non-commutative projector variables
    
    properties
        %list of operators. The associated monomial is
        %ops(1)ops(2)...ops(length(ops))
        ops
        
    end
    
    methods
        function seq =Seq(ops)
            %class constructor
            seq.ops = ops;
            
        end
        
        function seq2=ope_multiply(seq, ope)
            %multiply sequence seq by operator ope on the right
            ops = seq.ops;
            
            L = length(ops);
            
            
            if ops(L).meas && ope.meas
                if ops(L).setting == ope.setting
                    %if the settings of the last operator of the list and the new 
                    %operator are the same, the sequence doesn't change
                    seq2=seq;
                else
                    %if they are different, add new operator to the
                    %sequence list
                    ops(L+1)=ope;
                    seq2= Seq(ops);
                end
            elseif ops(L).id
                %if the last element equals the identity, then L=1 and
                %seq2=ope
                seq2=Seq([ope]);
            else
                %if not, then ope is the identity, so the sequence stays
                %the same
                seq2=seq;
                
            end
            
        end
        
        function final=mtimes(seq1, seq2)
            %product of two operator monomials
            ops2 = seq2.ops;
            final = seq1;
            for k =1:length(ops2)
                ope = ops2(k);
                final = ope_multiply(final, ope);
                
            end
        
        end
        
        function seq_ad=adjoint(seq)
            %adjoint of a monomial
            ops = seq.ops;
            %invert sequence
            ops = ops(length(ops):-1:1);
            %return new sequence
            seq_ad=Seq(ops);
            
        end
        function disp(seq)
           %display a monomial
           cadena = "";
           for k = 1:length(seq.ops)
               cadena = cadena+ text(seq.ops(k));
           end
           disp(cadena);
        end
        
        function bol = eq(seq1, seq2)
            %determine if two monomials are the same            
            if (length(seq1.ops)==length(seq2.ops))
                bol =1;
                for k =1:length(seq1.ops)
                    bol = and(bol, seq1.ops(k)==seq2.ops(k));
                end
            else
                bol =0;
            end
            bol = logical(bol);
        end
        
    end
    
    methods(Static)
        function seq=id
            %generates the identity monomial
            seq= Seq(Ope(0));
        end
        function seq=meas(setting)
            %generates the monomial corresponding to a single projection
            %operator E_setting
            seq= Seq([Ope(setting)]);
        end
    
    end
    
end

