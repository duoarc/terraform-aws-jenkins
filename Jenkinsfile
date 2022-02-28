pipeline {
    agent any
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }

    parameters {
        string(name: 'CONSUL_STATE_PATH', defaultValue: 'networking/state/globo-primary')
        string(name: 'WORKSPACE', defaultValue: 'development')
    }

    environment {
        TF_HOME = tool('terraform')
        TF_INPUT = "0"
        TF_IN_AUTOMATION = "TRUE"
        TF_VAR_consul_address = "host.docker.internal"
        TF_LOG = "WARN"
        CONSUL_HTTP_TOKEN = credentials('networking_consul_token')
        AWS_ACCESS_KEY_ID = credentials('aws_access_key')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        PATH = "$TF_HOME:$PATH"
    }

    stages {
        stage('NetworkingInit'){
            steps {
                dir('globo/'){
                    sh 'terraform --version'
                    sh "terraform init -backend-config='path=${parems/CONSUL_STATE_PATH}'"
                }
            }
        }

        stage('NetworkValidate'){
            steps {
                dir('globo'){
                    sh 'terraform validate'
                }
            }
        }
        stage('NetworkPlan'){
            steps {
                dir('globo/'){
                    script {
                        try {
                            sh "terraform workspace new ${params.WORKSPACE}"
                        } catch (err) {
                            sh "terraform workspace select ${params.WORKSPACE}"
                        }
                    }
                    sh "terraform plan -out terraform-networking.tfplan;echo \$? > status"
                    stash name: "terraform-networking-plan", includes: "terraform-networking.tfplan"
                }
            }
        }
        stage('NetworkApply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'confirm apply', ok: 'Apply Config'
                        apply = TRUE
                    } catch (err) {
                        apply = false
                        dir('globo/'){
                            sh "terraform destroy -auto-approve"
                        }
                        currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        dir('globo/'){
                            unstash "terraform-networking-plan"
                            sh 'terraform apply terraform-networking.tfplan'
                        }
                    }
                }
            }
        }
    }
}
