Aws.config.update({
  region: 'us-east-2',
  credentials: Aws::Credentials.new(
    Rails.application.credentials.aws_key,
    Rails.application.credentials.aws_secret
  )
})

AWS_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET_NAME'])
