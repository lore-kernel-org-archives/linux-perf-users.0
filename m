Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A7469832
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581985; cv=none; b=W2a/intJpQFZaus9tKBxD6X9Sm5T4v0iaJRHNZLKknlOTsh5OTS17bXDBVF74VSQv409F9IPu7xo8+OBq/V0pRhAgxaNhockadW5hk1Xq33fNu3Bmwhy0P9JjIK60qrZiHIyU0+/qrojfVozkFwdnzkeag5F+0BnhSTLAwQtA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581985; c=relaxed/simple;
	bh=VvlU7SOiURqzvNRQqaiy1ssfqIqpEzDaOWwuptG6W08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EhzQwgcTv5qrQ3ZWbDHesyWl77BJz2ID4Jig/nZUBIfACHL8GjNh5fBTQYNCwrWLRf0Wejd4BMWEKHW5+2U7VA7OsGX8A3rV3/iQQXpt9Sh9Pe4kFetj20Gt9W+HAk9uq7HyGeZv2NB/awTo9qoSGj5X9UGxwc5l58tVMPgzqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qD+VnoJ/; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qD+VnoJ/"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3282d5302ffso4815599eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 00:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790581980; x=1791186780; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t4PpGfIvlec/gBnT+F6OV7P9QZUTCFkr8OXrOwdVD8k=;
        b=qD+VnoJ/Nxa4rtSFmUgJZZDvFLKcR38dRQ/naIyekYcXHjmcXxIM0+jBHH6alySmuj
         uNNQNOK2i6Yi63E7WGFTm08YnjYJWNHolu3Bc2vJp3DHkTd4h66g3uCv7//5TA4ZP1Af
         JGyiV1+T8ryDpYhGvMI4i4KJirIBjLIxOOYkh/t/Ak8Xlnq4eHB/Z08l4VtJDNRiNJsI
         IDJgye//HKWPqpnnQGw9kSPsxU1cIpfnalJgU+9yxSU8THAQLCzGpUfSpKihXsMi8lJf
         6AOMiDq/GDVrwHvrULCJr7N7xKrrepvfeZ1byBgo4rXMRhacn9xCxzF5VITwLQ5K8sg+
         gT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581980; x=1791186780;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4PpGfIvlec/gBnT+F6OV7P9QZUTCFkr8OXrOwdVD8k=;
        b=J9SQkFd7lUwCTL5LKNOpgwwDUxiKzhdqt9CfI8QQRCy5w0lVyjk8gRZfQy71wSx5Wd
         rSE/IvudMrhlePbST3StLqpjX1cdvz/AxZJ15r8OoaVT9oPL2BCNYezPeRWd4HdPgZG4
         //cQp50pdXwHKY0nbbomWoDzLP03w1DWZ+wkI3WVDfWTPTOurkd6glQpzSEZD2TVaV4K
         0xPeJHRNBNAHyXnRXimhsRJEwdmASbqyJbo0+jMrrsLkAr5P3qvBD8q0fWGQdbwnYJG9
         LMdTw1HniwaddVojujGZHw2yZh3i+EFcJQejcVgFGtjk/HODdtnwh+eiGHSnmdXBOkBw
         vFsg==
X-Forwarded-Encrypted: i=1; AKwUvBxwF2lvtEuqGdrJqYVr44ZMvbTePfrrDdfxOU7OLpOQw1bZRXEJuNEnqp3arCJIc+ryteEwhKG1gMWkkTJei9Rb@vger.kernel.org
X-Gm-Message-State: AFq9FYKbdn8hT0lKKhzfB7p3iHA5PDJMn9ffzEEDf+t9spzrdvXXyWc9
	ULU4SdQgTKe61xeyke/3UitjcrPKGWlkgEYmAd4J9r2q0AJTnnS9XMDtBC6i10Ebe5qU/4Ld/zU
	F3QLLLoH68g==
X-Received: from dyc7.prod.google.com ([2002:a05:693c:6407:b0:33e:4672:13c0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2324:b0:340:f5ba:9670
 with SMTP id 5a478bee46e88-342709b321bmr7882748eec.1.1790581979018; Mon, 28
 Sep 2026 00:52:59 -0700 (PDT)
Date: Mon, 28 Sep 2026 00:52:35 -0700
In-Reply-To: <20260928075237.3055101-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928075237.3055101-6-irogers@google.com>
Subject: [PATCH v1 5/7] perf symbol: Add LRU memory shrinking for symbols,
 DSOs, and machines
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alireza Haghdoost <haghdoost@uber.com>
Content-Type: text/plain; charset="UTF-8"

Add Clock/Second-Chance LRU access tracking (SYMBOL_FLAG_ACCESSED on
struct symbol, accessed on struct dso, and shrunk on struct symbols) and
memory-shrinking helpers (symbols__shrink, dso__can_shrink_symbols,
dso__shrink, dsos__shrink, machine__shrink, machines__shrink, and
perf_session__shrink):

- symbols__shrink() scans a symbol table under symbols->lock: symbols
  with refcnt > 1 are retained, symbols with SYMBOL_FLAG_ACCESSED set
  have their accessed bit cleared (second chance), and unreferenced
  symbols with SYMBOL_FLAG_ACCESSED clear are evicted. When symbols are
  evicted, symbols->shrunk is set under symbols->lock and the backing
  array is compacted when occupancy drops below 50%.
- dso__shrink() closes any cached file descriptor, frees cached 4KB DSO
  data pages (__dso_cache__free()) and addr2line/libbfd/libdw state
  under dso__lock(dso), and shrinks dso->symbols if the DSO supports
  idempotent on-demand reloading (dso__can_shrink_symbols()). Protect
  dso_cache lookup and memcpy under dso__lock(dso) so concurrent
  shrinking cannot free a cache page while it is being read.
- dsos__shrink() sweeps a DSO collection using Clock/Second-Chance LRU:
  accessed DSOs have their symbol tables shrunk and their accessed bit
  cleared; unaccessed DSOs are fully shrunk via dso__shrink() and
  evicted from struct dsos if unreferenced outside the collection
  (refcnt == 1) and free of unreloadable state.
- When a DSO's symbol table has been shrunk (dso__symbols_shrunk(dso) is
  true) and a subsequent symbol lookup misses in map__find_symbol() or
  map__find_symbol_by_name_idx(), transparently reload the DSO on demand
  while preferring actively referenced (refcnt > 1) symbols in
  choose_best_symbol() and deduplicating identical (start, name) pairs
  in symbols__fixup_duplicate() even when symbol_conf.allow_aliases is
  enabled.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c        | 182 +++++++++++++++++++++++++++--------
 tools/perf/util/dso.h        |  46 +++++++++
 tools/perf/util/dsos.c       | 100 +++++++++++++++++++
 tools/perf/util/dsos.h       |  12 ++-
 tools/perf/util/machine.c    |  39 ++++++++
 tools/perf/util/machine.h    |   2 +
 tools/perf/util/map.c        |  26 ++++-
 tools/perf/util/session.c    |  15 +++
 tools/perf/util/session.h    |   3 +
 tools/perf/util/symbol-elf.c |   5 +-
 tools/perf/util/symbol.c     | 142 +++++++++++++++++++++++++--
 tools/perf/util/symbol.h     |  36 +++++--
 12 files changed, 551 insertions(+), 57 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 1b96853164be..330e43cc325b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -877,6 +877,7 @@ bool dso__data_get_fd(struct dso *dso, struct machine *machine, int *fd)
 	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR)
 		return false;
 
+	dso__set_accessed(dso, true);
 	mutex_lock(dso__data_open_lock());
 
 	try_to_open_dso(dso, machine);
@@ -955,12 +956,11 @@ static int bpf_size(struct dso *dso)
 #endif // HAVE_LIBBPF_SUPPORT
 
 static void
-dso_cache__free(struct dso *dso)
+__dso_cache__free(struct dso *dso)
 {
 	struct rb_root *root = &dso__data(dso)->cache;
 	struct rb_node *next = rb_first(root);
 
-	mutex_lock(dso__lock(dso));
 	while (next) {
 		struct dso_cache *cache;
 
@@ -969,6 +969,13 @@ dso_cache__free(struct dso *dso)
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
 
@@ -998,7 +1005,7 @@ static struct dso_cache *__dso_cache__find(struct dso *dso, u64 offset)
 }
 
 static struct dso_cache *
-dso_cache__insert(struct dso *dso, struct dso_cache *new)
+__dso_cache__insert(struct dso *dso, struct dso_cache *new)
 {
 	struct rb_root *root = &dso__data(dso)->cache;
 	struct rb_node **p = &root->rb_node;
@@ -1006,7 +1013,6 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 	struct dso_cache *cache;
 	u64 offset = new->offset;
 
-	mutex_lock(dso__lock(dso));
 	while (*p != NULL) {
 		u64 end;
 
@@ -1019,16 +1025,13 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 		else if (offset >= end)
 			p = &(*p)->rb_right;
 		else
-			goto out;
+			return cache;
 	}
 
 	rb_link_node(&new->rb_node, parent, p);
 	rb_insert_color(&new->rb_node, root);
 
-	cache = NULL;
-out:
-	mutex_unlock(dso__lock(dso));
-	return cache;
+	return NULL;
 }
 
 static ssize_t dso_cache__memcpy(struct dso_cache *cache, u64 offset, u8 *data,
@@ -1082,68 +1085,69 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 	return ret;
 }
 
-static struct dso_cache *dso_cache__populate(struct dso *dso,
-					     struct machine *machine,
-					     u64 offset, ssize_t *ret)
+static ssize_t dso_cache__populate(struct dso *dso, struct machine *machine,
+				   u64 offset, u8 *data, ssize_t size, bool out)
 {
 	u64 cache_offset = offset & DSO__DATA_CACHE_MASK;
 	struct dso_cache *cache;
 	struct dso_cache *old;
+	ssize_t ret;
 
 	cache = zalloc(sizeof(*cache) + DSO__DATA_CACHE_SIZE);
-	if (!cache) {
-		*ret = -ENOMEM;
-		return NULL;
-	}
+	if (!cache)
+		return -ENOMEM;
 #ifdef HAVE_LIBBPF_SUPPORT
 	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
-		*ret = bpf_read(dso, cache_offset, cache->data);
+		ret = bpf_read(dso, cache_offset, cache->data);
 	else
 #endif
 	if (dso__binary_type(dso) == DSO_BINARY_TYPE__OOL)
-		*ret = DSO__DATA_CACHE_SIZE;
+		ret = DSO__DATA_CACHE_SIZE;
 	else
-		*ret = file_read(dso, machine, cache_offset, cache->data);
+		ret = file_read(dso, machine, cache_offset, cache->data);
 
-	if (*ret <= 0) {
+	if (ret <= 0) {
 		free(cache);
-		return NULL;
+		return ret;
 	}
 
 	cache->offset = cache_offset;
-	cache->size   = *ret;
+	cache->size   = ret;
 
-	old = dso_cache__insert(dso, cache);
+	mutex_lock(dso__lock(dso));
+	old = __dso_cache__insert(dso, cache);
 	if (old) {
 		/* we lose the race */
 		free(cache);
 		cache = old;
 	}
+	ret = dso_cache__memcpy(cache, offset, data, size, out);
+	mutex_unlock(dso__lock(dso));
 
-	return cache;
-}
-
-static struct dso_cache *dso_cache__find(struct dso *dso,
-					 struct machine *machine,
-					 u64 offset,
-					 ssize_t *ret)
-{
-	struct dso_cache *cache = __dso_cache__find(dso, offset);
-
-	return cache ? cache : dso_cache__populate(dso, machine, offset, ret);
+	return ret;
 }
 
+/*
+ * Look up and copy cached DSO data while holding dso__lock(dso) so a
+ * concurrent dso__shrink() / __dso_cache__free() cannot free the cache node
+ * while it is being read.
+ */
 static ssize_t dso_cache_io(struct dso *dso, struct machine *machine,
 			    u64 offset, u8 *data, ssize_t size, bool out)
 {
 	struct dso_cache *cache;
-	ssize_t ret = 0;
+	ssize_t ret;
 
-	cache = dso_cache__find(dso, machine, offset, &ret);
-	if (!cache)
+	mutex_lock(dso__lock(dso));
+	cache = __dso_cache__find(dso, offset);
+	if (cache) {
+		ret = dso_cache__memcpy(cache, offset, data, size, out);
+		mutex_unlock(dso__lock(dso));
 		return ret;
+	}
+	mutex_unlock(dso__lock(dso));
 
-	return dso_cache__memcpy(cache, offset, data, size, out);
+	return dso_cache__populate(dso, machine, offset, data, size, out);
 }
 
 /*
@@ -1157,6 +1161,7 @@ static ssize_t cached_io(struct dso *dso, struct machine *machine,
 	ssize_t r = 0;
 	u8 *p = data;
 
+	dso__set_accessed(dso, true);
 	do {
 		ssize_t ret;
 
@@ -1723,6 +1728,7 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->is_kmod = 0;
 		dso->needs_swap = DSO_SWAP__UNSET;
 		dso->comp = COMP_ID__NONE;
+		atomic_init(&dso->accessed, false);
 		mutex_init(&dso->lock);
 		refcount_set(&dso->refcnt, 1);
 		data = &dso->data;
@@ -1776,6 +1782,106 @@ void dso__delete(struct dso *dso)
 	RC_CHK_FREE(dso);
 }
 
+/**
+ * dso__can_shrink_symbols - Check if a DSO's symbol table can be shrunk and
+ *                           reloaded on demand.
+ * @dso: DSO to check.
+ *
+ * Shrinking evicts unreferenced symbols from @dso->symbols and relies on
+ * dso__load() being able to reload the missing symbols idempotently if a future
+ * lookup misses in map__find_symbol(). Not all DSO types support idempotent
+ * reloading:
+ *
+ * - User-space ELF binaries, debuginfo files, build-id cache files, and
+ *   perf-<pid>.map JIT files (dso__kernel(dso) == DSO_SPACE__USER), as well as
+ *   standalone kernel module ELF files (dso__is_kmod(dso)), load their symbols
+ *   directly into @dso->symbols from a backing file on disk and can be safely
+ *   reloaded on demand.
+ *
+ * - Main kernel and guest kernel DSOs (vmlinux / kallsyms where
+ *   dso__kernel(dso) != DSO_SPACE__USER && !dso__is_kmod(dso)) split their
+ *   loaded symbols across multiple per-section or per-module maps and DSOs in
+ *   machine->kmaps (via maps__split_kallsyms()). Re-running dso__load() on one
+ *   of the split kernel DSOs would either fail to find a backing file or
+ *   re-split and duplicate kernel maps, so they are excluded.
+ *
+ * - KCORE / GUEST_KCORE DSOs replace and remap kernel maps in machine->kmaps
+ *   when loaded from /proc/kcore, so they cannot be reloaded in place.
+ *
+ * - BPF_PROG_INFO, BPF_IMAGE, and OOL DSOs have their symbols synthesized in
+ *   memory from PERF_RECORD_KSYMBOL / PERF_RECORD_BPF_EVENT meta-events rather
+ *   than loaded from disk by dso__load(), so evicting their symbols would lose
+ *   them permanently.
+ *
+ * Return: True if @dso->symbols can be safely shrunk and reloaded on demand.
+ */
+bool dso__can_shrink_symbols(const struct dso *dso)
+{
+	switch (dso__symtab_type(dso)) {
+	case DSO_BINARY_TYPE__KALLSYMS:
+	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
+	case DSO_BINARY_TYPE__VMLINUX:
+	case DSO_BINARY_TYPE__GUEST_VMLINUX:
+	case DSO_BINARY_TYPE__JAVA_JIT:
+	case DSO_BINARY_TYPE__DEBUGLINK:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
+	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
+	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
+	case DSO_BINARY_TYPE__GUEST_KMODULE:
+	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
+	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
+		return dso__kernel(dso) == DSO_SPACE__USER || dso__is_kmod(dso);
+	case DSO_BINARY_TYPE__KCORE:
+	case DSO_BINARY_TYPE__GUEST_KCORE:
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
+	case DSO_BINARY_TYPE__OOL:
+	case DSO_BINARY_TYPE__NOT_FOUND:
+	default:
+		return false;
+	}
+}
+
+/**
+ * dso__shrink - Reclaim cached file data, debuginfo, and unreferenced symbols
+ *               from a DSO.
+ * @dso: DSO to shrink.
+ *
+ * Closes any cached file descriptor, frees the 4KB page cache (@dso->data.cache),
+ * releases cached addr2line / libbfd / libdw handles, and shrinks @dso->symbols
+ * if supported by dso__can_shrink_symbols().
+ *
+ * Return: Number of symbols evicted from @dso->symbols.
+ */
+size_t dso__shrink(struct dso *dso)
+{
+	size_t removed = 0;
+
+	if (!dso)
+		return 0;
+
+	dso__data_close(dso);
+
+	mutex_lock(dso__lock(dso));
+	__dso_cache__free(dso);
+	dso__free_a2l(dso);
+	dso__free_a2l_libbfd(dso);
+	dso__free_libdw(dso);
+
+	if (dso__can_shrink_symbols(dso))
+		removed = symbols__shrink(dso__symbols(dso));
+	mutex_unlock(dso__lock(dso));
+
+	return removed;
+}
+
 struct dso *dso__get(struct dso *dso)
 {
 	struct dso *result;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 1de446966f01..3f27cb1a76df 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -285,13 +285,24 @@ struct dso_bpf_prog {
 
 struct auxtrace_cache;
 
+/**
+ * struct dso - Dynamic Shared Object (executable, shared library, kernel, or
+ *              module) metadata, symbol table, and cached file state.
+ */
 DECLARE_RC_STRUCT(dso) {
+	/** @lock: Mutex serializing symbol loading and DSO state updates. */
 	struct mutex	 lock;
+	/** @dsos: Owning collection of DSOs, or NULL if not in a struct dsos. */
 	struct dsos	 *dsos;
+	/** @symbols: Sorted array of symbols belonging to this DSO. */
 	struct symbols	 symbols;
+	/** @inlined_nodes: Cached DWARF inline call-tree nodes for addresses. */
 	struct rb_root_cached inlined_nodes;
+	/** @srclines: Cached address-to-source-line mappings. */
 	struct rb_root_cached srclines;
+	/** @data_types: Cached DWARF annotated data type definitions. */
 	struct rb_root	 data_types;
+	/** @global_vars: Cached DWARF global variable locations. */
 	struct rb_root	 global_vars;
 
 	u64		 text_offset;
@@ -319,6 +330,7 @@ DECLARE_RC_STRUCT(dso) {
 	struct dso_id	 id;
 	unsigned int	 a2l_fails;
 	int		 comp;
+	/** @refcnt: Reference count tracking active holders of the DSO. */
 	refcount_t	 refcnt;
 	enum dso_load_errno	load_errno;
 	u16		 long_name_len;
@@ -338,6 +350,12 @@ DECLARE_RC_STRUCT(dso) {
 	u8		 short_name_allocated:1;
 	u8		 long_name_allocated:1;
 	u8		 is_64_bit:1;
+	/**
+	 * @accessed: Clock/Second-Chance LRU flag set when the DSO or its
+	 * symbols/data are looked up or read, and cleared by dsos__shrink().
+	 */
+	_Atomic bool	 accessed;
+	/** @loaded: True once dso__load() has attempted to load symbols. */
 	bool		 loaded;
 	u8		 rel;
 	char		 name[];
@@ -589,9 +607,30 @@ static inline enum dso_load_errno *dso__load_errno(struct dso *dso)
 	return &RC_CHK_ACCESS(dso)->load_errno;
 }
 
+static inline bool dso__accessed(const struct dso *dso)
+{
+	return atomic_load_explicit(&RC_CHK_ACCESS(dso)->accessed, memory_order_relaxed);
+}
+
+static inline void dso__set_accessed(struct dso *dso, bool val)
+{
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->accessed, val, memory_order_relaxed);
+}
+
+static inline bool dso__symbols_shrunk(const struct dso *dso)
+{
+	return atomic_load_explicit(&RC_CHK_ACCESS(dso)->symbols.shrunk, memory_order_acquire);
+}
+
+static inline void dso__set_symbols_shrunk(struct dso *dso, bool val)
+{
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->symbols.shrunk, val, memory_order_release);
+}
+
 static inline void dso__set_loaded(struct dso *dso)
 {
 	RC_CHK_ACCESS(dso)->loaded = true;
+	dso__set_symbols_shrunk(dso, false);
 }
 
 static inline struct mutex *dso__lock(struct dso *dso)
@@ -661,6 +700,11 @@ static inline void dso__set_rel(struct dso *dso, u8 rel)
 	RC_CHK_ACCESS(dso)->rel = rel;
 }
 
+static inline refcount_t *dso__refcnt(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->refcnt;
+}
+
 static inline const char *dso__short_name(const struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->short_name;
@@ -756,6 +800,8 @@ static inline void dso__set_text_offset(struct dso *dso, u64 val)
 struct dso *dso__new_id(const char *name, const struct dso_id *id);
 struct dso *dso__new(const char *name);
 void dso__delete(struct dso *dso);
+bool dso__can_shrink_symbols(const struct dso *dso);
+size_t dso__shrink(struct dso *dso);
 
 int dso__cmp_id(struct dso *a, struct dso *b);
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e927e707abac..f64551ec2728 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -278,9 +278,13 @@ static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, const st
 		};
 
 		__dsos__for_each_dso(dsos, dsos__find_id_cb, &args);
+		if (args.res)
+			dso__set_accessed(args.res, true);
 		return args.res;
 	}
 	res = __dsos__find_by_longname_id(dsos, name, id, write_locked);
+	if (res)
+		dso__set_accessed(res, true);
 	return res;
 }
 
@@ -324,6 +328,7 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, const
 		 * the array isn't sorted.
 		 */
 		dso__set_basename(dso);
+		dso__set_accessed(dso, true);
 		__dsos__add(dsos, dso);
 	}
 	return dso;
@@ -446,6 +451,7 @@ struct dso *dsos__findnew_module_dso(struct dsos *dsos,
 	dso__set_module_info(dso, m, machine);
 	dso__set_long_name(dso,	strdup(filename), true);
 	dso__set_kernel(dso, DSO_SPACE__KERNEL);
+	dso__set_accessed(dso, true);
 	__dsos__add(dsos, dso);
 
 	up_write(&dsos->lock);
@@ -493,3 +499,97 @@ int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data)
 	up_read(&dsos->lock);
 	return err;
 }
+
+/**
+ * dsos__shrink - Reclaim cold symbols, DSO caches, and unreferenced DSOs.
+ * @dsos: Collection of DSOs to shrink.
+ *
+ * Implements a two-tier Clock/Second-Chance LRU eviction pass:
+ * 1. Snapshot all DSOs under the read lock and release @dsos->lock to respect
+ *    the lock ordering (dso__lock() -> dsos->lock).
+ *    - If a DSO was accessed since the previous shrink pass (dso__accessed(dso)
+ *      is true), its file-level caches (fd, data cache, srclines, inlines,
+ *      addr2line/libdw handles) get a second chance, while its unreferenced
+ *      cold symbols are still shrunk via symbols__shrink().
+ *    - If a DSO was not accessed since the previous shrink pass, dso__shrink()
+ *      is called to release its file descriptor, data cache, debuginfo caches,
+ *      and unreferenced symbols.
+ * 2. Re-acquire @dsos->lock for writing:
+ *    - Clear @dso->accessed on DSOs that were accessed during the interval.
+ *    - Evict and release cold user-space DSOs that have no remaining symbols,
+ *      no header build-id, and refcount == 1 (referenced only by @dsos->dsos).
+ *
+ * Return: Number of DSOs evicted from @dsos.
+ */
+size_t dsos__shrink(struct dsos *dsos)
+{
+	struct dso **snapshot = NULL;
+	unsigned int cnt = 0, dst = 0;
+	size_t removed = 0;
+
+	if (!dsos)
+		return 0;
+
+	down_read(&dsos->lock);
+	if (dsos->cnt > 0) {
+		snapshot = calloc(dsos->cnt, sizeof(*snapshot));
+		if (snapshot) {
+			cnt = dsos->cnt;
+			for (unsigned int i = 0; i < cnt; i++)
+				snapshot[i] = dso__get(dsos->dsos[i]);
+		}
+	}
+	up_read(&dsos->lock);
+
+	if (!snapshot)
+		return 0;
+
+	for (unsigned int i = 0; i < cnt; i++) {
+		struct dso *dso = snapshot[i];
+
+		if (dso__accessed(dso)) {
+			mutex_lock(dso__lock(dso));
+			if (dso__can_shrink_symbols(dso))
+				symbols__shrink(dso__symbols(dso));
+			mutex_unlock(dso__lock(dso));
+		} else {
+			dso__shrink(dso);
+		}
+		dso__put(dso);
+	}
+	free(snapshot);
+
+	down_write(&dsos->lock);
+	for (unsigned int src = 0; src < dsos->cnt; src++) {
+		struct dso *dso = dsos->dsos[src];
+
+		if (dso__accessed(dso)) {
+			dso__set_accessed(dso, false);
+			dsos->dsos[dst++] = dso;
+		} else if (!dso__has_symbols(dso) &&
+			   !dso__header_build_id(dso) &&
+			   !dso__kernel(dso) &&
+			   refcount_read(dso__refcnt(dso)) == 1) {
+			dso__set_dsos(dso, NULL);
+			dso__put(dso);
+			removed++;
+		} else {
+			dsos->dsos[dst++] = dso;
+		}
+	}
+	dsos->cnt = dst;
+	if (dst == 0) {
+		zfree(&dsos->dsos);
+		dsos->allocated = 0;
+	} else if (dst < dsos->allocated / 2) {
+		struct dso **temp = realloc(dsos->dsos, sizeof(*temp) * dst);
+
+		if (temp) {
+			dsos->dsos = temp;
+			dsos->allocated = dst;
+		}
+	}
+	up_write(&dsos->lock);
+
+	return removed;
+}
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index a26774950866..5c27f5efb74b 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -13,15 +13,20 @@ struct dso_id;
 struct kmod_path;
 struct machine;
 
-/*
- * Collection of DSOs as an array for iteration speed, but sorted for O(n)
- * lookup.
+/**
+ * struct dsos - Collection of DSOs stored as a sorted array for iteration speed
+ *               and O(log n) lookup.
  */
 struct dsos {
+	/** @lock: Read/write semaphore synchronizing access to @dsos. */
 	struct rw_semaphore lock;
+	/** @dsos: Dynamically allocated array of struct dso pointers. */
 	struct dso **dsos;
+	/** @cnt: Number of valid entries in @dsos. */
 	unsigned int cnt;
+	/** @allocated: Capacity (in entries) of the @dsos allocation. */
 	unsigned int allocated;
+	/** @sorted: True when @dsos is sorted by long name, dso_id, and short name. */
 	bool sorted;
 };
 
@@ -48,5 +53,6 @@ struct dso *dsos__findnew_module_dso(struct dsos *dsos, struct machine *machine,
 struct dso *dsos__find_kernel_dso(struct dsos *dsos);
 
 int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data), void *data);
+size_t dsos__shrink(struct dsos *dsos);
 
 #endif /* __PERF_DSOS */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f1155c608a95..ba0b982828c2 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -962,6 +962,45 @@ size_t machines__fprintf_dsos_buildid(struct machines *machines, FILE *fp,
 	return ret;
 }
 
+/**
+ * machine__shrink - Reclaim unreferenced symbols, DSO caches, and cold DSOs
+ *                   for a machine.
+ * @machine: Machine to shrink.
+ *
+ * Return: Number of DSOs evicted from @machine->dsos.
+ */
+size_t machine__shrink(struct machine *machine)
+{
+	if (!machine)
+		return 0;
+
+	return dsos__shrink(&machine->dsos);
+}
+
+/**
+ * machines__shrink - Reclaim unreferenced symbols, DSO caches, and cold DSOs
+ *                    across the host and all guest machines.
+ * @machines: Collection of host and guest machines to shrink.
+ *
+ * Return: Total number of DSOs evicted across all machines.
+ */
+size_t machines__shrink(struct machines *machines)
+{
+	struct rb_node *nd;
+	size_t ret;
+
+	if (!machines)
+		return 0;
+
+	ret = machine__shrink(&machines->host);
+	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
+		struct machine *pos = rb_entry(nd, struct machine, rb_node);
+
+		ret += machine__shrink(pos);
+	}
+	return ret;
+}
+
 struct machine_fprintf_cb_args {
 	FILE *fp;
 	size_t printed;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 973a59f7c26a..115e60979ec6 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -268,6 +268,8 @@ size_t machine__fprintf_dsos_buildid(struct machine *machine, FILE *fp,
 size_t machines__fprintf_dsos(struct machines *machines, FILE *fp);
 size_t machines__fprintf_dsos_buildid(struct machines *machines, FILE *fp,
 				     bool (skip)(struct dso *dso, int parm), int parm);
+size_t machine__shrink(struct machine *machine);
+size_t machines__shrink(struct machines *machines);
 
 void machine__destroy_kernel_maps(struct machine *machine);
 int machine__create_kernel_maps(struct machine *machine);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 19afe676adf2..633989615cf6 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -377,15 +377,30 @@ int map__load(struct map *map)
 
 struct symbol *map__find_symbol(struct map *map, u64 addr)
 {
+	struct dso *dso;
+	struct symbol *sym;
+
 	if (map__load(map) < 0)
 		return NULL;
 
-	return dso__find_symbol(map__dso(map), addr);
+	dso = map__dso(map);
+	sym = dso__find_symbol(dso, addr);
+	/*
+	 * If the DSO's symbol table was previously shrunk by symbols__shrink()
+	 * and the lookup missed, transparently reload the DSO so evicted
+	 * symbols are restored on demand rather than reported as [unknown].
+	 */
+	if (!sym && dso__symbols_shrunk(dso)) {
+		if (dso__load(dso, map) >= 0)
+			sym = dso__find_symbol(dso, addr);
+	}
+	return sym;
 }
 
 struct symbol *map__find_symbol_by_name_idx(struct map *map, const char *name, size_t *idx)
 {
 	struct dso *dso;
+	struct symbol *sym;
 
 	if (map__load(map) < 0)
 		return NULL;
@@ -393,7 +408,14 @@ struct symbol *map__find_symbol_by_name_idx(struct map *map, const char *name, s
 	dso = map__dso(map);
 	dso__sort_by_name(dso);
 
-	return dso__find_symbol_by_name(dso, name, idx);
+	sym = dso__find_symbol_by_name(dso, name, idx);
+	if (!sym && dso__symbols_shrunk(dso)) {
+		if (dso__load(dso, map) >= 0) {
+			dso__sort_by_name(dso);
+			sym = dso__find_symbol_by_name(dso, name, idx);
+		}
+	}
+	return sym;
 }
 
 struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7fea9e72726c..555d940a866a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -3933,6 +3933,21 @@ size_t perf_session__fprintf_dsos_buildid(struct perf_session *session, FILE *fp
 	return machines__fprintf_dsos_buildid(&session->machines, fp, skip, parm);
 }
 
+/**
+ * perf_session__shrink - Reclaim unreferenced symbols, DSO caches, and cold
+ *                        DSOs across all machines in the session.
+ * @session: Session to shrink.
+ *
+ * Return: Number of DSOs evicted across the session's machines.
+ */
+size_t perf_session__shrink(struct perf_session *session)
+{
+	if (!session)
+		return 0;
+
+	return machines__shrink(&session->machines);
+}
+
 size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp)
 {
 	size_t ret;
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index ac5803d5fb4e..4b223c2cee7f 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -91,7 +91,9 @@ struct perf_session {
 	u64			bytes_compressed;
 	/** @zstd_data: Owner of global compression state, buffers, etc. */
 	struct zstd_data	zstd_data;
+	/** @decomp_data: Decompression state for the session data file. */
 	struct decomp_data	decomp_data;
+	/** @active_decomp: Currently active decompression context. */
 	struct decomp_data	*active_decomp;
 };
 
@@ -175,6 +177,7 @@ size_t perf_session__fprintf_dsos(struct perf_session *session, FILE *fp);
 
 size_t perf_session__fprintf_dsos_buildid(struct perf_session *session, FILE *fp,
 					  bool (fn)(struct dso *dso, int parm), int parm);
+size_t perf_session__shrink(struct perf_session *session);
 
 size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp);
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 90542fb643e9..00d088b43f94 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1826,9 +1826,10 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 	/*
 	 * Modules may already have symbols from kallsyms, but those symbols
-	 * have the wrong values for the dso maps, so remove them.
+	 * have the wrong values for the dso maps, so remove them unless we are
+	 * reloading a previously shrunk module.
 	 */
-	if (kmodule && syms_ss->symtab)
+	if (kmodule && syms_ss->symtab && !dso__symbols_shrunk(dso))
 		symbols__delete(dso__symbols(dso));
 
 	if (!syms_ss->symtab) {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 593fccfe3240..33cfd86156d2 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -164,6 +164,14 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 	s64 b;
 	size_t na, nb;
 
+	/* Prefer a symbol that is actively referenced */
+	a = refcount_read(symbol__refcnt(syma)) > 1;
+	b = refcount_read(symbol__refcnt(symb)) > 1;
+	if (a && !b)
+		return SYMBOL_A;
+	if (b && !a)
+		return SYMBOL_B;
+
 	/* Prefer a symbol with non zero length */
 	a = symbol__end(syma) - symbol__start(syma);
 	b = symbol__end(symb) - symbol__start(symb);
@@ -224,6 +232,7 @@ void symbols__init(struct symbols *symbols)
 	symbols->num_by_name = 0;
 	symbols->sorted = true;
 	symbols->sorted_by_name = false;
+	atomic_init(&symbols->shrunk, false);
 }
 
 static void symbols__delete_locked(struct symbols *symbols)
@@ -238,6 +247,7 @@ static void symbols__delete_locked(struct symbols *symbols)
 	symbols->num_by_name = 0;
 	symbols->sorted = true;
 	symbols->sorted_by_name = false;
+	atomic_store_explicit(&symbols->shrunk, false, memory_order_release);
 }
 
 void symbols__delete(struct symbols *symbols)
@@ -253,6 +263,68 @@ void symbols__exit(struct symbols *symbols)
 	exit_rwsem(&symbols->lock);
 }
 
+/**
+ * symbols__shrink - Evict unreferenced, unaccessed symbols using Clock LRU.
+ * @symbols: Symbol table to shrink.
+ *
+ * Scans @symbols in place:
+ * - Symbols with refcount > 1 (held by an external owner such as a hist_entry,
+ *   callchain_cursor_node, or inline_list) are always retained.
+ * - Symbols with refcount == 1 that have SYMBOL_FLAG_ACCESSED set are given a
+ *   second chance: their accessed bit is cleared and they remain in @symbols.
+ * - Symbols with refcount == 1 and SYMBOL_FLAG_ACCESSED clear are evicted and
+ *   released via symbol__put().
+ *
+ * If any symbols are evicted, the secondary @symbols_by_name index is freed so
+ * it will be rebuilt lazily if needed, and the backing @symbols array is
+ * compacted when occupancy drops below 50%.
+ *
+ * Return: Number of symbols evicted and freed.
+ */
+size_t symbols__shrink(struct symbols *symbols)
+{
+	unsigned int write_idx = 0;
+	size_t freed = 0;
+
+	if (!symbols)
+		return 0;
+
+	down_write(&symbols->lock);
+	for (unsigned int read_idx = 0; read_idx < symbols->cnt; read_idx++) {
+		struct symbol *sym = symbols->symbols[read_idx];
+
+		if (refcount_read(symbol__refcnt(sym)) > 1 || symbol__accessed(sym)) {
+			symbol__set_accessed(sym, false);
+			symbols->symbols[write_idx++] = sym;
+		} else {
+			symbol__put(sym);
+			freed++;
+		}
+	}
+	if (freed > 0) {
+		symbols->cnt = write_idx;
+		zfree(&symbols->symbols_by_name);
+		symbols->num_by_name = 0;
+		symbols->sorted_by_name = false;
+		atomic_store_explicit(&symbols->shrunk, true, memory_order_release);
+		if (symbols->cnt == 0) {
+			zfree(&symbols->symbols);
+			symbols->allocated = 0;
+		} else if (symbols->cnt < symbols->allocated / 2 && symbols->allocated > 32) {
+			unsigned int new_alloc = max(symbols->cnt, 32U);
+			struct symbol **temp = realloc(symbols->symbols,
+						       sizeof(struct symbol *) * new_alloc);
+
+			if (temp) {
+				symbols->symbols = temp;
+				symbols->allocated = new_alloc;
+			}
+		}
+	}
+	up_write(&symbols->lock);
+	return freed;
+}
+
 static inline bool symbol__less_or_equal(const struct symbol *a, const struct symbol *b)
 {
 	if (symbol__start(a) != symbol__start(b))
@@ -310,9 +382,6 @@ void symbols__fixup_duplicate(struct symbols *symbols)
 {
 	unsigned int write_idx = 0;
 
-	if (symbol_conf.allow_aliases)
-		return;
-
 	down_write(&symbols->lock);
 	symbols__sort_locked(symbols);
 	if (symbols->cnt <= 1) {
@@ -329,6 +398,38 @@ void symbols__fixup_duplicate(struct symbols *symbols)
 			continue;
 		}
 
+		/*
+		 * When aliases are allowed, distinct symbol names at the same
+		 * address are kept, but identical (start, name) pairs (such as
+		 * when reloading a shrunk DSO that still holds referenced
+		 * symbols) are deduplicated using choose_best_symbol().
+		 */
+		if (symbol_conf.allow_aliases) {
+			bool dup = false;
+
+			for (unsigned int k = write_idx; ; k--) {
+				struct symbol *existing = symbols->symbols[k];
+
+				if (symbol__start(existing) != symbol__start(next))
+					break;
+				if (!strcmp(symbol__name(existing), symbol__name(next))) {
+					if (choose_best_symbol(existing, next) == SYMBOL_A) {
+						symbol__put(next);
+					} else {
+						symbol__put(existing);
+						symbols->symbols[k] = next;
+					}
+					dup = true;
+					break;
+				}
+				if (k == 0)
+					break;
+			}
+			if (!dup)
+				symbols->symbols[++write_idx] = next;
+			continue;
+		}
+
 		if (choose_best_symbol(curr, next) == SYMBOL_A) {
 			if (symbol__type(next) == STT_GNU_IFUNC)
 				symbol__set_ifunc_alias(curr, true);
@@ -502,6 +603,14 @@ void symbol__set_annotated(struct symbol *sym, bool annotated)
 		atomic_fetch_and(&RC_CHK_ACCESS(sym)->flags, ~SYMBOL_FLAG_ANNOTATED);
 }
 
+void symbol__set_accessed(struct symbol *sym, bool accessed)
+{
+	if (accessed)
+		atomic_fetch_or(&RC_CHK_ACCESS(sym)->flags, SYMBOL_FLAG_ACCESSED);
+	else
+		atomic_fetch_and(&RC_CHK_ACCESS(sym)->flags, ~SYMBOL_FLAG_ACCESSED);
+}
+
 static void symbol__set_idle(struct symbol *sym, bool idle)
 {
 	uint16_t old_flags = atomic_load_explicit(&RC_CHK_ACCESS(sym)->flags, memory_order_relaxed);
@@ -576,6 +685,7 @@ static struct symbol *symbols__find(struct symbols *symbols, u64 ip)
 			low = mid + 1;
 		else {
 			res = symbol__get(s);
+			symbol__set_accessed(res, true);
 			break;
 		}
 	}
@@ -700,7 +810,11 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 		}
 	}
 	assert(!found_idx || !s || s == symbols[*found_idx]);
-	return symbol__get(s);
+	if (s) {
+		s = symbol__get(s);
+		symbol__set_accessed(s, true);
+	}
+	return s;
 }
 
 int dso__insert_symbol(struct dso *dso, struct symbol *sym)
@@ -732,11 +846,17 @@ void dso__delete_symbol(struct dso *dso, struct symbol *sym)
 
 struct symbol *dso__find_symbol(struct dso *dso, u64 addr)
 {
+	if (!dso)
+		return NULL;
+	dso__set_accessed(dso, true);
 	return symbols__find(dso__symbols(dso), addr);
 }
 
 struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr)
 {
+	if (!dso)
+		return NULL;
+	dso__set_accessed(dso, true);
 	return symbols__find(dso__symbols(dso), addr);
 }
 
@@ -763,6 +883,9 @@ struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_
 	struct symbols *symbols;
 	struct symbol *s;
 
+	if (!dso)
+		return NULL;
+	dso__set_accessed(dso, true);
 	symbols = dso__symbols(dso);
 	down_read(&symbols->lock);
 	while (!symbols->sorted_by_name) {
@@ -1857,6 +1980,9 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
 	free(line);
 	fclose(file);
 
+	if (nr_syms > 0)
+		symbols__fixup_duplicate(dso__symbols(dso));
+
 	return nr_syms;
 
 out_delete_line:
@@ -1967,6 +2093,7 @@ int dso__load(struct dso *dso, struct map *map)
 	char newmapname[PATH_MAX];
 	const char *map_path = dso__long_name(dso);
 
+	dso__set_accessed(dso, true);
 	mutex_lock(dso__lock(dso));
 	perfmap = is_perf_pid_map_name(map_path);
 
@@ -1981,7 +2108,7 @@ int dso__load(struct dso *dso, struct map *map)
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
 	/* check again under the dso->lock */
-	if (dso__loaded(dso)) {
+	if (dso__loaded(dso) && !dso__symbols_shrunk(dso)) {
 		ret = 1;
 		goto out;
 	}
@@ -2140,8 +2267,10 @@ int dso__load(struct dso *dso, struct map *map)
 		int nr_plt;
 
 		nr_plt = dso__synthesize_plt_symbols(dso, runtime_ss);
-		if (nr_plt > 0)
+		if (nr_plt > 0) {
+			symbols__fixup_duplicate(dso__symbols(dso));
 			ret += nr_plt;
+		}
 	}
 
 	for (; ss_pos > 0; ss_pos--)
@@ -2151,6 +2280,7 @@ int dso__load(struct dso *dso, struct map *map)
 	if (ret < 0 && strstr(dso__name(dso), " (deleted)") != NULL)
 		ret = 0;
 out:
+	dso__set_symbols_shrunk(dso, false);
 	dso__set_loaded(dso);
 	mutex_unlock(dso__lock(dso));
 	nsinfo__mountns_exit(&nsc);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index a3c88b5224ec..a76613c43ba9 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -91,21 +91,32 @@ enum symbol_idle_kind {
 #define SYMBOL_FLAG_ANNOTATE2       (1 << 12)
 #define SYMBOL_FLAG_IFUNC_ALIAS     (1 << 13)
 #define SYMBOL_FLAG_ANNOTATED       (1 << 14)
+#define SYMBOL_FLAG_ACCESSED        (1U << 15)
+
 /**
- * A symtab entry.
+ * struct symbol - A symtab entry.
  */
 DECLARE_RC_STRUCT(symbol) {
-	/** Range of symbol [start, end). */
+	/** @start: Start address of symbol range [start, end). */
 	u64		start;
+	/** @end: End address (exclusive) of symbol range [start, end). */
 	u64		end;
-	/** Reference count. */
+	/** @refcnt: Reference count tracking active holders of the symbol. */
 	refcount_t	refcnt;
-	/** Length of the string name. */
+	/** @namelen: Length of the string @name (excluding trailing NUL). */
 	u16		namelen;
+	/**
+	 * @flags: Atomic bitfield of SYMBOL_FLAG_* values encoding symbol type,
+	 * binding, idle classification, ignore/inlined/annotate/ifunc flags,
+	 * and Clock LRU access state (SYMBOL_FLAG_ACCESSED).
+	 */
 	_Atomic uint16_t flags;
-	/** Architecture specific. Unused except on PPC where it holds st_other. */
+	/**
+	 * @arch_sym: Architecture specific value. Unused except on PPC where it
+	 * holds st_other.
+	 */
 	u8		arch_sym;
-	/** The name of length namelen associated with the symbol. */
+	/** @name: NUL-terminated symbol name of length @namelen. */
 	char		name[];
 };
 
@@ -138,6 +149,11 @@ struct symbols {
 	 * by name.
 	 */
 	bool sorted_by_name;
+	/**
+	 * @shrunk: Set under @lock when symbols__shrink() evicts one or more
+	 * symbols so a subsequent lookup miss knows to reload the DSO on demand.
+	 */
+	_Atomic bool shrunk;
 };
 
 void symbol__delete(struct symbol *sym);
@@ -145,6 +161,7 @@ void symbols__init(struct symbols *symbols);
 void symbols__exit(struct symbols *symbols);
 void symbols__delete(struct symbols *symbols);
 void symbols__sort_read_lock(struct symbols *symbols) SHARED_LOCK_FUNCTION(symbols->lock);
+size_t symbols__shrink(struct symbols *symbols);
 
 static inline refcount_t *symbol__refcnt(struct symbol *sym)
 {
@@ -253,6 +270,12 @@ static inline bool symbol__annotated(const struct symbol *sym)
 		SYMBOL_FLAG_ANNOTATED) != 0;
 }
 
+static inline bool symbol__accessed(const struct symbol *sym)
+{
+	return (atomic_load_explicit(&RC_CHK_ACCESS(sym)->flags, memory_order_relaxed) &
+		SYMBOL_FLAG_ACCESSED) != 0;
+}
+
 bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env *env);
 
 void symbol__set_ignore(struct symbol *sym, bool ignore);
@@ -260,6 +283,7 @@ void symbol__set_annotate2(struct symbol *sym, bool annotate2);
 void symbol__set_inlined(struct symbol *sym, bool inlined);
 void symbol__set_ifunc_alias(struct symbol *sym, bool ifunc_alias);
 void symbol__set_annotated(struct symbol *sym, bool annotated);
+void symbol__set_accessed(struct symbol *sym, bool accessed);
 
 /*
  * symbols__for_each_entry - iterate over symbols calling @cb for each entry
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

