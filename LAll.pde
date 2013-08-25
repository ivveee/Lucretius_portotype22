class LAll{
  
  private ArrayList<LBody> arBody = new ArrayList<LBody>();
  private ArrayList<LBody> arBodiesToAdd = new ArrayList<LBody>();
  private ArrayList<LBody> arBodiesToRemove = new ArrayList<LBody>();
  private  Iterator<LBody> activeIt = arBody.iterator();
  LBody currentBody;
  
  LAll(){}
  
  
 void addBody(LBody Body){
   arBodiesToAdd.add(Body);
 }
  
 void removeBody(LBody Body){
   if(Body == currentBody)
     activeIt.remove();
   else
     arBodiesToRemove.add(Body);
 } 
  
 LBody next(){
   currentBody = activeIt.next();
     return currentBody;
 }
  
 boolean hasNext(){
   if(activeIt.hasNext()){
     return true;
   }
   else{
     arBody.addAll(arBodiesToAdd);
     arBody.removeAll(arBodiesToRemove);
     
     return false;
   }

 }
  
//Iterator<LBody> iterator(){
//  return activeIt;
//}
  
  
  
}
