Button tabAddShape, btnShowColors;
FlagEditor flag_ed = new FlagEditor() ;
ArrayList<Button> tabHeaders = new ArrayList<Button>() ;
ArrayList<IEditor> tabLayers = new ArrayList<IEditor>() ;
int selected_tab = 0 ;
String msg = "" ;

void addTab(String title) {
    
    int x = 5 ;
    if (tabHeaders.size() > 0) { 
        Button last_btn = tabHeaders.get(tabHeaders.size() - 1) ;
        x = last_btn.Left + last_btn.Width ;
    }
    Button b = new Button(tabHeaders.size() + " - " + title, x, 305, 60, 20) ;
    tabHeaders.add(b);
    
}

void selectTab(int index) {
    for (int i=0; i<tabHeaders.size(); i++) {
        if (i == index) {
            selected_tab = i ;
            tabHeaders.get(i).Selected = true ;
        } else {
            tabHeaders.get(i).Selected = false ;
        }
    }
}

void setup() {
    size(400, 400) ;

    tabLayers.add(flag_ed);
    addTab("Base") ;
    selectTab(0) ;
    
    tabAddShape = new Button("+Sh", 355, 305, 40, 20) ;
    
}

void keyPressed() {

    tabLayers.get(selected_tab).keyPress(keyCode);
    
}

void mousePressed() {
    
    if (tabAddShape.hitTest(mouseX, mouseY)) {
        addTab("Shape") ;
        ShapeLayerEditor layer = new ShapeLayerEditor(flag_ed.Flag) ;
        tabLayers.add(layer);
    }
    for (int i=0; i<tabHeaders.size(); i++) {
        if (tabHeaders.get(i).hitTest(mouseX, mouseY)) {
            selectTab(i);
        }
    }
    for (int i=0; i<tabLayers.size(); i++) {
        if (i == selected_tab) {
            tabLayers.get(i).clickTest(mouseX, mouseY) ;
        }
    }    
    
}

void draw() {
    background(100, 100, 100) ;
    
    for (int i=0; i<tabLayers.size(); i++) {
        tabLayers.get(i).draw() ;
    }

    fill(200, 200, 200) ;
    rect(0, 300, 400, 100) ;

    for (Button btn : tabHeaders) {
        btn.draw() ;
    }
    
    tabLayers.get(selected_tab).drawControls() ;

    tabAddShape.draw() ;
   
    //text(msg, 5, 380) ;
    
}