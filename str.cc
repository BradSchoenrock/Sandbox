#include <iostream>
#include <typeinfo>

using namespace std;

int main()
{
  const char* action="stuff";
  cout << "none" << '\n';
  cout << action << '\n';
  cout << typeid("none").name() << '\n';
  cout << typeid(action).name() << '\n';
  //cout << decltype("none") << '\n';
  //cout << decltype("none") << '\n';
}
