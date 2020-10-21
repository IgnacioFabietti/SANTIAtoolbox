function[Segnale_BIG_filtrato_posS_0] = funz_gen_sgn_big_filt_posS_0(TF_Matrix)

[nr nc] = size(TF_Matrix);

Segnale_BIG_filtrato_posS_0 = zeros(1,nr*nc);
pos_iniziale = 1;

for i = 1:nr
    pos_finale = pos_iniziale + nc - 1;
    Segnale_BIG_filtrato_posS_0(pos_iniziale:pos_finale) = TF_Matrix(i,:);
    pos_iniziale = pos_finale + 1;
end
    
    