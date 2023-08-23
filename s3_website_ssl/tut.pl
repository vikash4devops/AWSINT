

1) very first, create a bucket and upload website code files and make it public.

2) go to certificate manager -> request ssl certificate -> enter domain name -> it will give cname and cname value to verify the doman
   put that cname and value in host or in route 53 (if)
   
3) go to cloudfront -> create distribution -> Origin domain -> select s3 bucket name (for redirect to)
   -> Origin domain -> select created domanin in certificate manager
   -> it will give a distribution name ie. -> https://d3uolh4vc3mp7b.cloudfront.net
   -> put this distribution name in cname record
   -> behaviour -> redirect http to https (after verifying manually)
   -> invalidation option -> if some code is changed and want to reflect that in website (cache updation), then need to add "Object paths" option to /*
      Now, after invalidation option is set, we no need to wait till next ttl for cache updation,
