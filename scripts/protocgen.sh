#!/usr/bin/env bash

set -eo pipefail

protoc_gen_gocosmos() {
  if ! grep "github.com/gogo/protobuf => github.com/regen-network/protobuf" go.mod &>/dev/null ; then
    echo -e "\tPlease run this command from somewhere inside the cosmos-sdk folder."
    return 1
  fi

  go get github.com/regen-network/cosmos-proto/protoc-gen-gocosmos@latest 2>/dev/null
}

protoc_gen_gocosmos

# proto_dirs=$(find ./proto -path -prune -o -name '*.proto' -print0 | xargs -0 -n1 dirname | sort | uniq)
# for dir in $proto_dirs; do
#   buf protoc \
#   -I "proto" \
#   -I "third_party/proto" \
#   --gocosmos_out=plugins=interfacetype+grpc,\
# Mgoogle/protobuf/any.proto=github.com/cosmos/cosmos-sdk/codec/types:. \
#   --grpc-gateway_out=logtostderr=true:. \
#   $(find "${dir}" -maxdepth 1 -name '*.proto')

# done

# command to generate docs using protoc-gen-doc

buf alpha protoc \
-I "third_party/proto" \
--doc_opt=./docs/protodoc-markdown.tmpl,proto-docs.md \
--doc_out=./docs/core \
$(find "$(pwd)/third_party/proto/cosmos" -maxdepth 4 -name '*.proto') \
$(find "$(pwd)/third_party/proto/cosmwasm" -maxdepth 4 -name '*.proto') \
$(find "$(pwd)/third_party/proto/ibc" -maxdepth 4 -name '*.proto')

# move proto files to the right places
# cp -r github.com/terra-money/core/* ./
# rm -rf github.com


# #!/usr/bin/env bash

# #== Requirements ==
# #
# ## make sure your `go env GOPATH` is in the `$PATH`
# ## Install:
# ## + latest buf (v1.0.0-rc11 or later)
# ## + protobuf v3
# #
# ## All protoc dependencies must be installed not in the module scope
# ## currently we must use grpc-gateway v1
# # cd ~
# # go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
# # go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
# # go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway@v1.16.0
# # go install github.com/cosmos/cosmos-proto/cmd/protoc-gen-go-pulsar@latest
# # go get github.com/regen-network/cosmos-proto@latest # doesn't work in install mode
# # go get github.com/regen-network/cosmos-proto/protoc-gen-gocosmos@v0.3.1

# set -eo pipefail

# echo "Generating gogo proto code"
# cd proto
# buf mod update
# cd ..
# buf generate

# # move proto files to the right places
# cp -r ./github.com/CosmosContracts/juno/x/* x/
# rm -rf ./github.com

# go mod tidy -compat=1.17

# # ./scripts/protocgen2.sh
