function[sgn_selected] = ramdomAssignment(vet_indici)

sgn_selected = round(vet_indici(1) + (vet_indici(end) - vet_indici(1))*rand(1));
