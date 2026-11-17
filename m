Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941592;
	b=GfXgIQsdQmgAa7xbaRNGHj/husdyqAyW8A6cH5b/5niAx/ttyokLcgXJhTPyPZujscCY
	 UG/7zU9RIZ5VXHMSCgRTgQlVk5k33G8fY5opk8erwaIDJRbSokcTEj85BN/6JK5X4NLYe
	 e01fH01gMSr9z278rFIV+LQHpFdlI6k22TUc5Tb7klbSZdaNlKSCIPjrAn4xOyF1irEKH
	 3whEuPYnQi0GhFlEhZVbBgSRAmtbxAvFEdzEldXGowlcN7PM+JQVMpsbOWYsponXbE/9j
	 GE0kQW540Yauw9RCeBuJo6tabpq799Fs4IRoUTsZMzHJGW542PpX0Zm76gCKmINfFPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=s3lKOZIehs7zghVMQL3qXW1rl5HT2ZJDnVe3jn0mFR8=;
	b=01bRaNPadYvw7HoYyN6EpSzOQjQtocEIf3SElGrm8j+ioyRNko4IhcHNQ04C91OWLOkd
	 Fvf9ilbXQ4PlLWrF1Ub2yw07nRqnEI9qjbyXpCWGhpOM5ksZBnXRWhcQ42HV+zJ2KVEpK
	 O4kytHfbmM+iBkYhtTXb3wqWpkcCWf9Smv4BB7HX8XYal2BKI50YT+ZqDzb8cnYOC0zyE
	 8xjuhDmmMg8GHeZqnBSr6WH4tu1d+ZgXQgSzkOv+fCeaYZ7icnbfvEZ3XPZ0n6yY17Kd7
	 I9eRgi2XWql8kUWNX13OBDThNBlJrPWC4jNgGiGwvIULkFLnfYmJLifSMl+GRcPDulg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cYvPGk5q;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ED7606A33A
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29ED7606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cYvPGk5q
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3821eb27024so224692eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941591; x=1795546391; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3lKOZIehs7zghVMQL3qXW1rl5HT2ZJDnVe3jn0mFR8=;
        b=cYvPGk5qVirLwkcoSanCeXroyfXujlmhEnc/D+n9MmKg7Z2SfAy94guIWpnYqHNifK
         K6yYpnD0mhBRu2AEtaidiWVxC+a90ZjaMGyGC1E9j0uOekiNM/qKugnMqVyMeRqIBnsT
         YworS9yrXreKeiPDNAFr+xxfrvsK93vd8VmdW0fYJ0/PrXdX3RtZma8hLIBaS4/cl3VX
         o6489fxQFIygqSWS3Lu6gVujAOytZcB8QvbouWrXzGr8h434BIWVKdweMs2XFE9nuYJE
         zAtw8OWs2QAfQGpps03VHcfb8ZCG0k6AqmkPm3UinYEbjbrp+aE17maNXDAJyytTtSrE
         QlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941591; x=1795546391;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s3lKOZIehs7zghVMQL3qXW1rl5HT2ZJDnVe3jn0mFR8=;
        b=ikjd4cBR/rX7kRPrmp/zKNJCoAKJqS7Xdvf/DaTDJmqwA9WE71IPN1lMrxcvCJto2z
         D+FMhOb2dSRF9/dMSGQ/hCPUenx04k6N06wV54+7kw/hDxMLsz1sgQQcg4J5L8TfszPB
         kXaNFyknJfywgq0MJJYiLlAVQJsdGF8lfN4Cl15feKjBx/8PZxwS2HTNr7aN5QNUVNhv
         3OYtAlmdo2CKxRLXBdQZgwbdlvzqzMWu3Xn66C5KjyWibicleomQa7srhvjDTnO/DJCl
         VaojLBnnDlWgegXVFYeeIc4w4Q9RPscv+qN6dxyJQxjMrv/gBF7VLK5Bud08MIB1W08f
         16yg==
X-Forwarded-Encrypted: i=1; AL+hErGGtK0wbco9xDvKDgjVJwPDg4phXQWVogdy34t4rRlzxcFSW+58vLzLVp949ID+0g9F+Tv+cEqpKsOmSi+DweS4@vger.kernel.org
X-Gm-Message-State: APuU4Z9WY0vGJ4+DH3yBGPz3xZsgeAX9a+MpDwJTyrbBOHwmH5d/R3ef
	ID8ghKthSmAl9+0ySVkqN3nlZCfhZY3Xf/z9t3V9MOJS+xlca2SW23TQdxj5tNLf7G5zBhe94Q7
	cJzlGpfzzmA==
X-Received: from dycnd20.prod.google.com ([2002:a05:7301:c14:b0:36c:99b8:3ed7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cf96:b0:381:17f:2735
 with SMTP id 5a478bee46e88-38281523ee1mr322010eec.27.1794941590795; Tue, 17
 Nov 2026 10:53:10 -0800 (PST)
Date: Tue, 17 Nov 2026 10:52:57 -0800
In-Reply-To: <20261117185305.108003-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117185305.108003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117185305.108003-2-irogers@google.com>
Subject: [PATCH v6 1/9] perf call-path: Use struct dso_symbol to retain symbol
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

