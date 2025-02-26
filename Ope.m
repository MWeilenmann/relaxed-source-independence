classdef Ope
    %class for projector operators
    
    properties
        setting=-1
        %if equal to 1, the operator represents the identity
        id=0
        %if equal to 1, the operator represents a projector
        meas =0
    end
    
    methods
        function ope = Ope(tipo)
            if tipo>0
                %measurement operator
                
                ope.setting=tipo;                
                ope.meas=1;
            else
                %identity operator
                ope.id =1;
            end
            
        end
    function cadena = text(ope)
        %subroutine that links every operator to a string
        if ope.id
            cadena='1';
        else
            cadena="E_{"+ num2str(ope.setting)+"}";
            
        end
        
    end
    
    function disp(ope)
        %function to display an operator
        disp(text(ope));
        
    end
    function bol = eq(ope1, ope2)
        %determine if two operators are the same
        bol =0;
        if (ope1.meas == ope2.meas) && (ope1.id == ope2.id) && (ope1.setting == ope2.setting)
           bol =1; 
        end
        bol = logical(bol);
    end
        
        
    end
    
end

