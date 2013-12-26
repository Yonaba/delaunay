package = "delaunay"
version = "0.1-1"
source =
{
   url = "https://github.com/Yonaba/delaunay/archive/delaunay-0.1-1.tar.gz",
   dir = "delaunay-delaunay-0.1-1"
}
description =
{
  summary = "Lua module for Delaunay triangulation of convex polygons",
  homepage = "http://yonaba.github.io/delaunay",
  license = "MIT",
  maintainer = "Roland Yonaba <roland.yonaba@gmail.com>"
}
dependencies = { "lua >= 5.1" }
build =
{
  type = "builtin",
  modules =
  {
    delaunay = "delaunay.lua"
  },
  copy_directories = {"docs"}  
}