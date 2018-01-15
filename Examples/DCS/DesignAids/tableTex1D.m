# Function to make TeX table

function tableTex1D(x, table2tex, fileID)

A = table2tex.Content;
nRows = rows(A);
sizex = columns(x);
buildTable = [x; A];

TableRow = "";
CellSep = "r|";

TableHead = ["\n\n\\begin{table}[!h]\n", "\\",...
 "begin{center}\n", "\\caption{", table2tex.Caption,"}", ...
 "\\begin{tabular}{"];

for i = 1:sizex+1
 TableHead = [TableHead,CellSep];
end
TableHead = [TableHead,"}\n"];

rowHead = {"$f_y$"};
#rowHead = [rowHead  table2tex.Header];

tmpText = [table2tex.Header];

rowHead = {rowHead;  tmpText};
IR = rows(buildTable);
JC = columns(buildTable);

for i = 1:IR
     TableHead = [TableHead, rowHead{i}, " & "];
  for j = 1:JC
    if ( (i>1) && (j>0) )
      TableHead = [TableHead, num2str(buildTable(i,j),"%8.3f")];
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

#disp(TableHead);

disp(char(TableHead))

endfunction
