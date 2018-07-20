
using namespace std;


void DistinctPowers()
{
  Node *head=new Node(-987654321);
  int numitems=0;
  for(int a=2;a<=100;a++)
    for(int b=2;b<=100;b++)
      {
	if(!head->search(pow(a,b)))
	  {
	    numitems++;
	    head->addInOrder(pow(a,b));
	    //cout<<a<<"  "<<b<<"   "<<pow(a,b)<<"   "<<numitems<<'\n';
	  }
      }
  //head->printTheList();
}


class Node
{
public:
  long long int data;
  Node *next;
  
  Node()
  {
    next=0;
    data=0;
  }
  Node(int value)
  {
    next=0;
    data=value;
  }
  Node(int value,Node *n)
  {
    next=n;
    data=value;
  }
  
  bool search(int isit)
  {
    if(data==isit)
      return true;
    if(next==0)
      return false;
    else
      return next->search(isit);
  }
  
  void addInOrder(int toadd)
  {
    if(next==0)
      {           
	next=new Node(toadd);
	return;
      }
    if(toadd<=(next->data))
      {
	next=new Node(toadd,next);
	return;
      }
    if(toadd>(next->data))
      {
	next->addInOrder(toadd);
	return;
      }
  }
  
  void printTheList()
  {
    if(data!=-987654321)
      cout<<data<<'\n';
    if(next!=0)
      next->printTheList();
  }
  
};
