%THE DEADTIME OF A G-M TUBE
clc
fprintf('              THE DEADTIME OF A G-M COUNTER\n')
fprintf('  This program calculates the deadtime in microseconds of a ')
fprintf('Geiger-Muller\ncounter from the counts obtained by the two source')
fprintf(' method. The count time\nshould be the same for each of the four')
fprintf(' counts Nb, N1, N12 and N2 which\nshould be entered in that ')
fprintf('order in response to the program prompts. The\nuncertainty in a')
fprintf(' count N will be taken as square root N.\n')
%THE REQUESTS FOR EXPERIMENTAL RESULTS FOLLOW.
%EACH ENTRY IS TESTED TO ENSURE THAT IT IS REAL AND POSITIVE (OR ZERO).
%THE BACKGROUND COUNT, Nb, MAY BE SET EQUAL TO ZERO WITHOUT AFFECTING
%THE RUNNING OF THE PROGRAM AND THIS VALUE MAY BE USED FOR CHECKING THE
%CORRECTNESS OF THE CALCULATIONS.
T = input('               The count time in seconds is ');
if T ~= abs(T)
fprintf('The count time must be REAL and POSITIVE. Try deadtime again.\n')
%break
else
end
Nb = input('      The back-ground count in this time is ');
if Nb ~= abs(Nb)
fprintf('This number should be REAL and POSITIVE. Try deadtime again.\n')
%break
else
end
N1 = input('The count with source 1 only in position is ');
if N1 ~= abs(N1)
fprintf('This number should be REAL and POSITIVE. Try deadtime again.\n')
%break
else
end
N12 = input('The count with both  sources in position is ');
if N12 ~= abs(N12)
fprintf('This number should be REAL and POSITIVE. Try deadtime again.\n')
%break
else
end
%FIRST TEST FOR SATISFACTORY DATA.
if N12 > N1
  N2 = input('The count with source 2 only in position is ');
  if N2 ~= abs(N2)
  fprintf('This number should be REAL and POSITIVE. Try deadtime again.\n')
%  break
  else
  end
%SECOND TEST FOR SATISFACTORY DATA.
  if N12 > N2
    A = N1 + N2;
    B = N12 + Nb;
%THIRD TEST FOR SATISFACTORY DATA. 
    if B >= A
    fprintf('\nThe statistical uncertainties in your measurements are ')
    fprintf('too large to permit a\nphysically sensible value of the ')
    fprintf('deadtime of the G-M counter.  You should repeat\nyour ')
    fprintf('measurements with a more suitable placement of the sources') 
    fprintf(', with due regard\nto the value of the background count.\n')
%    break
    else
    end
    H = A - B;
    DH = sqrt(A + B);
%FOURTH TEST FOR SATISFACTORY DATA.
    if H./DH < 6
fprintf('\nYour experimental results will give a value of the dead-time ')
fprintf('whose uncertainty  is far too large.  You should repeat ')
fprintf('the measurements with a higher count rate.\n')
%CALCULATION OF DEADTIME FROM SATISFACTORY DATA.
      else C = N1.*N2;
      D = N12.*Nb;
      E = C - D;
      F = B.*C - A.*D;
      Z = E - sqrt(E.^2 - H.*F);
      G = Z./F;
      tau = fix(1000000.*G.*T);
      fprintf(' \n              The deadtime is %4.0f microseconds\n\n',tau)
%CALCULATION OF THE UNCERTAINTY FOLLOWS
      DE = sqrt(A.*C + B.*D);
      DF = sqrt(A.*B.*B.*C +B.*C.*C - 4.*A.*C.*D - 4.*B.*C.*D + A.*A.*B.*D + A.*D.*D);
      DHF = sqrt((H.*DF).^2 + (F.*DH).^2);
      DZ = sqrt(DHF.^2./4 + (Z.*DE).^2)./(E-Z);
      DG = sqrt((F.*DZ).^2 + (Z.*DF).^2)./F.^2;
      Dtau = fix(1000000.*DG.*T);
      fprintf('            The uncertainty is %3.0f microseconds\n\n',Dtau)  
        if Dtau < tau./10
        fprintf('                            WELL DONE.\n')
        elseif Dtau < tau./5
        fprintf('     Uncertainty is large. You could improve on this.\n')
        else
       fprintf('Uncertainty is unacceptably large. Repeat measurements.\n')
        end
    end
  else
  fprintf('\nYour results will not give a physically reasonable value of ')
  fprintf('the deadtime since\nN12 is less than N2 which implies that ')
  fprintf('the tube was probably saturated by an\nexcessively high flux ')
 fprintf('of radiation from the sources.  Repeat your measurements\nwith ')
  fprintf('a more suitable geometry.\n')
end
else
fprintf('\nYour results will not give a physically reasonable value of ')
fprintf('the deadtime since\nN12 is less than N1 which implies that ')
fprintf('the tube was probably saturated by an\nexcessively high flux ')
fprintf('of radiation from the sources.  Repeat your measurements\nwith ')
fprintf('a more suitable geometry.\n')
end