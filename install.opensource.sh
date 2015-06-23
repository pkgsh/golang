args=$@;

echo ""
echo "Installing Epel"
echo ""

rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

echo ""
echo "Installing golang and dependencies"
echo ""

yum install -y golang

additional_packages=""
if [ ! -z "$(echo $args| grep 'include-git')" ]; then
  additional_packages="$additional_packages git"
fi

if [ ! -z "$(echo $args| grep 'include-hg')" ]; then
  additional_packages="$additional_packages hg"
fi

if [ ! -z "$additional_packages" ]; then
  yum install -y $additional_packages
fi

echo ""
echo "Creating Go dir in $HOME/.go and exporting GOPATH and etc."
echo ""

mkdir $HOME/.go
mkdir $HOME/.go/bin
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin


cat >> ~/.bashrc << EOF

export GOPATH=\$HOME/.go
export PATH=\$PATH:\$GOPATH/bin

EOF

echo ""
echo "Golang was installed successfully"
echo ""
