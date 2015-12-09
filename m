From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core  06/22] perf: Make dso to use refcnt for debug
Date: Wed, 09 Dec 2015 11:11:01 +0900
Message-ID: <20151209021101.10245.61601.stgit@localhost.localdomain>
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

Make 'dso' object to use refcnt interface for debug.
This can find refcnt related memory leaks on dsos.

E.g.
  ----
  # ./perf probe vfs_read
  Added new event:
    probe:vfs_read       (on vfs_read)

  You can now use it in all perf tools, such as:

          perf record -e probe:vfs_read -aR sleep 1

  REFCNT: BUG: Unreclaimed objects found.
  REFCNT: Total 75 objects are not reclaimed.
     To see all backtraces, rerun with -v option
  ----

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 Changes from v1:
  - Update refcnt__init() call to pass initial value.
---
 tools/perf/util/dso.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e8e9a9d..d7a3f34 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1066,7 +1066,7 @@ struct dso *dso__new(const char *name)
 		INIT_LIST_HEAD(&dso->node);
 		INIT_LIST_HEAD(&dso->data.open_entry);
 		pthread_mutex_init(&dso->lock, NULL);
-		atomic_set(&dso->refcnt, 1);
+		refcnt__init(dso, refcnt, 1);
 	}
 
 	return dso;
@@ -1098,19 +1098,20 @@ void dso__delete(struct dso *dso)
 	dso__free_a2l(dso);
 	zfree(&dso->symsrc_filename);
 	pthread_mutex_destroy(&dso->lock);
+	refcnt__exit(dso, refcnt);
 	free(dso);
 }
 
 struct dso *dso__get(struct dso *dso)
 {
 	if (dso)
-		atomic_inc(&dso->refcnt);
+		refcnt__get(dso, refcnt);
 	return dso;
 }
 
 void dso__put(struct dso *dso)
 {
-	if (dso && atomic_dec_and_test(&dso->refcnt))
+	if (dso && refcnt__put(dso, refcnt))
 		dso__delete(dso);
 }
 
