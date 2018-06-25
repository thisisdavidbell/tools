case $1 in
"red")
  code="{32708, 0, 0}";;
"green")
  code="{0, 19812, 0}";;
"blue")
  code="{0, 0, 35535}";;
"purple")
  code="{17779, 1224, 17522}";;
*)
  code="{0, 0, 0}";;
esac

osascript -e "tell application \"Terminal\" to set background color of window 1 to $code"

if [ ! -z $2 ]
then
  echo -n -e "\033]0;$2\007"
fi
