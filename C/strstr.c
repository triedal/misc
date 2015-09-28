#include <stdio.h>
#include <stdlib.h>

char* my_strstr(char *needle, char *haystack)
{
  char *start;
  for (start = haystack; *start != '\0'; start++)
  {
    char *p = needle;
    char *q = start;
    while (*p != '\0' && *q != '\0' && *p == *q)
    {
      p++;
      q++;
    }
    if (*p == '\0') return start;
  }

  return NULL;
}

int main()
{
  char *needle = "is";
  char *haystack = "This is some text";

  char *tmp = my_strstr(needle, haystack);
  if (tmp) {
    printf("Needle begins at %p\n", tmp);
  } 
  else {
    printf("Needle not found\n");
  }

  return 0;
}