From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Date: Fri, 20 Dec 2019 13:32:48 +0900
Message-ID: <20191220043253.3278951-5-namhyung@kernel.org>
References: <20191220043253.3278951-1-namhyung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191220043253.3278951-1-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Each cgroup is kept in the global cgroup_tree sorted by the inode
number.  Hist entries have cgroup ino number can compare it directly
and later it can be used to find a group name using this tree.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/cgroup.c  | 72 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cgroup.h  | 15 +++++---
 tools/perf/util/machine.c |  7 ++++
 tools/perf/util/session.c |  4 +++
 4 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 4881d4af3381..99d93f31732d 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -13,6 +13,8 @@
 
 int nr_cgroups;
 
+static struct rb_root cgroup_tree = RB_ROOT;
+
 static int
 cgroupfs_find_mountpoint(char *buf, size_t maxlen)
 {
@@ -250,3 +252,73 @@ int parse_cgroups(const struct option *opt, const char *str,
 	}
 	return 0;
 }
+
+struct cgroup *cgroup__findnew(uint64_t ino, const char *path)
+{
+	struct rb_node **p = &cgroup_tree.rb_node;
+	struct rb_node *parent = NULL;
+	struct cgroup *cgrp;
+
+	while (*p != NULL) {
+		parent = *p;
+		cgrp = rb_entry(parent, struct cgroup, node);
+
+		if (cgrp->ino == ino)
+			return cgrp;
+
+		if (cgrp->ino < ino)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
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
+	cgrp->ino = ino;
+	refcount_set(&cgrp->refcnt, 1);
+
+	rb_link_node(&cgrp->node, parent, p);
+	rb_insert_color(&cgrp->node, &cgroup_tree);
+
+	return cgrp;
+}
+
+struct cgroup *cgroup__find_by_path(const char *path)
+{
+	struct rb_node *node;
+
+	node = rb_first(&cgroup_tree);
+	while (node) {
+		struct cgroup *cgrp = rb_entry(node, struct cgroup, node);
+
+		if (!strcmp(cgrp->name, path))
+			return cgrp;
+
+		node = rb_next(&cgrp->node);
+	}
+
+	return NULL;
+}
+
+void destroy_cgroups(void)
+{
+	struct rb_node *node;
+	struct cgroup *cgrp;
+
+	while (!RB_EMPTY_ROOT(&cgroup_tree)) {
+		node = rb_first(&cgroup_tree);
+		cgrp = rb_entry(node, struct cgroup, node);
+
+		rb_erase(node, &cgroup_tree);
+		cgroup__put(cgrp);
+	}
+}
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 2ec11f01090d..11a8b187ec09 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -3,16 +3,18 @@
 #define __CGROUP_H__
 
 #include <linux/refcount.h>
+#include <linux/rbtree.h>
 
 struct option;
 
 struct cgroup {
-	char *name;
-	int fd;
-	refcount_t refcnt;
+	struct rb_node		node;
+	u64			ino;
+	char			*name;
+	int			fd;
+	refcount_t		refcnt;
 };
 
-
 extern int nr_cgroups; /* number of explicit cgroups defined */
 
 struct cgroup *cgroup__get(struct cgroup *cgroup);
@@ -26,4 +28,9 @@ void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
 int parse_cgroups(const struct option *opt, const char *str, int unset);
 
+struct cgroup *cgroup__findnew(uint64_t ino, const char *path);
+struct cgroup *cgroup__find_by_path(const char *path);
+
+void destroy_cgroups(void);
+
 #endif /* __CGROUP_H__ */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2c3223bec561..19d40a2016d7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -33,6 +33,7 @@
 #include "asm/bug.h"
 #include "bpf-event.h"
 #include <internal/lib.h> // page_size
+#include "cgroup.h"
 
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
@@ -658,9 +659,15 @@ int machine__process_cgroup_event(struct machine *machine __maybe_unused,
 				  union perf_event *event,
 				  struct perf_sample *sample __maybe_unused)
 {
+	struct cgroup *cgrp;
+
 	if (dump_trace)
 		perf_event__fprintf_cgroup(event, stdout);
 
+	cgrp = cgroup__findnew(event->cgroup.id, event->cgroup.path);
+	if (cgrp == NULL)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 6b4c12d48c3f..5e2c9f504184 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -289,6 +289,8 @@ static void perf_session__release_decomp_events(struct perf_session *session)
 	} while (1);
 }
 
+extern void destroy_cgroups(void);
+
 void perf_session__delete(struct perf_session *session)
 {
 	if (session == NULL)
@@ -303,6 +305,8 @@ void perf_session__delete(struct perf_session *session)
 	if (session->data)
 		perf_data__close(session->data);
 	free(session);
+
+	destroy_cgroups();
 }
 
 static int process_event_synth_tracing_data_stub(struct perf_session *session
-- 
2.24.1.735.g03f4e72817-goog
