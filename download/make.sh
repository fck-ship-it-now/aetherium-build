#!/usr/bin/env bash

# ======================================================
# 📥 DOWNLOAD — MAKE (Git Clone)
# ======================================================

if [ "${USE_KERNEL_CACHE}" = "true" ] && [ -d "${HOME}/kernel-cache/common" ]; then
    log "Restoring kernel source from cache..."
    cp -a "${HOME}/kernel-cache/." "${KERNEL_DIR}/"
    log "Kernel source restored ✅ ($(cache_freshness_note))"
else
    log "Cloning kernel source..."
    KERNEL_REPO_URL="https://github.com/chainonyourdoor/LuminaireKernel-${KERNEL_VERSION}"
    log "Source: ${KERNEL_REPO_URL} @ ${KERNEL_BRANCH}"
    
    # Hapus batasan koneksi agresif yang menyebabkan "curl 28 Operation too slow"
    # git config --global http.connectTimeout 30
    # git config --global http.lowSpeedLimit 1000
    # git config --global http.lowSpeedTime 30
    
    # Terapkan pengamanan large-push/pull dari kernel-source.yml
    git config --global http.postBuffer 524288000
    git config --global http.version HTTP/1.1
    
    retry 3 run_quiet git clone -q --depth=1 \
        -b "$KERNEL_BRANCH" \
        "$KERNEL_REPO_URL" \
        "${KERNEL_DIR}/common" || error "Failed to clone kernel! (see output above)"
        
    log "Saving to cache..."
    mkdir -p "${HOME}/kernel-cache"
    rsync -a --delete "${KERNEL_DIR}/" "${HOME}/kernel-cache/"
fi
