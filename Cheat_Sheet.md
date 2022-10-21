###_Bash
echo $? - exit status of last command (0 no error)
' - Single quote removes meaning special meaning of special character.
find /qwe -type f -iname _.js -exec cp --parents -t /tmp/ {} + -- find all js files and copy with parent directory
find . -type f -name \_.js -print0 | tar c --null -T - | tar xC /tmp/ -- find all js files and copy with parent directory
systemctl set-default graphical.target (ls -l /lib/systemd/system/runlevel\*) -- set runlevel
echo <password> | sudo -S
for i in t@01 st@02 ba@sta03;do ssh -o RequestTTY=true $i "sudo -l";done -- allow tty present
sed '/pattern to match/d' ./infile > ./newfile
sed -i 's/old-text/new-text/g' input.txt > outputfile

###\_VIM
:r! sed -n '16,812 p' < input_file.txt -- copy line range from input_file
:1,10d -- delete line from 1 to 10
:se nu -- show line numbers

###\_Apache
Redirection in Apache (By default, the Redirect directive establishes a 302, or temporary, redirect.):
URL:https://www.digitalocean.com/community/tutorials/how-to-create-temporary-and-permanent-redirects-with-apache-and-nginx
<VirtualHost \*:80>
ServerName www.domain1.com
Redirect 301 /oldlocation http://www.domain2.com/newlocation
</VirtualHost>

ServerTokens Prod -- hides Apache version

###\_Logrotate
vi /etc/logrotate.d/

###\_IPTABLES
iptables -A INPUT -p tcp -m tcp --dport 5000 -j DROP -- discard incoming traffic
iptables -A INPUT -p tcp -m tcp --dport 8094 -j ACCEPT -- allow incoming traffic
iptables -D INPUT -p tcp -m tcp --dport 5000 -j DROP -- Delete rule
iptables -I INPUT -p tcp ! -s yourIPaddress --dport 22 -j DROP -- discard incoming traffic for posrt 22 except yourIPaddress
iptables-save >/etc/sysconfig/iptables -- save rules

###\_GIT
git init -- creates .git folder
Files are untracked when first created
git add -- to start tracking (stage all files and changes in the current folder)
git diff --staged show changes on added files
