Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559490;
	b=tHDlRQot9eDfF0ehHNq4JbnHySw/MEO6mT3DmEl3TpWOn6uNWWxo2O+UdP5sI2LXl5jk
	 FTL/Cy5N/SB68r3zdjuIQ2q8dyYhkheNpypD8zuvr211+nnbPBVfXMJ3aRZq+HPO96/pq
	 m452BeH4IHgcFtJLg10rrODWKSWV8hneBayvZwJUMrwCG+HWxAcdFo1TmhaNURA3oEf08
	 TCSFz8L/ht/2m19GSFQXoWvBCS15r4/p1KHWc9Z2g4EeyFiFSYOPLirXvaYNuxtPQeHfX
	 0wakOAlMNMe0dXPlxTsmMIACo/1IJO0fC/fWxmYQYiIrfQHQspobZf/m8HATBh+0aBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=QCYdaX+gGCR9rqh1M6R/ZEIGIvsxPuaht+HN7q0IQhc=;
	b=PnDjx1Uf9mJzKzURm5Jg2Fip/0cAySoei08af5IaCIuYrUUSNTl1h93UDyQgWVYvvhyw
	 0vSW3fB+XplcY4uKJXuqKZT5KUmC4T3RNOlXaRqusQYjExbxvEfY6MLBwmmpQLriEFD2E
	 pvJAMfkdrUKtiUPPXXTlwd+k32lZROrim77MtAqTWncwVawcznC58l4hyqPi3kSUjL2Sy
	 0sUmUBXg5/eAaWJRh+XLoeVRgfGKLscUPqZ66p+OqoR5jMuvQl4KrbKQ4iBMR3olfIN3W
	 vbacy36YBtKy8/2CN8wToj5pggYlFk1xlwN7I/jiBT0d7x/0isO2OT0XgpnnTIEyZvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WZ3JLNmu;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD31606A689
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD31606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WZ3JLNmu
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b3a348a6dbso4120976c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 14:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795559489; x=1796164289; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCYdaX+gGCR9rqh1M6R/ZEIGIvsxPuaht+HN7q0IQhc=;
        b=WZ3JLNmudUfCbE8ABKetbbZ26ZeH89ln9BChxr1T+0iX1fx3sir9CcUCOoKampzTW4
         5heA+sNstFyl5KruD1SqlVCuOgRLfWJOOSCZbwBiEFeWIA/tHs3VjQZv7cJXPjoTTsCA
         NDLmMfwJESdvICPW4ON5PRXmDBIeUU2nxV2KV77RlFiTUkqiLNP8nCi4tvb9kBZkxDHv
         x+si1GaF0yuS1k1AEWYtMrkDyeSp26aRatEOwE8FPHXtivReRpfFtOQzH6MQaJpOrrUT
         nxUFo7M686UNkFoK5fyw2eHZAMctTSNxsJXjROFbWBuPEK/VeTl0P4kNSYnyDjTuZJAz
         V8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795559489; x=1796164289;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QCYdaX+gGCR9rqh1M6R/ZEIGIvsxPuaht+HN7q0IQhc=;
        b=0NltlK2GXOX2YfAxZTpSPZFsd+3sXVZKDndQzqWfQr5tvGyZYS32dwDQzkM9Du1pCr
         YWdg4lN6Io/sdps7Q0pIFZWKnzk4XaJKYePCjERYJn7zFJ8UA+fHU36ySHtNzc7BFbGm
         or0IXmYY2/EY8/wPeDP+2F62VW5Wu4BNQ8/Y85TE21Ua+jq6yU325wb3Vi53jWqWvN+h
         AmaqVuj8Ms65dotG737GIL+rH4qYb8artjxC0QcpBwB445ZaDSqxBq0fKvwrykq+UNbg
         4cd+cxZMRUQL6KlcVYfWOEIFqulVDqTT44Ce9UasmXW8BhK2s3HMA2gajufLkPi5Pjgg
         GtLA==
X-Forwarded-Encrypted: i=1; AL+hErHvao75inTXJqAVicrQ/h3fw6+sn9I4+v7vLvWPMaWVQr1NhP6nWeIQvLKyhq6YgWdOzb33K6cvziLKJm3H2wFm@vger.kernel.org
X-Gm-Message-State: APuU4Z9hgq59NbqrIA6BUCCGUDqIa334mGzPLnE/2452+0zF8dAqNnlQ
	k8207M0LXA2hsqdiuJrUcWMOmrMWr1YdHfRbJC33I6uzy/KDgeFBnAKBnPsjBwt8n2joXKyYSDs
	1djQbF+6r+w==
X-Received: from dyvo9-n1.prod.google.com ([2002:a05:693c:41c9:10b0:36a:16ac:9308])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8083:b0:376:6530:248f
 with SMTP id 5a478bee46e88-38570a3717dmr19047233eec.24.1795559488396; Tue, 24
 Nov 2026 14:31:28 -0800 (PST)
Date: Tue, 24 Nov 2026 14:31:05 -0800
In-Reply-To: <20261124223109.820609-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124223109.820609-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124223109.820609-9-irogers@google.com>
Subject: [PATCH v10 08/12] perf dso: Add dso__shrink() and dso__try_evict()
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add per-DSO memory shrinking and unreferenced DSO eviction helpers:
- dso__shrink(): Without blocking on contended locks, closes cached DSO
  data file descriptors, frees cached 4KB data pages, addr2line handles,
  and libdw DWARF contexts. When a reloadable user DSO in a dsos
  collection has no external references (refcnt == 1) and no annotated
  symbols or inlines, evicts its symbol table via
  symbols__try_delete_unannotated() and marks dso->loaded false so it
  reloads on demand; otherwise calls symbols__shrink().
- dso__try_evict(): Evicts an unreferenced user DSO (refcnt == 1, no
  symbols, not kernel/vDSO/hit/header_build_id, and not on
  dso__data_open) without blocking on locks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 215 +++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/dso.h |   9 ++
 2 files changed, 222 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 83611d7ccaff..b6217c49dd14 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -17,6 +17,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 
+#include "annotate.h"
 #include "annotate-data.h"
 #include "auxtrace.h"
 #include "compress.h"
@@ -1874,7 +1875,7 @@ struct dso *dso__new(const char *name)
 	return dso__new_id(name, NULL);
 }
 
-void dso__delete(struct dso *dso)
+static void __dso__delete(struct dso *dso, bool close_data)
 {
 	if (dso__dsos(dso))
 		pr_err("DSO %s is still in rbtree when being deleted!\n", dso__long_name(dso));
@@ -1896,7 +1897,8 @@ void dso__delete(struct dso *dso)
 		RC_CHK_ACCESS(dso)->long_name_allocated = false;
 	}
 
-	dso__data_close(dso);
+	if (close_data)
+		dso__data_close(dso);
 	auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
 	dso_cache__free(dso);
 	dso__free_a2l(dso);
@@ -1908,6 +1910,215 @@ void dso__delete(struct dso *dso)
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
index 70a121fd7ecd..b0ee45a53f40 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -789,6 +789,15 @@ static inline bool dso__has_symbols(const struct dso *dso)
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
-- 
2.56.1.831.g720f3f5937-goog

