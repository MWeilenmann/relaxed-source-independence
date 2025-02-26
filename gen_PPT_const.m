function C_PPT=gen_PPT_const(const_mom,nA,nC)
%given the matrix of moment constraints const_mom, it generates a matrix PPT such
%that x*PPT==0 implies that x*const_mom is self-PT

%number of variables
L=size(const_mom,1);

%dimensions of Alice's and Bob's subsystems (within the moment matrix)
mA=length(all_seq(nA, 3));
mC=length(all_seq(nC, 6));

%total size of moment matrix
m= mA*mC;

%list of rows that have already been accounted for
discarded=[];
C_PPT=[];
disp("Computing self-PT constraints for nA="+num2str(nA)+", nC="+num2str(nC)+".");
   
for k=1:L
   tic;
   if not(ismember(k, discarded))
        %choose a row, make it a matrix, partially transpose it and
        %transform it again into a row
        component=reshape(const_mom(k,:), m,m);
        component_PT=reshape(partialTranspose(component,[1],[mA,mC]),1,m^2);
        %find location of new row in const_mom
        %we exploit the fact that all the rows have orthogonal supports:
        %this means that all rows are orthogonal to component_PT except the
        %one that is identical to it
        loc=find(const_mom*component_PT');

        if not(loc==k)
            %add loc to list of discarded
            discarded=[discarded;loc];
            %create constraint that equals the variables multiplying
            %reshape(const_mom(k,:),m,m) and reshape(const_mom(loc,:),m,m)
            v= ket(loc,L)-ket(k,L);
            %add constraint to constraint list
            C_PPT=[C_PPT,v];
        end
   end
   %progress report
   if mod(k,10)==0
        clc;
        duration=toc*(L-k);
        disp("Computing self-PT constraints for nA="+num2str(nA)+", nC="+num2str(nC)+".");
        disp("Estimated time to finish: "+num2str(duration)+" seconds.");
   end
   
   
end
            
clc;
disp("Task complete.");
            

end

