From: James Clark <james.clark@arm.com>
Subject: [PATCH v2 5/7] perf tools: add perf_evlist__terminate() for terminate
Date: Thu, 23 Jan 2020 16:07:32 +0000
Message-ID: <20200123160734.3775-6-james.clark@arm.com>
References: <20200123160734.3775-1-james.clark@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200123160734.3775-1-james.clark@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com, gengdongjiu@huawei.com, wxf.wang@hisilicon.com, liwei391@huawei.com, liuqi115@hisilicon.com, huawei.libin@huawei.com, nd@arm.com, linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Tan Xiaojun <tanxiaojun@huawei.com>, Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Wei Li <liwei391@huawei.com>

In __cmd_record(), when receiving SIGINT(ctrl + c), a done flag will
be set and the event list will be disabled by perf_evlist__disable()
once.

While in auxtrace_record.read_finish(), the related events will be
enabled again, if they are continuous, the recording seems to be endless.

Mark the evlist's state as terminated, preparing for the following fix.

Signed-off-by: Wei Li <liwei391@huawei.com>
Tested-by: Qi Liu <liuqi115@hisilicon.com>
Signed-off-by: James Clark <james.clark@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Al Grant <al.grant@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c |  1 +
 tools/perf/util/evlist.c    | 14 ++++++++++++++
 tools/perf/util/evlist.h    |  1 +
 tools/perf/util/evsel.h     |  1 +
 4 files changed, 17 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4c301466101b..e7c917f9534d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1722,6 +1722,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (done && !disabled && !target__none(&opts->target)) {
 			trigger_off(&auxtrace_snapshot_trigger);
 			evlist__disable(rec->evlist);
+			evlist__terminate(rec->evlist);
 			disabled = true;
 		}
 	}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b9c7e5271611..b04794cd8586 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -377,6 +377,20 @@ bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
 	return true;
 }
 
+void evlist__terminate(struct evlist *evlist)
+{
+	struct evsel *pos;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
+			continue;
+		evsel__disable(pos);
+		pos->terminated = true;
+	}
+
+	evlist->enabled = false;
+}
+
 void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f5bd5c386df1..9fbd0ce2a1c4 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -206,6 +206,7 @@ void evlist__munmap(struct evlist *evlist);
 
 size_t evlist__mmap_size(unsigned long pages);
 
+void evlist__terminate(struct evlist *evlist);
 void evlist__disable(struct evlist *evlist);
 void evlist__enable(struct evlist *evlist);
 void perf_evlist__toggle_enable(struct evlist *evlist);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index dc14f4a823cd..8e8a2cb41de8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -104,6 +104,7 @@ struct evsel {
 		perf_evsel__sb_cb_t	*cb;
 		void			*data;
 	} side_band;
+	bool			terminated;
 };
 
 struct perf_missing_features {
-- 
2.25.0
