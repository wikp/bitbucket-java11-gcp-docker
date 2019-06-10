FROM adoptopenjdk/openjdk11:alpine

RUN apk update && \
    apk add curl bash python git openssh-client ca-certificates && \
    update-ca-certificates; \
    (curl https://sdk.cloud.google.com | bash) && \
    /root/google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true; \
    /root/google-cloud-sdk/bin/gcloud components install kubectl; \
    apk del --purge .fetch-deps; \
    rm -rf /var/cache/apk/*; \
    rm -fr /tmp/*; \
    sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' /root/google-cloud-sdk/lib/googlecloudsdk/core/config.json

VOLUME ["/.config"]
ENV PATH $PATH:/root/google-cloud-sdk/bin

CMD /bin/bash
