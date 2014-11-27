
if [ -z "$name" ]; then
  echo "need a package name (\$name) to continue"
  exit 1
fi


mkdir -p $build_root
