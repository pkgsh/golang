echo ""
echo "Installing Epel"
echo ""

rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

echo ""
echo "Installing golang and dependencies"
echo ""

yum install -y golang hg git

echo ""
echo "Creating Go dir in $HOME/.go and exporting GOPATH and etc."
echo ""

mkdir -p $HOME/.go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin


cat >> ~/.bashrc << EOF

export GOPATH=\$HOME/.go
export PATH=\$PATH:\$GOPATH/bin

EOF

echo ""
echo "Golang was installed successfully"
echo ""
