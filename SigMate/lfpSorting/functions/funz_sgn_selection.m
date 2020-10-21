function[sgn_selected] = funz_sgn_selection(vet_indici)

sgn_selected = round(vet_indici(1) + (vet_indici(end) - vet_indici(1))*rand(1));
