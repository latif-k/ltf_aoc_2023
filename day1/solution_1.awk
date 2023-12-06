BEGIN { FS = ""; total = 0 }

function intiate_trie(){
    numbers[1] = "one";
    numbers[2] = "two";
    numbers[3] = "three";
    numbers[4] = "four";
    numbers[5] = "five";
    numbers[6] = "six";
    numbers[7] = "seven";
    numbers[8] = "eight";
    numbers[9] = "nine";
}
{ 
  first = ""; last = "";
  for(i = 1; i <= length($0); i++)
  {
    # printf "%s: %s\n", $i, typeof($i)
    if(typeof($i) == "string") 
    if(typeof($i) == "strnum" && first == "") first = $i
    if(typeof($i) == "strnum")  last = $i
  } 
  total += strtonum(first last) # string concat
}
END {print total}

