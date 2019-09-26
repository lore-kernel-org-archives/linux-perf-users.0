From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/66] perf tools: Rename perf_evlist__purge() to evlist__purge()
Date: Wed, 25 Sep 2019 21:31:58 -0300
Message-ID: <20190926003244.13962-21-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename (perf_evlist__purge) to evlist__purge(), so we don't have a
name clash when we add (perf_evlist__purge) in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4c5b7040c02b..c96c743cc1d2 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -124,7 +124,7 @@ static void perf_evlist__update_id_pos(struct evlist *evlist)
 	perf_evlist__set_id_pos(evlist);
 }
 
-static void perf_evlist__purge(struct evlist *evlist)
+static void evlist__purge(struct evlist *evlist)
 {
 	struct evsel *pos, *n;
 
@@ -155,7 +155,7 @@ void evlist__delete(struct evlist *evlist)
 	perf_thread_map__put(evlist->core.threads);
 	evlist->core.cpus = NULL;
 	evlist->core.threads = NULL;
-	perf_evlist__purge(evlist);
+	evlist__purge(evlist);
 	evlist__exit(evlist);
 	free(evlist);
 }
-- 
2.21.0
