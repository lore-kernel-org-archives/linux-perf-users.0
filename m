From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/24] perf report: Dump s390 counter set data to file
Date: Mon, 21 Jan 2019 20:56:54 -0300
Message-ID: <20190121235706.20005-13-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Add support for the new s390 PMU device cpum_cf_diag to extract the
counter set diagnostic data. This data is available as event raw data
and can be created with this command:

  [root@s35lp76 perf]# ./perf record -R -e '{rbd000,rbc000}' --
                                 ~/mytests/facultaet 2500
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.009 MB perf.data ]
  [root@s35lp76 perf]#

The new event 0xbc000 generated this counter set diagnostic trace data.
The data can be extracted using command:

  [root@s35lp76 perf]# ./perf report --stdio --itrace=d
  #
  # Total Lost Samples: 0
  #
  # Samples: 21  of events 'anon group { rbd000, rbc000 }'
  # Event count (approx.): 21
  #
  #         Overhead  Command    Shared Object      Symbol
  # ................  .........  .................  ........................
  #
    80.95%   0.00%  facultaet  facultaet          [.] facultaet
     4.76%   0.00%  facultaet  [kernel.kallsyms]  [k] check_chain_key
     4.76%   0.00%  facultaet  [kernel.kallsyms]  [k] ftrace_likely_update
     4.76%   0.00%  facultaet  [kernel.kallsyms]  [k] lock_release
     4.76%   0.00%  facultaet  libc-2.26.so       [.] _dl_addr
  [root@s35lp76 perf]# ll aux*
  -rw-r--r-- 1 root root 3408 Oct 16 12:40 aux.ctr.02
  -rw-r--r-- 1 root root 4096 Oct 16 12:40 aux.smp.02
  [root@s35lp76 perf]#

The files named aux.ctr.## contain the counter set diagnostic data and
the files named aux.smp.## contain the sampling diagnostic data. ##
stand for the CPU number the data was taken from.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20190117093003.96287-4-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/s390-cpumsf.c | 77 +++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 68b2570304ec..835249c77f56 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -162,6 +162,7 @@
 #include "auxtrace.h"
 #include "s390-cpumsf.h"
 #include "s390-cpumsf-kernel.h"
+#include "s390-cpumcf-kernel.h"
 #include "config.h"
 
 struct s390_cpumsf {
@@ -184,8 +185,58 @@ struct s390_cpumsf_queue {
 	struct auxtrace_buffer	*buffer;
 	int			cpu;
 	FILE			*logfile;
+	FILE			*logfile_ctr;
 };
 
+/* Check if the raw data should be dumped to file. If this is the case and
+ * the file to dump to has not been opened for writing, do so.
+ *
+ * Return 0 on success and greater zero on error so processing continues.
+ */
+static int s390_cpumcf_dumpctr(struct s390_cpumsf *sf,
+			       struct perf_sample *sample)
+{
+	struct s390_cpumsf_queue *sfq;
+	struct auxtrace_queue *q;
+	int rc = 0;
+
+	if (!sf->use_logfile || sf->queues.nr_queues <= sample->cpu)
+		return rc;
+
+	q = &sf->queues.queue_array[sample->cpu];
+	sfq = q->priv;
+	if (!sfq)		/* Queue not yet allocated */
+		return rc;
+
+	if (!sfq->logfile_ctr) {
+		char *name;
+
+		rc = (sf->logdir)
+			? asprintf(&name, "%s/aux.ctr.%02x",
+				 sf->logdir, sample->cpu)
+			: asprintf(&name, "aux.ctr.%02x", sample->cpu);
+		if (rc > 0)
+			sfq->logfile_ctr = fopen(name, "w");
+		if (sfq->logfile_ctr == NULL) {
+			pr_err("Failed to open counter set log file %s, "
+			       "continue...\n", name);
+			rc = 1;
+		}
+		free(name);
+	}
+
+	if (sfq->logfile_ctr) {
+		/* See comment above for -4 */
+		size_t n = fwrite(sample->raw_data, sample->raw_size - 4, 1,
+				  sfq->logfile_ctr);
+		if (n != 1) {
+			pr_err("Failed to write counter set data\n");
+			rc = 1;
+		}
+	}
+	return rc;
+}
+
 /* Display s390 CPU measurement facility basic-sampling data entry */
 static bool s390_cpumsf_basic_show(const char *color, size_t pos,
 				   struct hws_basic_entry *basic)
@@ -792,7 +843,7 @@ static int s390_cpumsf_lost(struct s390_cpumsf *sf, struct perf_sample *sample)
 }
 
 static int
-s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
+s390_cpumsf_process_event(struct perf_session *session,
 			  union perf_event *event,
 			  struct perf_sample *sample,
 			  struct perf_tool *tool)
@@ -801,6 +852,8 @@ s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
 					      struct s390_cpumsf,
 					      auxtrace);
 	u64 timestamp = sample->time;
+	struct perf_evsel *ev_bc000;
+
 	int err = 0;
 
 	if (dump_trace)
@@ -811,6 +864,16 @@ s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
 		return -EINVAL;
 	}
 
+	if (event->header.type == PERF_RECORD_SAMPLE &&
+	    sample->raw_size) {
+		/* Handle event with raw data */
+		ev_bc000 = perf_evlist__event2evsel(session->evlist, event);
+		if (ev_bc000 &&
+		    ev_bc000->attr.config == PERF_EVENT_CPUM_CF_DIAG)
+			err = s390_cpumcf_dumpctr(sf, sample);
+		return err;
+	}
+
 	if (event->header.type == PERF_RECORD_AUX &&
 	    event->aux.flags & PERF_AUX_FLAG_TRUNCATED)
 		return s390_cpumsf_lost(sf, sample);
@@ -891,9 +954,15 @@ static void s390_cpumsf_free_queues(struct perf_session *session)
 		struct s390_cpumsf_queue *sfq = (struct s390_cpumsf_queue *)
 						queues->queue_array[i].priv;
 
-		if (sfq != NULL && sfq->logfile) {
-			fclose(sfq->logfile);
-			sfq->logfile = NULL;
+		if (sfq != NULL) {
+			if (sfq->logfile) {
+				fclose(sfq->logfile);
+				sfq->logfile = NULL;
+			}
+			if (sfq->logfile_ctr) {
+				fclose(sfq->logfile_ctr);
+				sfq->logfile_ctr = NULL;
+			}
 		}
 		zfree(&queues->queue_array[i].priv);
 	}
-- 
2.20.1
