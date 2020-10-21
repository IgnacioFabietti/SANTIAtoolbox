function[pos_best_next_to_zero] = funz_ricerca_fine_risposta(segnale, vett_MinMax_ord,m)

switch m
    case 1
        pos_iniziale = vett_MinMax_ord(1,1);
        segnale_tagliato = segnale(pos_iniziale+1:end);
        if segnale_tagliato(1) < 0
            % sort in genere va dal più piccolo al più grande.
            sgn_ord = sort(segnale_tagliato,'descend'); % dal + grande al più piccolo.
            if sgn_ord(1) > 0 % cioè se attraversa lo zero
                pos_best_next_to_zero = find(segnale_tagliato >= 0, 1);
                pos_best_next_to_zero = pos_best_next_to_zero + pos_iniziale;
            else % cioè se resta negativo
                vett_distance_from_zero = abs(segnale_tagliato);
                [vett_ord, posizioni] = sort(vett_distance_from_zero);
                pos_best_next_to_zero = posizioni(1) + pos_iniziale;
            end
        else
            sgn_ord = sort(segnale_tagliato, 'ascend');
            if sgn_ord(1) < 0 % cioè se attraversa lo zero
                pos_best_next_to_zero = find(segnale_tagliato <= 0, 1);
                pos_best_next_to_zero = pos_best_next_to_zero + pos_iniziale;
            else % cioè se resta positivo
                vett_distance_from_zero = abs(segnale_tagliato);
                [vett_ord, posizioni] = sort(vett_distance_from_zero);
                pos_best_next_to_zero = posizioni(1) + pos_iniziale;
            end
        end
            
%         vett_distance_from_zero = abs(segnale_tagliato);
%         [vett_ord, posizioni] = sort(vett_distance_from_zero);
%         pos_best_next_to_zero = posizioni(1) + pos_iniziale;
    case 2
        pos_iniziale = vett_MinMax_ord(2,1);
        segnale_tagliato = segnale(pos_iniziale+1:end);
        
        if segnale_tagliato(1) < 0
            % sort in genere va dal più piccolo al più grande.
            sgn_ord = sort(segnale_tagliato,'descend'); % dal + grande al più piccolo.
            if sgn_ord(1) > 0 % cioè se attraversa lo zero
                pos_best_next_to_zero = find(segnale_tagliato >= 0, 1);
                pos_best_next_to_zero = pos_best_next_to_zero + pos_iniziale;
            else % cioè se resta negativo
                vett_distance_from_zero = abs(segnale_tagliato);
                [vett_ord, posizioni] = sort(vett_distance_from_zero);
                pos_best_next_to_zero = posizioni(1) + pos_iniziale;
            end
        else
            sgn_ord = sort(segnale_tagliato, 'ascend');
            if sgn_ord(1) < 0 % cioè se attraversa lo zero
                pos_best_next_to_zero = find(segnale_tagliato <= 0, 1);
                pos_best_next_to_zero = pos_best_next_to_zero + pos_iniziale;
            else % cioè se resta positivo
                vett_distance_from_zero = abs(segnale_tagliato);
                [vett_ord, posizioni] = sort(vett_distance_from_zero);
                pos_best_next_to_zero = posizioni(1) + pos_iniziale;
            end
        end
        
%         vett_distance_from_zero = abs(segnale_tagliato);
%         [vett_ord, posizioni] = sort(vett_distance_from_zero);
%         pos_best_next_to_zero = posizioni(1) + pos_iniziale;
    case 3
        pos_iniziale = vett_MinMax_ord(3,1);
        segnale_tagliato = segnale(pos_iniziale+1:end);
        
        if segnale_tagliato(1) < 0
            % sort in genere va dal più piccolo al più grande.
            sgn_ord = sort(segnale_tagliato,'descend'); % dal + grande al più piccolo.
            if sgn_ord(1) > 0 % cioè se attraversa lo zero
                pos_best_next_to_zero = find(segnale_tagliato >= 0, 1);
                pos_best_next_to_zero = pos_best_next_to_zero + pos_iniziale;
            else % cioè se resta negativo
                vett_distance_from_zero = abs(segnale_tagliato);
                [vett_ord, posizioni] = sort(vett_distance_from_zero);
                pos_best_next_to_zero = posizioni(1) + pos_iniziale;
            end
        else
            sgn_ord = sort(segnale_tagliato, 'ascend');
            if sgn_ord(1) < 0 % cioè se attraversa lo zero
                pos_best_next_to_zero = find(segnale_tagliato <= 0, 1);
                pos_best_next_to_zero = pos_best_next_to_zero + pos_iniziale;
            else % cioè se resta positivo
                vett_distance_from_zero = abs(segnale_tagliato);
                [vett_ord, posizioni] = sort(vett_distance_from_zero);
                pos_best_next_to_zero = posizioni(1) + pos_iniziale;
            end
        end
        
%         vett_distance_from_zero = abs(segnale_tagliato);
%         [vett_ord, posizioni] = sort(vett_distance_from_zero);
%         pos_best_next_to_zero = posizioni(1) + pos_iniziale;
    case 4
        pos_iniziale = vett_MinMax_ord(4,1);
        segnale_tagliato = segnale(pos_iniziale+1:end);
        
        if segnale_tagliato(1) < 0
            % sort in genere va dal più piccolo al più grande.
            sgn_ord = sort(segnale_tagliato,'descend'); % dal + grande al più piccolo.
            if sgn_ord(1) > 0 % cioè se attraversa lo zero
                pos_best_next_to_zero = find(segnale_tagliato >= 0, 1);
                pos_best_next_to_zero = pos_best_next_to_zero + pos_iniziale;
            else % cioè se resta negativo
                vett_distance_from_zero = abs(segnale_tagliato);
                [vett_ord, posizioni] = sort(vett_distance_from_zero);
                pos_best_next_to_zero = posizioni(1) + pos_iniziale;
            end
        else
            sgn_ord = sort(segnale_tagliato, 'ascend');
            if sgn_ord(1) < 0 % cioè se attraversa lo zero
                pos_best_next_to_zero = find(segnale_tagliato <= 0, 1);
                pos_best_next_to_zero = pos_best_next_to_zero + pos_iniziale;
            else % cioè se resta positivo
                vett_distance_from_zero = abs(segnale_tagliato);
                [vett_ord, posizioni] = sort(vett_distance_from_zero);
                pos_best_next_to_zero = posizioni(1) + pos_iniziale;
            end
        end
        
%         vett_distance_from_zero = abs(segnale_tagliato);
%         [vett_ord, posizioni] = sort(vett_distance_from_zero);
%         pos_best_next_to_zero = posizioni(1) + pos_iniziale;
    case 5
        pos_iniziale = vett_MinMax_ord(4,1);
        segnale_tagliato = segnale(pos_iniziale+1:end);
        
        if segnale_tagliato(1) < 0
            % sort in genere va dal più piccolo al più grande.
            sgn_ord = sort(segnale_tagliato,'descend'); % dal + grande al più piccolo.
            if sgn_ord(1) > 0 % cioè se attraversa lo zero
                pos_best_next_to_zero = find(segnale_tagliato >= 0, 1);
                pos_best_next_to_zero = pos_best_next_to_zero + pos_iniziale;
            else % cioè se resta negativo
                vett_distance_from_zero = abs(segnale_tagliato);
                [vett_ord, posizioni] = sort(vett_distance_from_zero);
                pos_best_next_to_zero = posizioni(1) + pos_iniziale;
            end
        else
            sgn_ord = sort(segnale_tagliato, 'ascend');
            if sgn_ord(1) < 0 % cioè se attraversa lo zero
                pos_best_next_to_zero = find(segnale_tagliato <= 0, 1);
                pos_best_next_to_zero = pos_best_next_to_zero + pos_iniziale;
            else % cioè se resta positivo
                vett_distance_from_zero = abs(segnale_tagliato);
                [vett_ord, posizioni] = sort(vett_distance_from_zero);
                pos_best_next_to_zero = posizioni(1) + pos_iniziale;
            end
        end
        
%         vett_distance_from_zero = abs(segnale_tagliato);
%         [vett_ord, posizioni] = sort(vett_distance_from_zero);
%         pos_best_next_to_zero = posizioni(1) + pos_iniziale;
end
    