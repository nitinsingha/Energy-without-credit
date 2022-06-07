% Calling function main
function [blocks_1, blocks_2, blocks_3, blocks_4, blocks_5]=logBlock(node,Id1,Id2,Id3,Id4,Id5)
% Returns the blockc requirement at various nodes 
% Retrieving  network constants.
CONST=networkConstants();  
n=CONST.n;   % Total number of nodes in the network
if(node(Id1).type==0)
    blocks_1=-node(Id1).request;
else
    blocks_1=node(Id1).service;
end  
if(node(Id2).type==0)
    blocks_2=-node(Id2).request;
else
    blocks_2=node(Id2).service;
end   
if(node(Id3).type==0)
    blocks_3=-node(Id3).request;
else
    blocks_3=node(Id3).service;
end  
if(node(Id4).type==0)
    blocks_4=-node(Id4).request;
else
    blocks_4=node(Id4).service;
end   
if(node(Id5).type==0)
    blocks_5=-node(Id5).request;
else
    blocks_5=node(Id5).service;
end  

end

