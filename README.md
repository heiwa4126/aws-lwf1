# aws-lwf1

[AWS Lambda Web Functions](https://docs.aws.amazon.com/lambda/latest/dg/web-functions.html)
のテスト。

- TypeScript
- Bun
- [Express](https://www.npmjs.com/package/express)

で出来ていて、`dist/`以下にビルドしてから AWS へデプロイする式

This project was created using `bun init` in bun v1.4.3.
[Bun](https://bun.com) is a fast all-in-one JavaScript runtime.

## 開発

To install dependencies:

```bash
bun install
```

To run:

```bash
bun run dev
```

To type check:

```bash
bun check
```

プロダクションモードで実行:

```bash
bun start
```

トランスパイル&バンドルして実行:

```bash
bun run build
bun run preview
```

## 内容

[Announcing AWS Lambda Web Functions | AWS News Blog](https://aws.amazon.com/jp/blogs/aws/announcing-aws-lambda-web-functions-for-fast-consistent-web-app-performance-anywhere/)
のサンプルコードほぼそのまま ([src/index.ts](./src/index.ts))。

TypeScript で通らない部分を修正してあります。

## ローカルでの実行例

```console
$ bun start

Server running on http://localhost:3000
```

で、<http://localhost:3000> をブラウザや curl で開いてください。

```console
$ curl http://localhost:3000

{"message":"Hello from Lambda Web Functions!"}
```

## AWSへデプロイ

```bash
bun run build
bun run login  # または `bun run login-remote`
bun run deploy
```

削除は

```bash
bun run delete
```

### 注意

delete(`aws lambda-web delete-web-function`) は全部きれいに消してくれない。
<https://docs.aws.amazon.com/lambda/latest/dg/web-functions-create.html#web-functions-create-cleanup>
を参照して、手動で消すこと。

いちおう`script/remove-resources.sh`という半自動で消すやつを置いてあります。

消すものリスト:

- IAM で`awscli-lambdaweb-<関数名>`
- S3 で`awscli-lambdaweb-<account-id>-<region>-an`内の`lambda-web/<関数名>/`
- CloudWatch Logs の`/aws/lambda/web/<関数名>`と`/aws/lambda/web/<関数名>.local`
