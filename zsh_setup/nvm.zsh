export NVM_DIR="$HOME/.nvm"

if [[ ! -d "$NVM_DIR" ]]
then
  echo "Installing nvm (git clone) to $NVM_DIR"
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR" 2> /dev/null
  pushd "$NVM_DIR" > /dev/null || exit

  LATEST_RELEASE=$(git tag --sort=v:refname | tail -n 1)
  echo "Checking out $LATEST_RELEASE which SHOULD be latest release"
  git checkout "$LATEST_RELEASE" 2> /dev/null
  popd > /dev/null || exit
  echo "Done"
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

