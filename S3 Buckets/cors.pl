
1)  What is CORS in S3?
    
    it stands for "cross-origin resource sharing", it means if we have to load or share the data into a file from another bucket,
    we use CORS method.
    
    directly we can not get the data or resource from another bucket, for the same we need to create a CORS policy into the bucket who will share the data.
    
    
    suppose, we have 2 buckets, bucket1 & bucket2,
      Now, bucket1 need data from bucket2, so we need to write CORS policy into bucket2 and need to define with which bucket we want to share the data.
      
      CORS policy (into CORS Section)
      
      [
        {
            "AllowedHeaders": [
                "*"
            ],
            "AllowedMethods": [
                "GET",
                "HEAD"
            ],
            "AllowedOrigins": [
                "*"
            ],
            "ExposeHeaders": []
        }
    ]

  #AllowedHeaders, we can pass a particular bucket link, here we pass for all (*)
  
  
  
  ------------------------------------------------------- PRACTICALL SCENARIO ------------------------------------------------
  
  in bucket1, we have index.html file where it loads data from bucket2 file (below eg.), it will load data from "s3_url".
  
  ---- Index.html page -----
  
    <html>

    <head>
        <title> Test Website </title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>

    <body>

        <h1>Welcome to Index Page</h1>

        <div id="mycontent"></div>

    </body>

    <script type="text/javascript">
    // $("#mycontent").load("about.html");

    var s3_url = "https://cors-resource-shiva.s3.amazonaws.com/about.html" 

    $("#mycontent").load(s3_url); //now loading data from another s3 bucket

    </script>

    </html>
  
  
  
