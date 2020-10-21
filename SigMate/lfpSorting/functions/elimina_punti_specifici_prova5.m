function[pos_ok_max, pos_ok_min] = elimina_punti_specifici_prova5(matrice)

pippo = matrice;

[nr, nc] = size(pippo);
righe_da_non_cancellare = [];

a = 0;
pos_first_2 = find(pippo(:,2)==2,1);
if pos_first_2 == 1
    a = 1;                       % a = 2 se la sequenza incomincia con un 2.
else
    % a = pos_first_2 se la sequenza incomincia con un 1.
    % a = posizione corrispondente al primo 2.
    a = pos_first_2;
end                             

h = 1;
while a <= nr;
    if a == 1
        if (a+1) <= nr
            if pippo(a,2) ~= pippo(a+1,2)
                righe_da_non_cancellare(h) = a;
                h = h+1; 
            else
                inizio_seq = a;
                fine_seq = 0;
                condizione = 1;
                p = 1;
            
                while (condizione == 1)
                if (a+p) < nr
                    if pippo(a+p, 2) ~= pippo(a,2)
                        fine_seq = a+p-1;
                        condizione = 0;
                    else 
                        p = p+1;
                    end
                else
                    if pippo(a+p,2) ~= pippo(a,2)
                        condizione = 0;
                        fine_seq = a+p-1;
                    else                           
                        condizione = 0;
                        fine_seq = a+p;
                    end
                end
                
                end
            
                vett_tmp = pippo(inizio_seq:fine_seq,3);
                if pippo(inizio_seq,2) == 1
                    [val pos] = min(vett_tmp);
                    pos = pos + inizio_seq - 1;
                    righe_da_non_cancellare(h) = pos;
                    h = h+1;
                else
                    [val pos] = max(vett_tmp);
                    pos = pos + inizio_seq - 1;
                    righe_da_non_cancellare(h) = pos;
                    h = h+1;
                end
                a = fine_seq;            
            end
        else
            righe_da_non_cancellare(h) = a;
            h = h+1;
        end
    else 
        if (a+1) > nr
            righe_da_non_cancellare(h) = a;
            h = h+1;
            a = nr+1;
        else
            if pippo(a,2) ~= pippo(a+1,2)
                righe_da_non_cancellare(h) = a;
                h = h+1;
            else 
                inizio_seq = a;
                fine_seq = 0;
                condizione = 1;
                p = 1;
            
                while (condizione == 1)
                if (a+p) < nr
                    if pippo(a+p, 2) ~= pippo(a,2)
                        fine_seq = a+p-1;
                        condizione = 0;
                    else 
                        p = p+1;
                    end
                else
                    if pippo(a+p,2) ~= pippo(a,2)
                        condizione = 0;
                        fine_seq = a+p-1;
                    else                           
                        condizione = 0;
                        fine_seq = a+p;
                    end
                end
                
                end
            
                vett_tmp = pippo(inizio_seq:fine_seq,3);
                if pippo(inizio_seq,2) == 1
                    [val pos] = min(vett_tmp);
                    pos = pos + inizio_seq - 1;
                    righe_da_non_cancellare(h) = pos;
                    h = h+1;
                else
                    [val pos] = max(vett_tmp);
                    pos = pos + inizio_seq - 1;
                    righe_da_non_cancellare(h) = pos;
                    h = h+1;
                end
                a = fine_seq;
            end
        end
    end
    a = a+1;
end

righe_ok_max = [];
righe_ok_min = [];
c = 1;
d = 1;
for b = 1:length(righe_da_non_cancellare)
    riga_tmp = righe_da_non_cancellare(b);
    if pippo(riga_tmp,2)==2
        righe_ok_max(c,:) = pippo(riga_tmp,:);
        c = c+1;
    else
        righe_ok_min(d,:) = pippo(riga_tmp,:);
        d = d+1;
    end
end

if isempty(righe_ok_max)
    pos_ok_max = 1;    
else
    pos_ok_max = righe_ok_max(:,1);
end
if isempty(righe_ok_min)
    pos_ok_min = 1;
else
    pos_ok_min = righe_ok_min(:,1);
end