// https://aws.amazon.com/blogs/aws/announcing-aws-lambda-web-functions-for-fast-consistent-web-app-performance-anywhere/
// のサンプルコードほぼそのまま。TypeScriptで通らない部分を修正

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
