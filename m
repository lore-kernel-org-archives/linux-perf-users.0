Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810883;
	b=mOB2KO+/mAsOMn2auhUMAbYsV/M56z5itj3AtkxQqqEnsjArk/mra2/7/VPDKxh+J00P
	 qz6IDBpTEvhJwAZimDThWLvJ9RPPgmXyplCHbUJex2aA/TyEjRR8NS4YpBt6zCwM+BlgD
	 MvBPihUO5V3WUjCXj4jf2O34+5cJimcqyTkVJ2FqBCnA6hjEPvsCpjhx8ogDCCsbNo3V+
	 vqPNuGJ41cwZkDUpRYpoab2mnIX5JInAGRwo60ywYuYGWQyD5oe3lMN5zEPO3onQSdEep
	 LtsSDjW5gw/eXFDrjnOOIhGHIxTBIMyZyASPnDYVG72yIX1L0mFKvfLUrXudk2dSASg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=s3lKOZIehs7zghVMQL3qXW1rl5HT2ZJDnVe3jn0mFR8=;
	b=gsvvijwmBl/OE7PO9n1d7kr6ITYNhrVOcpXOy3eLG2CVoS3/I0sr0p80WF31CW9iJPNr
	 7DnHOY7oRC7u0/pwr4ivTjngn9MdwvajBVVzuDiJsZ4Kv5XRPWEVNuxSFqkheY0zIWfxb
	 KL2hoX126qamNsA8xp41hI7itqiyaMNxnx5Wf4q3qUL5RS/E8Dyjspf6WNvbM0zrrVcpY
	 rV/AhTWFfPQ9Z64Flv8dAJ3J+JwqNkUKMZ1863GSw/n5Vamg/Ba45cPVFWZYaYfiYuLGG
	 n9+NIQECEJHM3qSi+gSJN7D/2VQ3iLhkCeQR5p64YP6chq35vBi5rMBiRjUmFEfXpYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k9cO6Fcb;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A253606A33E
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A253606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k9cO6Fcb
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36efb506f29so2230088eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 22:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794810882; x=1795415682; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3lKOZIehs7zghVMQL3qXW1rl5HT2ZJDnVe3jn0mFR8=;
        b=k9cO6FcbIgYpGiivEO7uRhSbC59oYWXOJl35QfqvbguqQlkCBRFIP5GNHBbBeWRzQu
         A7QRTwu0tGvaD8rAvNQW6lX4k7N6R3djyOiPHwHOug3paDvLT7zikw0yr9nusfdBMLPG
         DX/JaDHZJnDC4x4uSW1sDOm2sBNyAyRu94WLOanhTNJSsAbGfz00MfOFwf0sFrUWUsSE
         4aFJFGWK4OvaxBEkXrDep2aJsGC1xK5c9Lj+N4/YlNPm4s1QLglFZP8UbI1RFz50wICV
         jLFWz96IdkvNkylezrGDswY01GlTl2JK0AVNZQqqG/CPfPp/GCD7vwyzWwbZd6+4k+Lh
         cwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794810882; x=1795415682;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s3lKOZIehs7zghVMQL3qXW1rl5HT2ZJDnVe3jn0mFR8=;
        b=jCgjyyRD8IPRitWfCCMr1uFzj8ge9NYojm0HC4lnDAhpP1ggwG/4aFdn2QO7z2uP5u
         0u1LvWOK+xgwJ4Eh6gCJToGGzr6nnTMvv0Cj3Bl7D4UxBaPoRhWYH0bxaYgnhtoulks/
         CV+kdY5dp4EzU6MFsn2pql4GBQta0ZNKDMZfB7t7utFfXjxfTewkhMjPJC6G5iqzQNBi
         t8VgYe0yn+k8lmpXWRKnxd+UfOGaqC5nnwKIePdPnEyXVwiNSzup/zWc2M4PbW9Xp8tg
         8zBUMdDPvjvB3de6Ac2iJJF4th3rF1C4AejY2NxQR29cuA0Z4+J4yqAYvb/wCpNdA4/D
         etBA==
X-Forwarded-Encrypted: i=1; AL+hErF1CxrKh86StkI2unH0x/tz4Unae5V46GhxwCdn2ZpSoAIpXWEA3Kf1YHfgjM/I8tMAZHkYjG6qSr+UPhCH982X@vger.kernel.org
X-Gm-Message-State: APuU4Z/uFdPFL3NEmHYSrC/g5ERSpSIjqVjCxxeKALoVB7G7KD07+TOp
	/M0UHKhG+yKsJ4+TsXsnVxCDce+N8e97yzgFSFsQMNLVArcKviJTprka223NXhE2mA0iJGONNRv
	3FoJQfscjrg==
X-Received: from dyax22-n1.prod.google.com ([2002:a05:693c:4196:10b0:33e:5767:2163])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7e8e:b0:165:aced:1fde
 with SMTP id a92af1059eb24-1b502fe08c6mr11773409c88.0.1794810880896; Sun, 15
 Nov 2026 22:34:40 -0800 (PST)
Date: Sun, 15 Nov 2026 22:34:27 -0800
In-Reply-To: <20261116063435.2817923-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116063435.2817923-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116063435.2817923-2-irogers@google.com>
Subject: [PATCH v5 1/9] perf call-path: Use struct dso_symbol to retain symbol
 DSO lifetimes
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct call_path stores resolved function symbols for the lifetime of a
call_path_root (in thread-stack call/return processing and db-export)
without holding a map reference. Similarly, Python callchain frames and
nodes store resolved symbols across Python object lifetimes.

Replace bare struct symbol * fields in struct call_path,
struct pyrf_callchain_frame, and struct pyrf_callchain_node with
struct dso_symbol so that each retained symbol pins its owning
struct dso until call_path_root__free() or Python deallocation. In
python.c, this also avoids duplicating symbol names for call_path frames
and allows pyrf_callchain_node__get_dso() to report the DSO of resolved
call_path symbols whose ip was zeroed. Also document the DSO-owned
symbol lifetime invariants in kernel-doc comments on struct dso_symbol
and struct map_symbol.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/call-path.c    | 42 ++++++++++++++++++++-------
 tools/perf/util/call-path.h    | 10 ++++---
 tools/perf/util/db-export.c    | 12 ++++++--
 tools/perf/util/map_symbol.h   | 28 ++++++++++++++++++
 tools/perf/util/python.c       | 53 +++++++++++++++-------------------
 tools/perf/util/thread-stack.c | 40 +++++++++++++------------
 6 files changed, 121 insertions(+), 64 deletions(-)

diff --git a/tools/perf/util/call-path.c b/tools/perf/util/call-path.c
index 5c60b8be1cf6..eac52a902d6b 100644
--- a/tools/perf/util/call-path.c
+++ b/tools/perf/util/call-path.c
@@ -10,13 +10,21 @@
 #include <stdlib.h>
 
 #include "call-path.h"
+#include "dso.h"
 
 static void call_path__init(struct call_path *cp, struct call_path *parent,
-			    struct symbol *sym, u64 ip, bool in_kernel)
+			    const struct dso_symbol *ds, u64 ip, bool in_kernel)
 {
+	struct symbol *sym = ds ? ds->sym : NULL;
+
 	cp->parent = parent;
-	cp->sym = sym;
-	cp->ip = sym ? 0 : ip;
+	if (sym) {
+		dso_symbol__copy(&cp->ds, ds);
+		cp->ip = 0;
+	} else {
+		cp->ds = (struct dso_symbol){};
+		cp->ip = ip;
+	}
 	cp->db_id = 0;
 	cp->in_kernel = in_kernel;
 	RB_CLEAR_NODE(&cp->rb_node);
@@ -39,7 +47,13 @@ void call_path_root__free(struct call_path_root *cpr)
 {
 	struct call_path_block *pos, *n;
 
+	if (!cpr)
+		return;
+
+	dso_symbol__exit(&cpr->call_path.ds);
 	list_for_each_entry_safe(pos, n, &cpr->blocks, node) {
+		for (size_t i = 0; i < CALL_PATH_BLOCK_SIZE; i++)
+			dso_symbol__exit(&pos->cp[i].ds);
 		list_del_init(&pos->node);
 		free(pos);
 	}
@@ -48,7 +62,7 @@ void call_path_root__free(struct call_path_root *cpr)
 
 static struct call_path *call_path__new(struct call_path_root *cpr,
 					struct call_path *parent,
-					struct symbol *sym, u64 ip,
+					const struct dso_symbol *ds, u64 ip,
 					bool in_kernel)
 {
 	struct call_path_block *cpb;
@@ -69,17 +83,20 @@ static struct call_path *call_path__new(struct call_path_root *cpr,
 	n = cpr->next++ & CALL_PATH_BLOCK_MASK;
 	cp = &cpb->cp[n];
 
-	call_path__init(cp, parent, sym, ip, in_kernel);
+	call_path__init(cp, parent, ds, ip, in_kernel);
 
 	return cp;
 }
 
 struct call_path *call_path__findnew(struct call_path_root *cpr,
 				     struct call_path *parent,
-				     struct symbol *sym, u64 ip, u64 ks)
+				     const struct dso_symbol *ds,
+				     u64 ip, u64 ks)
 {
 	struct rb_node **p;
 	struct rb_node *node_parent = NULL;
+	struct symbol *sym = ds ? ds->sym : NULL;
+	const void *dso_ptr = (sym && ds->dso) ? RC_CHK_ACCESS(ds->dso) : NULL;
 	struct call_path *cp;
 	bool in_kernel = ip >= ks;
 
@@ -87,23 +104,28 @@ struct call_path *call_path__findnew(struct call_path_root *cpr,
 		ip = 0;
 
 	if (!parent)
-		return call_path__new(cpr, parent, sym, ip, in_kernel);
+		return call_path__new(cpr, parent, ds, ip, in_kernel);
 
 	p = &parent->children.rb_node;
 	while (*p != NULL) {
+		const void *cp_dso_ptr;
+
 		node_parent = *p;
 		cp = rb_entry(node_parent, struct call_path, rb_node);
+		cp_dso_ptr = cp->ds.dso ? RC_CHK_ACCESS(cp->ds.dso) : NULL;
 
-		if (cp->sym == sym && cp->ip == ip)
+		if (cp->ds.sym == sym && cp_dso_ptr == dso_ptr && cp->ip == ip)
 			return cp;
 
-		if (sym < cp->sym || (sym == cp->sym && ip < cp->ip))
+		if (sym < cp->ds.sym ||
+		    (sym == cp->ds.sym && dso_ptr < cp_dso_ptr) ||
+		    (sym == cp->ds.sym && dso_ptr == cp_dso_ptr && ip < cp->ip))
 			p = &(*p)->rb_left;
 		else
 			p = &(*p)->rb_right;
 	}
 
-	cp = call_path__new(cpr, parent, sym, ip, in_kernel);
+	cp = call_path__new(cpr, parent, ds, ip, in_kernel);
 	if (!cp)
 		return NULL;
 
diff --git a/tools/perf/util/call-path.h b/tools/perf/util/call-path.h
index 5875cfc8106e..e43aa7513633 100644
--- a/tools/perf/util/call-path.h
+++ b/tools/perf/util/call-path.h
@@ -11,12 +11,13 @@
 
 #include <linux/types.h>
 #include <linux/rbtree.h>
+#include "map_symbol.h"
 
 /**
  * struct call_path - node in list of calls leading to a function call.
  * @parent: call path to the parent function call
- * @sym: symbol of function called
- * @ip: only if sym is null, the ip of the function
+ * @ds: DSO and symbol of function called
+ * @ip: only if ds.sym is null, the ip of the function
  * @db_id: id used for db-export
  * @in_kernel: whether function is a in the kernel
  * @rb_node: node in parent's tree of called functions
@@ -27,7 +28,7 @@
  */
 struct call_path {
 	struct call_path *parent;
-	struct symbol *sym;
+	struct dso_symbol ds;
 	u64 ip;
 	u64 db_id;
 	bool in_kernel;
@@ -63,6 +64,7 @@ void call_path_root__free(struct call_path_root *cpr);
 
 struct call_path *call_path__findnew(struct call_path_root *cpr,
 				     struct call_path *parent,
-				     struct symbol *sym, u64 ip, u64 ks);
+				     const struct dso_symbol *ds,
+				     u64 ip, u64 ks);
 
 #endif
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 8e08b306c8d3..e7b807e968cf 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -361,12 +361,18 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		db_ids_from_al(dbe, &al, &dso_db_id, &sym_db_id, &offset);
 
 		/* add node to the call path tree if it doesn't exist */
-		current = call_path__findnew(dbe->cpr, current,
-					     al.sym, node->ip,
-					     kernel_start);
+		{
+			struct dso_symbol ds = dso_symbol__from_al(&al);
+
+			current = call_path__findnew(dbe->cpr, current,
+						     &ds, node->ip,
+						     kernel_start);
+		}
 
 		callchain_cursor_advance(cursor);
 		addr_location__exit(&al);
+		if (!current)
+			break;
 	}
 
 	/* Reset the callchain order to its prior value. */
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
index 1781af7bd965..ee53b743fcc1 100644
--- a/tools/perf/util/map_symbol.h
+++ b/tools/perf/util/map_symbol.h
@@ -11,11 +11,39 @@ struct maps;
 struct map;
 struct symbol;
 
+/**
+ * struct dso_symbol - A symbol paired with a reference to its owning DSO.
+ * @dso: Reference-counted DSO (dso__get() / dso__put()) whose symbol table
+ *       owns the lifetime of @sym. May be %NULL when @sym is %NULL or points
+ *       to a synthetic symbol not owned by a DSO.
+ * @sym: Non-reference-counted symbol pointer borrowed from @dso.
+ *
+ * struct symbol is not independently reference counted; its memory is owned
+ * by the symbol table of its containing struct dso. Callers that retain a
+ * struct symbol pointer beyond a transient lookup without needing the mapping
+ * context of a struct map must hold a reference on @dso (managed via
+ * dso_symbol__from_al(), dso_symbol__copy(), and dso_symbol__exit()) so @dso
+ * and its symbol table cannot be shrunk or freed while @sym is in use.
+ */
 struct dso_symbol {
 	struct dso    *dso;
 	struct symbol *sym;
 };
 
+/**
+ * struct map_symbol - A resolved symbol together with its thread and mapping.
+ * @thread: Optional reference-counted thread (thread__get() / thread__put())
+ *          in whose address space @map was resolved.
+ * @map:    Reference-counted mapping (map__get() / map__put()). Holding a
+ *          reference on @map transitively pins map__dso(@map), which in turn
+ *          keeps @sym alive for the lifetime of this struct map_symbol.
+ * @sym:    Non-reference-counted symbol pointer borrowed from map__dso(@map).
+ *
+ * Unlike struct dso_symbol, struct map_symbol preserves the virtual-address
+ * mapping (@map) and optional @thread context in addition to pinning @sym's
+ * lifetime transitively through @map's reference on its struct dso (managed
+ * via map_symbol__copy() and map_symbol__exit()).
+ */
 struct map_symbol {
 	struct thread *thread;
 	struct map    *map;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 902157c472b3..18dfe21104f4 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -937,14 +937,13 @@ struct pyrf_callchain_node {
 	PyObject_HEAD
 	u64 ip;
 	struct map *map;
-	struct symbol *sym;
-	char *sym_name;
+	struct dso_symbol ds;
 };
 
 static void pyrf_callchain_node__delete(struct pyrf_callchain_node *pnode)
 {
 	map__put(pnode->map);
-	free(pnode->sym_name);
+	dso_symbol__exit(&pnode->ds);
 	Py_TYPE(pnode)->tp_free((PyObject *)pnode);
 }
 
@@ -957,27 +956,22 @@ static PyObject *pyrf_callchain_node__get_ip(struct pyrf_callchain_node *pnode,
 static PyObject *pyrf_callchain_node__get_symbol(struct pyrf_callchain_node *pnode,
 						 void *closure __maybe_unused)
 {
-	if (pnode->sym_name)
-		return PyUnicode_FromString(pnode->sym_name);
-	if (pnode->sym)
-		return PyUnicode_FromString(pnode->sym->name);
+	if (pnode->ds.sym)
+		return PyUnicode_FromString(pnode->ds.sym->name);
 	return PyUnicode_FromString("[unknown]");
 }
 
 static PyObject *pyrf_callchain_node__get_dso(struct pyrf_callchain_node *pnode,
 					      void *closure __maybe_unused)
 {
+	struct dso *dso = pnode->ds.dso ?: (pnode->map ? map__dso(pnode->map) : NULL);
 	const char *dsoname = "[unknown]";
 
-	if (pnode->map) {
-		struct dso *dso = map__dso(pnode->map);
-
-		if (dso) {
-			if (symbol_conf.show_kernel_path && dso__long_name(dso))
-				dsoname = dso__long_name(dso);
-			else
-				dsoname = dso__name(dso);
-		}
+	if (dso) {
+		if (symbol_conf.show_kernel_path && dso__long_name(dso))
+			dsoname = dso__long_name(dso);
+		else
+			dsoname = dso__name(dso);
 	}
 	return PyUnicode_FromString(dsoname);
 }
@@ -987,11 +981,11 @@ static PyObject *pyrf_callchain_node__get_sym_offset(struct pyrf_callchain_node
 {
 	u64 addr;
 
-	if (!pnode->sym)
+	if (!pnode->ds.sym || (!pnode->map && !pnode->ip))
 		Py_RETURN_NONE;
 
 	addr = pnode->map ? map__map_ip(pnode->map, pnode->ip) : pnode->ip;
-	return PyLong_FromUnsignedLongLong(addr - pnode->sym->start);
+	return PyLong_FromUnsignedLongLong(addr - pnode->ds.sym->start);
 }
 
 static PyGetSetDef pyrf_callchain_node__getset[] = {
@@ -1015,8 +1009,7 @@ static PyTypeObject pyrf_callchain_node__type = {
 struct pyrf_callchain_frame {
 	u64 ip;
 	struct map *map;
-	struct symbol *sym;
-	char *sym_name;
+	struct dso_symbol ds;
 };
 
 struct pyrf_callchain {
@@ -1030,7 +1023,7 @@ static void pyrf_callchain__delete(struct pyrf_callchain *pchain)
 	if (pchain->frames) {
 		for (u64 i = 0; i < pchain->nr_frames; i++) {
 			map__put(pchain->frames[i].map);
-			free(pchain->frames[i].sym_name);
+			dso_symbol__exit(&pchain->frames[i].ds);
 		}
 		free(pchain->frames);
 	}
@@ -1060,8 +1053,7 @@ static PyObject *pyrf_callchain__item(PyObject *obj, Py_ssize_t i)
 
 	pnode->ip = pchain->frames[i].ip;
 	pnode->map = map__get(pchain->frames[i].map);
-	pnode->sym = pchain->frames[i].sym;
-	pnode->sym_name = pchain->frames[i].sym_name ? strdup(pchain->frames[i].sym_name) : NULL;
+	dso_symbol__copy(&pnode->ds, &pchain->frames[i].ds);
 
 	return (PyObject *)pnode;
 }
@@ -1111,10 +1103,16 @@ static int pyrf_sample_event__resolve_callchain(struct pyrf_event *pevent)
 		return -ENOMEM;
 	}
 	for (u64 i = 0; i < pchain->nr_frames; i++) {
+		struct dso_symbol ds;
+
 		node = callchain_cursor_current(cursor);
+		ds = (struct dso_symbol){
+			.dso = (node->ms.sym && node->ms.map) ? map__dso(node->ms.map) : NULL,
+			.sym = node->ms.sym,
+		};
 		pchain->frames[i].ip = node->ip;
 		pchain->frames[i].map = map__get(node->ms.map);
-		pchain->frames[i].sym = node->ms.sym;
+		dso_symbol__copy(&pchain->frames[i].ds, &ds);
 		callchain_cursor_advance(cursor);
 	}
 	pevent->callchain = (PyObject *)pchain;
@@ -4504,10 +4502,9 @@ static PyObject *pyrf_call_path__to_callchain(const struct call_path *cp,
 		struct pyrf_callchain_frame *frame = &pchain->frames[--nr_frames];
 
 		frame->ip = pos->ip;
-		frame->sym = NULL;
-		frame->sym_name = pos->sym ? strdup(pos->sym->name) : NULL;
+		dso_symbol__copy(&frame->ds, &pos->ds);
 		frame->map = NULL;
-		if (thread) {
+		if (thread && !pos->ds.sym) {
 			struct addr_location al;
 			u8 cpumode = pos->in_kernel ? PERF_RECORD_MISC_KERNEL
 						    : PERF_RECORD_MISC_USER;
@@ -4515,8 +4512,6 @@ static PyObject *pyrf_call_path__to_callchain(const struct call_path *cp,
 			addr_location__init(&al);
 			thread__find_map(thread, cpumode, pos->ip, &al);
 			frame->map = map__get(al.map);
-			if (frame->map)
-				frame->sym = pos->sym;
 			addr_location__exit(&al);
 		}
 	}
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index d452d1a7eabb..aa05acb0467c 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include "addr_location.h"
 #include "thread.h"
 #include "event.h"
 #include "machine.h"
@@ -823,7 +824,7 @@ static int thread_stack__pop_cp(struct thread *thread, struct thread_stack *ts,
 	if (ts->cnt == 1) {
 		struct thread_stack_entry *tse = &ts->stack[0];
 
-		if (tse->cp->sym == sym)
+		if (tse->cp->ds.sym == sym)
 			return thread_stack__call_return(thread, ts, --ts->cnt,
 							 timestamp, ref, false);
 	}
@@ -862,21 +863,21 @@ static int thread_stack__bottom(struct thread_stack *ts,
 				struct addr_location *to_al, u64 ref)
 {
 	struct call_path_root *cpr = ts->crp->cpr;
+	struct dso_symbol ds;
 	struct call_path *cp;
-	struct symbol *sym;
 	u64 ip;
 
 	if (sample->ip) {
 		ip = sample->ip;
-		sym = from_al->sym;
+		ds = dso_symbol__from_al(from_al);
 	} else if (sample->addr) {
 		ip = sample->addr;
-		sym = to_al->sym;
+		ds = dso_symbol__from_al(to_al);
 	} else {
 		return 0;
 	}
 
-	cp = call_path__findnew(cpr, &cpr->call_path, sym, ip,
+	cp = call_path__findnew(cpr, &cpr->call_path, &ds, ip,
 				ts->kernel_start);
 
 	return thread_stack__push_cp(ts, ip, sample->time, ref, cp,
@@ -908,8 +909,8 @@ static int thread_stack__no_call_return(struct thread *thread,
 {
 	struct call_path_root *cpr = ts->crp->cpr;
 	struct call_path *root = &cpr->call_path;
-	struct symbol *fsym = from_al->sym;
-	struct symbol *tsym = to_al->sym;
+	struct dso_symbol fds = dso_symbol__from_al(from_al);
+	struct dso_symbol tds = dso_symbol__from_al(to_al);
 	struct call_path *cp, *parent;
 	u64 ks = ts->kernel_start;
 	u64 addr = sample->addr;
@@ -925,7 +926,7 @@ static int thread_stack__no_call_return(struct thread *thread,
 
 		/* If the stack is empty, push the userspace address */
 		if (!ts->cnt) {
-			cp = call_path__findnew(cpr, root, tsym, addr, ks);
+			cp = call_path__findnew(cpr, root, &tds, addr, ks);
 			return thread_stack__push_cp(ts, 0, tm, ref, cp, true,
 						     false);
 		}
@@ -941,7 +942,7 @@ static int thread_stack__no_call_return(struct thread *thread,
 	else
 		parent = root;
 
-	if (parent->sym == from_al->sym) {
+	if (parent->ds.sym == from_al->sym) {
 		/*
 		 * At the bottom of the stack, assume the missing 'call' was
 		 * before the trace started. So, pop the current symbol and push
@@ -955,7 +956,7 @@ static int thread_stack__no_call_return(struct thread *thread,
 		}
 
 		if (!ts->cnt) {
-			cp = call_path__findnew(cpr, root, tsym, addr, ks);
+			cp = call_path__findnew(cpr, root, &tds, addr, ks);
 
 			return thread_stack__push_cp(ts, addr, tm, ref, cp,
 						     true, false);
@@ -965,7 +966,7 @@ static int thread_stack__no_call_return(struct thread *thread,
 		 * Otherwise assume the 'return' is being used as a jump (e.g.
 		 * retpoline) and just push the 'to' symbol.
 		 */
-		cp = call_path__findnew(cpr, parent, tsym, addr, ks);
+		cp = call_path__findnew(cpr, parent, &tds, addr, ks);
 
 		err = thread_stack__push_cp(ts, 0, tm, ref, cp, true, false);
 		if (!err)
@@ -979,13 +980,13 @@ static int thread_stack__no_call_return(struct thread *thread,
 	 * pop 'from'.
 	 */
 
-	cp = call_path__findnew(cpr, parent, tsym, addr, ks);
+	cp = call_path__findnew(cpr, parent, &tds, addr, ks);
 
 	err = thread_stack__push_cp(ts, addr, tm, ref, cp, true, false);
 	if (err)
 		return err;
 
-	cp = call_path__findnew(cpr, cp, fsym, ip, ks);
+	cp = call_path__findnew(cpr, cp, &fds, ip, ks);
 
 	err = thread_stack__push_cp(ts, ip, tm, ref, cp, true, false);
 	if (err)
@@ -1052,7 +1053,8 @@ static int thread_stack__x86_retpoline(struct thread_stack *ts,
 {
 	struct thread_stack_entry *tse = &ts->stack[ts->cnt - 1];
 	struct call_path_root *cpr = ts->crp->cpr;
-	struct symbol *sym = tse->cp->sym;
+	struct symbol *sym = tse->cp->ds.sym;
+	struct dso_symbol tds = dso_symbol__from_al(to_al);
 	struct symbol *tsym = to_al->sym;
 	struct call_path *cp;
 
@@ -1068,7 +1070,7 @@ static int thread_stack__x86_retpoline(struct thread_stack *ts,
 		 * graph, since all the original branches are left unchanged.
 		 */
 		ts->cnt -= 1;
-		sym = ts->stack[ts->cnt - 2].cp->sym;
+		sym = ts->stack[ts->cnt - 2].cp->ds.sym;
 		if (sym && sym == tsym && to_al->addr != tsym->start) {
 			/*
 			 * Target is back to the middle of the symbol we came
@@ -1087,7 +1089,7 @@ static int thread_stack__x86_retpoline(struct thread_stack *ts,
 		return 0;
 	}
 
-	cp = call_path__findnew(cpr, ts->stack[ts->cnt - 2].cp, tsym,
+	cp = call_path__findnew(cpr, ts->stack[ts->cnt - 2].cp, &tds,
 				sample->addr, ts->kernel_start);
 	if (!cp)
 		return -ENOMEM;
@@ -1147,6 +1149,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 
 	if (sample->flags & PERF_IP_FLAG_CALL) {
 		bool trace_end = sample->flags & PERF_IP_FLAG_TRACE_END;
+		struct dso_symbol tds = dso_symbol__from_al(to_al);
 		struct call_path_root *cpr = ts->crp->cpr;
 		struct call_path *cp;
 		u64 ret_addr;
@@ -1160,7 +1163,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 			return 0; /* Zero-length calls are excluded */
 
 		cp = call_path__findnew(cpr, ts->stack[ts->cnt - 1].cp,
-					to_al->sym, sample->addr,
+					&tds, sample->addr,
 					ts->kernel_start);
 		err = thread_stack__push_cp(ts, ret_addr, sample->time, ref,
 					    cp, false, trace_end);
@@ -1209,6 +1212,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	} else if (sample->flags & PERF_IP_FLAG_BRANCH &&
 		   from_al->sym != to_al->sym && to_al->sym &&
 		   to_al->addr == to_al->sym->start) {
+		struct dso_symbol tds = dso_symbol__from_al(to_al);
 		struct call_path_root *cpr = ts->crp->cpr;
 		struct call_path *cp;
 
@@ -1219,7 +1223,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 		 * when a ret pops the stack, all jmps must be popped off first.
 		 */
 		cp = call_path__findnew(cpr, ts->stack[ts->cnt - 1].cp,
-					to_al->sym, sample->addr,
+					&tds, sample->addr,
 					ts->kernel_start);
 		err = thread_stack__push_cp(ts, 0, sample->time, ref, cp, false,
 					    false);
-- 
2.56.1.703.gf848ed807c-goog

