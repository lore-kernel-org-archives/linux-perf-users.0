From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: What does the "scaled from 66.58%" means?? What is scaled??
Date: Mon, 24 Jun 2013 18:37:12 -0400
Message-ID: <CAEuYUeq_fT+rz_hoMTqSX14EL0Z1CdAaEc8C5zyxXfgG=H7=bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:61902 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab3FXWhN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 24 Jun 2013 18:37:13 -0400
Received: by mail-ee0-f53.google.com with SMTP id c41so6357296eek.40
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2013 15:37:12 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: perf group <linux-perf-users@vger.kernel.org>

perf stat -B dd if=/dev/zero of=/dev/null count=1000000

1000000+0 records in
1000000+0 records out
512000000 bytes (512 MB) copied, 0.956217 s, 535 MB/s

 Performance counter stats for 'dd if=/dev/zero of=/dev/null count=1000000':

            5,099 cache-misses             #      0.005 M/sec (scaled
from 66.58%)
          235,384 cache-references         #      0.246 M/sec (scaled
from 66.56%)
        9,281,660 branch-misses            #      3.858 %     (scaled
from 33.50%)
      240,609,766 branches                 #    251.559 M/sec (scaled
from 33.66%)
    1,403,561,257 instructions             #      0.679 IPC   (scaled
from 50.23%)
    2,066,201,729 cycles                   #   2160.227 M/sec (scaled
from 66.67%)
              217 page-faults              #      0.000 M/sec
                3 CPU-migrations           #      0.000 M/sec
               83 context-switches         #      0.000 M/sec
       956.474238 task-clock-msecs         #      0.999 CPUs

       0.957617512  seconds time elapsed

Hi, all. I get a data from the
page:https://code.google.com/p/kernel/wiki/PerfUserGuide,
Can anyone explain to me the meaning of "scaled from", and from which
get the 66.58% or 33.50%??

Best wishes.
Yours,
Wang Peipei
