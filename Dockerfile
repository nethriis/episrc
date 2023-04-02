FROM ubuntu:latest

#Update the repository sources list
RUN apt-get update && apt-get upgrade -y
# Install basic applications
RUN apt-get install -y build-essential libssl-dev manpages-dev zsh git curl nasm gdb htop vim libsfml-dev haskell-platform
# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Install GEF
RUN sh -c "$(curl -fsSL https://gef.blah.cat/sh)"

WORKDIR /home

CMD [ "/bin/zsh" ]