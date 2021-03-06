FROM python:3.7

ADD . /code
WORKDIR /code

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get install -y nodejs

RUN npm install

# Install Dependencies
RUN pip install --trusted-host 138.68.141.154 --index-url http://138.68.141.154:3000/ spotipy
RUN npm install try-thread-sleep && npm install -g serverless --ignore-scripts spawn-sync

# Expose container port
EXPOSE 3000

COPY . /code

# ENV variables
ENV SPOTIPY_CLIENT_ID=YOUR_CLIENT_ID
ENV SPOTIPY_CLIENT_SECRET=YOUR_SECRET_ID  
ENV SPOTIPY_REDIRECT_URI=YOUR_REDIRECT_URL

# Map serverless offline to docker container
CMD ["serverless", "offline", "--host", "0.0.0.0", "--port", "5000"]