class Color {
    public int R = 0 ;
    public int G = 0 ;
    public int B = 0 ;

    public Color() {
    }

    public Color(int r, int g, int b) {
        this.setColor(r, g, b);
    }

    public void setColor(int r, int g, int b) {
        this.R = r ;
        this.G = g ;
        this.B = b ;
    }

    public void setFill() {
        fill(this.R, this.G, this.B);
    }

    public void setStroke() {
        stroke(this.R, this.G, this.B);
    }
    
    public String toString() {
        return "<Color [R: " + this.R + ", G: " + this.G + ", B: " + this.B + "]>";
    }
    
}

abstract class Control {
    public int Left = 0 ;
    public int Top = 0 ;
    public int Width = 0 ;
    public int Height = 0 ;
    public String Text = "" ;
    public boolean Visible = true ;
    public Color BackColor = new Color(200, 200, 200) ;
    public IEditor Parent = null ;
    
    private String _type = "Control" ;

    public void setLocation(int x, int y) {
        this.Left = x ;
        this.Top = y ;
    }

    public void setSize(int w, int h) {
        this.Width = w ;
        this.Height = h ;
    }
    
    public String getType() { return _type ; }
    
    protected void setType(String type) {
        _type = type ;
    }

    public boolean hitTest(int x, int y) {
        if (x >= this.Left && x <= (this.Left + this.Width)) {
            if (y >= this.Top && y <= (this.Top + this.Height)) {
                return true ;
            }
        }
        return false ;
    }

    abstract void draw() ;
}

class Form {

    public ArrayList<Control> Controls = new ArrayList<Control>() ;

    public void draw() {
    }
}

class Label extends Control {

    public Label() {
        this.setType("Label");
    }

    public Label(String text, int x, int y, int w, int h) {
        this.Text = text ;
        this.Left = x ;
        this.Top = y ;
        this.Width = w ;
        this.Height = h;
        this.setType("Label");
    }

    public void draw() {
        textAlign(LEFT);

        noStroke() ;
        fill(200, 200, 200) ;
        rect(this.Left + 1, this.Top + 1, this.Width - 2, this.Height - 2) ;

        fill(0, 0, 0) ;
        text(this.Text, this.Left + 2, this.Top + this.Height*0.75);
    }
}

class Button extends Control {

    public boolean Selected = false ;

    public Button() {
        this.setType("Button");
    }

    public Button(String text, int x, int y, int w, int h) {
        this.Text = text ;
        this.Left = x ;
        this.Top = y ;
        this.Width = w ;
        this.Height = h;
        this.setType("Button");
    }

    public void draw() {
        noStroke() ;
        if (this.Selected) {
            fill(200, 100, 0) ;
        } else {
            this.BackColor.setFill() ;
        }
        rect(this.Left + 1, this.Top + 1, this.Width - 2, this.Height - 2) ;
        stroke(255, 255, 255) ;
        line(this.Left, this.Top, this.Left + this.Width - 1, this.Top);
        line(this.Left, this.Top, this.Left, this.Top + this.Height - 1);
        stroke(127, 127, 127) ;
        line(this.Left + 1, this.Top + this.Height, this.Left + this.Width - 1, this.Top + this.Height);
        line(this.Left + this.Width, this.Top + 1, this.Left + this.Width, this.Top + this.Height - 1);
        noStroke() ;
        fill(0, 0, 0) ;
        textAlign(CENTER);
        text(this.Text, this.Left + this.Width/2, this.Top + this.Height*0.75);
        textAlign(LEFT);
    }
}

class Textbox extends Control {

    public boolean Selected = false ;
    
    public Textbox() {
        this.Left = 0 ;
        this.Top = 0 ;
        this.Width = 100 ;
        this.Height = 20;
        this.setType("Textbox");
    }
    
    public Textbox(int x, int y, int w, int h) {
        this.Left = x ;
        this.Top = y ;
        this.Width = w ;
        this.Height = h;
        this.setType("Textbox");
    }
    
    public void draw() {
        
        noStroke() ;
        if (this.Selected) {
            fill(255, 255, 170) ;
        } else {
            fill(200, 200, 200) ;
        }
        rect(this.Left + 1, this.Top + 1, this.Width - 2, this.Height - 2) ;
        stroke(127, 127, 127) ;
        line(this.Left, this.Top, this.Left + this.Width - 1, this.Top);
        line(this.Left, this.Top, this.Left, this.Top + this.Height - 1);
        stroke(255, 255, 255) ;
        line(this.Left + 1, this.Top + this.Height, this.Left + this.Width - 1, this.Top + this.Height);
        line(this.Left + this.Width, this.Top + 1, this.Left + this.Width, this.Top + this.Height - 1);
        noStroke() ;
        fill(0, 0, 0) ;
        textAlign(LEFT);
        text(this.Text, this.Left + 2, this.Top + this.Height*0.75);
        
    }
    
    public void keyPress(int key_code) {
        
        if (key_code == 8) {
            if (this.Text.length() > 0) {
                this.Text = this.Text.substring(0, this.Text.length() - 1) ;
            }
        } else if (key_code >= 32) {
            this.Text += (char) key_code ;
        }
        
    }
    
}

class ColorSelector extends Control {

    public Color Color = new Color(0, 0, 0) ;
    public Color Hue = new Color(255, 0, 0) ;

    public ColorSelector() {
        this.Text = "Select Color" ;
        this.Left = 0 ;
        this.Top = 0 ;
        this.Width = 150 ;
        this.Height = 170;
        this.setType("ColorSelector");
    }

    public ColorSelector(String text, Color clr, int x, int y) {
        this.Text = text ;
        this.Left = x ;
        this.Top = y ;
        this.Width = 150 ;
        this.Height = 170;
        this.Color = clr ;
        this.setType("ColorSelector");
    }

    public void clickTest(int x, int y) {
        
        //Color selection
        if (x >= this.Left + 5 && x <= this.Left + 133) {
            if (y >= this.Top + 25 && y <= this.Top + 153) {
                int nx = x - this.Left - 5 ;
                int ny = y - this.Top - 25 ;
                Color clr_y = new Color(ny*2, ny*2, ny*2);
                Color clr_s = new Color((int) (this.Hue.R * (ny/128.0)),
                                        (int) (this.Hue.G * (ny/128.0)), 
                                        (int) (this.Hue.B * (ny/128.0)));
                this.Color = getBlendedColor(clr_s, clr_y, nx/128.0) ;
                this.Visible = false ;
                this.Parent.update(this);
            }
        }
        
        //Hue
        if (x >= this.Left + 135 && x <= this.Left + 145) {
            if (y >= this.Top + 25 && y <= this.Top + 145) {
                this.Hue = getHueColor(y-this.Top-25);
            }
        }
        
    }

    public void draw() {
        noStroke() ;
        this.BackColor.setFill() ;
        rect(this.Left + 1, this.Top + 1, this.Width - 2, this.Height - 2) ;
        stroke(255, 255, 255) ;
        line(this.Left, this.Top, this.Left + this.Width - 1, this.Top);
        line(this.Left, this.Top, this.Left, this.Top + this.Height - 1);
        stroke(127, 127, 127) ;
        line(this.Left + 1, this.Top + this.Height, this.Left + this.Width - 1, this.Top + this.Height);
        line(this.Left + this.Width, this.Top + 1, this.Left + this.Width, this.Top + this.Height - 1);
        noStroke() ;
        fill(0, 0, 0) ;
        textAlign(LEFT);
        text(this.Text, this.Left + 5, this.Top + 15);
        drawColors() ;
        drawHueBand() ;
        //text("Hue: " + this.Hue.toString(), 5, 200) ;
    }

    private Color getBlendedColor(Color clr1, Color clr2, double pct) {

        int r = (int) (clr1.R * (1.0-pct) + clr2.R * pct) ;
        int g = (int) (clr1.G * (1.0-pct) + clr2.G * pct) ;
        int b = (int) (clr1.B * (1.0-pct) + clr2.B * pct) ;

        return new Color(r, g, b) ;
    }

    public void drawColors() {

        Color clr_y = new Color() ;
        Color clr_s = new Color() ;
        for (int y=0; y < 128; y++) {
            clr_y = new Color(y*2, y*2, y*2);
            clr_s = new Color((int) (this.Hue.R * (y/128.0)),
                (int) (this.Hue.G * (y/128.0)), 
                (int) (this.Hue.B * (y/128.0)));
            for (int x = 0; x < 128; x++) {
                //clr_y.setStroke() ;
                getBlendedColor(clr_s, clr_y, x/128.0).setStroke() ;
                point(this.Left + x + 5, this.Top + y + 25) ;
            }
        }
    }

    //This is a value from 0 to 120
    //0 - r, 40 - g, 80 - b
    private Color getHueColor(int value) {
        
        int r = 0 ;
        int g = 0 ;
        int b = 0 ;
        
        if (value < 20) {
            r = 255 ;
            g = (int)(256 * (value/20.0)) ;
            b = 0 ;
        } else if (value < 40) {
            r = 255 - (int) (256 * (value-20)/20.0) ;
            g = 255 ;
            b = 0 ;
        } else if (value < 60) {
            r = 0 ;
            g = 255 ;
            b = (int)  (256 * ((value-40)/20.0)) ;
        } else if (value < 80) {
            r = 0 ;
            g = 255 - (int) (256 * ((value-60)/20.0)) ;
            b = 255 ;
        } else if (value < 100) {
            r = (int) (256 * ((value-80)/20.0)) ;
            g = 0 ;
            b = 255 ;
        } else {
            r = 255 ;
            g = 0 ;
            b = 255 - (int) (256 * ((value-100)/20.0)) ;
        }
        
        return new Color(r, g, b);
        
    }

    private void drawHueBand() {
        
        for (int i=0; i<120; i++) {
            getHueColor(i).setStroke() ;
            line(this.Left + 135, this.Top + i + 25, this.Left + 145, this.Top + i + 25);
        }
        
    }
}