### Multiarchitecture build using githunactions

This is a Python Project to learn Docker BuildKit/Buildx, multi-stage builds, multi-architecture images, image optimization, non-root containers, health checks, build caching, CI/CD-oriented container practices,
and GitHub Action workflow .

Inspect the manifest:

```
docker buildx imagetools inspect varunladha/python-project:latest 
```

You should see something conceptually like:
```
Name: docker.io/varunladha/python-project:latest

Manifests:

linux/amd64
linux/arm64
```
Run it:
```
docker run --rm -p 8080:8080 \
  varunladha/python-project:latest
```
Then:
```
curl http://localhost:8080/
```
Example on an x86 machine:
```
Multi-Architecture Docker Demo

OS: Linux
Architecture: x86_64
Python: 3.12.x
```
On ARM:
```
Multi-Architecture Docker Demo

OS: Linux
Architecture: aarch64
Python: 3.12.x
```

### New Concepts learned in Github Actions

QEMU
```
uses: docker/setup-qemu-action@v3
```
Allows the GitHub runner to build an ARM image even though the standard runner is typically AMD64.

Buildx
```
uses: docker/setup-buildx-action@v3
```
Provides BuildKit functionality and multi-platform builds.

Multi-architecture build
```
platforms: |
  linux/amd64
  linux/arm64
```
Creates both architectures.

Build cache
```
cache-from: type=gha
cache-to: type=gha,mode=max
```
Uses GitHub Actions cache to avoid rebuilding unchanged layers.

Conditional push
```
push: ${{ github.event_name != 'pull_request' }}
```
This is a nice production practice: PRs can build/test the image without pushing it to Docker Hub.
