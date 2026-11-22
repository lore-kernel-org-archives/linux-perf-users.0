Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323891;
	b=N6nIC2PFiXEaubajM602E96v/oj8Pm0hC1cINN/LilRpCQt94SuplKDSUb7E2UH15tzX
	 ycvSvEvf5YftlEwjPzOrPDeZgc+6/AW5LB6s+NtI2szqfuXf4RAMqIOXSCOQTcHJlzw5h
	 Mm7SGslNl+nGquLt+qhy2SZ0gYwM9yCSh75qSobIdUmIUMfojIEGsD1SN5iuztK59zk4T
	 Mm4lXn2moJVvQYqokHtBYTzWv34EWiOz0GHsWLL7xUTMsKd5tC/pGGbFugWnm+kSPe8WX
	 4EAHHGJUSYqvp86opw+p1wuMmKw82PNN0Ql+fmnUfJOGGXqTHttldDjYOKlUA62+6Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=sKCN0xkGtD40xmw8BUtJsPQkTFtJI6AVG6guKPdcdV8=;
	b=Ccbih9uLxOwO8bImtsdOKREn+xSZuJ5ihQKEKB7Z8eL/9BIbHNX7w4AsS+Knb8UlX6VG
	 BwWl6lkKqQoQMGRrvk5jyImvkh8qF4oP9ybz+GBWUukQc3rvqV33ZoYSHtFd8IBLcrb/2
	 yBcE48ZotJndPhT6WPRYRFFQ+E0wtMCejr4pPGhYFkQMsFCg0FSUKvsIkOox72cHjKJO8
	 kPwHddyjGnUA7FDECP/XoX3ob57XRlYI8NgofNx+i5zvyGhiAVI33NTv726i4t19wAyf/
	 KaUo6Bi7ZUwjgeJy56yf550fCAmeLqR1ZBtdLLYoFX8jAVmrZ4gEAVNR6Y7FXFrU0Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ync8aA+r;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA47606A32C
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 05:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEA47606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ync8aA+r
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3854627c1c8so3537675eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 21:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795323890; x=1795928690; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sKCN0xkGtD40xmw8BUtJsPQkTFtJI6AVG6guKPdcdV8=;
        b=Ync8aA+rqrajW+8kHx8KMMIL5qRB2PQMPqJGzuZlEGGYL9c6Hby6aDbYDtYyn3Va9v
         cuB24VtdC1z1N1wypCKPxglwK2kzJ1ZeO0D0o6L31TPLeRF6azjKTdk2KIjpaJMxl/Zl
         ZMwscJuCMFJYViclvX19SiXkgEWx/l056c+jKeNBEqamzidJ9FCfF7VmIWQdpgCGiIsv
         imjeM+j0ROlK4c26B+TeVDROWcmE6sbirsallETJNDJ8b0eDpCb+B12sCvQu1iqNOsCi
         o6YmGobpfHrqX27n3JhYZICP4kcCBuDhERDGdSbfBBYD2wzTb/hEDT06UAsvAv8Q3ojW
         rl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795323890; x=1795928690;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sKCN0xkGtD40xmw8BUtJsPQkTFtJI6AVG6guKPdcdV8=;
        b=ZPW9m3rH/N5YqbTN3QceogCxy00Z+qUbJ/ajuZBd4ErnzZmqSQYDmHgIiQkdppLegC
         BagiT/LDSVDl2j39WSfBN3Laf8/bXbfgC3cVNKq1+G3el7mVLwJ04PyY9wRhiyBL9HPb
         bwqMB9TtSaKvFxdJpFDClGXZb39yd0PBrn3cdizOPO72Oo21a830ZW8iG3ECJ/c7tZu9
         N8JNwxGht/rp6NyHmHRbRGvb51mBHcJlQECNrRHksBX4iJtJrubEtlTJqldMhtA+t19l
         tASThiGZquLEcgIFToUb2542LiU/JaM4cVZabukDbrdQr3uxV0Ar+gZqs3M+HqX/FBCA
         EjBg==
X-Forwarded-Encrypted: i=1; AL+hErEbtZah7MrRzvFemY2niLz2d16SlKHu6yjiclCV7zRQdnyGr5bVmaB6bU7FVZB/UreKSsMg6tq8E0m0Tkl2T/hH@vger.kernel.org
X-Gm-Message-State: APuU4Z+pRZKt9TFWthk/BYHD8DtPvKD839CPNBovgQBv1rZUMXvZHWnU
	RGpPjak7MoU2wjlaBy1HUPqEAARobS3nqwQEUCyPMe7pA9ygIzUYv2Jyj8YtsNL9FgAbvKe7K5C
	yIuoHuufRQQ==
X-Received: from dyev10.prod.google.com ([2002:a05:7300:430a:b0:343:520f:7a80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ce11:b0:381:6b5:56e6
 with SMTP id 5a478bee46e88-3856f65aed4mr7827105eec.16.1795323889616; Sat, 21
 Nov 2026 21:04:49 -0800 (PST)
Date: Sat, 21 Nov 2026 21:04:03 -0800
In-Reply-To: <20261122050405.80335-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122050405.80335-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122050405.80335-9-irogers@google.com>
Subject: [PATCH v8 08/10] perf symbol: Add memory shrinking for symbols, DSOs,
 and machines
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When profiling large workloads or systems with thousands of processes and
shared libraries, perf can accumulate significant memory in loaded DSO
symbol tables, secondary name-sorted symbol indices, cached DSO file data,
and DWARF/addr2line state.

Because the lifetime of struct symbol is controlled by its owning
struct dso, symbols in a referenced DSO (refcnt > 1) must remain valid for
the lifetime of the DSO reference. However, auxiliary per-DSO allocations
and unreferenced DSOs can still be reclaimed under memory pressure:

1. symbols__shrink(): Reclaims the secondary name-sorted index
   (symbols_by_name, which is rebuilt on demand by dso__sort_by_name())
   and trims unused over-allocated tail capacity in the symbols array.

2. dso__shrink(): Releases cached DSO resources (open file descriptor,
   cached 4KB data pages, addr2line handles, and libdw DWARF contexts).
   When a DSO in a dsos collection has no external references
   (refcnt == 1), dso__shrink() also evicts its unannotated symbol table
   via symbols__try_delete_unannotated() and marks the DSO unloaded so it
   can be reloaded on demand if mapped again; otherwise it calls
   symbols__shrink() to reclaim auxiliary symbol arrays.

3. dsos__shrink(), machine__shrink(), machines__shrink(), and
   perf_session__shrink(): Walk the session's host and guest machines to
   shrink DSOs and evict unreferenced user DSOs (refcnt == 1, not kernel,
   not vDSO, not hit, and not carrying header build-ids), followed by
   malloc_trim(0) on glibc to return freed heap pages to the OS.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c     | 263 +++++++++++++++++++++++++++++++++++---
 tools/perf/util/dso.h     |  14 +-
 tools/perf/util/dsos.c    |  50 ++++++++
 tools/perf/util/dsos.h    |   2 +
 tools/perf/util/machine.c |  29 +++++
 tools/perf/util/machine.h |   3 +
 tools/perf/util/session.c |   8 ++
 tools/perf/util/session.h |   2 +
 tools/perf/util/symbol.c  |  68 +++++++++-
 tools/perf/util/symbol.h  |   3 +
 10 files changed, 419 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d1668c986e8d..dce9d8d7838c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -3,6 +3,7 @@
 
 #include <assert.h>
 #include <errno.h>
+#include <stdatomic.h>
 #include <stdlib.h>
 
 #include <asm/bug.h>
@@ -16,6 +17,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 
+#include "annotate.h"
 #include "annotate-data.h"
 #include "auxtrace.h"
 #include "compress.h"
@@ -1050,12 +1052,12 @@ static int bpf_size(struct dso *dso)
 #endif // HAVE_LIBBPF_SUPPORT
 
 static void
-dso_cache__free(struct dso *dso)
+__dso_cache__free(struct dso *dso)
+	__must_hold(dso__lock(dso))
 {
 	struct rb_root *root = &dso__data(dso)->cache;
 	struct rb_node *next = rb_first(root);
 
-	mutex_lock(dso__lock(dso));
 	while (next) {
 		struct dso_cache *cache;
 
@@ -1064,10 +1066,18 @@ dso_cache__free(struct dso *dso)
 		rb_erase(&cache->rb_node, root);
 		free(cache);
 	}
+}
+
+static void
+dso_cache__free(struct dso *dso)
+{
+	mutex_lock(dso__lock(dso));
+	__dso_cache__free(dso);
 	mutex_unlock(dso__lock(dso));
 }
 
 static struct dso_cache *__dso_cache__find(struct dso *dso, u64 offset)
+	__must_hold(dso__lock(dso))
 {
 	const struct rb_root *root = &dso__data(dso)->cache;
 	struct rb_node * const *p = &root->rb_node;
@@ -1218,27 +1228,30 @@ static struct dso_cache *dso_cache__populate(struct dso *dso,
 	return cache;
 }
 
-static struct dso_cache *dso_cache__find(struct dso *dso,
-					 struct machine *machine,
-					 u64 offset,
-					 ssize_t *ret)
-{
-	struct dso_cache *cache = __dso_cache__find(dso, offset);
-
-	return cache ? cache : dso_cache__populate(dso, machine, offset, ret);
-}
-
 static ssize_t dso_cache_io(struct dso *dso, struct machine *machine,
 			    u64 offset, u8 *data, ssize_t size, bool out)
 {
 	struct dso_cache *cache;
 	ssize_t ret = 0;
 
-	cache = dso_cache__find(dso, machine, offset, &ret);
-	if (!cache)
-		return ret;
+	mutex_lock(dso__lock(dso));
+	cache = __dso_cache__find(dso, offset);
+	while (!cache) {
+		mutex_unlock(dso__lock(dso));
+		cache = dso_cache__populate(dso, machine, offset, &ret);
+		if (!cache)
+			return ret;
+		mutex_lock(dso__lock(dso));
+		/*
+		 * Re-lookup under dso__lock(dso) in case dso__shrink() freed
+		 * the cache while the lock was dropped.
+		 */
+		cache = __dso_cache__find(dso, offset);
+	}
 
-	return dso_cache__memcpy(cache, offset, data, size, out);
+	ret = dso_cache__memcpy(cache, offset, data, size, out);
+	mutex_unlock(dso__lock(dso));
+	return ret;
 }
 
 /*
@@ -1797,7 +1810,7 @@ int dso__name_len(const struct dso *dso)
 
 bool dso__loaded(const struct dso *dso)
 {
-	return RC_CHK_ACCESS(dso)->loaded;
+	return atomic_load_explicit(&RC_CHK_ACCESS(dso)->loaded, memory_order_acquire);
 }
 
 bool dso__sorted_by_name(const struct dso *dso)
@@ -1835,7 +1848,7 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->binary_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->dbginfo_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->is_64_bit = (sizeof(void *) == 8);
-		dso->loaded = 0;
+		atomic_init(&dso->loaded, false);
 		dso->rel = 0;
 		dso->has_srcline = 1;
 		dso->a2l_fails = 1;
@@ -1859,7 +1872,7 @@ struct dso *dso__new(const char *name)
 	return dso__new_id(name, NULL);
 }
 
-void dso__delete(struct dso *dso)
+static void __dso__delete(struct dso *dso, bool close_data)
 {
 	if (dso__dsos(dso))
 		pr_err("DSO %s is still in rbtree when being deleted!\n", dso__long_name(dso));
@@ -1881,7 +1894,8 @@ void dso__delete(struct dso *dso)
 		RC_CHK_ACCESS(dso)->long_name_allocated = false;
 	}
 
-	dso__data_close(dso);
+	if (close_data)
+		dso__data_close(dso);
 	auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
 	dso_cache__free(dso);
 	dso__free_a2l(dso);
@@ -1893,6 +1907,215 @@ void dso__delete(struct dso *dso)
 	RC_CHK_FREE(dso);
 }
 
+void dso__delete(struct dso *dso)
+{
+	__dso__delete(dso, /*close_data=*/true);
+}
+
+bool dso__can_shrink_symbols(const struct dso *dso)
+{
+	const char *name;
+
+	if (!dso || !dso__loaded(dso))
+		return false;
+
+	if (dso__kernel(dso) || dso__is_kmod(dso))
+		return false;
+
+	if (dso__is_vdso(dso))
+		return false;
+
+	switch (dso__binary_type(dso)) {
+	case DSO_BINARY_TYPE__KALLSYMS:
+	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
+	case DSO_BINARY_TYPE__VMLINUX:
+	case DSO_BINARY_TYPE__GUEST_VMLINUX:
+	case DSO_BINARY_TYPE__KCORE:
+	case DSO_BINARY_TYPE__GUEST_KCORE:
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
+	case DSO_BINARY_TYPE__OOL:
+	case DSO_BINARY_TYPE__JAVA_JIT:
+	case DSO_BINARY_TYPE__GUEST_KMODULE:
+	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
+		return false;
+	case DSO_BINARY_TYPE__DEBUGLINK:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
+	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
+	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
+	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
+	case DSO_BINARY_TYPE__NOT_FOUND:
+	default:
+		break;
+	}
+
+	switch (dso__symtab_type(dso)) {
+	case DSO_BINARY_TYPE__KALLSYMS:
+	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
+	case DSO_BINARY_TYPE__VMLINUX:
+	case DSO_BINARY_TYPE__GUEST_VMLINUX:
+	case DSO_BINARY_TYPE__KCORE:
+	case DSO_BINARY_TYPE__GUEST_KCORE:
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
+	case DSO_BINARY_TYPE__OOL:
+	case DSO_BINARY_TYPE__JAVA_JIT:
+	case DSO_BINARY_TYPE__GUEST_KMODULE:
+	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
+	case DSO_BINARY_TYPE__NOT_FOUND:
+		return false;
+	case DSO_BINARY_TYPE__DEBUGLINK:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
+	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
+	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
+	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
+	default:
+		break;
+	}
+
+	name = dso__long_name(dso);
+	if (!name || name[0] == '[' || is_perf_pid_map_name(name) ||
+	    strstr(name, " (deleted)") != NULL)
+		return false;
+
+	return true;
+}
+
+static bool dso__has_annotated_inlines(struct dso *dso)
+{
+	struct rb_root_cached *tree = dso__inlined_nodes(dso);
+	struct rb_node *nd;
+
+	for (nd = rb_first_cached(tree); nd; nd = rb_next(nd)) {
+		struct inline_node *node = rb_entry(nd, struct inline_node, rb_node);
+		struct inline_list *ilist;
+
+		list_for_each_entry(ilist, &node->val, list) {
+			if (ilist->symbol && symbol__annotated(ilist->symbol))
+				return true;
+		}
+	}
+	return false;
+}
+
+static void dso__delete_inlines_and_srclines(void *ctx)
+{
+	struct dso *dso = ctx;
+
+	/* Free inlines before symbols, as inline frames reference symbols. */
+	inlines__tree_delete(dso__inlined_nodes(dso));
+	srcline__tree_delete(dso__srclines(dso));
+}
+
+size_t dso__shrink(struct dso *dso)
+{
+	size_t freed = 0;
+
+	if (!dso)
+		return 0;
+
+	if (mutex_trylock(&dso__data_open_lock)) {
+		if (dso__data(dso)->fd >= 0) {
+			close_dso(dso);
+			freed++;
+		}
+		mutex_unlock(&dso__data_open_lock);
+	}
+
+	if (!mutex_trylock(dso__lock(dso)))
+		return freed;
+
+	if (!dso__kernel(dso) && dso__binary_type(dso) != DSO_BINARY_TYPE__OOL &&
+	    !RB_EMPTY_ROOT(&dso__data(dso)->cache)) {
+		__dso_cache__free(dso);
+		freed++;
+	}
+	if (dso__a2l(dso)) {
+		dso__free_a2l(dso);
+		freed++;
+	}
+#ifdef HAVE_LIBBFD_SUPPORT
+	if (dso__a2l_libbfd(dso)) {
+		dso__free_a2l_libbfd(dso);
+		freed++;
+	}
+#endif
+#ifdef HAVE_LIBDW_SUPPORT
+	if (dso__libdw(dso)) {
+		dso__free_libdw(dso);
+		freed++;
+	}
+#endif
+
+	if (dso__dsos(dso) && refcount_read(dso__refcnt(dso)) == 1 &&
+	    dso__can_shrink_symbols(dso) && dso__has_symbols(dso) &&
+	    !dso__has_annotated_inlines(dso) &&
+	    symbols__try_delete_unannotated(dso__symbols(dso),
+					    dso__delete_inlines_and_srclines, dso)) {
+		atomic_store_explicit(&RC_CHK_ACCESS(dso)->loaded, false,
+				      memory_order_release);
+		freed++;
+	} else {
+		freed += symbols__shrink(dso__symbols(dso));
+	}
+
+	mutex_unlock(dso__lock(dso));
+	return freed;
+}
+
+/*
+ * Try to evict an unreferenced @dso from its owning struct dsos (whose write
+ * lock must be held by the caller) without blocking on any lock.
+ */
+bool dso__try_evict(struct dso *dso)
+{
+	bool can_evict = false;
+
+	if (!dso ||
+	    dso__has_symbols(dso) ||
+	    dso__header_build_id(dso) ||
+	    dso__hit(dso) ||
+	    dso__kernel(dso) ||
+	    dso__is_vdso(dso) ||
+	    refcount_read(dso__refcnt(dso)) != 1)
+		return false;
+
+	if (!mutex_trylock(&dso__data_open_lock))
+		return false;
+
+	if (dso__data(dso)->fd < 0 &&
+	    list_empty(&dso__data(dso)->open_entry) &&
+	    refcount_read(dso__refcnt(dso)) == 1 &&
+	    mutex_trylock(dso__lock(dso))) {
+		can_evict = !dso__has_symbols(dso) && !dso__has_annotated_inlines(dso);
+		mutex_unlock(dso__lock(dso));
+	}
+	mutex_unlock(&dso__data_open_lock);
+	if (!can_evict)
+		return false;
+
+	dso__set_dsos(dso, NULL);
+	if (refcount_dec_and_test(&RC_CHK_ACCESS(dso)->refcnt))
+		__dso__delete(dso, /*close_data=*/false);
+	else
+		RC_CHK_PUT(dso);
+	return true;
+}
+
 struct dso *dso__get(struct dso *dso)
 {
 	struct dso *result;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 63c1b7d6f6f8..b0ee45a53f40 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/rbtree.h>
 #include <sys/types.h>
+#include <stdatomic.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <linux/bitops.h>
@@ -343,7 +344,7 @@ DECLARE_RC_STRUCT(dso) {
 	u8		 is_64_bit:1;
 	u8		 bintype_searched:1;
 	u8		 debuginfo_searched:1;
-	bool		 loaded;
+	_Atomic bool	 loaded;
 	u8		 rel;
 	char		 name[];
 };
@@ -599,7 +600,7 @@ static inline enum dso_load_errno *dso__load_errno(struct dso *dso)
 
 static inline void dso__set_loaded(struct dso *dso)
 {
-	RC_CHK_ACCESS(dso)->loaded = true;
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->loaded, true, memory_order_release);
 }
 
 static inline struct mutex *dso__lock(struct dso *dso)
@@ -788,6 +789,15 @@ static inline bool dso__has_symbols(const struct dso *dso)
 	return res;
 }
 
+static inline refcount_t *dso__refcnt(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->refcnt;
+}
+
+bool dso__can_shrink_symbols(const struct dso *dso);
+bool dso__try_evict(struct dso *dso);
+size_t dso__shrink(struct dso *dso);
+
 char *dso__filename_with_chroot(const struct dso *dso, const char *filename);
 
 bool dso__sorted_by_name(const struct dso *dso);
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 7a56577f4ec8..77f668d7557c 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -6,6 +6,9 @@
 #include "vdso.h"
 #include "namespaces.h"
 #include <errno.h>
+#ifdef __GLIBC__
+#include <malloc.h>
+#endif
 #include <stdlib.h>
 #include <string.h>
 #include <symbol.h> // filename__read_build_id
@@ -517,3 +520,50 @@ int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data)
 	up_read(&dsos->lock);
 	return err;
 }
+
+size_t dsos__shrink(struct dsos *dsos)
+{
+	unsigned int write_idx = 0;
+	size_t freed = 0;
+	bool any_removed = false;
+
+	down_write(&dsos->lock);
+
+	for (unsigned int read_idx = 0; read_idx < dsos->cnt; read_idx++) {
+		struct dso *dso = dsos->dsos[read_idx];
+
+		freed += dso__shrink(dso);
+
+		if (dso__try_evict(dso)) {
+			any_removed = true;
+			freed++;
+			continue;
+		}
+		dsos->dsos[write_idx++] = dso;
+	}
+
+	dsos->cnt = write_idx;
+	if (any_removed) {
+		if (write_idx == 0) {
+			zfree(&dsos->dsos);
+			dsos->allocated = 0;
+			dsos->sorted = true;
+		} else if (write_idx < dsos->allocated / 2) {
+			struct dso **shrunk = realloc(dsos->dsos,
+						      write_idx * sizeof(struct dso *));
+			if (shrunk) {
+				dsos->dsos = shrunk;
+				dsos->allocated = write_idx;
+			}
+		}
+	}
+
+	up_write(&dsos->lock);
+
+#ifdef __GLIBC__
+	if (freed > 0)
+		malloc_trim(0);
+#endif
+
+	return freed;
+}
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index cc7e3a42f9cb..de10a10de777 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -51,4 +51,6 @@ struct dso *dsos__find_kernel_dso(struct dsos *dsos);
 
 int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data), void *data);
 
+size_t dsos__shrink(struct dsos *dsos);
+
 #endif /* __PERF_DSOS */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3c206c26bd62..f4108cc725fc 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3438,3 +3438,32 @@ int machine__hit_all_dsos(struct machine *machine)
 {
 	return dsos__hit_all(&machine->dsos);
 }
+
+size_t machine__shrink(struct machine *machine)
+{
+	if (!machine)
+		return 0;
+
+	return dsos__shrink(&machine->dsos);
+}
+
+size_t machines__shrink(struct machines *machines)
+{
+	struct rb_node *nd;
+	size_t freed;
+
+	if (!machines)
+		return 0;
+
+	freed = machine__shrink(&machines->host);
+
+	down_read(&machines->lock);
+	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
+		struct machine *pos = rb_entry(nd, struct machine, rb_node);
+
+		freed += machine__shrink(pos);
+	}
+	up_read(&machines->lock);
+
+	return freed;
+}
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 67d517742fb6..b42c363723c9 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -339,4 +339,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 
 int machine__hit_all_dsos(struct machine *machine);
 
+size_t machine__shrink(struct machine *machine);
+size_t machines__shrink(struct machines *machines);
+
 #endif /* __PERF_MACHINE_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4e11eabbbe6f..9f16bff1b72f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -4270,3 +4270,11 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
 	 */
 	return perf_env__e_machine_nocache(env, e_flags);
 }
+
+size_t perf_session__shrink(struct perf_session *session)
+{
+	if (!session)
+		return 0;
+
+	return machines__shrink(&session->machines);
+}
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 05ea2c1ee8c9..cbea6792a008 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -211,4 +211,6 @@ int perf_event__process_finished_round(const struct perf_tool *tool,
 struct perf_env *perf_session__env(struct perf_session *session);
 uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags);
 
+size_t perf_session__shrink(struct perf_session *session);
+
 #endif /* __PERF_SESSION_H */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 22b84e9a40fd..eadaa5bfaa9e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dirent.h>
 #include <errno.h>
+#include <stdatomic.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -256,6 +257,69 @@ void symbols__exit(struct symbols *symbols)
 	exit_rwsem(&symbols->lock);
 }
 
+bool symbols__try_delete_unannotated(struct symbols *symbols,
+				     void (*pre_delete)(void *ctx), void *ctx)
+{
+	down_write(&symbols->lock);
+	for (unsigned int i = 0; i < symbols->cnt; i++) {
+		if (symbol__annotated(symbols->symbols[i])) {
+			up_write(&symbols->lock);
+			return false;
+		}
+	}
+
+	if (pre_delete)
+		pre_delete(ctx);
+
+	symbols__delete_locked(symbols);
+	up_write(&symbols->lock);
+	return true;
+}
+
+/*
+ * Reclaim auxiliary memory from @symbols without freeing live symbol
+ * entries (whose lifetimes are owned by the containing struct dso):
+ * - Free the secondary name-sorted index (@symbols_by_name), which is
+ *   rebuilt on demand by dso__sort_by_name().
+ * - Trim unused over-allocated tail capacity in @symbols->symbols.
+ *
+ * Returns the number of buffers reclaimed/shrunk.
+ */
+size_t symbols__shrink(struct symbols *symbols)
+{
+	size_t freed = 0;
+
+	down_write(&symbols->lock);
+
+	if (symbols->symbols_by_name) {
+		zfree(&symbols->symbols_by_name);
+		symbols->num_by_name = 0;
+		symbols->sorted_by_name = false;
+		freed++;
+	}
+
+	if (symbols->cnt == 0) {
+		if (symbols->allocated > 0) {
+			zfree(&symbols->symbols);
+			symbols->sorted_cnt = 0;
+			symbols->allocated = 0;
+			symbols->sorted = true;
+			freed++;
+		}
+	} else if (symbols->cnt < symbols->allocated) {
+		struct symbol **shrunk = realloc(symbols->symbols,
+						 symbols->cnt * sizeof(struct symbol *));
+		if (shrunk) {
+			symbols->symbols = shrunk;
+			symbols->allocated = symbols->cnt;
+			freed++;
+		}
+	}
+
+	up_write(&symbols->lock);
+	return freed;
+}
+
 /*
  * Order symbols by start address only, preserving insertion order among
  * symbols sharing the same start address (matching the previous rbtree
@@ -2394,8 +2458,9 @@ int dso__load(struct dso *dso, struct map *map)
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
 		ret = 1;
-		goto out;
+		goto out_unlock;
 	}
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->loaded, false, memory_order_release);
 
 	kmod = dso__is_kmod(dso);
 
@@ -2553,6 +2618,7 @@ int dso__load(struct dso *dso, struct map *map)
 		ret = 0;
 out:
 	dso__set_loaded(dso);
+out_unlock:
 	mutex_unlock(dso__lock(dso));
 	nsinfo__mountns_exit(&nsc);
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 541ab9321d99..ca0e201f1756 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -139,6 +139,9 @@ void symbol__delete(struct symbol *sym);
 void symbols__init(struct symbols *symbols);
 void symbols__exit(struct symbols *symbols);
 void symbols__delete(struct symbols *symbols);
+bool symbols__try_delete_unannotated(struct symbols *symbols,
+				     void (*pre_delete)(void *ctx), void *ctx);
+size_t symbols__shrink(struct symbols *symbols);
 void symbols__sort_read_lock(struct symbols *symbols) __acquires_shared(&symbols->lock);
 
 static inline u8 symbol__type(const struct symbol *sym)
-- 
2.56.1.750.gf70dc682cf-goog

