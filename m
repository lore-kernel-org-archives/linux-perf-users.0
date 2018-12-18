From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/63] perf trace: Rename set_ev_qualifier_filter to clarify its a tracepoint filter
Date: Tue, 18 Dec 2018 19:06:50 -0300
Message-ID: <20181218220733.15839-21-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Rename it to trace__set_ev_qualifier_tp_filter(), as this just sets up
tracepoint filters on the raw_syscalls:sys_{enter,exit} tracepoints, and
since we're going to do the same for the augmented_raw_syscalls
codepath, when used, rename it to clarify.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8bjsul8x7osw7nxjodnyfn14@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a14ee4ed2c9f..76e4fa04d824 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2553,7 +2553,7 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	goto out;
 }
 
-static int trace__set_ev_qualifier_filter(struct trace *trace)
+static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 {
 	int err = -1;
 	struct perf_evsel *sys_exit;
@@ -2578,6 +2578,11 @@ static int trace__set_ev_qualifier_filter(struct trace *trace)
 	goto out;
 }
 
+static int trace__set_ev_qualifier_filter(struct trace *trace)
+{
+	return trace__set_ev_qualifier_tp_filter(trace);
+}
+
 static int bpf_map__set_filter_pids(struct bpf_map *map __maybe_unused,
 				    size_t npids __maybe_unused, pid_t *pids __maybe_unused)
 {
-- 
2.19.2
