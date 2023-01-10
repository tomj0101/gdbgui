
// Check for Balanced Brackets in an expression.
// g++ -g samplev2.cpp -o samplev2
 
#include <bits/stdc++.h>
using namespace std;
 
bool areBracketsBalanced(string expr)
{
    stack<char> temp;
    for (int i = 0; i < expr.length(); i++) {
        if (temp.empty()) {
             
            temp.push(expr[i]);
        }
        else if ((temp.top() == '(' && expr[i] == ')')
                 || (temp.top() == '{' && expr[i] == '}')
                 || (temp.top() == '[' && expr[i] == ']')) {
             
            temp.pop();
        }
        else {
            temp.push(expr[i]);
        }
    }
    if (temp.empty()) {
         
        return true;
    }
    return false;
}
 
int main()
{
    string expr = "{()}[]";
 
    if (areBracketsBalanced(expr))
        cout << "Balanced \n";
    else
        cout << "Not Balanced \n";
    return 0;
}