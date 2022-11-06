# syntax=docker/dockerfile:1

FROM haskell:9.4.2-slim-buster as builder
WORKDIR /cabal-fmt/
RUN cabal update

COPY cabal.project .
COPY cabal-fmt.cabal .
COPY Changelog.md .
COPY LICENSE .
COPY fixtures fixtures
COPY src src
COPY tests tests
COPY src-interval src-interval
COPY tests-interval tests-interval
COPY cli cli

RUN cabal install exe:cabal-fmt --install-method=copy --overwrite-policy=always --installdir=dist

FROM scratch
COPY --from=builder /cabal-fmt/dist/cabal-fmt .