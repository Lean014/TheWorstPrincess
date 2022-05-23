//import controlP5.*;
//import java.util.*;

//ControlP5 cp5;

//String currentControlUser = "USER_A";

//String[] QRCodes = {"1-armour", "2-sky", "3-tea", "4-nasal-spray", "5-tower", "5-dress", "6-dragon-air", "7-pants-on-fire"};

//void setupControl(){

//  cp5 = new ControlP5(this);
  
  
//  for (int i=0;i<QRCodes.length;i++) {
//    cp5.addBang(QRCodes[i])
//       .setPosition(40+i*80, 200)
//       .setSize(40, 40)
//       .setId(i)
//       ;
//  }

       
//  List l = Arrays.asList("USER_A", "USER_B", "USER_C");
//  /* add a ScrollableList, by default it behaves like a DropdownList */
//  cp5.addScrollableList("dropdown")
//     .setPosition(100, 100)
//     .setSize(200, 100)
//     .setBarHeight(20)
//     .setItemHeight(20)
//     .addItems(l)
//     // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
//     ;


//}



//public void controlEvent(ControlEvent theEvent) {
  
  
//  if(theEvent.controller().getName() == "dropdown"){
//   return; 
//  }
  
//  println(
//  "## controlEvent / id:"+theEvent.controller().getId()+
//    " / name:"+theEvent.controller().getName()+
//    " / value:"+theEvent.controller().getValue()
//    );
   
    
//    readQR(theEvent.controller().getName(), currentControlUser);
    
    
//    println();
    
//}



//void dropdown(int n) {
//  /* request the selected item based on index n */
//  //println(n, cp5.get(ScrollableList.class, "dropdown").getItem(n).get("text"));

//  currentControlUser = (String)cp5.get(ScrollableList.class, "dropdown").getItem(n).get("text");
//}
