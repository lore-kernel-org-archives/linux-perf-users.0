From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 79/86] perf header: Add event desc to pipe-mode header
Date: Wed, 19 Jul 2017 11:29:43 -0300
Message-ID: <20170719142950.3747-80-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932748AbdGSOh4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2017 10:37:56 -0400
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: David Carrillo-Cisneros <davidcc@google.com>

Add event descriptor to perf header output in pipe-mode.

After this patch:

  $ perf record -e cycles sleep 1 | perf report --header
  # ========
  # captured on: Mon Jun  5 22:52:13 2017
  # ========
  #
  # hostname : lphh20
  # os release : 4.3.5-smp-801.43.0.0
  # perf version : 4.12.rc2.g439987
  # arch : x86_64
  # nrcpus online : 72
  # nrcpus avail : 72
  # cpudesc : Intel(R) Xeon(R) CPU E5-2696 v3 @ 2.30GHz
  # cpuid : GenuineIntel,6,63,2
  # total memory : 264134144 kB
  # cmdline : /root/perf record -e cycles sleep 1
  # event : name = cycles, , size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|PERIOD, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1
  # CPU_TOPOLOGY info available, use -I to display
  # NUMA_TOPOLOGY info available, use -I to display
  # pmu mappings: intel_bts = 6, cpu = 4, msr = 49, uncore_cbox_10 = 36, uncore_cbox_11 = 37, uncore_cbox_12 = 38, uncore_cbox_13 = 39, uncore_cbox_14 = 40, uncore_cbox_15 = 41, uncore_cbox_16 = 42, uncore_cbox_17 = 43, software = 1, power = 7, uncore_irp = 24, uncore_pcu = 48, tracepoint = 2, uncore_imc_0 = 16, uncore_imc_1 = 17, uncore_imc_2 = 18, uncore_imc_3 = 19, uncore_imc_4 = 20, uncore_imc_5 = 21, uncore_imc_6 = 22, uncore_imc_7 = 23, uncore_qpi_0 = 8, uncore_qpi_1 = 9, uncore_cbox_0 = 26, uncore_cbox_1 = 27, uncore_cbox_2 = 28, uncore_cbox_3 = 29, uncore_cbox_4 = 30, uncore_cbox_5 = 31, uncore_cbox_6 = 32, uncore_cbox_7 = 33, uncore_cbox_8 = 34, uncore_cbox_9 = 35, uncore_r2pcie = 13, uncore_r3qpi_0 = 10, uncore_r3qpi_1 = 11, uncore_r3qpi_2 = 12, uncore_sbox_0 = 44, uncore_sbox_1 
 = 45, uncore_sbox_2 = 46, uncore_sbox_3 = 47, breakpoint = 5, uncore_ha_0 = 14, uncore_ha_1 = 15, uncore_ubox = 25
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB (null) ]

Prior to this patch, event was not printed.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: David Ahern <dsahern@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170718042549.145161-17-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2e6036d3e584..28bf4442d577 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -67,6 +67,7 @@ struct feat_fd {
 	void			*buf;	/* Either buf != NULL or fd >= 0 */
 	ssize_t			offset;
 	size_t			size;
+	struct perf_evsel	*events;
 };
 
 void perf_header__set_feat(struct perf_header *header, int feat)
@@ -1359,10 +1360,15 @@ static int __desc_attr__fprintf(FILE *fp, const char *name, const char *val,
 
 static void print_event_desc(struct feat_fd *ff, FILE *fp)
 {
-	struct perf_evsel *evsel, *events = read_event_desc(ff);
+	struct perf_evsel *evsel, *events;
 	u32 j;
 	u64 *id;
 
+	if (ff->events)
+		events = ff->events;
+	else
+		events = read_event_desc(ff);
+
 	if (!events) {
 		fprintf(fp, "# event desc: not available or unable to read\n");
 		return;
@@ -1387,6 +1393,7 @@ static void print_event_desc(struct feat_fd *ff, FILE *fp)
 	}
 
 	free_event_desc(events);
+	ff->events = NULL;
 }
 
 static void print_total_mem(struct feat_fd *ff, FILE *fp)
@@ -1757,10 +1764,18 @@ process_event_desc(struct feat_fd *ff, void *data __maybe_unused)
 		return 0;
 
 	session = container_of(ff->ph, struct perf_session, header);
+
+	if (session->file->is_pipe) {
+		/* Save events for reading later by print_event_desc,
+		 * since they can't be read again in pipe mode. */
+		ff->events = events;
+	}
+
 	for (evsel = events; evsel->attr.size; evsel++)
 		perf_evlist__set_event_name(session->evlist, evsel);
 
-	free_event_desc(events);
+	if (!session->file->is_pipe)
+		free_event_desc(events);
 
 	return 0;
 }
-- 
2.9.4
