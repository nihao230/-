%__________________________________________________________________%
%  Source code of the LEO (Matlab  R2020b)				         	%
%                                                                   %
%   Enhanced Marine Predators Algorithm with Local Escaping         %
%    Operator for Global Optimization                               %
%  Author and programmer: Mariusz Oszust, PhD, DSc                  %
%  marosz@prz.edu.pl												%
%  www.marosz.kia.prz.edu.pl                                        %
%  https://marosz.kia.prz.edu.pl/LEO-MPA.html    					%
%___________________________________________________________________%



% newSolutions - newNo of new Solutions
% orderY- order of sorted solutionsY to know which solutionsX should be replaced
 
  function [newSolutions, orderY]=LEO(solutionsX,solutionsY,newNo,cIter,itermax,lb,ub)
  
 
	newSolutions=[];
	orderY=[];
	 
	togetherY=solutionsY;
	together=solutionsX;
					
						 
	if size(togetherY,1 )==1						 
			  togetherY=togetherY'; %columns are processed 
	end
	  
	[w1,w2]=sort(togetherY ,'ascend')  ; % sorting	 
	togetherS=together(w2,:); %



    lb=min(togetherS);
    ub=max(togetherS); %new solution will use them. 
 
    
	 		
	nP= length(togetherY); 		
	Best_X=togetherS(1,:);
	
	
	nV = length(Best_X);
	
	  
	%similarity matrix	calculation			
	D = pdist(togetherS);  
	Z = squareform(D); %    
	averageS=mean(Z) ;	 	
	[war,indy]=sort(averageS ,'descend') ; 
	tmp=togetherS(indy ,:); 
	Xr2=tmp(1,:);   
	Xr1=tmp(nP,:); 

	 
	for lec=1:newNo % 	
		
		Xm = mean(togetherS);                  
        
		paramterNrnd=1*(1-(cIter/itermax) );			 
		Xnew =    Best_X +normrnd(0 ,paramterNrnd)*(Best_X-Xm)  ; 		%Prey_{in}
					
		
		 pr =.66; 
		
			if rand<pr      
			 
				X1 =    Best_X +normrnd(0 ,paramterNrnd)*(Best_X-Xr1)  ; 
				X2 =    Best_X +normrnd(0 ,paramterNrnd)*(Best_X-Xr2)  ; 
			  
				Xp =  lb+(ub-lb).*rand(1,nV);   
				 
				los=rand; 
			  
				if rand <0.5						 
										 
					Xnew =   (los*Xnew+(1-los)*Xp)+normrnd(0 ,paramterNrnd)*(X1-X2)  ;  %Prey_{in}^2				 
				else
					 
					Xnew =   (los*Best_X+(1-los)*Xp)+normrnd(0 ,paramterNrnd)*(X1-X2)  ;	%Prey_{in}^3 			
				end			
			end
		 
		 newSolutions =[newSolutions; Xnew  ];
		
		
	    if size(newSolutions,1)>=newNo	
			 break; % 
	    end
	end %for
 	
 
orderY= flip(w2) ;
 


 
 

		 
