
resource "aws_wafv2_web_acl" "WAF1-Japan" {
  name        = "WAF1-Japan" #required
  description = "WAF1-Japan" #optional
  scope       = "REGIONAL" #required

  default_action { #required
    allow {} #allow requests by default
  }

  visibility_config { #required
    cloudwatch_metrics_enabled = true #required
    metric_name                = "WAF1-Japan" #required
    sampled_requests_enabled   = true #required
  }

  rule { #optional
    name     = "AWSManagedRulesCommonRuleSet" #required
    priority = 1 #required

    statement { #required
      managed_rule_group_statement { #optional
        vendor_name = "AWS" #required
        name        = "AWSManagedRulesCommonRuleSet" #required
      }
    }

    override_action { #optional but required for "managed_rule_group_statement" and "rule_group_reference_statement" 
      none {}
    }

    visibility_config { #required
      cloudwatch_metrics_enabled = true #required
      metric_name                = "AWSManagedRulesCommonRuleSet" #required
      sampled_requests_enabled   = true #required
    }
  }

  rule {
    name     = "AWSManagedRulesAmazonIpReputationList"
    priority = 2

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesAmazonIpReputationList"
      }
    }

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesAmazonIpReputationList"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesAnonymousIpList"
    priority = 3

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesAnonymousIpList"
      }
    }

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesAnonymousIpList"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 4

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
      }
    }

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesLinuxRuleSet"
    priority = 5

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesLinuxRuleSet"
      }
    }

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesLinuxRuleSet"
      sampled_requests_enabled   = true
    }
  }
}

resource "aws_wafv2_web_acl_association" "appWAF1_association" {
  resource_arn = aws_lb.app1_alb-Japan.arn
  web_acl_arn  = aws_wafv2_web_acl.WAF1-Japan.arn
}
######################################################################################################################################################################################
resource "aws_wafv2_web_acl" "WAF1-Brazil" {
  provider = aws.sa-east-1
  name        = "WAF1-Brazil" #required
  description = "WAF1-Brazil" #optional
  scope       = "REGIONAL" #required

  default_action { #required
    allow {} #allow requests by default
  }

  visibility_config { #required
    cloudwatch_metrics_enabled = true #required
    metric_name                = "WAF1-Brazil" #required
    sampled_requests_enabled   = true #required
  }

  rule { #optional
    name     = "AWSManagedRulesCommonRuleSet" #required
    priority = 1 #required

    statement { #required
      managed_rule_group_statement { #optional
        vendor_name = "AWS" #required
        name        = "AWSManagedRulesCommonRuleSet" #required
      }
    }

    override_action { #optional but required for "managed_rule_group_statement" and "rule_group_reference_statement" 
      none {}
    }

    visibility_config { #required
      cloudwatch_metrics_enabled = true #required
      metric_name                = "AWSManagedRulesCommonRuleSet" #required
      sampled_requests_enabled   = true #required
    }
  }

  rule {
    name     = "AWSManagedRulesAmazonIpReputationList"
    priority = 2

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesAmazonIpReputationList"
      }
    }

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesAmazonIpReputationList"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesAnonymousIpList"
    priority = 3

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesAnonymousIpList"
      }
    }

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesAnonymousIpList"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 4

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
      }
    }

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesLinuxRuleSet"
    priority = 5

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesLinuxRuleSet"
      }
    }

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesLinuxRuleSet"
      sampled_requests_enabled   = true
    }
  }
}

resource "aws_wafv2_web_acl_association" "WAF1-Brazil_association" {
  provider = aws.sa-east-1
  resource_arn = aws_lb.app1_alb-Brazil.arn
  web_acl_arn  = aws_wafv2_web_acl.WAF1-Brazil.arn
}


