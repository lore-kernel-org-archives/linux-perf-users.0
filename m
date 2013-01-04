From: William Cohen <wcohen@redhat.com>
Subject: Unsing perf BTS support
Date: Fri, 04 Jan 2013 11:48:09 -0500
Message-ID: <50E707C9.4030102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32418 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754952Ab3ADQsK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Jan 2013 11:48:10 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r04GmAt7013598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-perf-users@vger.kernel.org>; Fri, 4 Jan 2013 11:48:10 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Arnaldo de Melo <acme@redhat.com>


Hi All,

I have been playing around with the Intel BTS support available in
perf and I have a number of questions about it.  I read through the
information on:

http://lwn.net/Articles/478047/

I only care about recording calls in the BTS.  Is there some way to
limit the BTS data collection to just calls?

I have been using the perf-3.6.10-2.fc17.x86_64 on Fedora 17, but seem
to get the same results with perf built from the linux mainline git
tree.  It seems to be missing much of the file and function
information in the perf report information. I attempt to collect some
trace data with a simple example like:


$ perf record -e branches:u -c 1 -d ls
..listing of directory ...
[ perf record: Woken up 8 times to write data ]
[ perf record: Captured and wrote 1.916 MB perf.data (~83705 samples) ]

However, sometimes it appears that the BTS data collection cause
segmentation faults like the following:

$ perf record -e branches:u -c 1 -d ls
..listing of directory ...
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.100 MB perf.data (~4384 samples) ]
ls: Segmentation fault

With a successful run the data should be analyzed with, but it doesn't
provide symbol mapping information:


$ perf script -f ip,addr,sym,dso,symoff --show-kernel-path
# ========
# captured on: Fri Jan  4 11:26:07 2013
# hostname : santana
# os release : 3.6.10-2.fc17.x86_64
# perf version : 3.6.10-2.fc17.x86_64
# arch : x86_64
# nrcpus online : 8
# nrcpus avail : 8
# cpudesc : Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz
# cpuid : GenuineIntel,6,58,9
# total memory : 3612396 kB
# cmdline : /usr/bin/perf record -e branches:u -c 1 -d ls 
# event : name = branches:u, type = 0, config = 0x4, config1 = 0x0, config2 = 0x0, excl_usr = 0, excl_kern = 1, excl_host = 0, excl_guest = 0, precise_ip = 0, id = { 335, 336, 337, 338, 339, 340, 341,
# HEADER_CPU_TOPOLOGY info available, use -I to display
# HEADER_NUMA_TOPOLOGY info available, use -I to display
# ========
#
 ffffffff8162713e sysret_check+0x4b (/usr/lib/debug/lib/modules/3.6.10-2.fc17.x86_64/vmlinux) =>       3439a0e090 [unknown] ([unknown])
       3439a0e098 [unknown] ([unknown]) =>           43c6cf [unknown] ([unknown])
           43c6dc [unknown] ([unknown]) =>           4121c0 [unknown] ([unknown])
           4121c0 [unknown] ([unknown]) =>       34392baec0 [unknown] ([unknown])
       34392baeca [unknown] ([unknown]) =>       34392bb080 [unknown] ([unknown])
       34392bb0af [unknown] ([unknown]) =>       3439283ba0 [unknown] ([unknown])
 ffffffff8161f429 irq_return+0x0 (/usr/lib/debug/lib/modules/3.6.10-2.fc17.x86_64/vmlinux) =>       3439283ba0 [unknown] ([unknown])
 ffffffff8161f429 irq_return+0x0 (/usr/lib/debug/lib/modules/3.6.10-2.fc17.x86_64/vmlinux) =>       3439283ba0 [unknown] ([unknown])
       3439283be6 [unknown] ([unknown]) =>       3439283c08 [unknown] ([unknown])
       3439283c0b [unknown] ([unknown]) =>       3439283c19 [unknown] ([unknown])
       3439283c1b [unknown] ([unknown]) =>       34392bb0b4 [unknown] ([unknown])
       34392bb0b7 [unknown] ([unknown]) =>       34392bb1d0 [unknown] ([unknown])
       34392bb1d7 [unknown] ([unknown]) =>       3439238170 [unknown] ([unknown])
 ffffffff8161f429 irq_return+0x0 (/usr/lib/debug/lib/modules/3.6.10-2.fc17.x86_64/vmlinux) =>       3439238170 [unknown] ([unknown])


It looks like the instructions don't mention the "-m" option for the
perf record the results look better with it:

$ perf record -e branches:u -m 128 -c 1 -d ls
...listing....
[ perf record: Woken up 8 times to write data ]
[ perf record: Captured and wrote 1.964 MB perf.data (~85807 samples) ]

$ perf script -f ip,addr,sym,dso,symoff --show-kernel-path
# ========
# captured on: Fri Jan  4 11:33:07 2013
# hostname : santana
# os release : 3.6.10-2.fc17.x86_64
# perf version : 3.6.10-2.fc17.x86_64
# arch : x86_64
# nrcpus online : 8
# nrcpus avail : 8
# cpudesc : Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz
# cpuid : GenuineIntel,6,58,9
# total memory : 3612396 kB
# cmdline : /usr/bin/perf record -e branches:u -m 128 -c 1 -d ls 
# event : name = branches:u, type = 0, config = 0x4, config1 = 0x0, config2 = 0x0, excl_usr = 0, excl_kern = 1, excl_host = 0, excl_guest = 0, precise_ip = 0, id = { 399, 400, 401, 402, 403, 404, 405,
# HEADER_CPU_TOPOLOGY info available, use -I to display
# HEADER_NUMA_TOPOLOGY info available, use -I to display
# ========
#
 ffffffff8162713e sysret_check+0x4b (/usr/lib/debug/lib/modules/3.6.10-2.fc17.x86_64/vmlinux) =>       3439a0e090 __read_nocancel+0x7 (/usr/lib64/libpthread-2.15.so)
       3439a0e098 __read_nocancel+0xf (/usr/lib64/libpthread-2.15.so) =>           43c6cf perf_evlist__prepare_workload+0x1af (/usr/bin/perf)
           43c6dc perf_evlist__prepare_workload+0x1bc (/usr/bin/perf) =>           4121c0 execvp@plt+0x0 (/usr/bin/perf)
           4121c0 execvp@plt+0x0 (/usr/bin/perf) =>       34392baec0 execvp+0x0 (/usr/lib64/libc-2.15.so)
       34392baeca execvp+0xa (/usr/lib64/libc-2.15.so) =>       34392bb080 __execvpe+0x0 (/usr/lib64/libc-2.15.so)
       34392bb0af __execvpe+0x2f (/usr/lib64/libc-2.15.so) =>       3439283ba0 __strchr_sse2+0x0 (/usr/lib64/libc-2.15.so)


However, a little ways into the output start seeing many [unknown] again:


ffffffff8161f429 irq_return+0x0 (/usr/lib/debug/lib/modules/3.6.10-2.fc17.x86_64/vmlinux) =>       343928f580 [unknown] ([unknown])
       343928f5ee [unknown] ([unknown]) =>       34392bb296 [unknown] ([unknown])
       34392bb2b2 [unknown] ([unknown]) =>       343928dee0 [unknown] ([unknown])
       343928deec [unknown] ([unknown]) =>       343928def9 [unknown] ([unknown])
       343928df24 [unknown] ([unknown]) =>       343928df34 [unknown] ([unknown])
       343928df5b [unknown] ([unknown]) =>       34392bb2b7 [unknown] ([unknown])
       34392bb2c3 [unknown] ([unknown]) =>       34392baa50 [unknown] ([unknown])


Are there some other combination of arguments that need to be passed
to "perf record" or "perf report" to get appropriate BTS data mapped
back to files and function?

-Will
