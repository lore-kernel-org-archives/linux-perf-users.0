From: "arkaitzj@gmail.com" <arkaitzj@gmail.com>
Subject: Perf inject taking hours to inject 10 minutes worth of capture
Date: Wed, 12 Apr 2017 14:09:56 +0100
Message-ID: <CAAPxSdz2rnjop5UPizRLn8iWu1gnngxgL5MEr9w_+6irgp3HcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:36070 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbdDLNKl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Apr 2017 09:10:41 -0400
Received: by mail-io0-f174.google.com with SMTP id l7so39495946ioe.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Apr 2017 06:10:40 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I am trying to get java callstacks on a perf report, but perf inject
seems to be taking forever, it hasn't stopped yet and its been running
for more than 60 minutes.

The system is:    4.10.9-1.el6.elrepo.x86_64 #1 SMP Sat Apr 8 14:45:00
EDT 2017 x86_64 x86_64 x86_64 GNU/Linux
The jitdump size is 328MB
And perf.data file sizes are(jitted is still growing):
#ls -alh perf.data*
-rw------- 1 root root 137M Apr 12 11:58 perf.data
-rw------- 1 root root 678M Apr 12 12:58 perf.data.jitted

The recording took around 10 minutes.
The command used for record is:
./perf record -k 1 -F99 -g --pid $(pgrep -f server)

The command used for injection is:
time ./perf inject  -i perf.data --jit -o perf.data.jitted

Is it normal that it takes so long? Can I do anything to speed it up,
its already burning 100% of a single core.

Thanks

--
Arkaitz
