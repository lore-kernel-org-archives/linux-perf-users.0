From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/25] perf record: No need to process the synthesized MMAP events twice
Date: Tue, 19 Nov 2019 08:32:29 -0300
Message-ID: <20191119113245.19593-10-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

At the end of a 'perf record' session, by default, we'll process all
samples and populate the threads, maps, etc so as to find out which of
the DSOs got samples, to reduce the size of the build-id table we'll
add to the perf.data headers.

But we don't need to process the PERF_RECORD_MMAP events synthesized
for the kernel modules, as we have those already via
perf_session__create_kernel_maps(), so add mmap/mmap2 handlers that
first look at event->header.misc to see if the event is for a user map,
bailing out if not.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mofoxvcx2dryppcw3o689jdd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b95c000c1ed9..7ab3110b4035 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2148,6 +2148,31 @@ static const char * const __record_usage[] = {
 };
 const char * const *record_usage = __record_usage;
 
+static int build_id__process_mmap(struct perf_tool *tool, union perf_event *event,
+				  struct perf_sample *sample, struct machine *machine)
+{
+	/*
+	 * We already have the kernel maps, put in place via perf_session__create_kernel_maps()
+	 * no need to add them twice.
+	 */
+	if (!(event->header.misc & PERF_RECORD_MISC_USER))
+		return 0;
+	return perf_event__process_mmap(tool, event, sample, machine);
+}
+
+static int build_id__process_mmap2(struct perf_tool *tool, union perf_event *event,
+				   struct perf_sample *sample, struct machine *machine)
+{
+	/*
+	 * We already have the kernel maps, put in place via perf_session__create_kernel_maps()
+	 * no need to add them twice.
+	 */
+	if (!(event->header.misc & PERF_RECORD_MISC_USER))
+		return 0;
+
+	return perf_event__process_mmap2(tool, event, sample, machine);
+}
+
 /*
  * XXX Ideally would be local to cmd_record() and passed to a record__new
  * because we need to have access to it in record__exit, that is called
@@ -2177,8 +2202,8 @@ static struct record record = {
 		.exit		= perf_event__process_exit,
 		.comm		= perf_event__process_comm,
 		.namespaces	= perf_event__process_namespaces,
-		.mmap		= perf_event__process_mmap,
-		.mmap2		= perf_event__process_mmap2,
+		.mmap		= build_id__process_mmap,
+		.mmap2		= build_id__process_mmap2,
 		.ordered_events	= true,
 	},
 };
-- 
2.21.0
