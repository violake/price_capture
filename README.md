# README

This README would normally document whatever steps are necessary to get the
application up and running.

## How to Run

### in Docker
```bash
docker build -t price-capture .
docker run --rm -it -p 3000:3000 --name price-capture-app price-capture

# in the container
# test
rspec

# code format
rubocop

# start server
rails s

# playground
http://localhost:3000


```

### local

```bash
# install gems
bundle install

# test
# coverage/index.html shows test coverage details
rspec

# code format
rubocop

# start server
rails s

# playground
http://localhost:3000


```

