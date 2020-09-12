# Copyright (c) 2020 Wenhao Ji <predator.ray@gmail.com>

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

FROM zetaplusae/lighttpd-cgi

RUN set -ex && \
    apk add --no-cache jq curl

RUN set -ex && \
    wget -O /tmp/prom-exposit.tar.gz https://github.com/predatorray/prometheus-bash-exposition/releases/download/v1.1/prom-exposit-1.1.tar.gz && \
    mkdir -p /usr/local/prom-exposit && cd /usr/local/prom-exposit && \
    tar -zxf /tmp/prom-exposit.tar.gz && rm -f /tmp/prom-exposit.tar.gz && \
    [ -f /usr/local/prom-exposit/bin/prom-exposit ] && chmod +x /usr/local/prom-exposit/bin/prom-exposit && \
    ln -s /usr/local/prom-exposit/bin/prom-exposit /usr/local/bin/prom-exposit
ENV PATH "$PATH:/usr/local/prom-exposit/bin"

COPY env.conf /etc/lighttpd/conf.d/env.conf
COPY env.conf.sh /etc/lighttpd/conf.d/env.conf.sh
COPY cgi-bin/ /var/www/cgi-bin/
