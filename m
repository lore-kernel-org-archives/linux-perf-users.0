From: Guru Prasad <gurupras@buffalo.edu>
Subject: Sampling the perf counters
Date: Sun, 16 Dec 2012 11:29:32 -0500
Message-ID: <CAMefCkCMj2XNE15u9QEMKW0=0HU=QS3KLyxiyK40Zb-qaZxt6w@mail.gmail.com>
References: <CAMefCkBP4-We-jGet6EaWDGcztvMiKPsVBVVs7d3hyxOncSzFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46535 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab2LPQ3d (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 16 Dec 2012 11:29:33 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so8189376ieb.19
        for <linux-perf-users@vger.kernel.org>; Sun, 16 Dec 2012 08:29:32 -0800 (PST)
In-Reply-To: <CAMefCkBP4-We-jGet6EaWDGcztvMiKPsVBVVs7d3hyxOncSzFg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I modified Perf Stat to enable it to sample the performance counters
periodically. To do this, I moved the sampling portion of the code
into the while block.
While this works, I seem to get some erroneous data; such as cycle
counter being the same whereas instruction counter increased.

while(!done) {
            nanosleep(&delay,NULL);
            update_stats(&walltime_nsecs_stats, (rdclock() - t0));
            if (no_aggr) {
                list_for_each_entry(counter, &evsel_list->entries, node) {

                    read_counter(counter);
                }
            } else {
                list_for_each_entry(counter, &evsel_list->entries, node) {
                    read_counter_aggr(counter);
                }

                if(verbose)
                    fprintf(stdout , "\n\n");
            }
}

The command that I use to do this is
perf stat -e cycles,instructions -p <pid>

I believe this is because a context switch to the process being
monitored happens after perf reads the first counter (cycles).
Hence, after the context switch, when perf runs, it reads the
instruction counter which has moved ahead (as the process executed
upon context switching). This causes the cycle counter to reflect no
change in this sample whereas the instruction counter changed.

Is there any way to circumvent this issue?
