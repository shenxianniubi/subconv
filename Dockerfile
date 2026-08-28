FROM --platform=$BUILDPLATFORM python:3.13-alpine3.22 AS builder
LABEL name="subconv"

WORKDIR /app

RUN apk add --update-cache ca-certificates tzdata patchelf clang ccache bash curl unzip && \
    apk upgrade --no-cache

ENV BUN_INSTALL=/root/.bun
ENV PATH=${BUN_INSTALL}/bin:${PATH}

RUN pip3 install uv

ENV UV_LINK_MODE=copy UV_PYTHON_DOWNLOADS=0

COPY pyproject.toml uv.lock ./

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-install-project --no-editable --group build

COPY . .

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-editable --group build

RUN --mount=type=cache,target=/root/.cache/Nuitka \
    uv run python -m nuitka --clang --onefile --standalone api.py && \
    chmod +x api.bin

RUN curl -fsSL https://bun.sh/install | bash -s -- bun-v1.3.11

RUN cd mainpage && bun install --frozen-lockfile && bun run build


FROM alpine:3.22

WORKDIR /app

RUN apk upgrade --no-cache

COPY --from=builder /app/api.bin /app/api.bin
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /app/mainpage/dist /app/mainpage/dist
COPY config.yaml.example /app/config.yaml.example
COPY template /app/template

EXPOSE 8080

ENTRYPOINT ["/app/api.bin"]
