# =========================
# Get Credential and Config
# Assume the secret you store is formatted like this:
# export APP_ENV=production

echo "Populate secret"
source <(aws secretsmanager get-secret-value --secret-id $SECRET_NAME --region $AWS_REGION --query SecretString --output text)
