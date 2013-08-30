From: Vince Weaver <vincent.weaver@maine.edu>
Subject: perf_event: rdpmc self-monitoring overhead issue
Date: Fri, 30 Aug 2013 13:55:25 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1308301334410.19094@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:47785 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340Ab3H3Rsl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 30 Aug 2013 13:48:41 -0400
Received: by mail-qe0-f43.google.com with SMTP id t7so1147944qeb.30
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2013 10:48:41 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org, acme@redhat.com, Stephane Eranian <eranian@gmail.com>

Hello,

I've finally found time to track down why perf_event/rdpmc self-monitoring 
overhead was so bad.

To summarize, a test which does:

   perf_event_open()
   ioctl(PERF_EVENT_IOC_ENABLE)
   read() /* either via syscall or  the rdpmc code listed in 
             include/uapi/linux/perf_event.h */
   ioctl(PERF_EVENT_IOC_DISABLE)

is done, and the number of cycles for each routine is taken using
rdtsc().

On a Core2 Processor the results look something like this for read:

                              | read time for 1 event
                              | median of 1024 runs
                              |     (cycles)
 -----------------------------|-------------------------
   2.6.32-perfctr (rdpmc)     |       133
   2.6.30-perfmon2            |      1264
   3.10                       |      1482
   3.10 (rdpmc)               |      3062

As you can see, using the userspace-only rdpmc code is twice as slow as 
just using the read() syscall.


I've tracked down the cause of this, and apparently it's due to
the first access to the event's struct perf_event_mmap_page.  If 
outside of the read timing code I do an unrelated read of the mmap() page
to fault it in, then the result is much more believable:

  3.10 (rdpmc)                 |      123

So the question is, why do I have to explicitly in advance fault the
page in?  Is there a way to force this to happen automatically?

The perfctr code as far as I can tell doesn't touch its mmap page in 
advance.
It uses vm_insert_page() to insert the page rather than the
rb tree stuff that perf_event uses.

I know part of this overhead is due to the construction of my benchmark
and in theory would be mitigated if you were doing a large number
of measurements in a program, but at the same time this is also a common
pattern when self-monitoring: putting calipers around one chunk of code
and taking one measurement (often in a timing-critical area where
overhead matters).

Vince
