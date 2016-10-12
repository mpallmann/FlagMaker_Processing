class ShapeLayer extends Layer {

    public static final int SHAPETYPE_POLYGON = 0 ;
    public static final int SHAPETYPE_RECTANGLE = 1 ;
    public static final int SHAPETYPE_ELLIPSE = 2 ;
    public static final int SHAPETYPE_STAR = 3 ;
    
    public int ShapeType ;
    public ArrayList<Point> Points = new ArrayList<Point>() ;
    public Color Color = new Color(255, 255, 255) ;
    
    public ShapeLayer(Flag fl) {
        this.flag = fl ;
        this.Points.add(new Point(0, 0));
        this.Points.add(new Point(1, 1));
    }
    
    public void draw() {
        
        noStroke() ;
        this.Color.setFill() ;
        if (this.ShapeType == SHAPETYPE_RECTANGLE) {
            if (this.Points.size() >= 2) {
                float x1 = this.Points.get(0).X * this.flag.Width ;
                float y1 = this.Points.get(0).Y * this.flag.Height ;
                float x2 = (this.Points.get(1).X - this.Points.get(0).X) * this.flag.Width ;
                float y2 = (this.Points.get(1).Y - this.Points.get(0).Y) * this.flag.Height ;
                rect(x1, y1, x2, y2) ;
            }
        } else if (this.ShapeType == SHAPETYPE_ELLIPSE) {
            if (this.Points.size() >= 2) {
                ellipseMode(CORNER);
                float x1 = this.Points.get(0).X * this.flag.Width ;
                float y1 = this.Points.get(0).Y * this.flag.Height ;
                float x2 = (this.Points.get(1).X - this.Points.get(0).X) * this.flag.Width ;
                float y2 = (this.Points.get(1).Y - this.Points.get(0).Y) * this.flag.Height ;
                ellipse(x1, y1, x2, y2);
            }
        } else if (this.ShapeType == SHAPETYPE_STAR) {
            if (this.Points.size() >= 2) {
                float x = this.Points.get(0).X * this.flag.Width ;
                float y = this.Points.get(0).Y * this.flag.Height ;
                float sz = this.Points.get(1).X * this.flag.Width ;
                float base = 4*PI ;

                beginShape();
                float nx = sin(base + PI) * sz + x ;
                float ny = cos(base + PI) * sz + y ;
                vertex(nx, ny) ;
                nx = sin(base*1/5 + PI) * sz + x ;
                ny = cos(base*1/5 + PI) * sz + y ;
                vertex(nx, ny) ;
                nx = sin(base*2/5 + PI) * sz + x ;
                ny = cos(base*2/5 + PI) * sz + y ;
                vertex(nx, ny) ;
                nx = sin(base*3/5 + PI) * sz + x ;
                ny = cos(base*3/5 + PI) * sz + y ;
                vertex(nx, ny) ;
                nx = sin(base*4/5 + PI) * sz + x ;
                ny = cos(base*4/5 + PI) * sz + y ;
                vertex(nx, ny) ;
                endShape();
            }
        } else {    //Polygon
            
        }
        
    }
    
}

class ShapeLayerEditor implements IEditor {

    public ShapeLayer Layer ;
    public ArrayList<Control> controls = new ArrayList<Control>() ;
    private Label lblIndex, lblColor ;
    private Button btnPrevIndex, btnNextIndex, btnColor ;
    private ColorSelector clrSelect ;
    private Button btnShapeType = new Button() ;
    private Textbox txtLeft, txtTop ;
    private String[] btnShapeType_Text = {"Polygon", "Rectangle", "Ellipse", "Star"} ;
    private int btnShapeType_SelectedText = 0 ;
    private int selected_point = 0 ;
    
    public ShapeLayerEditor(Flag fl) {
        
        this.Layer = new ShapeLayer(fl) ;
        
        initializeControls();
    }
    
    private void initializeControls() {
        
        btnShapeType.Text = btnShapeType_Text[btnShapeType_SelectedText] ;
        btnShapeType.setLocation(5, 330) ;
        btnShapeType.setSize(80, 20) ;

        btnPrevIndex = new Button("<", 100, 330, 20, 20) ;
        lblIndex = new Label("0", 120, 330, 30, 20);
        btnNextIndex = new Button(">", 150, 330, 20, 20) ;
        lblColor = new Label("Color", 210, 330, 100, 20) ;
        btnColor = new Button("", 210, 350, 100, 20) ;
        btnColor.BackColor = this.Layer.Color ;

        clrSelect = new ColorSelector() ;
        clrSelect.setLocation(100, 100) ;
        clrSelect.Visible = false ;

        txtLeft = new Textbox(100, 355, 50, 20);
        txtTop = new Textbox(155, 355, 50, 20);

        this.controls.add(btnShapeType) ;
        this.controls.add(btnPrevIndex);
        this.controls.add(lblIndex);
        this.controls.add(btnNextIndex);
        this.controls.add(lblColor);
        this.controls.add(btnColor);
        this.controls.add(clrSelect) ;
        this.controls.add(txtLeft) ;
        this.controls.add(txtTop) ;

        for (Control c : this.controls) {
            c.Parent = this ;
        }

    }
    
    public String getName() {
        return "SHAPE";
    }
    
    public Color getColor() {
        return this.Layer.Color ;
    }
    
    public void setColor(Color clr) {
        this.Layer.Color = clr ;
    }
    
    public void clickTest(int x, int y) {

        if (btnShapeType.hitTest(x, y)) {
            btnShapeType_Click() ;
        }
        if (btnColor.hitTest(x, y)) {
            btnColor_Click() ;
        }
        if (clrSelect.hitTest(x, y)) {
            clrSelect.clickTest(x, y) ;
        }
        if (btnPrevIndex.hitTest(x, y)) {
            selected_point-- ;
            if (selected_point < 0) {
                selected_point = this.Layer.Points.size() - 1 ;
            }
            lblIndex.Text = "" + selected_point ;
            txtLeft.Text = "" + this.Layer.Points.get(selected_point).X ;
            txtTop.Text = "" + this.Layer.Points.get(selected_point).Y ;
        }
        if (btnNextIndex.hitTest(x, y)) {
            selected_point++ ;
            if (selected_point >= this.Layer.Points.size()) {
                selected_point = 0 ;
            }
            lblIndex.Text = "" + selected_point ;
            txtLeft.Text = "" + this.Layer.Points.get(selected_point).X ;
            txtTop.Text = "" + this.Layer.Points.get(selected_point).Y ;
        }
        if (txtLeft.hitTest(x, y)) {
            txtLeft.Selected = true ;
        } else {
            txtLeft.Selected = false ;   
        }
        if (txtTop.hitTest(x, y)) {
            txtTop.Selected = true ;
        } else {
            txtTop.Selected = false ;   
        }
        
    }

    private void btnShapeType_Click() {

        btnShapeType_SelectedText++ ;
        if (btnShapeType_SelectedText >= btnShapeType_Text.length) {
            btnShapeType_SelectedText = 0 ;
        }
        btnShapeType.Text = btnShapeType_Text[btnShapeType_SelectedText] ;
        if (btnShapeType.Text == "Rectangle") {
            this.Layer.ShapeType = ShapeLayer.SHAPETYPE_RECTANGLE ;
        } else if (btnShapeType.Text == "Ellipse") {
            this.Layer.ShapeType = ShapeLayer.SHAPETYPE_ELLIPSE ;
        } else if (btnShapeType.Text == "Star") {
            this.Layer.ShapeType = ShapeLayer.SHAPETYPE_STAR ;
        } else {
            this.Layer.ShapeType = ShapeLayer.SHAPETYPE_POLYGON ;
        }

    }
    
    private void btnColor_Click() {

        clrSelect.Color = this.Layer.Color ;
        clrSelect.Visible = true ;
        
    }
    
    public void keyPress(int key_code) {

        if (txtLeft.Selected) { 
            txtLeft.keyPress(key_code) ; 
            try {
                float f = parseFloat(txtLeft.Text);
                this.Layer.Points.get(selected_point).X = f ;
            } catch (Exception ex) {
                
            }
        }
        if (txtTop.Selected) { 
            txtTop.keyPress(key_code) ; 
            try {
                float f = parseFloat(txtTop.Text);
                this.Layer.Points.get(selected_point).Y = f ;
            } catch (Exception ex) {
                
            }
        }
        
    }
    
    public void draw() {

        this.Layer.draw() ;
        
    }
    
    public void drawControls() {
        
        for (Control b : controls) {
            if (b.Visible) {
                b.draw() ;
            }
        }
    
    }
    
    public void update(Control c) {

        if (c.getType() == "ColorSelector") {
            //msg = "Color:" + ((ColorSelector) c).Color.toString() ;
            this.Layer.Color = ((ColorSelector) c).Color ;
            btnColor.BackColor = this.Layer.Color ;
        }


    }

}