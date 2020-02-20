

bool isNumeric(String valor){
  
  return !valor.isEmpty && ( num.tryParse(valor) != null); 
}