import processing.svg.*;

int factor = 3;
int points = 200;
TimesTable tt;

void setup() {
  size(600, 600);
  tt = new TimesTable(factor, points);
  String filename = String.format("svg/times_table-%d-%d.svg", tt.m_factor, tt.m_points);
  beginRecord(SVG, filename);
  background(255);
  noFill();
  stroke(0);
  noLoop();
}

void draw() {
  tt.drawEmptyTable();
  tt.drawLines();
  endRecord();
}


class TimesTable {
  int m_factor;
  int m_points;
  ArrayList<PVector> m_pointPositions;
  PVector m_center;
  float m_radius;

  float fillRatio = 0.9;
  float pointRadius = 3;

  TimesTable(int factor, int points) {
    m_factor = factor;
    m_points = points;
    m_center = new PVector(width / 2, height / 2);
    m_radius = ((float) min(width, height) * fillRatio) / 2;
    initializePositions();
  }

  void initializePositions() {
    m_pointPositions = new ArrayList<PVector>();
    for (int i = 0; i < m_points; i++) {
      m_pointPositions.add(pointPosition(i));
    }
  }

  void drawEmptyTable() {
    circle(m_center.x, m_center.y, m_radius * 2);
    // fill(255, 0, 0);
    // for (PVector p : m_pointPositions) {
    //   circle(p.x, p.y, pointRadius);
    // }
  }
  
  void drawLines() {
    for (int i = 1; i < m_points; i++) {
      int endingIndex = (i * m_factor) % m_points;
      PVector startingPoint = m_pointPositions.get(i);
      PVector endingPoint = m_pointPositions.get(endingIndex);
      line(startingPoint.x, startingPoint.y, endingPoint.x, endingPoint.y);
    }
  }
  
  private

  PVector pointPosition(int pointIndex) {
    double angle = (((float) pointIndex) / m_points) * 2*Math.PI;
    float px = m_center.x - (float) (Math.cos(angle) * m_radius);
    float py = m_center.y + (float) (Math.sin(angle) * m_radius);
    PVector p = new PVector(px, py);
    return p;
  }
}
