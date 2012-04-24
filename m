From: Joy Arulraj <prabhu.link@gmail.com>
Subject: How to capture L1 cache stores using perf
Date: Tue, 24 Apr 2012 22:08:18 +0000 (UTC)
Message-ID: <loom.20120425T000533-297@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36445 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757962Ab2DXWIc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 Apr 2012 18:08:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1SMnuP-0007rv-5a
	for linux-perf-users@vger.kernel.org; Wed, 25 Apr 2012 00:08:29 +0200
Received: from angua.cs.wisc.edu ([128.105.7.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Apr 2012 00:08:29 +0200
Received: from prabhu.link by angua.cs.wisc.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Apr 2012 00:08:29 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

 I am using Perf to capture L1 cache STORE and LOAD events on an Intel Nehalem
machine. In the example below from Apache, I am trying to capture the store to
the shared variable buf.  An incorrect interleaving should leave the buf->outcnt
vairable in invalid state before it is written to, leading to corrupt Apache
logs. For reference, the bug report is available here :
https://issues.apache.org/bugzilla/show_bug.cgi?id=25520

 I am able to capture a LOAD  event of shared variable buf->outcnt  quite
frequently [buf->outcnt = buf->outcnt + len ] , but I am never able to see the
following STORE event performed after adding len to it.
I am sampling every 10th occurrence of the event ( -c 10 ) and I run perf
separately for LOAD and STORE events.

static apr_status_t ap_buffered_log_writer(request_rec *r, void *handle,  const
char **strs, int *strl, int nelts, apr_size_t len){
    char *str;
    char *s;
    int i;
    apr_status_t rv;
    buffered_log *buf = (buffered_log*)handle;

    if (len + buf->outcnt > LOG_BUFSIZE) {
            flush_log(buf);
    }
    if (len >= LOG_BUFSIZE) {
            apr_size_t w;

            str = apr_palloc(r->pool, len + 1);
            for (i = 0, s = str; i < nelts; ++i) {
                    memcpy(s, strs[i], strl[i]);
                    s += strl[i];
            }

   }
    else {
            for (i = 0, s = &buf->outbuf[buf->outcnt]; i < nelts; ++i) {
                    memcpy(s, strs[i], strl[i]);
                    s += strl[i];
            }

            buf->outcnt += tmp;  // ------  buf is a shared variable
            //for(j=0 ; j<1000 ; j++);           

            rv = APR_SUCCESS;
    }

    return rv;
}

 So, my question is :

 (a) Is there any way to increase the possibility of capturing the STORE event
of buf->outcnt  [ by adding some code ] ?

 (b) I am not able to see the ap_buffered_log_write function in the perf log
when I increase sampling rate to -c 5 or more. I guess this because of frequent
page faults or due to highly frequent interrupts. I observed that -c 10 is good
for this example. 

Currently I use perf to sample all events in a script that sets up apache, wget
files and then stops apache. This involves sampling across the entire script.

once.sh :
killall -9 httpd  &> /dev/null
./install/bin/apachectl -k start
./get_files 8
./install/bin/apachectl -k stop
file -b ./install/logs/access_log

Then,
 perf record -R -e r841:u,r140:u -c 10 -a bash once.sh 

I only need to monitor httpd logging process. How can I get more fine grained
control over the specific logging process rather than running perf on the entire
Apache script ?


Thanks.
Joy
