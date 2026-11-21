Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245457;
	b=YJ0V79jqIcZiUn5f+Y2vLuLiNQRvoN7MzT1LTdTMuzMOO7G2O7430A6RKEdNi1eV9Edg
	 SqXCmdAFxXV1JQsHMFODpslpA7nDFzxODqyQMLzEw56+M/mnMjLpvE7mVjKQFeUdDx2Bx
	 yXQDJI4+5hmw2e6Yxr+9FSFm++PK7pBk+bTwU2nIPV/LjuVKDkPZ09uWKnOe6dvfDmb5e
	 cXWMJyfV1LPsRXkEk9bAtnMYMlnJV8pJhcJNNzfTPn7J4x1StLA84oGSzLe8KdhPXakGE
	 Uca9uq2L6FE3gxs6z5fJosHtmhCXNdcHtEeXlOpc/rYL0gevkOZh/eEqs2R73ZwKCBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=z8CY15Gprx3qAa91v18mazjQ/jM3l/w10b3dAf+R8yc=;
	b=d28N3CfXbSgkIswfHf2rxfKnF0mjthDhpbaaZ7rM4YdcOgJmbtwyn+y2gV8WTACLhqHp
	 gQX1T+Wf5D2yxXtUjoNQaqkZDZGOmDQvMVjG0KieV3oF5k35BJRj6M/79rjxW3RrjxwhF
	 Mld7E8LU1R8obbBs51D1UcfjmRUTzB5I86on35PqW9E3OFSZ8muj5kA9NKot1dxU+J5mr
	 9vhUhd8tWHAwtqAfls0PonLmugv1XloQqzjFA/JXDwcsJL5Em0vPIq0SRkjIirBUQuI+K
	 L3Z4Wv5B3OtgLK1SvCJ++aRYSstEC91vTQR1+PdMzFgemhQRTSADqtjzgi4LdNwKnIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kbh7J+FQ;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0919606A337
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 07:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0919606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kbh7J+FQ
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b3b5b49cabso1553069c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 23:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795245456; x=1795850256; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z8CY15Gprx3qAa91v18mazjQ/jM3l/w10b3dAf+R8yc=;
        b=kbh7J+FQh1351w97Kw9yHnZRj4xNyr49hvYK6BP0n8lx4bFMvmRA3Fb6Gzf5kUt5Qu
         cc24Orx3kHFWjIgCO6M4RE2Eys/sDtmJMPA9I43xueNrNye8e2D1TtEy79MIQbH15pPF
         F8YzXx5w98KxqNpEys6VA4gn6uP7zHX3MyC+hiHwGMisHv2HUiDOR4pRgrNjZgeS3VGH
         RBdRUvdXM4THdCvkfJlnS67oVcuMo+Zat2ljdVA1Rk0tShzC4fXUGnFZZ11lYKUpAGMu
         TeEsVdL4/nVW9/NHzfUSDaDwPZrdAHeaiOPphgg33N5qlGON+UFdrS/EwzHq22+/GSaZ
         0LUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245456; x=1795850256;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z8CY15Gprx3qAa91v18mazjQ/jM3l/w10b3dAf+R8yc=;
        b=Pd31MCt53tUjXQce93s4LBL7N+klxsptOGaUlApZqwvPnzlKnn5YImIr6QsDUQZArF
         RtRuQhDU0FkpK4Y9r6jIzhlwh/cvVaYEMz8RfoAs9cUYvMWEYnwFnvbdaspOwadfs/9m
         WNuHWze+LW4d6o7mHYCm2TcodjXCCEUbiiTjwVMkqMe48pfzFX7+UMJSk0I6jBSeGQIs
         oYx0vhWbEyM7hMNloctnqwnzR43zwXp3jIy5iaFw6QolVK45+mJDIzzMwv7bv2xnAbfV
         uqDHuS+zF2rVccy+XmzpF2IWmkUo1nFn9Fq0yjOCkxN3esVTQEa9pLuN3csWLIsSaBv+
         Wf3Q==
X-Forwarded-Encrypted: i=1; AL+hErGUiCtF+YJNcZ3WAs+h6RAg7hnuW27Fg0011gzk5uU3aO2GzLS8/64tHAMpXmcqNm+tCU1XNGr16olve9jLTb3N@vger.kernel.org
X-Gm-Message-State: APuU4Z+DiZZi8I627kEkY9lotRSThrsX5TNRjfmOTNgL+sFpUMVf1mCM
	18R9TtYHjWoGkM39WK/jU4LaP/Y7pkPpJHd8lSGrBiHNSONnB8rjZJ4IRQXzOtPjtWPJCvyiUHN
	ksHXBLfUi6A==
X-Received: from dycpq22.prod.google.com ([2002:a05:7301:fd16:b0:385:2e0b:4776])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f68e:b0:36c:a42d:9bc9
 with SMTP id 5a478bee46e88-3857015357fmr5254745eec.25.1795245455453; Fri, 20
 Nov 2026 23:17:35 -0800 (PST)
Date: Fri, 20 Nov 2026 23:16:49 -0800
In-Reply-To: <20261121071651.67118-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121071651.67118-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121071651.67118-9-irogers@google.com>
Subject: [PATCH v7 08/10] perf symbol: Add memory shrinking for symbols, DSOs,
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
 tools/perf/util/dso.c     | 311 ++++++++++++++++++++++++++++++++++----
 tools/perf/util/dso.h     |  14 +-
 tools/perf/util/dsos.c    |  50 ++++++
 tools/perf/util/dsos.h    |   2 +
 tools/perf/util/machine.c |  29 ++++
 tools/perf/util/machine.h |   3 +
 tools/perf/util/session.c |   8 +
 tools/perf/util/session.h |   2 +
 tools/perf/util/symbol.c  |  67 +++++++-
 tools/perf/util/symbol.h  |   3 +
 10 files changed, 455 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 3d7db37ff095..0d205015c6dc 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2,6 +2,7 @@
 #include "dso.h"
 
 #include <errno.h>
+#include <stdatomic.h>
 #include <stdlib.h>
 
 #include <asm/bug.h>
@@ -15,6 +16,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 
+#include "annotate.h"
 #include "annotate-data.h"
 #include "auxtrace.h"
 #include "compress.h"
@@ -552,17 +554,20 @@ static void dso__list_add(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_o
 	dso__data_open_cnt++;
 }
 
-static void dso__list_del(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+static struct dso *dso__list_del(struct dso *dso)
+	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
+	struct dso *put_dso = NULL;
+
 	list_del_init(&dso__data(dso)->open_entry);
 #ifdef REFCNT_CHECKING
-	mutex_unlock(dso__data_open_lock());
-	dso__put(dso__data(dso)->dso);
-	mutex_lock(dso__data_open_lock());
+	put_dso = dso__data(dso)->dso;
+	dso__data(dso)->dso = NULL;
 #endif
 	WARN_ONCE(dso__data_open_cnt <= 0,
 		  "DSO data fd counter out of bounds.");
 	dso__data_open_cnt--;
+	return put_dso;
 }
 
 static void close_first_dso(void);
@@ -729,13 +734,26 @@ static int open_dso(struct dso *dso, struct machine *machine)
 	return fd;
 }
 
+static struct dso *__close_data_fd(struct dso *dso)
+	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+{
+	if (dso__data(dso)->fd < 0)
+		return NULL;
+
+	close(dso__data(dso)->fd);
+	dso__data(dso)->fd = -1;
+	dso__data(dso)->file_size = 0;
+	return dso__list_del(dso);
+}
+
 static void close_data_fd(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
-	if (dso__data(dso)->fd >= 0) {
-		close(dso__data(dso)->fd);
-		dso__data(dso)->fd = -1;
-		dso__data(dso)->file_size = 0;
-		dso__list_del(dso);
+	struct dso *put_dso = __close_data_fd(dso);
+
+	if (put_dso) {
+		mutex_unlock(dso__data_open_lock());
+		dso__put(put_dso);
+		mutex_lock(dso__data_open_lock());
 	}
 }
 
@@ -828,9 +846,12 @@ static void check_data_close(void) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock
  */
 void dso__data_close(struct dso *dso)
 {
+	struct dso *put_dso;
+
 	mutex_lock(dso__data_open_lock());
-	close_dso(dso);
+	put_dso = __close_data_fd(dso);
 	mutex_unlock(dso__data_open_lock());
+	dso__put(put_dso);
 }
 
 static int dso__find_binary_type_locked(struct dso *dso)
@@ -1075,12 +1096,12 @@ static int bpf_size(struct dso *dso)
 #endif // HAVE_LIBBPF_SUPPORT
 
 static void
-dso_cache__free(struct dso *dso)
+__dso_cache__free(struct dso *dso)
+	EXCLUSIVE_LOCKS_REQUIRED(dso__lock(dso))
 {
 	struct rb_root *root = &dso__data(dso)->cache;
 	struct rb_node *next = rb_first(root);
 
-	mutex_lock(dso__lock(dso));
 	while (next) {
 		struct dso_cache *cache;
 
@@ -1089,6 +1110,13 @@ dso_cache__free(struct dso *dso)
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
 
@@ -1243,27 +1271,30 @@ static struct dso_cache *dso_cache__populate(struct dso *dso,
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
@@ -1803,7 +1834,7 @@ int dso__name_len(const struct dso *dso)
 
 bool dso__loaded(const struct dso *dso)
 {
-	return RC_CHK_ACCESS(dso)->loaded;
+	return atomic_load_explicit(&RC_CHK_ACCESS(dso)->loaded, memory_order_acquire);
 }
 
 bool dso__sorted_by_name(const struct dso *dso)
@@ -1835,7 +1866,7 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->binary_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->dbginfo_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->is_64_bit = (sizeof(void *) == 8);
-		dso->loaded = 0;
+		atomic_init(&dso->loaded, false);
 		dso->rel = 0;
 		dso->has_srcline = 1;
 		dso->a2l_fails = 1;
@@ -1862,7 +1893,7 @@ struct dso *dso__new(const char *name)
 	return dso__new_id(name, NULL);
 }
 
-void dso__delete(struct dso *dso)
+static void __dso__delete(struct dso *dso, bool close_data)
 {
 	if (dso__dsos(dso))
 		pr_err("DSO %s is still in rbtree when being deleted!\n", dso__long_name(dso));
@@ -1884,7 +1915,8 @@ void dso__delete(struct dso *dso)
 		RC_CHK_ACCESS(dso)->long_name_allocated = false;
 	}
 
-	dso__data_close(dso);
+	if (close_data)
+		dso__data_close(dso);
 	auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
 	dso_cache__free(dso);
 	dso__free_a2l(dso);
@@ -1896,6 +1928,222 @@ void dso__delete(struct dso *dso)
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
+	NO_THREAD_SAFETY_ANALYSIS
+{
+	size_t freed = 0;
+
+	if (!dso)
+		return 0;
+
+	if (mutex_trylock(dso__data_open_lock())) {
+		struct dso *put_dso = NULL;
+
+		if (dso__data(dso)->fd >= 0) {
+			put_dso = __close_data_fd(dso);
+			freed++;
+		}
+		mutex_unlock(dso__data_open_lock());
+		dso__put(put_dso);
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
+	NO_THREAD_SAFETY_ANALYSIS
+{
+	bool can_evict;
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
+	if (!mutex_trylock(dso__data_open_lock()))
+		return false;
+
+	can_evict = dso__data(dso)->fd < 0 &&
+		    list_empty(&dso__data(dso)->open_entry) &&
+		    refcount_read(dso__refcnt(dso)) == 1 &&
+		    mutex_trylock(dso__lock(dso));
+	if (can_evict) {
+		if (dso__has_symbols(dso) || dso__has_annotated_inlines(dso))
+			can_evict = false;
+		mutex_unlock(dso__lock(dso));
+	}
+	mutex_unlock(dso__data_open_lock());
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
@@ -1909,7 +2157,8 @@ struct dso *dso__get(struct dso *dso)
 void dso__put(struct dso *dso)
 {
 #ifdef REFCNT_CHECKING
-	if (dso && dso__data(dso) && refcount_read(&RC_CHK_ACCESS(dso)->refcnt) == 2)
+	if (dso && dso__data(dso) && dso__data(dso)->fd >= 0 &&
+	    refcount_read(&RC_CHK_ACCESS(dso)->refcnt) == 2)
 		dso__data_close(dso);
 #endif
 	if (dso && refcount_dec_and_test(&RC_CHK_ACCESS(dso)->refcnt))
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 85880f49ddac..0a8df19383e8 100644
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
@@ -346,7 +347,7 @@ DECLARE_RC_STRUCT(dso) {
 	u8		 is_64_bit:1;
 	u8		 bintype_searched:1;
 	u8		 debuginfo_searched:1;
-	bool		 loaded;
+	_Atomic bool	 loaded;
 	u8		 rel;
 	char		 name[];
 };
@@ -602,7 +603,7 @@ static inline enum dso_load_errno *dso__load_errno(struct dso *dso)
 
 static inline void dso__set_loaded(struct dso *dso)
 {
-	RC_CHK_ACCESS(dso)->loaded = true;
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->loaded, true, memory_order_release);
 }
 
 static inline struct mutex *dso__lock(struct dso *dso)
@@ -783,6 +784,15 @@ static inline bool dso__has_symbols(const struct dso *dso)
 	return RC_CHK_ACCESS(dso)->symbols.cnt > 0;
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
index e927e707abac..52d80219ac2f 100644
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
@@ -493,3 +496,50 @@ int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data)
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
index a26774950866..151efdba2aa4 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -49,4 +49,6 @@ struct dso *dsos__find_kernel_dso(struct dsos *dsos);
 
 int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data), void *data);
 
+size_t dsos__shrink(struct dsos *dsos);
+
 #endif /* __PERF_DSOS */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e8a3d8095346..60eed6ae3ba1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3441,3 +3441,32 @@ int machine__hit_all_dsos(struct machine *machine)
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
index 80191545ee8a..0f4c0ae5b56d 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -338,4 +338,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 
 int machine__hit_all_dsos(struct machine *machine);
 
+size_t machine__shrink(struct machine *machine);
+size_t machines__shrink(struct machines *machines);
+
 #endif /* __PERF_MACHINE_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a58b4fe44b62..d5cb5e94a54a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -4266,3 +4266,11 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
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
index 0eaeced63cd4..6e2c5c16cda0 100644
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
@@ -254,6 +255,68 @@ void symbols__exit(struct symbols *symbols)
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
@@ -2382,8 +2445,9 @@ int dso__load(struct dso *dso, struct map *map)
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
 		ret = 1;
-		goto out;
+		goto out_unlock;
 	}
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->loaded, false, memory_order_release);
 
 	kmod = dso__is_kmod(dso);
 
@@ -2541,6 +2605,7 @@ int dso__load(struct dso *dso, struct map *map)
 		ret = 0;
 out:
 	dso__set_loaded(dso);
+out_unlock:
 	mutex_unlock(dso__lock(dso));
 	nsinfo__mountns_exit(&nsc);
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index dfdcf026a8c1..687747661dd3 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -139,6 +139,9 @@ void symbol__delete(struct symbol *sym);
 void symbols__init(struct symbols *symbols);
 void symbols__exit(struct symbols *symbols);
 void symbols__delete(struct symbols *symbols);
+bool symbols__try_delete_unannotated(struct symbols *symbols,
+				     void (*pre_delete)(void *ctx), void *ctx);
+size_t symbols__shrink(struct symbols *symbols);
 void symbols__sort_read_lock(struct symbols *symbols) SHARED_LOCK_FUNCTION(symbols->lock);
 
 static inline u8 symbol__type(const struct symbol *sym)
-- 
2.56.1.750.gf70dc682cf-goog

