args=$@;

describe "Installing Epel"
rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

describe "Installing golang and dependencies"
yum install -y golang

additional_packages=""
if [ ! -z "$(echo $args| grep 'include-git')" ]; then
  additional_packages="$additional_packages git"
fi

if [ ! -z "$(echo $args| grep 'include-hg')" ]; then
  additional_packages="$additional_packages hg"
fi

if [ ! -z "$additional_packages" ]; then
  describe "Installing additional packages ${$additional_packages}"
  yum install -y $additional_packages
fi

if [ ! -d "$HOME/.go" ]; then

describe "Creating Go dir in $HOME/.go and exporting GOPATH and etc."

mkdir $HOME/.go
mkdir $HOME/.go/bin
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin


cat >> ~/.bashrc << EOF

export GOPATH=\$HOME/.go
export PATH=\$PATH:\$GOPATH/bin

EOF
fi

success "Golang was installed successfully"
