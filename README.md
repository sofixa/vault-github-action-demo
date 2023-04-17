# vault-github-action

Demo repository containing the code for authenticating into a HashiCorp Vault cluster from GitHub Actions, get policies based on the environment of the GitHub job (e.g. branch name), and read secrets from Vault. 

- `.github/workflows/

- `jwt-auth-conf.sh` that creates and configures a Vault [JWT auth method](https://developer.hashicorp.com/vault/docs/auth/jwt), with two roles, `dev` and `main`, with `bound_claims` mapping them to allow this repository's `dev` and `main` branches respectively to authenticate against them

- `dev.policy` and `main.policy`, containing two policies for the `dev` and `main` auth roles and branches respectively, giving access to different paths

