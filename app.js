const http = require('http');
const server = http.createServer((req, res) => {
    console.log(req.url, req.headers, req.method);
    res.setHeader("Content-Type", "text/html");
    res.write("<html>");
    res.write("<head><title>AirAOA</title>");
    res.write("</head>");
    res.write("<body>");
    res.write("<h1>Omar is shit!</h1>")
    res.write("</body>");
    res.write("</html>");
});
//this takes a function which is a request listener ...
// this funciotn excutes with every comming request.

server.listen(3000);