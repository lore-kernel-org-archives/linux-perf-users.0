From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/23] perf symbols: Update the list of kernel idle symbols
Date: Fri, 14 Feb 2020 16:10:36 -0300
Message-ID: <20200214191057.26266-3-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kim Phillips <kim.phillips@amd.com>, Jiri Olsa <jolsa@redhat.com>, Song Liu <songliubraving@fb.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

The "acpi_idle_do_entry", "acpi_processor_ffh_cstate_enter", and
"idle_cpu" symbols appear in 'perf top' output, at least on AMD systems.

Add them to perf's idle_symbols list, so they don't dominate 'perf top'
output.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200207230613.26709-2-kim.phillips@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3b379b1296f1..f3120c4f47ad 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -635,9 +635,12 @@ int modules__parse(const char *filename, void *arg,
 static bool symbol__is_idle(const char *name)
 {
 	const char * const idle_symbols[] = {
+		"acpi_idle_do_entry",
+		"acpi_processor_ffh_cstate_enter",
 		"arch_cpu_idle",
 		"cpu_idle",
 		"cpu_startup_entry",
+		"idle_cpu",
 		"intel_idle",
 		"default_idle",
 		"native_safe_halt",
-- 
2.21.1
