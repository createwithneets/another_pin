Rails.configuration.stripe = {
:public_key =>  Rails.application.credentials.public_key,
:secret_key =>  Rails.application.credentials.secret_key,
}
