function output = isText(myVar)
    output = isstring(myVar)||ischar(myVar)||iscellstr(myVar);
end