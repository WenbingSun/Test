#!/usr/bin/env groovy
pipeline {
    agent any
    stages {
        stage('Verify Branch') {
            steps {
                sh $GIT_BRANCH
            }
        }
    }
}
