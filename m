From: Milian Wolff <milian.wolff@kdab.com>
Subject: perf sampling frequency drops after some record rounds?
Date: Tue, 11 Apr 2017 15:49:06 +0200
Message-ID: <14226027.icvnRACTdJ@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:37612 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752232AbdDKNtI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Apr 2017 09:49:08 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Perf Users <linux-perf-users@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <ak@linux.intel.com>, Nate Rogers <nate.rogers@kdab.com>

Hello all,

a colleague of mine (CC'ed) is encountering a strange issue with perf from 
Ubuntu 16.04 running on a Thinkpad P50 with Intel(R) Core(TM) i7-6700HQ CPU @ 
2.60GHz on 4.4.0-72-generic with perf version 4.4.49.

For him, the sampling frequency drops dramatically after some successful 
records, making perf record essentially unusable afterwards:

First, everything is nice and peachy:

Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
6.66491e+16
[ perf record: Woken up 20 times to write data ]
[ perf record: Captured and wrote 4.926 MB perf.data (613 samples) ]
Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
6.66491e+16
[ perf record: Woken up 19 times to write data ]
[ perf record: Captured and wrote 4.734 MB perf.data (591 samples) ]
Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
6.66491e+16
[ perf record: Woken up 19 times to write data ]
[ perf record: Captured and wrote 4.750 MB perf.data (591 samples) ]
Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
6.66491e+16
[ perf record: Woken up 20 times to write data ]
[ perf record: Captured and wrote 4.766 MB perf.data (593 samples) ]
Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
6.66491e+16
[ perf record: Woken up 19 times to write data ]
[ perf record: Captured and wrote 4.750 MB perf.data (591 samples) ]

But then, suddenly:

Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
6.66491e+16
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.082 MB perf.data (10 samples) ]
Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
6.66491e+16
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.082 MB perf.data (10 samples) ]

dmesg only shows:

[28449.132447] perf interrupt took too long (2510 > 2500), lowering 
kernel.perf_event_max_sample_rate to 50000

But that should still be large enough to encompass the above. Also, increasing 
that value to, say, 100000 does not help this situation. The only known 
workaround is to restart the machine to make it work again.

Is this a known kernel bug in that version? Anything he can try out to fix 
this situation? Anything he could do, other than restarting this machine, to 
bring back the usable sampling frequency?

Thanks
-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
