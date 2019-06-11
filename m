From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 59/85] perf data: Fix perf.data documentation for HEADER_CPU_TOPOLOGY
Date: Tue, 11 Jun 2019 15:58:45 -0300
Message-ID: <20190611185911.11645-60-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'die' info isn't in the same array as core and socket ids, and we
missed the 'dies' string list, that comes right after the 'core' +
'socket' id variable length array, followed by the VLA for the dies.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: c9cb12c5ba08 ("perf header: Add die information in CPU topology")
Link: https://lkml.kernel.org/n/tip-nubi6mxp2n8ofvlx7ph6k3h6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/perf.data-file-format.txt   | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index de78183f6881..5f54feb19977 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -151,20 +151,35 @@ struct {
 
 	HEADER_CPU_TOPOLOGY = 13,
 
-String lists defining the core and CPU threads topology.
-The string lists are followed by a variable length array
-which contains core_id, die_id (for x86) and socket_id of each cpu.
-The number of entries can be determined by the size of the
-section minus the sizes of both string lists.
-
 struct {
+	/*
+	 * First revision of HEADER_CPU_TOPOLOGY
+	 *
+	 * See 'struct perf_header_string_list' definition earlier
+	 * in this file.
+	 */
+
        struct perf_header_string_list cores; /* Variable length */
        struct perf_header_string_list threads; /* Variable length */
+
+       /*
+        * Second revision of HEADER_CPU_TOPOLOGY, older tools
+        * will not consider what comes next
+        */
+
        struct {
 	      uint32_t core_id;
-	      uint32_t die_id;
 	      uint32_t socket_id;
        } cpus[nr]; /* Variable length records */
+       /* 'nr' comes from previously processed HEADER_NRCPUS's nr_cpu_avail */
+
+        /*
+	 * Third revision of HEADER_CPU_TOPOLOGY, older tools
+	 * will not consider what comes next
+	 */
+
+	struct perf_header_string_list dies; /* Variable length */
+	uint32_t die_id[nr_cpus_avail]; /* from previously processed HEADER_NR_CPUS, VLA */
 };
 
 Example:
-- 
2.20.1
