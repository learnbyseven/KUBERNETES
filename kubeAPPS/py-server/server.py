import http.server
import socketserver
from http import HTTPStatus


class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(HTTPStatus.OK)
        self.end_headers()
        self.wfile.write(b'PYTHON-WEB-SEVER-2.00\n')


httpd = socketserver.TCPServer(('', 80), Handler)
httpd.serve_forever()
