#include <algorithm>
#include <cmath>
#include <fstream>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <tuple>
#include <vector>

using namespace std;

struct point {
  int x;
  int y;
  int z;
  vector<point *> connections;
  bool checked = false;

  point(int x, int y, int z) {
    this->x = x;
    this->z = z;
    this->y = y;
  }

  void print() { cout << x << "," << y << "," << z << endl; }
  float distance(point b) {
    return sqrt(pow((float)this->x - b.x, 2) + pow((float)this->y - b.y, 2) +
                pow((float)this->z - b.z, 2));
  }
};

int floodFill(point *p) {
  if (p->checked) {
    return 0;
  } else {
    p->checked = true;
    int c = 0;
    for (auto c : p->connections) {
      c += floodFill(c);
    }
    return 1 + c;
  }
}

struct TupleElem {
  point *p1, *p2;
  float distance;
  TupleElem() {
    p1 = nullptr;
    p2 = nullptr;
    distance = 0.0;
  };
};

point *processLine(string s) {
  int b = 0;
  vector<int> nums;
  for (int i = 0; i < s.size(); i++) {
    if (s[i] == ',') {
      int n = atoi(s.substr(b, i - b).c_str());
      b = i + 1;
      nums.push_back(n);
    } else if (i == s.size() - 1) {
      int n = atoi(s.substr(b, s.size() - b).c_str());
      nums.push_back(n);
    }
  }
  return new point(nums[0], nums[1], nums[2]);
}

int main() {
  std::cout << "test tsetsntsre tnrsent " << std::endl;
  string strBuff = "";
  ifstream Data("data.txt");
  auto lines = new pmr::vector<string>();
  vector<point *> points;
  while (getline(Data, strBuff)) {
    auto point = processLine(strBuff);
    points.push_back(point);
  }

  for (auto p : points) {
    p->print();
  }

  vector<TupleElem> list;
  float distances[1000][1000];
  for (int i = 0; i < 1000; i++) {
    for (int j = 0; j < i; j++) {
      if (i == j)
        continue;
      auto d = points[i]->distance(*points[j]);
      TupleElem t;
      t.distance = d;
      t.p1 = points[i];
      t.p2 = points[j];
      list.push_back(t);
    }
  }

  sort(list.begin(), list.end(),
       [](TupleElem a, TupleElem b) { return a.distance < b.distance; });
  for (int i; i < 1000; i++) {
    list[i].p1->connections.push_back(list[i].p2);
    list[i].p2->connections.push_back(list[i].p1);
  }
  for (int i = 0; i < 1000; i++) {
    int d = floodFill(list[i].p1);
    if(d!=0)cout << d << endl;
  }
}
