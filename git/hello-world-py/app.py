#!/usr/bin/python

import http.server


class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        message = b"Hello, world!\n"
        
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.send_header("Content-length", len(message))
        self.end_headers()
        self.wfile.write(message)


if __name__ == "__main__":
    http.server.HTTPServer(("", 8080), Handler).serve_forever()
