#include<bits/stdc++.h>
using namespace std;
int twosum(int target)
{ 
	int sum=0;
	int k=0;
    int a[100];
     cout << "Enter an array of values";
    for(int i=0;i<100;i++)
     {
      cin >> a[i];
     }
	//vector<int> a = {2, 7, 11, 15};
     for (k=0;k<100;k++)
     {
  if(a[k]!=NULL)
{
  sum = a[k] + a[k+1];
  if(sum == target)
  {
        cout << "The value is in the position \t" << k << "\t" << k+1 << "\n";  	
  	  	break;
  }
  else
  {
  	k++;
  	continue;
  }
}
}
}
main()
{  
   vector<int> v;
  //int v[2, 7, 13 , 17];
  int temp;
  cout << "Enter the target sum";
  cin >> temp;
  twosum(temp);
  }
