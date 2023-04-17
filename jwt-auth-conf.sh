export VAULT_ADDR="https://vault-cluster-paris-day-public-vault-3c0c0458.c22eb206.z1.hashicorp.cloud:8200"
export VAULT_NAMESPACE="admin"
export VAULT_TOKEN=""


vault auth enable -path github jwt
vault write auth/github/config \
 oidc_discovery_url="https://token.actions.githubusercontent.com" \
 bound_issuer="https://token.actions.githubusercontent.com"

# Submit the production policy for the `main` GitHub branch
vault policy write demo-prod main.policy

# Submit the dev policy for all other branches
vault policy write demo-dev dev.policy

vault write auth/github/role/vault-github-action-demo-main -<<EOF
{
  "role_type": "jwt",
  "user_claim": "actor",
  "bound_claims": {
    "repository": "sofixa/vault-github-action-demo",
    "ref": "refs/heads/main"
  },
  "policies": ["demo-prod "],
  "ttl": "10m"
}
EOF

vault write auth/github/role/vault-github-action-demo-dev -<<EOF
{
  "role_type": "jwt",
  "user_claim": "actor",
  "bound_claims": {
    "repository": "sofixa/vault-github-action-demo",
    "ref": "refs/heads/dev"
  },
  "policies": ["demo-dev "],
  "ttl": "10m"
}
EOF
