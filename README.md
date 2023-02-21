# Matcher

- 採用管理のサポートシステム

## 動かし方

```bash
cp dot.env .env
docker compose build
docker compose up -d
docker compose exec matcher mix ecto.migrate
docker compose exec matcher mix run priv/repo/seeds.exs
docker compose exec matcher mix phx.server
```
