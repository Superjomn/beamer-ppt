 void Insert(int *a,int n)
 {
     int i=n-1;
     int key=a[n];
     while((i>=0)&&(key<a[i]))
     {
         a[i+1]=a[i];
         i--;
     }
     a[i+1]=key;
     return;
 }
 
 void InsertionSort(int *a,int n)
 {
     if(n>0)
     {
         InsertionSort(a,n-1);
         Insert(a,n);
     }
     else 
         return;
 }
