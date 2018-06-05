From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/46] perf cgroup: Make evlist__find_cgroup() more compact
Date: Tue,  5 Jun 2018 14:49:47 -0300
Message-ID: <20180605175030.32549-4-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

By taking advantage that __get() routines return the pointer to the
object for which a reference count is being get.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-xnvd07rdxliy04oi062samik@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index decb91f9da82..ccd02634a616 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -93,20 +93,17 @@ static int open_cgroup(const char *name)
 static struct cgroup *evlist__find_cgroup(struct perf_evlist *evlist, const char *str)
 {
 	struct perf_evsel *counter;
-	struct cgroup *cgrp = NULL;
 	/*
 	 * check if cgrp is already defined, if so we reuse it
 	 */
 	evlist__for_each_entry(evlist, counter) {
 		if (!counter->cgrp)
 			continue;
-		if (!strcmp(counter->cgrp->name, str)) {
-			cgrp = cgroup__get(counter->cgrp);
-			break;
-		}
+		if (!strcmp(counter->cgrp->name, str))
+			return cgroup__get(counter->cgrp);
 	}
 
-	return cgrp;
+	return NULL;
 }
 
 static struct cgroup *cgroup__new(const char *name)
-- 
2.14.3
