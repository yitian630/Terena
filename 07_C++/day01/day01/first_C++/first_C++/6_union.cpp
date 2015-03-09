#include <iostream>
using namespace std;

union MyUnion {
    int x;
    int y;
    char cs[4];
};

int main() {
    MyUnion myUnion;
    myUnion.x = 0x41424344;
    cout << myUnion.x << endl; //1094861636
    cout << myUnion.y << endl; //1094861636
    //0x44 68  0x43 67  0x42 66  0x41 65
    cout << myUnion.cs << endl; //DCBA
    
    union {
        int a;
        int b;
    };
    a = 500;
    cout << b << endl; // 500

    int x = 10;
    int y = 10;
    if (x not_eq 100 and y not_eq 200) <%
        cout << "x not_eq 100 and y not_eq 200" << endl; //x not_eq 100 and y not_eq 200
    %>
    
    
    return 0;
}




