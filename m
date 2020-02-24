From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 05/10] perf tools: Maintain cgroup hierarchy
Date: Mon, 24 Feb 2020 13:37:44 +0900
Message-ID: <20200224043749.69466-6-namhyung@kernel.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Each cgroup is kept in the perf_env's cgroup_tree sorted by the cgroup
id.  Hist entries have cgroup id can compare it directly and later it
can be used to find a group name using this tree.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/cgroup.c  | 80 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cgroup.h  | 17 +++++++--
 tools/perf/util/env.c     |  2 +
 tools/perf/util/env.h     |  6 +++
 tools/perf/util/machine.c |  9 ++++-
 5 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 12e466d1ec3b..3c99f228e749 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -191,3 +191,83 @@ int parse_cgroups(const struct option *opt, const char *str,
 	}
 	return 0;
 }
+
+static struct cgroup *__cgroup__findnew(struct rb_root *root, uint64_t id,
+					bool create, const char *path)
+{
+	struct rb_node **p = &root->rb_node;
+	struct rb_node *parent = NULL;
+	struct cgroup *cgrp;
+
+	while (*p != NULL) {
+		parent = *p;
+		cgrp = rb_entry(parent, struct cgroup, node);
+
+		if (cgrp->id == id)
+			return cgrp;
+
+		if (cgrp->id < id)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+
+	if (!create)
+		return NULL;
+
+	cgrp = malloc(sizeof(*cgrp));
+	if (cgrp == NULL)
+		return NULL;
+
+	cgrp->name = strdup(path);
+	if (cgrp->name == NULL) {
+		free(cgrp);
+		return NULL;
+	}
+
+	cgrp->fd = -1;
+	cgrp->id = id;
+	refcount_set(&cgrp->refcnt, 1);
+
+	rb_link_node(&cgrp->node, parent, p);
+	rb_insert_color(&cgrp->node, root);
+
+	return cgrp;
+}
+
+struct cgroup *cgroup__findnew(struct perf_env *env, uint64_t id,
+			       const char *path)
+{
+	struct cgroup *cgrp;
+
+	down_write(&env->cgroups.lock);
+	cgrp = __cgroup__findnew(&env->cgroups.tree, id, true, path);
+	up_write(&env->cgroups.lock);
+	return cgrp;
+}
+
+struct cgroup *cgroup__find(struct perf_env *env, uint64_t id)
+{
+	struct cgroup *cgrp;
+
+	down_read(&env->cgroups.lock);
+	cgrp = __cgroup__findnew(&env->cgroups.tree, id, false, NULL);
+	up_read(&env->cgroups.lock);
+	return cgrp;
+}
+
+void perf_env__purge_cgroups(struct perf_env *env)
+{
+	struct rb_node *node;
+	struct cgroup *cgrp;
+
+	down_write(&env->cgroups.lock);
+	while (!RB_EMPTY_ROOT(&env->cgroups.tree)) {
+		node = rb_first(&env->cgroups.tree);
+		cgrp = rb_entry(node, struct cgroup, node);
+
+		rb_erase(node, &env->cgroups.tree);
+		cgroup__put(cgrp);
+	}
+	up_write(&env->cgroups.lock);
+}
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 2ec11f01090d..e98d5975fe55 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -3,16 +3,19 @@
 #define __CGROUP_H__
 
 #include <linux/refcount.h>
+#include <linux/rbtree.h>
+#include "util/env.h"
 
 struct option;
 
 struct cgroup {
-	char *name;
-	int fd;
-	refcount_t refcnt;
+	struct rb_node		node;
+	u64			id;
+	char			*name;
+	int			fd;
+	refcount_t		refcnt;
 };
 
-
 extern int nr_cgroups; /* number of explicit cgroups defined */
 
 struct cgroup *cgroup__get(struct cgroup *cgroup);
@@ -26,4 +29,10 @@ void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
 int parse_cgroups(const struct option *opt, const char *str, int unset);
 
+struct cgroup *cgroup__findnew(struct perf_env *env, uint64_t id,
+			       const char *path);
+struct cgroup *cgroup__find(struct perf_env *env, uint64_t id);
+
+void perf_env__purge_cgroups(struct perf_env *env);
+
 #endif /* __CGROUP_H__ */
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 6242a9215df7..d299dc25001f 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -6,6 +6,7 @@
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 #include "bpf-event.h"
+#include "cgroup.h"
 #include <errno.h>
 #include <sys/utsname.h>
 #include <bpf/libbpf.h>
@@ -168,6 +169,7 @@ void perf_env__exit(struct perf_env *env)
 	int i;
 
 	perf_env__purge_bpf(env);
+	perf_env__purge_cgroups(env);
 	zfree(&env->hostname);
 	zfree(&env->os_release);
 	zfree(&env->version);
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 11d05ae3606a..7632075a8792 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -88,6 +88,12 @@ struct perf_env {
 		u32			btfs_cnt;
 	} bpf_progs;
 
+	/* same reason as above (for perf-top) */
+	struct {
+		struct rw_semaphore	lock;
+		struct rb_root		tree;
+	} cgroups;
+
 	/* For fast cpu to numa node lookup via perf_env__numa_node */
 	int			*numa_map;
 	int			 nr_numa_map;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2c3223bec561..644cbc813e9e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -33,6 +33,7 @@
 #include "asm/bug.h"
 #include "bpf-event.h"
 #include <internal/lib.h> // page_size
+#include "cgroup.h"
 
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
@@ -654,13 +655,19 @@ int machine__process_namespaces_event(struct machine *machine __maybe_unused,
 	return err;
 }
 
-int machine__process_cgroup_event(struct machine *machine __maybe_unused,
+int machine__process_cgroup_event(struct machine *machine,
 				  union perf_event *event,
 				  struct perf_sample *sample __maybe_unused)
 {
+	struct cgroup *cgrp;
+
 	if (dump_trace)
 		perf_event__fprintf_cgroup(event, stdout);
 
+	cgrp = cgroup__findnew(machine->env, event->cgroup.id, event->cgroup.path);
+	if (cgrp == NULL)
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog
