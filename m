From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/86] perf symbols: Find symbols in different mount namespace
Date: Wed, 19 Jul 2017 11:28:58 -0300
Message-ID: <20170719142950.3747-35-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Krister Johansen <kjlx@templeofstupid.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Krister Johansen <kjlx@templeofstupid.com>

Teach perf how to resolve symbols from binaries that are in a different
mount namespace from the tool.  This allows perf to generate meaningful
stack traces even if the binary resides in a different mount namespace
from the tool.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Tested-by: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/1499305693-1599-2-git-send-email-kjlx@templeofstupid.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c        |   1 +
 tools/perf/util/dso.h        |   2 +
 tools/perf/util/map.c        |   2 +
 tools/perf/util/namespaces.c | 127 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/namespaces.h |  33 +++++++++++
 tools/perf/util/symbol.c     |  11 ++++
 tools/perf/util/thread.c     |   3 +
 tools/perf/util/thread.h     |   1 +
 8 files changed, 180 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 4e7ab611377a..beda40ed63b0 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1236,6 +1236,7 @@ void dso__delete(struct dso *dso)
 	dso_cache__free(dso);
 	dso__free_a2l(dso);
 	zfree(&dso->symsrc_filename);
+	nsinfo__zput(dso->nsinfo);
 	pthread_mutex_destroy(&dso->lock);
 	free(dso);
 }
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index bd061ba7b47c..78ec637fc68b 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include "map.h"
+#include "namespaces.h"
 #include "build-id.h"
 
 enum dso_binary_type {
@@ -187,6 +188,7 @@ struct dso {
 		void	 *priv;
 		u64	 db_id;
 	};
+	struct nsinfo	*nsinfo;
 	refcount_t	 refcnt;
 	char		 name[0];
 };
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 2179b2deb730..5dc60ca5a294 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -16,6 +16,7 @@
 #include "machine.h"
 #include <linux/string.h>
 #include "srcline.h"
+#include "namespaces.h"
 #include "unwind.h"
 
 static void __maps__insert(struct maps *maps, struct map *map);
@@ -200,6 +201,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			if (type != MAP__FUNCTION)
 				dso__set_loaded(dso, map->type);
 		}
+		dso->nsinfo = nsinfo__get(thread->nsinfo);
 		dso__put(dso);
 	}
 	return map;
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 67dcbcc73c7d..bcc6bb19cf10 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -9,9 +9,13 @@
 #include "namespaces.h"
 #include "util.h"
 #include "event.h"
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sched.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
+#include <unistd.h>
 
 struct namespaces *namespaces__new(struct namespaces_event *event)
 {
@@ -35,3 +39,126 @@ void namespaces__free(struct namespaces *namespaces)
 {
 	free(namespaces);
 }
+
+void nsinfo__init(struct nsinfo *nsi)
+{
+	char oldns[PATH_MAX];
+	char *newns = NULL;
+	struct stat old_stat;
+	struct stat new_stat;
+
+	if (snprintf(oldns, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
+		return;
+
+	if (asprintf(&newns, "/proc/%d/ns/mnt", nsi->pid) == -1)
+		return;
+
+	if (stat(oldns, &old_stat) < 0)
+		goto out;
+
+	if (stat(newns, &new_stat) < 0)
+		goto out;
+
+	/* Check if the mount namespaces differ, if so then indicate that we
+	 * want to switch as part of looking up dso/map data.
+	 */
+	if (old_stat.st_ino != new_stat.st_ino) {
+		nsi->need_setns = true;
+		nsi->mntns_path = newns;
+		newns = NULL;
+	}
+
+out:
+	free(newns);
+}
+
+struct nsinfo *nsinfo__new(pid_t pid)
+{
+	struct nsinfo *nsi = calloc(1, sizeof(*nsi));
+
+	if (nsi != NULL) {
+		nsi->pid = pid;
+		nsi->need_setns = false;
+		nsinfo__init(nsi);
+		refcount_set(&nsi->refcnt, 1);
+	}
+
+	return nsi;
+}
+
+void nsinfo__delete(struct nsinfo *nsi)
+{
+	zfree(&nsi->mntns_path);
+	free(nsi);
+}
+
+struct nsinfo *nsinfo__get(struct nsinfo *nsi)
+{
+	if (nsi)
+		refcount_inc(&nsi->refcnt);
+	return nsi;
+}
+
+void nsinfo__put(struct nsinfo *nsi)
+{
+	if (nsi && refcount_dec_and_test(&nsi->refcnt))
+		nsinfo__delete(nsi);
+}
+
+void nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc)
+{
+	char curpath[PATH_MAX];
+	int oldns = -1;
+	int newns = -1;
+
+	if (nc == NULL)
+		return;
+
+	nc->oldns = -1;
+	nc->newns = -1;
+
+	if (!nsi || !nsi->need_setns)
+		return;
+
+	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
+		return;
+
+	oldns = open(curpath, O_RDONLY);
+	if (oldns < 0)
+		return;
+
+	newns = open(nsi->mntns_path, O_RDONLY);
+	if (newns < 0)
+		goto errout;
+
+	if (setns(newns, CLONE_NEWNS) < 0)
+		goto errout;
+
+	nc->oldns = oldns;
+	nc->newns = newns;
+	return;
+
+errout:
+	if (oldns > -1)
+		close(oldns);
+	if (newns > -1)
+		close(newns);
+}
+
+void nsinfo__mountns_exit(struct nscookie *nc)
+{
+	if (nc == NULL || nc->oldns == -1 || nc->newns == -1)
+		return;
+
+	setns(nc->oldns, CLONE_NEWNS);
+
+	if (nc->oldns > -1) {
+		close(nc->oldns);
+		nc->oldns = -1;
+	}
+
+	if (nc->newns > -1) {
+		close(nc->newns);
+		nc->newns = -1;
+	}
+}
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 468f1e9a1484..b20f6ead7b2d 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -11,6 +11,7 @@
 
 #include "../perf.h"
 #include <linux/list.h>
+#include <linux/refcount.h>
 
 struct namespaces_event;
 
@@ -23,4 +24,36 @@ struct namespaces {
 struct namespaces *namespaces__new(struct namespaces_event *event);
 void namespaces__free(struct namespaces *namespaces);
 
+struct nsinfo {
+	pid_t			pid;
+	bool			need_setns;
+	char			*mntns_path;
+	refcount_t		refcnt;
+};
+
+struct nscookie {
+	int			oldns;
+	int			newns;
+};
+
+void nsinfo__init(struct nsinfo *nsi);
+struct nsinfo *nsinfo__new(pid_t pid);
+void nsinfo__delete(struct nsinfo *nsi);
+
+struct nsinfo *nsinfo__get(struct nsinfo *nsi);
+void nsinfo__put(struct nsinfo *nsi);
+
+void nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc);
+void nsinfo__mountns_exit(struct nscookie *nc);
+
+static inline void __nsinfo__zput(struct nsinfo **nsip)
+{
+	if (nsip) {
+		nsinfo__put(*nsip);
+		*nsip = NULL;
+	}
+}
+
+#define nsinfo__zput(nsi) __nsinfo__zput(&nsi)
+
 #endif  /* __PERF_NAMESPACES_H */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index e7a98dbd2aed..60a9eaa372ef 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -18,6 +18,8 @@
 #include "symbol.h"
 #include "strlist.h"
 #include "intlist.h"
+#include "namespaces.h"
+#include "vdso.h"
 #include "header.h"
 #include "path.h"
 #include "sane_ctype.h"
@@ -1436,9 +1438,17 @@ int dso__load(struct dso *dso, struct map *map)
 	struct symsrc *syms_ss = NULL, *runtime_ss = NULL;
 	bool kmod;
 	unsigned char build_id[BUILD_ID_SIZE];
+	struct nscookie nsc;
 
+	nsinfo__mountns_enter(dso->nsinfo, &nsc);
 	pthread_mutex_lock(&dso->lock);
 
+	/* The vdso files always live in the host container, so don't go looking
+	 * for them in the container's mount namespace.
+	 */
+	if (dso__is_vdso(dso))
+		nsinfo__mountns_exit(&nsc);
+
 	/* check again under the dso->lock */
 	if (dso__loaded(dso, map->type)) {
 		ret = 1;
@@ -1584,6 +1594,7 @@ int dso__load(struct dso *dso, struct map *map)
 out:
 	dso__set_loaded(dso, map->type);
 	pthread_mutex_unlock(&dso->lock);
+	nsinfo__mountns_exit(&nsc);
 
 	return ret;
 }
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 378c418ca0c1..aee9a42102ba 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -59,6 +59,8 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		list_add(&comm->list, &thread->comm_list);
 		refcount_set(&thread->refcnt, 1);
 		RB_CLEAR_NODE(&thread->rb_node);
+		/* Thread holds first ref to nsdata. */
+		thread->nsinfo = nsinfo__new(pid);
 	}
 
 	return thread;
@@ -91,6 +93,7 @@ void thread__delete(struct thread *thread)
 		comm__free(comm);
 	}
 	unwind__finish_access(thread);
+	nsinfo__zput(thread->nsinfo);
 
 	free(thread);
 }
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 4eb849e9098f..cb1a5dd5c2b9 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -34,6 +34,7 @@ struct thread {
 
 	void			*priv;
 	struct thread_stack	*ts;
+	struct nsinfo		*nsinfo;
 #ifdef HAVE_LIBUNWIND_SUPPORT
 	void				*addr_space;
 	struct unwind_libunwind_ops	*unwind_libunwind_ops;
-- 
2.9.4
