From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1]: perf tests: check that complex event name is parsed
 correctly
Date: Tue, 19 Jun 2018 11:45:40 +0300
Message-ID: <ad30b774-219b-7b80-c610-4e9e298cf8a7@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org


Extend regression testing to cover case of complex event names enabled 
by the patch "perf record: enable arbitrary event names thru name= modifier".

tools/perf/perf test
 1: vmlinux symtab matches kallsyms                       : Skip
 2: Detect openat syscall event                           : Ok
 3: Detect openat syscall event on all cpus               : Ok
 4: Read samples using the mmap interface                 : Ok
 5: Test data source output                               : Ok
 6: Parse event definition strings                        : Ok		<===!
 7: Simple expression parser                              : Ok
...

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/tests/parse-events.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index b9ebe15afb13..706b574f9747 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1317,6 +1317,14 @@ static int test__intel_pt(struct perf_evlist *evlist)
 	return 0;
 }
 
+static int test__checkevent_complex_name(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel = perf_evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong complex name parsing", strcmp(evsel->name, "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks") == 0);
+	return 0;
+}
+
 static int count_tracepoints(void)
 {
 	struct dirent *events_ent;
@@ -1651,6 +1659,11 @@ static struct evlist_test test__events[] = {
 		.check = test__intel_pt,
 		.id    = 52,
 	},
+	{
+		.name  = "cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk",
+		.check = test__checkevent_complex_name,
+		.id    = 53
+	}
 };
 
 static struct evlist_test test__events_pmu[] = {
@@ -1669,6 +1682,11 @@ static struct evlist_test test__events_pmu[] = {
 		.check = test__checkevent_pmu_partial_time_callgraph,
 		.id    = 2,
 	},
+	{
+		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp",
+		.check = test__checkevent_complex_name,
+		.id    = 3,
+	}
 };
 
 struct terms_test {
