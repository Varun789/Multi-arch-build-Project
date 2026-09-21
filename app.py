
from http.server import BaseHTTPRequestHandler, HTTPServer
import platform
import os


class Handler(BaseHTTPRequestHandler):

    def do_GET(self):

        if self.path == "/health":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"OK")
            return

        if self.path == "/":
            architecture = platform.machine()

            response = f"""
Multi-Architecture Docker Learning

OS: {platform.system()}
Architecture: {architecture}
Python: {platform.python_version()}
Hostname: {os.uname().nodename}
"""

            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.end_headers()
            self.wfile.write(response.encode())

    def log_message(self, format, *args):
        return


server = HTTPServer(("0.0.0.0", 8080), Handler)

print("Server listening on port 8080")

server.serve_forever()

