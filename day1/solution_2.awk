BEGIN {
  FS = ""
  numbers["one"] = 1;
  numbers["two"] = 2;
  numbers["three"] = 3;
  numbers["four"] = 4;
  numbers["five"] = 5;
  numbers["six"] = 6;
  numbers["seven"] = 7;
  numbers["eight"] = 8;
  numbers["nine"] = 9;
  for(numword in numbers){
    for(i = 1; i < length(numword); i++){
      subset = substr(numword, 1, i)
      numword_subset[subset] = 0
    }
    numword_subset[numword] = 1
  }
}
function parse_text(accumlator, ch){
  accumlator = accumlator ch
  if(typeof(ch) == "strnum") return strtonum(ch)
  if(accumlator in numword_subset && numword_subset[accumlator] == 1) return numbers[accumlator]
  if(accumlator in numword_subset) return accumlator
  return ""
}
{ 
  accumlator = "";first = ""; last = "";
  #keeps tracks of where parsing starts
  anchor = 1
  i = 1
  while(i <= length($0))
  {
    accumlator = parse_text(accumlator, $i);
    #parsing substring fails
    if(accumlator == ""){
      anchor++;
      i = anchor;
      continue;
    };
    #parsing succeeds
    if(typeof(accumlator) == "number" && first == "") first = accumlator
    if(typeof(accumlator) == "number")  {
      anchor++;
      i = anchor
      last = accumlator
      accumlator = ""
      continue;
    }
    #continue parsing
    i++;
  } 
  total += strtonum(first last) # string concat
  if(debug == 1){
    print $0 " " first last
  }
}
END {
  if(debug != 1){
    print "total: " total
  }
}

