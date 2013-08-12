class LBit{
  int x;
  int y;
  int type;
//---------------------Bit created from World-----------------
  LBit(int in_iX,int in_iY, int in_iType){
    x = in_iX;
    y = in_iY;
    type = in_iType;
  }  
//---------------------Bit created from XML------------------
  LBit(XML oXML){
       x=oXML.getInt("x")*(iPixDefaultSize);
       y=oXML.getInt("y")*(iPixDefaultSize);
       type=oXML.getInt("type");
  }
//---------------------Bit is written down--------------------       
  XML BitToXML(){
    XML xmlBitData = new XML("bit");
           xmlBitData.setString("x", nfc((int)x/iPixDefaultSize));
           xmlBitData.setString("y", nfc((int)y/iPixDefaultSize));
           xmlBitData.setString("type", nfc(type));
    return xmlBitData;
  }
};

//-----------------------------------------------------------------
//---------------------------Form----------------------------------
class LForm{
  String sName = "a";
  int iType = 0;
  LBit[] arBits= new LBit[0];
  
//----------------------Form is seen----------------------
  LForm(PImage imgEye, color col){
    imgEye.loadPixels();
    int j=0;int k=0;
    for (int i = 0; i < imgEye.pixels.length; i++) {
      if(j == imgEye.width){
        j=0;
        k++;
      }
      if (imgEye.pixels[i] == col) {
        LBit Pixel=new LBit(j*(iPixDefaultSize),
                            k*(iPixDefaultSize),
                            0);
        LBit[] NewarBits= (LBit[])append(arBits, Pixel);
        arBits = NewarBits;
      }
      j++;
    }
  }
//----------------------Form is read----------------------  
  LForm(XML xmlFormData){
         XML[] xmlBitsData = xmlFormData.getChildren("bit");
         arBits = new LBit[xmlBitsData.length];
         for(int j=0;j < xmlBitsData.length;j++){
           LBit NewBit = new LBit(xmlBitsData[j].getInt("x")*iPixDefaultSize,
                                  xmlBitsData[j].getInt("y")*iPixDefaultSize,
                                  xmlBitsData[j].getInt("type"));
           arBits[j]=NewBit;
         } 
  }
//----------------------Form is set----------------------   
/*  LForm(LFly[] arLFly){
     arBits = new LBit[arLFly.length];
     for (int i=0;i<arLFly.length;i++){
       LBit oNewBit = new LBit(arLFly[i].iX,arLFly[i].iY,0);
       arBits[i]=oNewBit;
     }   
  }*/
//----------------------Get bit----------------------     
    LBit At(int i){
      if (i > arBits.length)
        return arBits[i];
      else
        return null;
  }
//----------------------Form to write---------------------- 
  XML FormToXML(){
        XML xmlNewString = new XML("form");
         xmlNewString.setString("name", sName);
         xmlNewString.setString("type", nfc(iType));
         for (int i=0;i<arBits.length;i++){
           XML xmlBitData = new XML("bit");
           xmlBitData.setString("x", nfc((int)arBits[i].x/iPixDefaultSize));
           xmlBitData.setString("y", nfc((int)arBits[i].y/iPixDefaultSize));
           xmlBitData.setString("type", nfc(arBits[i].type));
           xmlNewString.addChild(xmlBitData);
         }   
         return xmlNewString;
  } 
  

};
