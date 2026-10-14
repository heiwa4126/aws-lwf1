# aws-lwf1

[AWS Lambda Web Functions](https://docs.aws.amazon.com/lambda/latest/dg/web-functions.html)
のテスト。

- TypeScript
- Bun
- [Express](https://www.npmjs.com/package/express)

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

This project was created using `bun init` in bun v1.4.3.
[Bun](https://bun.com) is a fast all-in-one JavaScript runtime.
