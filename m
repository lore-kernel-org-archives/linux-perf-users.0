From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core 13/22] perf: Make perf_mmap to use refcnt for debug
Date: Wed, 09 Dec 2015 11:11:16 +0900
Message-ID: <20151209021116.10245.15749.stgit@localhost.localdomain>
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

Make 'perf_mmap' object to use refcnt interface for debug.
This can find refcnt related memory leaks.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/evlist.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d1b6c20..0637603 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -15,6 +15,7 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "debug.h"
+#include "refcnt.h"
 #include <unistd.h>
 
 #include "parse-events.h"
@@ -769,14 +770,14 @@ static bool perf_mmap__empty(struct perf_mmap *md)
 
 static void perf_evlist__mmap_get(struct perf_evlist *evlist, int idx)
 {
-	atomic_inc(&evlist->mmap[idx].refcnt);
+	refcnt__get(&evlist->mmap[idx], refcnt);
 }
 
 static void perf_evlist__mmap_put(struct perf_evlist *evlist, int idx)
 {
 	BUG_ON(atomic_read(&evlist->mmap[idx].refcnt) == 0);
 
-	if (atomic_dec_and_test(&evlist->mmap[idx].refcnt))
+	if (refcnt__put(&evlist->mmap[idx], refcnt))
 		__perf_evlist__munmap(evlist, idx);
 }
 
@@ -827,6 +828,7 @@ static void __perf_evlist__munmap(struct perf_evlist *evlist, int idx)
 	if (evlist->mmap[idx].base != NULL) {
 		munmap(evlist->mmap[idx].base, evlist->mmap_len);
 		evlist->mmap[idx].base = NULL;
+		refcnt__exit(&evlist->mmap[idx], refcnt);
 		atomic_set(&evlist->mmap[idx].refcnt, 0);
 	}
 	auxtrace_mmap__munmap(&evlist->mmap[idx].auxtrace_mmap);
@@ -876,7 +878,7 @@ static int __perf_evlist__mmap(struct perf_evlist *evlist, int idx,
 	 * evlist layer can't just drop it when filtering events in
 	 * perf_evlist__filter_pollfd().
 	 */
-	atomic_set(&evlist->mmap[idx].refcnt, 2);
+	refcnt__init_as(&evlist->mmap[idx], refcnt, 2, "perf_mmap");
 	evlist->mmap[idx].prev = 0;
 	evlist->mmap[idx].mask = mp->mask;
 	evlist->mmap[idx].base = mmap(NULL, evlist->mmap_len, mp->prot,
