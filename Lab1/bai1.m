clc;
input='Faculty of Electronic and Telecommunication';
output='';
%Error
locate=[2,3,4,5,13,14,16,17,18,27,28,0];
error=[1,2,4,3,3,5,7,1,6,1,2];
%encode
for i=1:strlength(input)
    encode_char=dec2bin(input(i),7);
    output=strcat(output,encode_char);
    output=strcat(output," ");
    % fprintf('%s: %s\n',input(i),encode_char);
end

%After encode
fprintf('After encode: %s\n',output);

output2='';

%add error
for i=1:strlength(input)
    fprintf("%d ",i);
    encode_char=dec2bin(input(i),7);
    temp='';
    if ~isempty(locate)&&i==locate(1)
        temp=strcat(temp,encode_char);
        if temp(error(1))=='1'
            temp(error(1))='0';
        else 
            temp(error(1))='1';
        end
        locate(1)=[];
        error(1)=[];
        output2=strcat(output2,temp);
    else 
        output2=strcat(output2,encode_char);
    end    
    output2=strcat(output2," ");
end
encoded_chars = strsplit(output2, ' ');

for i = 1:numel(encoded_chars)
    decoded_char = char(bin2dec(encoded_chars{i}));
    for j=2:strlength(input)
        if input(j)==' '&&input(j)==decoded_char
            fprintf(" ")
            break;
        end
    end
    fprintf("%c",decoded_char);
end

