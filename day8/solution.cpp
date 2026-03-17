#include <algorithm>
#include <cmath>
#include <fstream>
#include <iostream>
#include <set>
#include <stack>
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
  set<point *> test;
  stack<point *> toCheck;
  test.insert(p);
  toCheck.push(p);

  while (!toCheck.empty()) {
    auto pp = toCheck.top();

    test.insert(pp);
    pp->checked = true;
    toCheck.pop();
    for (auto c : pp->connections) {
      if (!c->checked) {
        toCheck.push(c);
      }
    }
  }
  return test.size();
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
  string strBuff = "";
  ifstream Data("data.txt");
  auto lines = new pmr::vector<string>();
  vector<point *> points;
  while (getline(Data, strBuff)) {
    auto point = processLine(strBuff);
    points.push_back(point);
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
  vector<int> results;
  for (int i = 0; i < 1000; i++) {
    int d = floodFill(points[i]);
    results.push_back(d);
  }

  sort(results.begin(), results.end(), [](int a, int b) { return a > b; });
  int mult = 1;
  for (int i = 0; i < 3; i++) {
    mult *= results[i];
  }
  cout << mult << endl;
  for (auto p : points)
    p->checked = false;
  int ii = 999;
  while (floodFill(points[0]) != 1000) {
    ii+=1;
    list[ii].p1->connections.push_back(list[ii].p2);
    list[ii].p2->connections.push_back(list[ii].p1);
    for (auto p : points)
      p->checked = false;
  }

  cout << (list[ii].p1)->x * (list[ii].p2)->x << endl;
}
