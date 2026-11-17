#!/bin/bash

vault=$(cat <<'EOF' | base64 -d | gpg --pinentry-mode loopback -d
jA0ECQMKoPyLF7gogb//0sAKAY94JC3+ks4LF2zOKNKrvyUKe2k3mMbjEkqh+krakIjChzbQor0R
0zBObdwWDIOn0MeuXt5B1eIswc0H/uX+pVZxCzzHXRaf8PhaayZQxTWtjU/EtvN3v9uCUKx7DTNk
W2Whpa2hUDOJAneJ4dLdjVotm0XnChIbHP6Kp8kqHjZI+HuMxWlONk+3EEvyg1hUdP7Kk+LA5VWE
aFXy3+DAov6/O7+MVOufURIicorn2eFUU2rdAF6Za3Z+eoqNOkWwpdQp13q45Na+FQ==
EOF
)

url=$(echo "$vault" | sed -n '1p')
token=$(echo "$vault" | sed -n '2p')
repo=$(basename "$url" .git)

git -c http.extraheader="AUTHORIZATION: basic $(printf 'x-access-token:%s' "$token" | base64 -w0)" \
    clone --no-single-branch "$url"

cd "$repo"
