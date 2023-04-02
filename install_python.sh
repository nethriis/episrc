#!/bin/bash

# Variables
URL="https://www.python.org/ftp/python/3.11.2"
TARBALL="Python-3.11.2.tar.xz"
DIR="Python-3.11.2"
TMP_DIR="/tmp"
DEPENDENCIES=("wget" "tar" "make")

# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

# Functions
check_dependencies() {
    echo -ne "${BLUE}Vérification des dépendances...${NC}"
    for cmd in "${DEPENDENCIES[@]}"; do
        command -v "$cmd" >/dev/null 2>&1 || {
            echo -e "\n${RED}Error: $cmd is not installed. Please install $cmd and try again.${NC}"
            exit 1
        }
    done
    echo -e "${GREEN} ✔${NC}"
}

download_tarball() {
    echo -e "${BLUE}Téléchargement de ${TARBALL}...${NC}"
    rm -f "${TMP_DIR}/${TARBALL}"
    wget --quiet --show-progress -P "${TMP_DIR}" "${URL}/${TARBALL}"
}

extract_tarball() {
    echo -ne "${BLUE}Extraction de ${TARBALL}...${NC}"
    tar -xf "${TMP_DIR}/${TARBALL}" -C "${TMP_DIR}"
    echo -e "${GREEN} ✔${NC}"
}

configure_and_install() {
    echo -e "${BLUE}Configuration...${NC}"
    (cd "${TMP_DIR}/${DIR}" && ./configure)
    echo -e "${BLUE}Compilation...${NC}"
    (cd "${TMP_DIR}/${DIR}" && make)
    # echo -e "${BLUE}Tests...${NC}"
    # (cd "${TMP_DIR}/${DIR}" && make test)
    echo -e "${BLUE}Installation...${NC}"
    (cd "${TMP_DIR}/${DIR}" && $SUDO make install)
}

cleanup() {
    rm -rf "${TMP_DIR}/${DIR}"
}

main() {
    set -e
    trap cleanup EXIT

    if [ $UID -eq 0 ]; then
        echo -e "${YELLOW}[no sudo for root]${NC}"
    else
        # Add sudo for non-root users
        SUDO="/usr/bin/sudo"
    fi

    check_dependencies
    download_tarball
    extract_tarball
    configure_and_install

    echo -e "${GREEN}Fait!${NC}"
}

main
