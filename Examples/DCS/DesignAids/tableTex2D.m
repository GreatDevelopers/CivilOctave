# Function to make TeX table

function tableTex2D(x, y, table2tex, fileID)

A = table2tex.Content;
nRows = rows(A);
nColmns = columns(A);
sizey = columns(y);
sizex = columns(x);

buildTable = [0 x; y' A]';


TableRow = "";
CellSep = "r|";

TableHead = "\\";

TableHead = [TableHead, "begin{table}[!h]\n", "\\",...
 "begin{center}\n", "\\caption{", table2tex.Caption,"}", ...
 "\n\\begin{tabular}{"];

for i = 1:sizey+1
 TableHead = [TableHead,CellSep];
end
TableHead = [TableHead,"}\n"];
IR = rows(buildTable);
JC = columns(buildTable);

for i = 1:IR
  for j = 1:JC
    if ( (i>1) && (j>1) )
      TableHead = [TableHead, num2str(buildTable(i,j),"%8.2f")];
    else
      TableHead = [TableHead, num2str(buildTable(i,j))];
    end
    if ( j != JC)
	TableHead = [TableHead, " & "];
     else
        TableHead = [TableHead, " \\\\ \n "];
    end
  end
  if (i == 1)
    TableHead = [TableHead, " \\hline "];
  end
end

TableFoot = "\\end{tabular}\n \\end{center}\n";
TableFoot = [TableFoot, "\n\\label{tab:", table2tex.ID , ...
 "}\n", "\\end{table}" ];

TableFoot;
TableHead = [TableHead, TableFoot];

# fprintf(fileID,'%6s %12s\n','x','exp(x)');
#fprintf(fileID,TableHead);

#fprintf(fileID,'%6.2f %12.8f\n',A);

disp(TableHead);

endfunction
