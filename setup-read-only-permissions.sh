IFS=$',' users=($(echo $PG_READ_ONLY_USERS))

for username in "${users[@]}"; do
  ./run-psql.sh -c "GRANT CONNECT ON DATABASE $PG_DATABASE TO $username;"
  ./run-psql.sh -c "GRANT USAGE ON SCHEMA public TO $username;"
  ./run-psql.sh -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO $username;"
done
