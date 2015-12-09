From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core  02/22] perf refcnt: Use a hash for refcnt_root
Date: Wed, 09 Dec 2015 11:10:52 +0900
Message-ID: <20151209021052.10245.54298.stgit@localhost.localdomain>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5]:53342 "EHLO
	mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbbLICSq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 8 Dec 2015 21:18:46 -0500
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>

Make refcnt to use a hash table to reduce search overhead
on refcnt_root. This hash is based on passed object address.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/refcnt.c |   71 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/refcnt.c b/tools/perf/util/refcnt.c
index 9bd36b2b..9748dba 100644
--- a/tools/perf/util/refcnt.c
+++ b/tools/perf/util/refcnt.c
@@ -9,9 +9,21 @@
 #include "debug.h"
 #include "util.h"
 #include "refcnt.h"
+#include "linux/hash.h"
 
-/* A root of backtrace */
-static LIST_HEAD(refcnt_root);	/* List head of refcnt object */
+#define REFCNT_HASHBITS	7
+#define REFCNT_HASHSZ	(1 << REFCNT_HASHBITS)
+
+/* A root of backtraces (a hash table of the list of refcnt_object)*/
+static struct list_head refcnt_root[REFCNT_HASHSZ];
+
+static void  __attribute__((constructor)) refcnt__init_root(void)
+{
+	int h;
+
+	for (h = 0; h < REFCNT_HASHSZ; h++)
+		INIT_LIST_HEAD(&refcnt_root[h]);
+}
 
 static void refcnt_object__delete(struct refcnt_object *ref)
 {
@@ -29,9 +41,9 @@ static void refcnt_object__delete(struct refcnt_object *ref)
 static struct refcnt_object *refcnt_object__find(void *obj)
 {
 	struct refcnt_object *ref;
+	int h = (int)hash_ptr(obj, REFCNT_HASHBITS);
 
-	/* TODO: use hash list */
-	list_for_each_entry(ref, &refcnt_root, list)
+	list_for_each_entry(ref, &refcnt_root[h], list)
 		if (ref->obj == obj)
 			return ref;
 
@@ -67,6 +79,7 @@ static void refcnt_object__record(struct refcnt_object *ref, int count)
 static struct refcnt_object *refcnt_object__new(void *obj, const char *name)
 {
 	struct refcnt_object *ref = malloc(sizeof(*ref));
+	int h = (int)hash_ptr(obj, REFCNT_HASHBITS);
 
 	if (!ref) {
 		pr_debug("REFCNT: Out of memory for %p (%s)\n",
@@ -77,7 +90,7 @@ static struct refcnt_object *refcnt_object__new(void *obj, const char *name)
 	INIT_LIST_HEAD(&ref->head);
 	ref->name = name;
 	ref->obj = obj;
-	list_add_tail(&ref->list, &refcnt_root);
+	list_add_tail(&ref->list, &refcnt_root[h]);
 
 	return ref;
 }
@@ -110,6 +123,11 @@ static void pr_refcnt_buffer(struct refcnt_buffer *buf)
 
 	if (!buf)
 		return;
+
+	pr_debug("Refcount %s => %d at\n",
+		 buf->count >= 0 ? "+1" : "-1",
+		 buf->count >= 0 ? buf->count : -buf->count - 1);
+
 	symbuf = backtrace_symbols(buf->buf, buf->nr);
 	/* Skip the first one because it is always btrace__record */
 	for (i = 1; i < buf->nr; i++) {
@@ -121,29 +139,38 @@ static void pr_refcnt_buffer(struct refcnt_buffer *buf)
 	free(symbuf);
 }
 
-static void  __attribute__((destructor)) refcnt__dump_unreclaimed(void)
+static void pr_refcnt_object(struct refcnt_object *ref)
 {
-	struct refcnt_object *ref, *n;
 	struct refcnt_buffer *buf;
-	int i = 0;
 
-	if (list_empty(&refcnt_root))
-		return;
+	pr_debug("Unreclaimed %s@%p\n",
+		 ref->name ? ref->name : "(object)", ref->obj);
+
+	list_for_each_entry(buf, &ref->head, list)
+		pr_refcnt_buffer(buf);
+}
 
+static void  __attribute__((destructor)) refcnt__dump_unreclaimed(void)
+{
+	struct refcnt_object *ref, *n;
+	int h, i = 0;
+
+	for (h = 0; h < REFCNT_HASHSZ; h++)
+		if (!list_empty(&refcnt_root[h]))
+			goto found;
+	return;
+found:
 	pr_warning("REFCNT: BUG: Unreclaimed objects found.\n");
-	list_for_each_entry_safe(ref, n, &refcnt_root, list) {
-		pr_debug("==== [%d] ====\nUnreclaimed %s@%p\n", i,
-			 ref->name ? ref->name : "(object)", ref->obj);
-		list_for_each_entry(buf, &ref->head, list) {
-			pr_debug("Refcount %s => %d at\n",
-				 buf->count >= 0 ? "+1" : "-1",
-				 buf->count >= 0 ? buf->count :
-						  -buf->count - 1);
-			pr_refcnt_buffer(buf);
+	for ( ; h < REFCNT_HASHSZ; h++)
+		list_for_each_entry_safe(ref, n, &refcnt_root[h], list) {
+			if (verbose) {
+				pr_debug("==== [%d] ====\n", i);
+				pr_refcnt_object(ref);
+			}
+			refcnt_object__delete(ref);
+			i++;
 		}
-		refcnt_object__delete(ref);
-		i++;
-	}
+
 	pr_warning("REFCNT: Total %d objects are not reclaimed.\n", i);
 	if (!verbose)
 		pr_warning("   To see all backtraces, rerun with -v option\n");
