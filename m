From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core 01/22] [v2] perf refcnt: Introduce generic
 refcount APIs with debug feature
Date: Wed, 09 Dec 2015 11:10:50 +0900
Message-ID: <20151209021050.10245.81565.stgit@localhost.localdomain>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5]:53331 "EHLO
	mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbbLICSo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 8 Dec 2015 21:18:44 -0500
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>

This is a kind of debugging feature for atomic reference counter.
The reference counters are widely used in perf tools but not well
debugged. It sometimes causes memory leaks but no one has noticed
the issue, since it is hard to debug such un-reclaimed objects.

This refcnt interface provides fully backtrace debug feature to
analyze such issue. User just replace atomic_t ops with refcnt
APIs and add refcnt__exit() where the object is released.

/* At object initializing */
refcnt__init(obj, refcnt, 1); /* <- atomic_set(&obj->refcnt, 1); */
/* or */
refcnt__init_as(obj, refcnt, 1, "class");	/* init as "class" */

/* At object get method */
refcnt__get(obj, refcnt); /* <- atomic_inc(&obj->refcnt); */

/* At object put method */
if (obj && refcnt__put(obj, refcnt)) /* <-atmoic_dec_and_test(&obj->refcnt)*/

/* At object releasing */
refcnt__exit(obj, refcnt); /* <- Newly added */

The debugging feature is enabled when building perf with
REFCNT_DEBUG=1. Otherwides it is just translated as normal
atomic ops.

Debugging binary warns you if it finds leaks when the perf exits.
If you give -v (or --verbose) to the perf, it also shows backtrace
logs on all refcnt operations of leaked objects.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>

---
 Changes from v1:
  - Change internal functions as it indicates the object more clear
  - Minor macro changes to have braces.
  - refcnt__init takes an initial number for some cases.
  - Add refcnt__init_as() for the object which the object and class
    have different name.
  - Header shows "obj@addr" instead of "obj: addr".
  - Shrink down the backtrace size to 16 (it is enough).
  - Fix a bug in case of refcnt == 0.
  - Show raw addresses if backtrace_symbol is failed.
---
 tools/perf/config/Makefile |    5 +
 tools/perf/util/Build      |    1 
 tools/perf/util/refcnt.c   |  151 ++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/refcnt.h   |   70 ++++++++++++++++++++
 4 files changed, 227 insertions(+)
 create mode 100644 tools/perf/util/refcnt.c
 create mode 100644 tools/perf/util/refcnt.h

diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index 6eb9a95..62fc93f 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -147,6 +147,11 @@ ifdef PARSER_DEBUG
   $(call detected_var,PARSER_DEBUG_FLEX)
 endif
 
+ifdef REFCNT_DEBUG
+  CFLAGS += -DREFCNT_DEBUG
+  $(call detected,CONFIG_REFCNT_DEBUG)
+endif
+
 ifndef NO_LIBPYTHON
   # Try different combinations to accommodate systems that only have
   # python[2][-config] in weird combinations but always preferring
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 0513dd5..646a4b7 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -87,6 +87,7 @@ libperf-$(CONFIG_AUXTRACE) += intel-pt.o
 libperf-$(CONFIG_AUXTRACE) += intel-bts.o
 libperf-y += parse-branch-options.o
 libperf-y += parse-regs-options.o
+libperf-$(CONFIG_REFCNT_DEBUG) += refcnt.o
 
 libperf-$(CONFIG_LIBBPF) += bpf-loader.o
 libperf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
diff --git a/tools/perf/util/refcnt.c b/tools/perf/util/refcnt.c
new file mode 100644
index 0000000..9bd36b2b
--- /dev/null
+++ b/tools/perf/util/refcnt.c
@@ -0,0 +1,151 @@
+/* Refcount backtrace for debugging leaks */
+#include "../perf.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <execinfo.h>	/* For backtrace */
+
+#include "event.h"
+#include "debug.h"
+#include "util.h"
+#include "refcnt.h"
+
+/* A root of backtrace */
+static LIST_HEAD(refcnt_root);	/* List head of refcnt object */
+
+static void refcnt_object__delete(struct refcnt_object *ref)
+{
+	struct refcnt_buffer *buf;
+
+	while (!list_empty(&ref->head)) {
+		buf = list_entry(ref->head.next, struct refcnt_buffer, list);
+		list_del_init(&buf->list);
+		free(buf);
+	}
+	list_del_init(&ref->list);
+	free(ref);
+}
+
+static struct refcnt_object *refcnt_object__find(void *obj)
+{
+	struct refcnt_object *ref;
+
+	/* TODO: use hash list */
+	list_for_each_entry(ref, &refcnt_root, list)
+		if (ref->obj == obj)
+			return ref;
+
+	return NULL;
+}
+
+void refcnt__delete(void *addr)
+{
+	struct refcnt_object *ref = refcnt_object__find(addr);
+
+	if (!ref) {
+		pr_debug("REFCNT: Delete uninitialized refcnt: %p\n", addr);
+		return;
+	}
+	refcnt_object__delete(ref);
+}
+
+static void refcnt_object__record(struct refcnt_object *ref, int count)
+{
+	struct refcnt_buffer *buf = malloc(sizeof(*buf));
+
+	if (!buf) {
+		pr_debug("REFCNT: Out of memory for %p (%s)\n",
+			 ref->obj, ref->name);
+		return;
+	}
+	INIT_LIST_HEAD(&buf->list);
+	buf->count = count;
+	buf->nr = backtrace(buf->buf, BACKTRACE_SIZE);
+	list_add_tail(&buf->list, &ref->head);
+}
+
+static struct refcnt_object *refcnt_object__new(void *obj, const char *name)
+{
+	struct refcnt_object *ref = malloc(sizeof(*ref));
+
+	if (!ref) {
+		pr_debug("REFCNT: Out of memory for %p (%s)\n",
+			 obj, name);
+		return NULL;
+	}
+	INIT_LIST_HEAD(&ref->list);
+	INIT_LIST_HEAD(&ref->head);
+	ref->name = name;
+	ref->obj = obj;
+	list_add_tail(&ref->list, &refcnt_root);
+
+	return ref;
+}
+
+/* This is called via refcnt__init */
+void refcnt__recordnew(void *obj, const char *name, int count)
+{
+	struct refcnt_object *ref = refcnt_object__new(obj, name);
+
+	if (ref)
+		refcnt_object__record(ref, count);
+}
+
+/* This is called via refcnt__get/put */
+void refcnt__record(void *obj, const char *name, int count)
+{
+	struct refcnt_object *ref = refcnt_object__find(obj);
+
+	/* If no entry, allocate new one */
+	if (!ref)
+		refcnt__recordnew(obj, name, count);
+	else
+		refcnt_object__record(ref, count);
+}
+
+static void pr_refcnt_buffer(struct refcnt_buffer *buf)
+{
+	char **symbuf;
+	int i;
+
+	if (!buf)
+		return;
+	symbuf = backtrace_symbols(buf->buf, buf->nr);
+	/* Skip the first one because it is always btrace__record */
+	for (i = 1; i < buf->nr; i++) {
+		if (symbuf)
+			pr_debug("  %s\n", symbuf[i]);
+		else
+			pr_debug("  [%p]\n", buf->buf[i]);
+	}
+	free(symbuf);
+}
+
+static void  __attribute__((destructor)) refcnt__dump_unreclaimed(void)
+{
+	struct refcnt_object *ref, *n;
+	struct refcnt_buffer *buf;
+	int i = 0;
+
+	if (list_empty(&refcnt_root))
+		return;
+
+	pr_warning("REFCNT: BUG: Unreclaimed objects found.\n");
+	list_for_each_entry_safe(ref, n, &refcnt_root, list) {
+		pr_debug("==== [%d] ====\nUnreclaimed %s@%p\n", i,
+			 ref->name ? ref->name : "(object)", ref->obj);
+		list_for_each_entry(buf, &ref->head, list) {
+			pr_debug("Refcount %s => %d at\n",
+				 buf->count >= 0 ? "+1" : "-1",
+				 buf->count >= 0 ? buf->count :
+						  -buf->count - 1);
+			pr_refcnt_buffer(buf);
+		}
+		refcnt_object__delete(ref);
+		i++;
+	}
+	pr_warning("REFCNT: Total %d objects are not reclaimed.\n", i);
+	if (!verbose)
+		pr_warning("   To see all backtraces, rerun with -v option\n");
+}
+
diff --git a/tools/perf/util/refcnt.h b/tools/perf/util/refcnt.h
new file mode 100644
index 0000000..cd5e4e4
--- /dev/null
+++ b/tools/perf/util/refcnt.h
@@ -0,0 +1,70 @@
+/*
+ * Atomic reference counter API with debugging feature
+ */
+#ifndef __PERF_REFCNT_H
+#define __PERF_REFCNT_H
+
+#include <linux/atomic.h>
+
+#ifdef REFCNT_DEBUG
+
+struct refcnt_object {
+	struct list_head	list;	/* List of objects */
+	void			*obj;	/* Object address which has refcnt */
+	const char		*name;	/* Object class name */
+	struct list_head	head;	/* List head for buffers */
+};
+
+#define BACKTRACE_SIZE 16
+struct refcnt_buffer {
+	struct list_head	list;	/* List of buffers */
+	int			count;	/* Count number at recording point */
+	int			nr;	/* Number of recorded buffer entries */
+	void			*buf[BACKTRACE_SIZE];	/* Backtrace buffer */
+};
+
+void refcnt__recordnew(void *obj, const char *name, int count);
+void refcnt__record(void *obj, const char *name, int count);
+void refcnt__delete(void *obj);
+
+static inline void __refcnt__init(atomic_t *refcnt, int n, void *obj,
+				  const char *name)
+{
+	atomic_set(refcnt, n);
+	refcnt__recordnew(obj, name, n);
+}
+
+static inline void __refcnt__get(atomic_t *refcnt, void *obj, const char *name)
+{
+	atomic_inc(refcnt);
+	refcnt__record(obj, name, atomic_read(refcnt));
+}
+
+static inline int __refcnt__put(atomic_t *refcnt, void *obj, const char *name)
+{
+	refcnt__record(obj, name, -atomic_read(refcnt));
+	return atomic_dec_and_test(refcnt);
+}
+
+#define refcnt__init(obj, member, n)	\
+	__refcnt__init(&(obj)->member, n, obj, #obj)
+#define refcnt__init_as(obj, member, n, name)	\
+	__refcnt__init(&(obj)->member, n, obj, name)
+#define refcnt__exit(obj, member)	\
+	refcnt__delete(obj)
+#define refcnt__get(obj, member)	\
+	__refcnt__get(&(obj)->member, obj, #obj)
+#define refcnt__put(obj, member)	\
+	__refcnt__put(&(obj)->member, obj, #obj)
+
+#else	/* !REFCNT_DEBUG */
+
+#define refcnt__init(obj, member, n)	atomic_set(&(obj)->member, n)
+#define refcnt__init_as(obj, member, n, name)	refcnt__init(obj, member, n)
+#define refcnt__exit(obj, member)	do { } while (0)
+#define refcnt__get(obj, member)	atomic_inc(&(obj)->member)
+#define refcnt__put(obj, member)	atomic_dec_and_test(&(obj)->member)
+
+#endif	/* !REFCNT_DEBUG */
+
+#endif	/* __PERF_REFCNT_H */
