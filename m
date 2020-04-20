From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/60] perf synthetic-events: save 4kb from 2 stack frames
Date: Mon, 20 Apr 2020 08:52:36 -0300
Message-ID: <20200420115316.18781-21-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andrey Zhizhikin <andrey.z@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ian Rogers <irogers@google.com>

Reuse an existing char buffer to avoid two PATH_MAX sized char buffers.

Reduces stack frame sizes by 4kb.

perf_event__synthesize_mmap_events before 'sub $0x45b8,%rsp' after
'sub $0x35b8,%rsp'.

perf_event__get_comm_ids before 'sub $0x2028,%rsp' after
'sub $0x1028,%rsp'.

The performance impact of this change is negligible.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrey Zhizhikin <andrey.z@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200402154357.107873-4-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/synthetic-events.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index a661b122d9d8..9d4aa951eaa6 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -71,7 +71,6 @@ int perf_tool__process_synth_event(struct perf_tool *tool,
 static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 				    pid_t *tgid, pid_t *ppid)
 {
-	char filename[PATH_MAX];
 	char bf[4096];
 	int fd;
 	size_t size = 0;
@@ -81,11 +80,11 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 	*tgid = -1;
 	*ppid = -1;
 
-	snprintf(filename, sizeof(filename), "/proc/%d/status", pid);
+	snprintf(bf, sizeof(bf), "/proc/%d/status", pid);
 
-	fd = open(filename, O_RDONLY);
+	fd = open(bf, O_RDONLY);
 	if (fd < 0) {
-		pr_debug("couldn't open %s\n", filename);
+		pr_debug("couldn't open %s\n", bf);
 		return -1;
 	}
 
@@ -281,9 +280,9 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 				       struct machine *machine,
 				       bool mmap_data)
 {
-	char filename[PATH_MAX];
 	FILE *fp;
 	unsigned long long t;
+	char bf[BUFSIZ];
 	bool truncation = false;
 	unsigned long long timeout = proc_map_timeout * 1000000ULL;
 	int rc = 0;
@@ -293,15 +292,15 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	if (machine__is_default_guest(machine))
 		return 0;
 
-	snprintf(filename, sizeof(filename), "%s/proc/%d/task/%d/maps",
-		 machine->root_dir, pid, pid);
+	snprintf(bf, sizeof(bf), "%s/proc/%d/task/%d/maps",
+		machine->root_dir, pid, pid);
 
-	fp = fopen(filename, "r");
+	fp = fopen(bf, "r");
 	if (fp == NULL) {
 		/*
 		 * We raced with a task exiting - just return:
 		 */
-		pr_debug("couldn't open %s\n", filename);
+		pr_debug("couldn't open %s\n", bf);
 		return -1;
 	}
 
@@ -309,7 +308,6 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	t = rdclock();
 
 	while (1) {
-		char bf[BUFSIZ];
 		char prot[5];
 		char execname[PATH_MAX];
 		char anonstr[] = "//anon";
@@ -321,10 +319,10 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 			break;
 
 		if ((rdclock() - t) > timeout) {
-			pr_warning("Reading %s time out. "
+			pr_warning("Reading %s/proc/%d/task/%d/maps time out. "
 				   "You may want to increase "
 				   "the time limit by --proc-map-timeout\n",
-				   filename);
+				   machine->root_dir, pid, pid);
 			truncation = true;
 			goto out;
 		}
-- 
2.21.1
