case $1 in
"red")
  code="{62708, 8995, 0}";;
"green")
  code="{0, 39064, 0}";;
"blue")
  code="{1028, 12850, 65535}";;
"purple")
  code="{37779, 8224, 37522}";;
*)
  code="{0, 0, 0}";;
esac

osascript -e "tell application \"Terminal\" to set background color of window 1 to $code"

if [ ! -z $2 ]
then
  echo -n -e "\033]0;$2\007"
fi
