#include <arpa/inet.h>
#include <stdlib.h>
#include <unistd.h>
 
static char response[] = "HTTP/1.0 200 OK\r\n"
  "Content-Type: text/plain\r\n"
  "\r\n"
  "Hello, world!\r\n";
 
int main(int argc, char **argv) {
  int port = 8080;
  if(argc == 2)
    port = atoi(argv[1]);
  
  int sock = socket(AF_INET, SOCK_STREAM, 0);
  if(sock == -1)
    return 1;
 
  {
    int one = 1;
    setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(int));
  }
 
  {
    struct sockaddr_in sockaddr_in;
    sockaddr_in.sin_family = AF_INET;
    sockaddr_in.sin_addr.s_addr = INADDR_ANY;
    sockaddr_in.sin_port = htons(port);
 
    if(bind(sock, (struct sockaddr *)&sockaddr_in, sizeof(sockaddr_in)) == -1) {
      close(sock);
      return 1;
    }
  }

  listen(sock, 5);

  while(1) {
    int fd = accept(sock, NULL, NULL);
    if(fd == -1)
      continue;
 
    write(fd, response, sizeof(response) - 1);
    close(fd);
  }
}
