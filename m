From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core 11/22] perf: Make cgroup_sel to use refcnt for
 debug
Date: Wed, 09 Dec 2015 11:11:12 +0900
Message-ID: <20151209021112.10245.81989.stgit@localhost.localdomain>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Make 'cgroup_sel' object to use refcnt interface for debug.
This can find refcnt related memory leaks.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/cgroup.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 32e12ec..d925f86 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -4,6 +4,7 @@
 #include "evsel.h"
 #include "cgroup.h"
 #include "evlist.h"
+#include "refcnt.h"
 
 int nr_cgroups;
 
@@ -103,6 +104,7 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
 			free(cgrp);
 			return -1;
 		}
+		refcnt__init_as(cgrp, refcnt, 0, "cgroup_sel");
 	}
 
 	/*
@@ -115,21 +117,24 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
 			goto found;
 		n++;
 	}
-	if (atomic_read(&cgrp->refcnt) == 0)
+	if (atomic_read(&cgrp->refcnt) == 0) {
+		refcnt__exit(cgrp, refcnt);
 		free(cgrp);
+	}
 
 	return -1;
 found:
-	atomic_inc(&cgrp->refcnt);
+	refcnt__get(cgrp, refcnt);
 	counter->cgrp = cgrp;
 	return 0;
 }
 
 void close_cgroup(struct cgroup_sel *cgrp)
 {
-	if (cgrp && atomic_dec_and_test(&cgrp->refcnt)) {
+	if (cgrp && refcnt__put(cgrp, refcnt)) {
 		close(cgrp->fd);
 		zfree(&cgrp->name);
+		refcnt__exit(cgrp, refcnt);
 		free(cgrp);
 	}
 }
