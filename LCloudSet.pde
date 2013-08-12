class LCloudSet extends LBody{

ArrayList <LCloud> Clouds;
Vec2 SumForce = new Vec2(0,0); 
float stability = 20;
float mass;

LCloudSet(ArrayList <LCloud> in_Clouds){
  mass = 200;//in_Clouds.length();
  Clouds = in_Clouds;
  for (Iterator<LCloud> activeIt = Clouds.iterator();activeIt.hasNext();) {
     LCloud Cloud = activeIt.next();
     Cloud.PhBody.getFixtureList().getFilterData().categoryBits=0x0010;
     Cloud.arBodiesAffect.clear();
     Cloud.arBodiesAffect.add(this);
   }
}


void Display(){
  for (Iterator<LCloud> activeIt = Clouds.iterator();activeIt.hasNext();) {
     LCloud Cloud = activeIt.next();
     //Cloud.Display();
   }
}
    
void ApplyForce(){  
  mass++;
    SumForce.set(0,0);
   Vec2 pos = new Vec2(0,0);
   for (Iterator<LCloud> activeIt = Clouds.iterator();activeIt.hasNext();) {
     LCloud Cloud = activeIt.next();
     Fixture fd = Cloud.PhBody.getFixtureList();
    if (fd == null) println(Cloud.PhBody.isActive());
     pos.addLocal(Cloud.getPosition().mul(1.f/Clouds.size()));
    }    
  for (LBody oLForceBody: arBodiesAffect) {
      Vec2 f = oLForceBody.GetForce(pos); 
      stability -= (sqrt(f.x*f.x + f.y*f.y));
      if (stability<0) {
        SumForce.addLocal(f);
      }
    }
   for (Iterator<LCloud> activeIt = Clouds.iterator();activeIt.hasNext();) {
     LCloud Cloud = activeIt.next();
     if (mass>300){
       int i = (int) random(1,Clouds.size());
       if (i==1){ 
         Cloud.arBodiesAffect.remove(this);
         Cloud.arBodiesAffect.addAll(arBodiesAffect);
         Cloud.arBodiesAffect.add(oEarth);
         Cloud.PhBody.getFixtureList().getFilterData().categoryBits=0x0002;
         activeIt.remove();
       }
     }
    }
}
    

Vec2 GetForce(Vec2 input)
{

  return SumForce;
}

  

}
