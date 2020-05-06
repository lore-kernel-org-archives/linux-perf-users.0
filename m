From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 46/91] perf intel-pt: Update documentation about itrace G and L options
Date: Wed,  6 May 2020 12:21:49 -0300
Message-ID: <20200506152234.21977-47-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Provide a little more information about the new G and L options,
particularly the issue with large PEBs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/itrace.txt        |  4 +++
 tools/perf/Documentation/perf-intel-pt.txt | 35 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 0326050beebd..271484754fee 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -33,6 +33,10 @@
 	Also the number of last branch entries (default 64, max. 1024) for
 	instructions or transactions events can be specified.
 
+	Similar to options g and l, size may also be specified for options G and L.
+	On x86, note that G and L work poorly when data has been recorded with
+	large PEBS. Refer linkperf:perf-intel-pt[1] man page for details.
+
 	It is also possible to skip events generated (instructions, branches, transactions,
 	ptwrite, power) at the beginning. This is useful to ignore initialization code.
 
diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 456fdcbf26ac..782eb8a65caf 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -821,7 +821,9 @@ The letters are:
 	e	synthesize tracing error events
 	d	create a debug log
 	g	synthesize a call chain (use with i or x)
+	G	synthesize a call chain on existing event records
 	l	synthesize last branch entries (use with i or x)
+	L	synthesize last branch entries on existing event records
 	s	skip initial number of events
 
 "Instructions" events look like they were recorded by "perf record -e
@@ -912,6 +914,39 @@ transactions events can be specified. e.g.
 Note that last branch entries are cleared for each sample, so there is no overlap
 from one sample to the next.
 
+The G and L options are designed in particular for sample mode, and work much
+like g and l but add call chain and branch stack to the other selected events
+instead of synthesized events. For example, to record branch-misses events for
+'ls' and then add a call chain derived from the Intel PT trace:
+
+	perf record --aux-sample -e '{intel_pt//u,branch-misses:u}' -- ls
+	perf report --itrace=Ge
+
+Although in fact G is a default for perf report, so that is the same as just:
+
+	perf report
+
+One caveat with the G and L options is that they work poorly with "Large PEBS".
+Large PEBS means PEBS records will be accumulated by hardware and the written
+into the event buffer in one go.  That reduces interrupts, but can give very
+late timestamps.  Because the Intel PT trace is synchronized by timestamps,
+the PEBS events do not match the trace.  Currently, Large PEBS is used only in
+certain circumstances:
+	- hardware supports it
+	- PEBS is used
+	- event period is specified, instead of frequency
+	- the sample type is limited to the following flags:
+		PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_ADDR |
+		PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_STREAM_ID |
+		PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER |
+		PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR |
+		PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER |
+		PERF_SAMPLE_PERIOD (and sometimes) | PERF_SAMPLE_TIME
+Because Intel PT sample mode uses a different sample type to the list above,
+Large PEBS is not used with Intel PT sample mode. To avoid Large PEBS in other
+cases, avoid specifying the event period i.e. avoid the 'perf record' -c option,
+--count option, or 'period' config term.
+
 To disable trace decoding entirely, use the option --no-itrace.
 
 It is also possible to skip events generated (instructions, branches, transactions)
-- 
2.21.1
