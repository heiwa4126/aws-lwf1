import express from "express";

const app = express();

const endpoint = process.env.AWS_LAMBDA_HTTP_ENDPOINT ?? "";
const [hostString = "", portString] = endpoint.split(":");
const host = hostString || "localhost";
const port = Number(portString || "3000");

app.get("/", (_req, res) => {
	res.json({ message: "Hello from Lambda Web Functions!" });
});

app.listen(port, host, () => {
	console.log(`Server running on http://${host}:${port}`);
});
