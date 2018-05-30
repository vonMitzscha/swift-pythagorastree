//Import für mathematischen Krimskrams
import Foundation

//Winkel Alpha (Angle) Dreieck
let angle = 45/180*Double.pi

//Dicke der Linien
let fett:Double = 0.2

//Konstate für die Abbruchbedingung festlegen
let abbruch:Double = 0.5

//Funktion für das Rechteck
func square(start:Point,rotation:Double,size:Double) {
    //Start = Linke untere Ecke des Quadrates
    
    //Rotation = Winkel des " Hilfsdreiecks (rechtwinklig) unter dem Rechteck, was das Rechteck dreht. Damit können dann mit den trigonometrischen Berechnungen die Punkte berechnet werden
    let B = Point(x: start.x-sin(rotation)*size, y: start.y+cos(rotation)*size)
    //Diagonal = Diagonale eines Rechtecks
    let diagonal = size*sqrt(2)
    
    let C = Point(x: start.x+cos(rotation+Double.pi/4)*diagonal, y: start.y+sin(rotation+Double.pi/4)*diagonal)
    
    let D = Point(x: start.x+cos(rotation)*size, y: start.y+sin(rotation)*size)
    
    //Hier wird das Rechteck gezeichnet
    Line(start: start, end: B, thickness:fett)
    Line(start: B, end: C, thickness:fett)
    Line(start: C, end: D, thickness:fett)
    Line(start: D, end: start, thickness:fett)
}

//Funktion, um das Dreieck zu zeichnen
func triangle(start:Point,size:Double,rotation:Double) {
    let B = Point(x: start.x + size * cos(rotation),y: start.y + size * sin(rotation))
    
    let x = cos(angle)*size
    
    let C = Point(x: start.x+x*cos(rotation+angle), y: start.y+x*sin(rotation+angle))
    
    //Hier werden die Seiten den Dreiecks gezeichnet. Die Hypothenuse ist die Oberseite des Rechtecks
    Line(start: B, end: C, thickness:fett)
    Line(start: start, end: C,thickness:fett)
}

//Rekursive Funktion, die den Baum zeichnet
func tree(start:Point,size:Double,rotation:Double) {
    
    //Abbruchbedingung
    if size<abbruch {
        return
    }
    square(start: start, rotation: rotation, size: size)
    
    //Corner = Punkt oben links im Rechteck
    let corner = Point(x: start.x-cos(Double.pi/2-rotation)*size, y: start.y+sin(Double.pi/2-rotation)*size)
    
    triangle(start: corner, size: size, rotation: rotation)
    
    //Berechnung der neuen Seitenlänge des Rechtecks
    let a = (size*sin(Double.pi/2-angle))
    
    tree(start: corner, size: a, rotation: rotation+angle)
    
    //Berechnungen für die Zweige auf der Rechten Seite
    let b = sin(angle)*size
    let C = Point(x: corner.x+a*cos(rotation+angle), y: corner.y+a*sin(rotation+angle))
    
    tree(start: C, size: b, rotation: -(Double.pi/2-rotation-angle))
}
//Ausführen der rekursiven Funktion
tree(start: Point(x: -5, y: -15), size: 10, rotation: 0)

