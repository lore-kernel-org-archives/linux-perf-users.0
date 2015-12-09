From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core  03/22] perf refcnt: Add refcnt debug filter
Date: Wed, 09 Dec 2015 11:10:55 +0900
Message-ID: <20151209021054.10245.25855.stgit@localhost.localdomain>
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

Add refcnt debug filter for filtering the debug objects.
Developers can set the target object name (or glob pattern)
to PERF_REFCNT_DEBUG_FILTER environment variable.

E.g.
 # PERF_REFCNT_DEBUG_FILTER=dso ./perf ...

This traces only the dso object. This also removes
unused name arguments from refcnt__record API.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/refcnt.c |   29 ++++++++++++++++++-----------
 tools/perf/util/refcnt.h |   14 +++++++-------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/refcnt.c b/tools/perf/util/refcnt.c
index 9748dba..e83e9a8 100644
--- a/tools/perf/util/refcnt.c
+++ b/tools/perf/util/refcnt.c
@@ -16,13 +16,20 @@
 
 /* A root of backtraces (a hash table of the list of refcnt_object)*/
 static struct list_head refcnt_root[REFCNT_HASHSZ];
+static const char *refcnt_filter;
 
 static void  __attribute__((constructor)) refcnt__init_root(void)
 {
 	int h;
+	const char *filter;
 
 	for (h = 0; h < REFCNT_HASHSZ; h++)
 		INIT_LIST_HEAD(&refcnt_root[h]);
+
+	/* glob matching filter */
+	filter = getenv("PERF_REFCNT_DEBUG_FILTER");
+	if (filter && *filter)
+		refcnt_filter = filter;
 }
 
 static void refcnt_object__delete(struct refcnt_object *ref)
@@ -54,11 +61,9 @@ void refcnt__delete(void *addr)
 {
 	struct refcnt_object *ref = refcnt_object__find(addr);
 
-	if (!ref) {
-		pr_debug("REFCNT: Delete uninitialized refcnt: %p\n", addr);
-		return;
-	}
-	refcnt_object__delete(ref);
+	/* If !ref, it is already filtered out */
+	if (ref)
+		refcnt_object__delete(ref);
 }
 
 static void refcnt_object__record(struct refcnt_object *ref, int count)
@@ -98,21 +103,23 @@ static struct refcnt_object *refcnt_object__new(void *obj, const char *name)
 /* This is called via refcnt__init */
 void refcnt__recordnew(void *obj, const char *name, int count)
 {
-	struct refcnt_object *ref = refcnt_object__new(obj, name);
+	struct refcnt_object *ref;
+
+	if (refcnt_filter && !strglobmatch(name, refcnt_filter))
+		return;
 
+	ref = refcnt_object__new(obj, name);
 	if (ref)
 		refcnt_object__record(ref, count);
 }
 
 /* This is called via refcnt__get/put */
-void refcnt__record(void *obj, const char *name, int count)
+void refcnt__record(void *obj, int count)
 {
 	struct refcnt_object *ref = refcnt_object__find(obj);
 
-	/* If no entry, allocate new one */
-	if (!ref)
-		refcnt__recordnew(obj, name, count);
-	else
+	/* If no entry, it should be filtered out */
+	if (ref)
 		refcnt_object__record(ref, count);
 }
 
diff --git a/tools/perf/util/refcnt.h b/tools/perf/util/refcnt.h
index cd5e4e4..21569e1 100644
--- a/tools/perf/util/refcnt.h
+++ b/tools/perf/util/refcnt.h
@@ -24,7 +24,7 @@ struct refcnt_buffer {
 };
 
 void refcnt__recordnew(void *obj, const char *name, int count);
-void refcnt__record(void *obj, const char *name, int count);
+void refcnt__record(void *obj, int count);
 void refcnt__delete(void *obj);
 
 static inline void __refcnt__init(atomic_t *refcnt, int n, void *obj,
@@ -34,15 +34,15 @@ static inline void __refcnt__init(atomic_t *refcnt, int n, void *obj,
 	refcnt__recordnew(obj, name, n);
 }
 
-static inline void __refcnt__get(atomic_t *refcnt, void *obj, const char *name)
+static inline void __refcnt__get(atomic_t *refcnt, void *obj)
 {
 	atomic_inc(refcnt);
-	refcnt__record(obj, name, atomic_read(refcnt));
+	refcnt__record(obj, atomic_read(refcnt));
 }
 
-static inline int __refcnt__put(atomic_t *refcnt, void *obj, const char *name)
+static inline int __refcnt__put(atomic_t *refcnt, void *obj)
 {
-	refcnt__record(obj, name, -atomic_read(refcnt));
+	refcnt__record(obj, -atomic_read(refcnt));
 	return atomic_dec_and_test(refcnt);
 }
 
@@ -53,9 +53,9 @@ static inline int __refcnt__put(atomic_t *refcnt, void *obj, const char *name)
 #define refcnt__exit(obj, member)	\
 	refcnt__delete(obj)
 #define refcnt__get(obj, member)	\
-	__refcnt__get(&(obj)->member, obj, #obj)
+	__refcnt__get(&(obj)->member, obj)
 #define refcnt__put(obj, member)	\
-	__refcnt__put(&(obj)->member, obj, #obj)
+	__refcnt__put(&(obj)->member, obj)
 
 #else	/* !REFCNT_DEBUG */
 
