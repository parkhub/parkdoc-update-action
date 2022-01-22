FROM golang:1.17

WORKDIR /var

RUN apt update
RUN apt install -y unzip
RUN go env -w GOPRIVATE=github.com/parkhub/*
RUN go install golang.org/x/tools/cmd/godoc@latest
RUN go install gitlab.com/tslocum/godoc-static@latest

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install


## ARG TOKEN
RUN git config --global url."https://${TOKEN}@github.com/".insteadOf "https://github.com/"

COPY ./ ./
RUN mkdir /tmp/docs

## ARG AWS_ACCESS_KEY_ID
## ARG AWS_SECRET_ACCESS_KEY
ENV AWS_DEFAULT_REGION=us-east-1
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID

RUN chmod +x upload.sh

CMD [ "./upload.sh"]
