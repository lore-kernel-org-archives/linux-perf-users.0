From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCHv2] perf/report: Report OOM in perf report status line
Date: Mon, 29 Apr 2019 09:50:33 +0200
Message-ID: <20190429075033.68680-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

An -ENOMEM error is not reported in the GTK GUI.
Instead this error message pops up on the screen:

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

The GUI always fails in the FINISHED_ROUND event (68) and does not
indicate the reason why.

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

This occurred in the FINISHED_ROUND event when it has to process some
10000 entries and ran out of memory.

This patch indicates the root cause and displays it in the status line
of ther perf report GUI.

Output before (on GUI status line):
0xf4198 [0x8]: failed to process type: 68

Output after:
0xf4198 [0x8]: failed to process type: 68 [not enough memory]

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/util/session.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b17f1c9bc965..267d3f8fcc0f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1930,10 +1930,17 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 	if (size < sizeof(struct perf_event_header) ||
 	    (skip = rd->process(session, event, file_pos)) < 0) {
-		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
-		       file_offset + head, event->header.size,
-		       event->header.type);
-		err = -EINVAL;
+		if (skip < 0) {
+			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
+			       file_offset + head, event->header.size,
+			       event->header.type, strerror(-skip));
+			err = skip;
+		} else {
+			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
+			       file_offset + head, event->header.size,
+			       event->header.type);
+			err = -EINVAL;
+		}
 		goto out;
 	}
 
-- 
2.19.1
