class FlagEditor implements IEditor {
    
    public Flag Flag ;

    private Label lblFlagWidth, lblFlagHeight, lblBackColor;
    private Button btnFlagWidthUp, btnFlagWidthDown, btnFlagHeightUp, btnFlagHeightDown, btnBackColor ;
    private ColorSelector clrSelect ;
    public ArrayList<Control> controls = new ArrayList<Control>() ;
    private String msg = "" ;

    public FlagEditor() {
        this.Flag = new Flag() ;
        initializeControls() ;
    }
    
    public String getName() {
        return "FLAG" ;
    }
    
    public Color getColor() {
        return this.Flag.Background ;
    }
    
    public void setColor(Color clr) {
        this.Flag.Background = clr ;
    }

    void initializeControls() {
    
        //Flag Tab
        lblFlagWidth = new Label("Flag Width", 5, 330, 80, 20) ;
        btnFlagWidthDown = new Button("<",85, 330, 20, 20) ;
        btnFlagWidthUp = new Button(">",105, 330, 20, 20) ;
        lblFlagHeight = new Label("Flag Height", 5, 355, 80, 20) ;
        btnFlagHeightDown = new Button("<",85, 355,20, 20) ;
        btnFlagHeightUp = new Button(">",105, 355, 20, 20) ;
        lblBackColor = new Label("Background Color", 150, 330, 100, 20) ;
        btnBackColor = new Button("", 150, 350, 100, 20);
        btnBackColor.BackColor = this.Flag.Background ;

        clrSelect = new ColorSelector() ;
        clrSelect.setLocation(100, 100) ;
        clrSelect.Visible = false ;

        controls.add(lblFlagWidth) ;
        controls.add(btnFlagWidthDown) ;
        controls.add(btnFlagWidthUp) ;
        controls.add(lblFlagHeight) ;
        controls.add(btnFlagHeightDown) ;
        controls.add(btnFlagHeightUp) ;
        controls.add(btnBackColor) ;
        controls.add(lblBackColor) ;
        controls.add(clrSelect) ;
        
        for (Control c : this.controls) {
            c.Parent = this ;
        }
    
    }
    
    public void clickTest(int x, int y) {

        if (btnFlagWidthUp.hitTest(x, y)) {
            if (this.Flag.Width < 400) this.Flag.Width += 10 ;
        }
        if (btnFlagWidthDown.hitTest(x, y)) {
            if (this.Flag.Width > 10) this.Flag.Width -= 10 ;
        }
        
        if (btnFlagHeightUp.hitTest(x, y)) {
            if (this.Flag.Height < 300) this.Flag.Height += 10 ;
        }
        if (btnFlagHeightDown.hitTest(x, y)) {
            if (this.Flag.Height > 10) this.Flag.Height -= 10 ;
        }
        if (btnBackColor.hitTest(x, y)) {
            clrSelect.Color = this.Flag.Background ;
            clrSelect.Visible = true ;
        }
        if (clrSelect.hitTest(x, y)) {
            clrSelect.clickTest(x, y) ;
        }
        
    }
    
    public void keyPress(int key_code) {
    
    }
    
    public void draw() {
        
        this.Flag.draw() ;
        
    }
    
    public void drawControls() {
        
        for (Control b : controls) {
            if (b.Visible) {
                b.draw() ;
            }
        }
        
        text(msg, 200, 370) ;
    
    }
    
    public void update(Control c) {
        
        if (c.getType() == "ColorSelector") {
            //msg = "Color:" + ((ColorSelector) c).Color.toString() ;
            this.Flag.Background = ((ColorSelector) c).Color ;
            btnBackColor.BackColor = this.Flag.Background ;
        }

    }
    
}