From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf record premature termination
Date: Mon, 11 Feb 2013 12:34:35 -0700
Message-ID: <511947CB.5010600@gmail.com>
References: <1360608612.17632.193.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:36972 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758075Ab3BKTej (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 11 Feb 2013 14:34:39 -0500
Received: by mail-da0-f53.google.com with SMTP id w3so570358dad.12
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Feb 2013 11:34:39 -0800 (PST)
In-Reply-To: <1360608612.17632.193.camel@schen9-DESK>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, ak <ak@linux.intel.com>

On 2/11/13 11:50 AM, Tim Chen wrote:
> David,
>
> When I am doing a profiling of kernel compile with 32 threads on a 4
> socket westmere machine, I found that perf record terminated right away
> for the version of perf in 3.7 kernel source tree.
> There's no profile data recroded and the compile is running in
> background.
>
> $ make -j32 &
> then
> $ sudo /test/perf record -a -g -f sleep 5
> sleep: Terminated
>

This should fix it. I guess not all return codes were meant to be checked.


diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e9231659..7733051 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -645,9 +645,6 @@ static int __cmd_record(struct perf_record *rec, int 
argc, const char **argv)
         err = perf_event__synthesize_threads(tool, 
process_synthesized_event,
                            machine);

-   if (err != 0)
-       goto out_delete_session;
-
     if (rec->realtime_prio) {
         struct sched_param param;
