From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/report: [RFC] Handling OOM in perf report
Date: Mon,  1 Apr 2019 16:20:00 +0200
Message-ID: <20190401142000.17679-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

A very strange -ENOMEM error which only when output
is displayed using the GTK GUI (I have copied the text from the GUI):

[root@m35lp76 perf]# ./perf  report -i perf.data.error68-1

	Processing events... [974K/3M]
	Error:failed to process sample

	0xf4198 [0x8]: failed to process type: 68

However when I use the same perf.data file with --stdio it works:

[root@m35lp76 perf]# ./perf  report -i perf.data.error68-1 --stdio \
		| head -12

  # Total Lost Samples: 0
  #
  # Samples: 76K of event 'cycles'
  # Event count (approx.): 99056160000
  #
  # Overhead  Command          Shared Object      Symbol
  # ........  ...............  .................  .........
  #
     8.81%  find             [kernel.kallsyms]  [k] ftrace_likely_update
     8.74%  swapper          [kernel.kallsyms]  [k] ftrace_likely_update
     8.34%  sshd             [kernel.kallsyms]  [k] ftrace_likely_update
     2.19%  kworker/u512:1-  [kernel.kallsyms]  [k] ftrace_likely_update

The sample precentage is a bit low.....

It always fails in the FINISHED_ROUND event, event number 68.

When happened is the following. Perf report calls a lot of functions and
down deep when a FINISHED_ROUND event is processed, these functions are
called:

  perf_session__process_event()
  + perf_session__process_user_event()
    + process_finished_round()
      + ordered_events__flush()
        + __ordered_events__flush()
	  + do_flush()
	    + ordered_events__deliver_event()
	      + perf_session__deliver_event()
	        + machine__deliver_event()
	          + perf_evlist__deliver_event()
	            + process_sample_event()
	              + hist_entry_iter_add() --> only called in GUI case!!!
	                + hist_iter__report__callback()
	                  + symbol__inc_addr_sample()

	                    Now this functions runs out of memory and
			    returns -ENOMEM. This is reported all the way up
			    until function

perf_session__process_event() returns to its caller, where -ENOMEM is
changed to -EINVAL and processing stops:

 if ((skip = perf_session__process_event(session, event, head)) < 0) {
      pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
	     head, event->header.size, event->header.type);
      err = -EINVAL;
      goto out_err;
 }

This occured in the FINISHED_ROUND event when it has to process some
10000 entries and ran out of memory.

I understand that my perf.data file might just be too big, but I would
like to see some error message indicating OOM error instead of
processing failure of a unrelated event.

However this patch just does what the pr_debug() statement indicates,
the event is skipped and processing continues.
But at least the root cause is indicated and also shows up in the
GUI.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/builtin-report.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4054eb1f98ac..7a27b815f7a8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -283,8 +283,13 @@ static int process_sample_event(struct perf_tool *tool,
 		al.map->dso->hit = 1;
 
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_debug("problem adding hist entry, skipping event\n");
+		if (ret == -ENOMEM) {
+			pr_err("Running out of memory\n");
+			ret = 0;
+		}
+	}
 out_put:
 	addr_location__put(&al);
 	return ret;
-- 
2.16.4
