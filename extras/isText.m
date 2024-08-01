function output = isText(myVar)
% returns true if argument is (string|char|cellstr)
    output = isstring(myVar)||ischar(myVar)||iscellstr(myVar);
end