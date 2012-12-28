void   InsertionSort(int   data[],   size_t   size)
{
    if   (size   > =   2)
    {
        InsertionSort(data,   size   -   1);
        Insert(data,   size   -   1,   data[size   -   1]);
    }
} 
