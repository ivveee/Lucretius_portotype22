class LAll{
  
  private ArrayList<LBody> arBody = new ArrayList<LBody>();
  private ArrayList<LBody> arBodiesToAdd = new ArrayList<LBody>();
  private ArrayList<LBody> arBodiesToRemove = new ArrayList<LBody>();
  private  Iterator<LBody> activeIt = null;// = arBody.iterator();
  private LBody currentBody = null;
  
  LAll(){}
  
  LBody getFirst(){
    arBodiesToAdd.clear();
    arBodiesToRemove.clear();
    activeIt = arBody.iterator();
    if(hasNext())
      return next();
    else
      return null;
  }
  
 void addBody(LBody Body){
   if(activeIt == null)
     arBody.add(Body);
   else 
     arBodiesToAdd.add(Body);
 }
  
 void removeBody(LBody Body){
   if(activeIt == null)
        arBody.remove(Body);
   else{  
     if(Body == currentBody)
       activeIt.remove();
     else
       arBodiesToRemove.add(Body);
   }
 } 
  
 LBody next(){
   if(activeIt.hasNext())
     currentBody = activeIt.next();
   else
     currentBody = null;   
   return currentBody;
 }
  
 boolean hasNext(){
   if(activeIt.hasNext()){
     return true;
   }
   else{
     activeIt = null;
     return false;
   }
 }
 
 boolean flush(){
   if(activeIt != null){
     arBody.addAll(arBodiesToAdd);
     arBody.removeAll(arBodiesToRemove);
     for(LBody body : arBodiesToRemove){
       body.destroy();
     }
   }
   activeIt = null;
   return true;
 }
  
//Iterator<LBody> iterator(){
//  return activeIt;
//}
  
  
  
}
