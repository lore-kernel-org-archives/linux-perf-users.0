From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf record premature termination
Date: Mon, 11 Feb 2013 15:30:56 -0700
Message-ID: <51197120.7030207@gmail.com>
References: <1360608612.17632.193.camel@schen9-DESK>  <511947CB.5010600@gmail.com> <1360620940.17632.194.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:53913 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932630Ab3BKWbF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 11 Feb 2013 17:31:05 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so2959884dan.9
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Feb 2013 14:31:04 -0800 (PST)
In-Reply-To: <1360620940.17632.194.camel@schen9-DESK>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, ak <ak@linux.intel.com>

On 2/11/13 3:15 PM, Tim Chen wrote:
> On Mon, 2013-02-11 at 12:34 -0700, David Ahern wrote:
>> On 2/11/13 11:50 AM, Tim Chen wrote:
>>> David,
>>>
>>> When I am doing a profiling of kernel compile with 32 threads on a 4
>>> socket westmere machine, I found that perf record terminated right away
>>> for the version of perf in 3.7 kernel source tree.
>>> There's no profile data recroded and the compile is running in
>>> background.
>>>
>>> $ make -j32 &
>>> then
>>> $ sudo /test/perf record -a -g -f sleep 5
>>> sleep: Terminated

This is the more appropriate fix. Make mmap consistent with comm. Revert 
the other one.

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 3cf2c3e..ba74a81 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -183,7 +183,7 @@ static int perf_event__synthesize_mmap_events(struct 
perf_tool *tool,
          * We raced with a task exiting - just return:
          */
         pr_debug("couldn't open %s\n", filename);
-       return -1;
+       return 0;
     }

     event->header.type = PERF_RECORD_MMAP;
