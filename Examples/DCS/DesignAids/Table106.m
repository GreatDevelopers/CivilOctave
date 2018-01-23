# Table 1-4 of SP16, Page 47-50

fckT =  Material.Conc.f_ck;
fyT = Material.Steel.f_y;

iI = columns(fckT);
jJ = columns(fyT);
kK = columns(steelpt);

for i = 1:iI
 for j = 1:jJ
  maxPt = interp2(fckT, fyT, Table(5).Content,fckT(i),fyT(j));

   for k = 1:kK
     if ( steelpt(k) > maxPt )
#       MuBYbd2(i,j,k) = NaN;
     else
       MuBYbd2(i,j,k) = 0.87 * fyT(j) * steelpt(k)/100. * ...
       ( 1. - 1.005 * fyT(j)/fckT(i) * steelpt(k)/100. );
     end
   end  

 end
end

# Produce final table
TabContent = [ MuBYbd2 ];

# Produce 2D Tables

for i = 1:iI

tmpID = 50 + i; # Table number

Table(tmpID).ID = "1-4";
Table(tmpID).Source = "SP16";
Table(tmpID).Caption = "Reinforcement Percentage $p_t$ for Singly ";
Table(tmpID).Caption = [ Table(tmpID).Caption "Reinforced Sections for M"];
Table(tmpID).Caption = [ Table(tmpID).Caption num2str(fckT(i)) ];
Table(tmpID).Clause = ["???"];
Table(tmpID).Header = ["$p_t$"];

#  for j = 1:jJ
#    for k = 1:kK

      Table(tmpID).Content = squeeze(TabContent(i,:,:));
 Table(tmpID).Content = Table(tmpID).Content;
#size (Table(tmpID).Content)
#     tableTex2D(fyT, steelpt, Table(tmpID), fileID);
     tableTex2D(steelpt, fyT, Table(tmpID), fileID);

#    end
#  end
end


# PrintTable =  [0 Material.Conc.f_ck; Material.Steel.f_y' Table(6).Content];

# To display content of table uncomment following line, else
# comment it by #
#disp('Table 4')
#Table(6).Header
#PrintTable'

# EoF ==========
