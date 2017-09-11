bler=0;
ber=0.0412;
m=255;
t=18;
for j=(t+1):m
    bler=bler+((nchoosek(m,j))*(ber^j)*((1-ber)^(m-j)));
end
bler
C_I=(((erfcinv(bler*2))^2)*2)/(3*32)
