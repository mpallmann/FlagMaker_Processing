interface IEditor {
    String getName() ;
    Color getColor() ;
    void setColor(Color clr) ;
    void clickTest(int x, int y);
    void keyPress(int key_code);
    void draw() ;
    void drawControls() ;
    void update(Control c) ;
}

class Point {
    
    public float X ;
    public float Y ;
    
    public Point() {
    }
    
    public Point(float x, float y) {
        this.X = x ;
        this.Y = y ;
    }
    
}

class Flag {
    public int Width = 400 ;
    public int Height = 300 ;
    public Color Background = new Color(255, 255, 255);

    public void draw() {
        noStroke() ;
        this.Background.setFill() ;
        rect(0, 0, this.Width, this.Height) ;
    }

}

abstract class Layer {

    protected Flag flag ;

    public String LayerType = "" ;
    private Color Color = new Color() ;
    
    public Layer() {
    
    }

    public Color getColor() {
        return this.Color ;
    }
    
    public void setColor(Color clr) {
        this.Color = clr ;
    }
    
    public abstract void draw() ; 
    
}