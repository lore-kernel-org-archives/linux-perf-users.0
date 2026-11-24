Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490978;
	b=gsKWzjiVSfXzgutdSIs9AjCOckaisc1DV1NIXOpOIxIZMoGhZjhEfr7VMs92hjWnm9J2
	 paE9cBypuxWOmeqIa5VInWsJZhNgpK1ncl2OkVKYEMCRL5SiOSEcfWIu6JmAYV3fk0ShK
	 ozulsuFbmMHU7eDLp8PF70CU8C8/I8sK3v7TZZmp0TgYFlGs8U9l7fn4d7pCLET42bM6X
	 MQB7eK5uPs9x1izORGoVyUJyXoacfvDO4cVplyXWcxzsh7FVhmJXmLx8S3YkSU2G6LSwO
	 uPiUBCrB5qHnBMla5X0FOG1ik2qcwmRmHvt58sbG0NyMfqZ+c+UAahYz/FJOMePOOBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=HcjBsddpqd/V5XcUMYQq5yvXHNPx3bXbpQNp1l6u9Yk=;
	b=MBCFbQPhf1twOrHSe5qMpqHrDije2zz+0EjBiSd+Vdcukb0k8pGzBe/XT/LcDrpRqsOy
	 WP4i75xFMfY+/LswHeYAa6WCapEpzXdqVuc6vESh9hJIUh81rNCRCEh7R9/azgO0rWAAl
	 Oe9xctQud8wVA0p1B+eNNeaEkc+pHe+vszy5pKO171sk6VkjCouE9ugtXVF+IzKx1+V7L
	 bqCdbrk2oNNT3Z2jAN+x+NJuyzA3KSxY0deAqpCEgdsrdmJpjOTibgY4kyGqnCrUEbFvh
	 EDGC1vSEEmSzsbKAzF+irwkhf6Ib8oYooHGi4X4WWjnKVG962zuUyqBTs8H8Z1prDgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KDR8PLyD;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16375606A322
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16375606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KDR8PLyD
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-386177b0516so10788688eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 19:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795490977; x=1796095777; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HcjBsddpqd/V5XcUMYQq5yvXHNPx3bXbpQNp1l6u9Yk=;
        b=KDR8PLyD4WaWpooJbg8Gdfw4g6IH/BtHoRSKltWovSiAf3b5IfwJM1ju2FeEXbUH/j
         /A4NdOt7edjZlchI9vVK0GalNKhm+k4QOYG3nVCTAf1xaJQ2VZLV/+dTW92LhQLLBEYE
         TwPNMFCiS0wyJrdsi0Rib4BNlTi8nfymIRHCMD00vTHSD4KBxaPahAd+wh5UmtXYnPKT
         gspATMMop+E9zYb92dJx9wqa792Fpni0fWgETo4IsTN11AaPOl8AU+jjtaOUWlNwwNmA
         fBdLzSf3r80FrKDFXP+LOW8qfL93m6rFxThgYiwytrte4TdWlVTBPJrgR5CEIruEgpvd
         N2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490977; x=1796095777;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HcjBsddpqd/V5XcUMYQq5yvXHNPx3bXbpQNp1l6u9Yk=;
        b=H5hax7jm8xO1JSB3zmzQy+KdgjKiO1LHLoV2zm376L9fH5v16GStlXj+6Wvx3HG9m9
         w+/nlZfNBUwtXx6GFpiBBENa0CyXp0coMOq6ZbQPqjpaeaPlJUzhlCX41ILpLnqSBL/B
         AMbubd9vX/woyPFH5U3YmQxadhTySzuGKeWPS35Y2oIK5pH5nNLgy8Ee8cYB6gSBn+EV
         cNpFqr7X6PcSnPuOggfPOWW4mGZ7Ew/KQ4hdkiHoOXZTUXSNsiuUueWB9aNiL8oKBbeM
         vudjSAWM8Lz+c8eIc1RRoiYea+1dpnH6eMJDeqO281GHv2L+JpefmSr2ZgWLpmEgbSWQ
         xoPw==
X-Forwarded-Encrypted: i=1; AL+hErFKUxcu7luFdzbC4hT4lMonRqdX6ADBvLV1XrjmMPMVE6X6Y/lbl/E2QmroZlZGpA+jffxD8IKfO0WbXvYYL6AW@vger.kernel.org
X-Gm-Message-State: APuU4Z/SBXzuEg7QEjxPxtA19YEFpprQZ3jLlxOk48W8uE3BWaerzY+R
	H90qdffBlyZZOgPl98BtNXBIbZ2AloRoavfR2zAe0YKf+ENvLOIGm9Sf871ibBVBgw9xKb8ghA3
	BSlAuHLVUpA==
X-Received: from dlgx14-n2.prod.google.com ([2002:a05:701a:ccce:20b0:184:6cc9:b13c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea21:b0:1b3:b6d3:b91c
 with SMTP id a92af1059eb24-1b5568b3149mr16361629c88.7.1795490976837; Mon, 23
 Nov 2026 19:29:36 -0800 (PST)
Date: Mon, 23 Nov 2026 19:28:58 -0800
In-Reply-To: <20261124032902.3859564-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124032902.3859564-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124032902.3859564-8-irogers@google.com>
Subject: [PATCH v9 07/11] perf dso: Add dso__shrink() and dso__try_evict()
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
2.56.1.809.ga0b61035b5-goog

