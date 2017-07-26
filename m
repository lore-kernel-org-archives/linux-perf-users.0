From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/40] perf trace: Filter out 'sshd' in the tracer ancestry in syswide tracing
Date: Wed, 26 Jul 2017 11:17:04 -0300
Message-ID: <20170726141730.30750-15-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Avoiding a loop, so now its quite convenient to ssh to a machine and
then simply do:

	# perf trace

To trace all syscalls without causing a loop.

This was possible using --filter-pids, i.e. once you noticed the loop,
get the sshd pid and add it to --filter-pids, restarting the 'perf
trace'.

Now to figure out how to do that in a X terminal, the other common
scenario, which is way more involved, as there are multiple processes
communicating to process terminal activity...

Using --filter-pids + '-e \!syscall,names,you,dont,need' may be a good
approximation when having to do syswide tracing on your workstation.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-68rjeao9wnpylla41htk7xps@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0ba36f08efd8..05d24b6570ee 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2241,10 +2241,24 @@ static int trace__set_ev_qualifier_filter(struct trace *trace)
 
 static int trace__set_filter_loop_pids(struct trace *trace)
 {
-	int nr = 1;
+	unsigned int nr = 1;
 	pid_t pids[32] = {
 		getpid(),
 	};
+	struct thread *thread = machine__find_thread(trace->host, pids[0], pids[0]);
+
+	while (thread && nr < ARRAY_SIZE(pids)) {
+		struct thread *parent = machine__find_thread(trace->host, thread->ppid, thread->ppid);
+
+		if (parent == NULL)
+			break;
+
+		if (!strcmp(thread__comm_str(parent), "sshd")) {
+			pids[nr++] = parent->tid;
+			break;
+		}
+		thread = parent;
+	}
 
 	return perf_evlist__set_filter_pids(trace->evlist, nr, pids);
 }
-- 
2.9.4
