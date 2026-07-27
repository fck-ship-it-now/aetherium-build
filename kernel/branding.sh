#!/usr/bin/env bash

# ======================================================
# 🏷️ BRANDING — CONFIG + APPLY
# ======================================================

export KERNEL_NAME="${CUSTOM_KERNEL_NAME:-Aetherium4.0-Singularity+}"
export BUILD_USER="kaminarich"
export BUILD_HOST="Kaminari"

export KBUILD_BUILD_USER="$BUILD_USER"
export KBUILD_BUILD_HOST="$BUILD_HOST"
export LOCALVERSION="-${ANDROID_VERSION}-${KMI_GENERATION}-${KERNEL_NAME}"
export KBUILD_BUILD_TIMESTAMP="$(date '+%a %b %d %T %Z %Y')"

# env vars are enough, kernel reads them directly
log "Branding: ${BUILD_USER}@${BUILD_HOST} | ${LOCALVERSION} ✅"
