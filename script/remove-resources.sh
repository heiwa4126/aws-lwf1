#!/usr/bin/env bash
set -euo pipefail

FUNCTION_NAME=aws-lwf1
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION=${AWS_REGION:-$(aws configure get region)}
BUCKET="awscli-lambdaweb-${ACCOUNT_ID}-${REGION}-an"
ROLE="awscli-lambdaweb-${FUNCTION_NAME}"
PREFIX="lambda-web/${FUNCTION_NAME}/"

# 1. S3: プレフィックス配下の全バージョン + 削除マーカーを削除
#    (バケットはバージョニング有効なので、単なる rm では消えない)
for kind in Versions DeleteMarkers; do
  aws s3api list-object-versions --bucket "$BUCKET" --prefix "$PREFIX" \
    --query "${kind}[].[Key,VersionId]" --output text |
  while read -r key vid; do
    [ "$key" = "None" ] && continue
    aws s3api delete-object --bucket "$BUCKET" --key "$key" --version-id "$vid"
  done
done

# 2. IAM ロール: ポリシーを外してから削除
for p in $(aws iam list-role-policies --role-name "$ROLE" --query 'PolicyNames[]' --output text); do
  aws iam delete-role-policy --role-name "$ROLE" --policy-name "$p"
done
for arn in $(aws iam list-attached-role-policies --role-name "$ROLE" --query 'AttachedPolicies[].PolicyArn' --output text); do
  aws iam detach-role-policy --role-name "$ROLE" --policy-arn "$arn"
done
aws iam delete-role --role-name "$ROLE"

# 3. CloudWatch Logs: まず候補を確認
aws logs describe-log-groups --log-group-name-pattern "$FUNCTION_NAME" \
  --query 'logGroups[].logGroupName' --output text

echo '`aws logs delete-log-group --log-group-name ...` で消してください'
