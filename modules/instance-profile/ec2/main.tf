resource "aws_iam_instance_profile" "ec2" {
  name = var.ec2_role_name
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = var.ec2_role_name
  path = "/"


  # EC2 Assumed Role Policy
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": ["ec2.amazonaws.com"]
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}


# AWS Existing policy attachment/ AWS Managed Policy
data "aws_iam_policy" "ssm-ec2-console" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ssm-ec2-console" {

  role      = aws_iam_role.role.name
  policy_arn = data.aws_iam_policy.ssm-ec2-console.arn
}
