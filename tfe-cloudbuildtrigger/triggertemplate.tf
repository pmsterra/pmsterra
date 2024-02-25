resource "google_cloudbuild_trigger" "filename-trigger" {
  location = "us-central1"

  trigger_template {
    branch_name = "main"
    repo_name   = "my-repo"
  }

  substitutions = {
    _FOO = "bar"
    _BAZ = "qux"
  }

  filename = "build.yaml"
}



resource "google_pubsub_topic" "mytopic" {
  name = "my-topic"
}

resource "google_cloudbuild_trigger" "build-trigger-inline" {
  name = "my-inline"
  location = "us-central1"

  pubsub_config {
    topic = google_pubsub_topic.mytopic.id
    
  }

  build {
     step {
      name = "gcr.io/cloud-builders/gcloud"
      args = ["auth", "configure-docker"]
    }
    
    step {
      name = "gcr.io/cloud-builders/gsutil"
      args = ["cp", "gs://us-central1-test-f115302e-bucket/cloudbuild.tar.gz", "/workspace/"]
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      args = ["run","--rm", "-v", "/workspace:/workspace", "busybox","tar", "-xzf","/workspace/cloudbuild.tar.gz","-C","/workspace/"]
    }

    step {
      name = "gcr.io/cloud-builders/docker"
      args = ["build", "-t", "us-central1-docker.pkg.dev/turing-alcove-384403/gcf-artifacts/myflex:latest", "."]
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      args = ["push", "us-central1-docker.pkg.dev/turing-alcove-384403/gcf-artifacts/myflex:latest"]
      
    }
   options {
      logging = "CLOUD_LOGGING_ONLY"
      dynamic_substitutions = true
      
   }
  source   {
    storage_source {
      bucket = "us-central1-test-f115302e-bucket"
      object = "cloudbuild.tar.gz"
    }
  }
}


}