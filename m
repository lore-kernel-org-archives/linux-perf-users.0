From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/27] perf tests: Check that complex event name is parsed correctly
Date: Wed, 25 Jul 2018 14:59:35 -0300
Message-ID: <20180725180001.15108-2-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Extend regression testing to cover case of complex event names enabled
by the cset f92da71280fb ("perf record: Enable arbitrary event names
thru name= modifier").

Testing it:

  # perf test
   1: vmlinux symtab matches kallsyms                       : Skip
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok		<===!
   7: Simple expression parser                              : Ok
...

Committer testing:

  # perf test "event definition"
   6: Parse event definition strings                        : Ok
  # perf test -v 6 2> /tmp/before
  # perf test -v 6 2> /tmp/after
  # diff -u /tmp/before /tmp/after
  --- /tmp/before	2018-06-19 10:50:21.485572638 -0300
  +++ /tmp/after	2018-06-19 10:50:40.886572896 -0300
  @@ -1,6 +1,6 @@
    6: Parse event definition strings                        :
   --- start ---
  -test child forked, pid 24259
  +test child forked, pid 24904
   running test 0 'syscalls:sys_enter_openat'Using CPUID GenuineIntel-6-3D
   registering plugin: /root/.traceevent/plugins/plugin_kvm.so
   registering plugin: /root/.traceevent/plugins/plugin_hrtimer.so
  @@ -136,9 +136,11 @@
   running test 50 '4:0x6530160/name=numpmu/'
   running test 51 'L1-dcache-misses/name=cachepmu/'
   running test 52 'intel_pt//u'
  +running test 53 'cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk'
   running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
   running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
   running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
  +running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp'
   el-capacity -> cpu/event=0x54,umask=0x2/
   el-conflict -> cpu/event=0x54,umask=0x1/
   el-start -> cpu/event=0xc8,umask=0x1/
  #

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/ad30b774-219b-7b80-c610-4e9e298cf8a7@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/parse-events.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 61211918bfba..a36313daec4e 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1322,6 +1322,14 @@ static int test__intel_pt(struct perf_evlist *evlist)
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
@@ -1658,6 +1666,11 @@ static struct evlist_test test__events[] = {
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
@@ -1676,6 +1689,11 @@ static struct evlist_test test__events_pmu[] = {
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
-- 
2.14.4
