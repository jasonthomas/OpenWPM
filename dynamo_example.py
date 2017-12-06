import boto3
import StringIO

# Create an S3 client
s3 = boto3.resource('s3')

my_bucket = s3.Bucket('safe-ucosp-2017')
for object in my_bucket.objects.all():
    print(object)

#s3.Bucket("safe-ucosp-2017")
#output = StringIO.StringIO()
#output.write('First line.\n')
#s3.upload_file("test.txt", "safe-ucosp-2017", "key")
#s3.upload_fileobj(output, "safe-ucosp-2017", "key")


# Download object at bucket-name with key-name to tmp.txt
#s3.download_file("safe-ucosp-2017", "key", "test_google.txt")


