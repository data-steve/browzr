re_self_closing<-functoin(tag){
  gsub("<.*?\\/>" , "<.*?></.*?>", tag)
}
