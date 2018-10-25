From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/37] perf evsel: Mark a evsel as disabled when asking the kernel do disable it
Date: Thu, 25 Oct 2018 08:10:03 -0300
Message-ID: <20181025111031.3440-10-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Because there may be more such events in the ring buffer that should be
discarded when an app decides to stop considering them.

At some point we'll do this with eBPF, this way we stop them at origin,
before they are placed in the ring buffer.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-uzufuxws4hufigx07ue1dpv6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c |  2 +-
 tools/perf/util/evsel.c  | 23 +++++++++++++++++------
 tools/perf/util/evsel.h  |  1 +
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index be440df29615..e88e6f9b1463 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -358,7 +358,7 @@ void perf_evlist__disable(struct perf_evlist *evlist)
 	struct perf_evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
-		if (!perf_evsel__is_group_leader(pos) || !pos->fd)
+		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->fd)
 			continue;
 		perf_evsel__disable(pos);
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7e95ec1c19a8..6d187059a373 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1207,16 +1207,27 @@ int perf_evsel__append_addr_filter(struct perf_evsel *evsel, const char *filter)
 
 int perf_evsel__enable(struct perf_evsel *evsel)
 {
-	return perf_evsel__run_ioctl(evsel,
-				     PERF_EVENT_IOC_ENABLE,
-				     0);
+	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0);
+
+	if (!err)
+		evsel->disabled = false;
+
+	return err;
 }
 
 int perf_evsel__disable(struct perf_evsel *evsel)
 {
-	return perf_evsel__run_ioctl(evsel,
-				     PERF_EVENT_IOC_DISABLE,
-				     0);
+	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0);
+	/*
+	 * We mark it disabled here so that tools that disable a event can
+	 * ignore events after they disable it. I.e. the ring buffer may have
+	 * already a few more events queued up before the kernel got the stop
+	 * request.
+	 */
+	if (!err)
+		evsel->disabled = true;
+
+	return err;
 }
 
 int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ad5d615c6db6..4ef50f157b50 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -122,6 +122,7 @@ struct perf_evsel {
 	bool			snapshot;
 	bool 			supported;
 	bool 			needs_swap;
+	bool 			disabled;
 	bool			no_aux_samples;
 	bool			immediate;
 	bool			system_wide;
-- 
2.14.4
