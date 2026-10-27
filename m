Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142963;
	b=kc0GJVbeMsfJCqyxq0M9dEJQArkBkI0htwQdU/8F/ozXhj1Dgj3ks3yTIdckHDIuxWOA
	 BBT8vzj2viVevgmK4dQyYwGJA1Q2u+C7IJVabHJOYH3jSPfkhm2LupVM1yGRlnjxOe80M
	 NjaLIk9IhLTLM45Qfg4WhBgzqkbBZ2a5/ip7GhG8kjfiPy/qWp/6xM8DjTPQy0h45ORog
	 Rjlrf7NM+BXHB50UagAr2AIqxIVyds+21g3pKc55mtaRR+ZHj9vrCsiby4lTDfU/kWjNO
	 jtrtaPA3qAC/d8Wy8d7wsp+KCs7EyWfHdJ5pqYyBX/KbuEYAjh7jYUSR148yEBNqDTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=2ICSiGq1LNrW70LfMkwSPIlNioTWG5BLi1FlYc/PkbE=;
	b=uM1eYYhkhdBbgy3DDmOviUtcyTIWmd4TOzhYGbabFNaMkRPSH8O1peceAl+wgSgUo1KK
	 cFzZWkcj657lY3WCy8UBKpUGNaFA+arGfHKRIkI0HHbzd1gpoQUKDK7SaE9W/RUWV+vqL
	 Ja5DplujK/gPFNRZCDEN9Iog9RXNFmj/09pfDY6PGnZ+aGlqZGmjFAQTWBNHu92/7XksG
	 IP9HGX6PqVrcPcFtQYxlX7CBpwOGWVbzfgZm6b2ZV7ZijD639bcaBWQRuUncvpM6CZbQS
	 a2mzOMV0wkRY4rxtXLp6mp9997gi2FhY5Q7D7sjeKkYfEYmxsUuEHzSsktMbmH9ChdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OdKkpEz3;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843560A380F
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5843560A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OdKkpEz3
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1383723dfddso607320c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142956; x=1793747756; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ICSiGq1LNrW70LfMkwSPIlNioTWG5BLi1FlYc/PkbE=;
        b=OdKkpEz3JxHceCZgWnyyTNhJNVG/xFCwSruDtDH9YI5ZMi/5BSogmGe4DXoDyKECzC
         GrOBeW+EITeShsNo4fajPl/RJpaNkE3/7ZmVw+SMoee1YsX3PVkhOaB7TTmTpaFchtI7
         XCs7E/JnhLo7h6jxlacbgkbFlB6b6fqXniG14/FGd2nV+81deBuBQFB8l1tc/PT7bZD0
         gXtDcZxzf2M03EmhMi6j5rKmK4lBuaiMNBalxLXQ6aydYmiF8KfCUbyREdM1PJ9j6hiF
         E8uhCvabcxLkb7BRjnGzORxUj+QuYiv9eOVFbGHtfvpvLarDOhoHoKR+UkhX6baXR9Lt
         etRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142956; x=1793747756;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ICSiGq1LNrW70LfMkwSPIlNioTWG5BLi1FlYc/PkbE=;
        b=peABl1p3Lty3rdp4ok6eGKmuI3GwE2HbFfdm3PgEViEbCsD15k+skKjOxq+O2bhJ4/
         34tYClgR2FXG3IyXE1dr1YVmnEnSS4q4KdAkOL4oBbB+8u9BEDngSR17GUfQb4V6ioqa
         rf1cQTLM5tthVSh7iG1niR1rqg2RA7Uvie+gofecxYcDTUS4Fm/EwkmvEyNeIojrzIqB
         JQvgI432vvYJU7K/T2eDcJHviXcaqeShNhZ6gmF81Su648FGSwUKhJITjsVpbGSy6R6w
         i2Q1ZtdHmL3aS4GUyO+iqUEL9v9UuIWEBAXN6DAAguKwYWSOUTAsVhHGhVYTFUhGn4aL
         p3YA==
X-Forwarded-Encrypted: i=1; AKwUvBwUJ2XBPXUgmBCBOe+Npjdsi9wlJ4pymzBfEyFAI5z5IQShH095dhQDlOwBbo5SWQSIbs5eSfLMIRyeBzgYK8NH@vger.kernel.org
X-Gm-Message-State: AFq9FYLtupXYS8H+Hvqp+P4o0XTFGLa8wmHXas7FH9u4mzjf0xX7UH20
	mo9lliz9ftWTnXypH81klFkw8IB7FuFDUDBHLQbHdVpMcsiQiY9riAcvjF4agUxaO41GAec0faT
	xtDrEsl2qjA==
X-Received: from dleb17-n1.prod.google.com ([2002:a05:701b:4251:10b0:199:f7f6:16f2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b87:b0:14f:fb87:cf62
 with SMTP id a92af1059eb24-1a6cec9a0dcmr899479c88.27.1793142955730; Tue, 27
 Oct 2026 16:15:55 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:15:09 -0700
In-Reply-To: <20261027231513.816148-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027231513.816148-16-irogers@google.com>
Subject: [PATCH v2 15/18] perf symbol: Add memory shrinking for symbols, DSOs,
 and machines
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Long-running 'perf top' and large 'perf report' sessions can load full
symbol tables, cached 4KB data pages, addr2line subprocesses, and libdw
contexts across thousands of DSOs even when only a small fraction of
symbols are actively referenced by live hist_entry or callchain nodes.

Add on-demand memory shrinking functions to reclaim cached symbol, DSO,
and debuginfo state under memory pressure:

- symbols__shrink(): Evict symbols whose only reference is the struct
  symbols container (refcnt == 1 and not annotated) while retaining
  symbols actively referenced by callers (e.g. hist_entry, map_symbol,
  callchain nodes, or annotations). Mark the symbol table as shrunk and
  clear dso->loaded when symbols are evicted so subsequent map__load()
  calls reload the DSO under dso__lock(dso) and merge retained symbol
  instances back in place.
- dso__shrink(): Close open file descriptors, free cached 4KB data
  pages (on file-backed user DSOs), addr2line handles, and libdw Dwfl
  contexts, and shrink reloadable user DSO symbol tables.
- dsos__shrink(), machine__shrink(), machines__shrink(), and
  perf_session__shrink(): Shrink all DSOs across host and guest
  machines, evict unreferenced user DSOs with no remaining symbols, and
  return free heap pages via malloc_trim(0) on glibc.

All shrinking paths use non-blocking trylocks and perform zero heap
allocations so they can be safely invoked from OOM recovery paths.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c        | 192 ++++++++++++++++++--
 tools/perf/util/dso.h        |  24 ++-
 tools/perf/util/dsos.c       |  68 +++++++
 tools/perf/util/dsos.h       |   2 +
 tools/perf/util/machine.c    |  32 ++++
 tools/perf/util/machine.h    |   3 +
 tools/perf/util/session.c    |   8 +
 tools/perf/util/session.h    |   2 +
 tools/perf/util/symbol-elf.c |   2 +-
 tools/perf/util/symbol.c     | 332 ++++++++++++++++++++++++++++++-----
 tools/perf/util/symbol.h     |   6 +
 11 files changed, 609 insertions(+), 62 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 35a5c65030af..be257c77ab0a 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1075,12 +1075,12 @@ static int bpf_size(struct dso *dso)
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
 
@@ -1089,6 +1089,13 @@ dso_cache__free(struct dso *dso)
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
 
@@ -1243,27 +1250,34 @@ static struct dso_cache *dso_cache__populate(struct dso *dso,
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
+	if (!cache) {
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
+		if (!cache) {
+			mutex_unlock(dso__lock(dso));
+			return -EAGAIN;
+		}
+	}
 
-	return dso_cache__memcpy(cache, offset, data, size, out);
+	ret = dso_cache__memcpy(cache, offset, data, size, out);
+	mutex_unlock(dso__lock(dso));
+	return ret;
 }
 
 /*
@@ -1803,7 +1817,8 @@ int dso__name_len(const struct dso *dso)
 
 bool dso__loaded(const struct dso *dso)
 {
-	return RC_CHK_ACCESS(dso)->loaded;
+	return atomic_load_explicit(&RC_CHK_ACCESS(dso)->loaded, memory_order_acquire) &&
+	       !dso__symbols_shrunk(dso);
 }
 
 bool dso__sorted_by_name(const struct dso *dso)
@@ -1835,7 +1850,7 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->binary_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->dbginfo_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->is_64_bit = (sizeof(void *) == 8);
-		dso->loaded = 0;
+		atomic_init(&dso->loaded, false);
 		dso->rel = 0;
 		dso->has_srcline = 1;
 		dso->a2l_fails = 1;
@@ -1896,6 +1911,144 @@ void dso__delete(struct dso *dso)
 	RC_CHK_FREE(dso);
 }
 
+bool dso__can_shrink_symbols(const struct dso *dso)
+{
+	const char *name;
+
+	if (!dso || (!dso__loaded(dso) && !dso__symbols_shrunk(dso)))
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
+size_t dso__shrink(struct dso *dso)
+	NO_THREAD_SAFETY_ANALYSIS
+{
+	size_t freed = 0;
+
+	if (!dso)
+		return 0;
+
+	if (mutex_trylock(dso__data_open_lock())) {
+		if (dso__data(dso)->fd >= 0) {
+			close_dso(dso);
+			freed++;
+		}
+		mutex_unlock(dso__data_open_lock());
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
+	if (dso__can_shrink_symbols(dso)) {
+		size_t sym_freed = symbols__shrink(dso__symbols(dso));
+
+		if (sym_freed > 0) {
+			atomic_store_explicit(&RC_CHK_ACCESS(dso)->loaded, false,
+					      memory_order_release);
+			freed += sym_freed;
+		}
+	}
+
+	mutex_unlock(dso__lock(dso));
+	return freed;
+}
+
 struct dso *dso__get(struct dso *dso)
 {
 	struct dso *result;
@@ -1909,7 +2062,8 @@ struct dso *dso__get(struct dso *dso)
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
index f23cf9957aec..64a118ea2524 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -346,7 +346,7 @@ DECLARE_RC_STRUCT(dso) {
 	u8		 is_64_bit:1;
 	u8		 bintype_searched:1;
 	u8		 debuginfo_searched:1;
-	bool		 loaded;
+	_Atomic bool	 loaded;
 	u8		 rel;
 	char		 name[];
 };
@@ -602,7 +602,7 @@ static inline enum dso_load_errno *dso__load_errno(struct dso *dso)
 
 static inline void dso__set_loaded(struct dso *dso)
 {
-	RC_CHK_ACCESS(dso)->loaded = true;
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->loaded, true, memory_order_release);
 }
 
 static inline struct mutex *dso__lock(struct dso *dso)
@@ -783,6 +783,26 @@ static inline bool dso__has_symbols(const struct dso *dso)
 	return RC_CHK_ACCESS(dso)->symbols.cnt > 0;
 }
 
+static inline bool dso__symbols_shrunk(const struct dso *dso)
+{
+	return atomic_load_explicit(&RC_CHK_ACCESS(dso)->symbols.shrunk,
+				    memory_order_acquire);
+}
+
+static inline void dso__set_symbols_shrunk(struct dso *dso, bool val)
+{
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->symbols.shrunk, val,
+			      memory_order_release);
+}
+
+static inline refcount_t *dso__refcnt(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->refcnt;
+}
+
+bool dso__can_shrink_symbols(const struct dso *dso);
+size_t dso__shrink(struct dso *dso);
+
 char *dso__filename_with_chroot(const struct dso *dso, const char *filename);
 
 bool dso__sorted_by_name(const struct dso *dso);
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e927e707abac..30ecc9a19244 100644
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
@@ -493,3 +496,68 @@ int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data)
 	up_read(&dsos->lock);
 	return err;
 }
+
+size_t dsos__shrink(struct dsos *dsos)
+	NO_THREAD_SAFETY_ANALYSIS
+{
+	unsigned int write_idx = 0;
+	size_t freed = 0;
+	bool any_removed = false;
+
+	if (!down_write_trylock(&dsos->lock))
+		return 0;
+
+	for (unsigned int read_idx = 0; read_idx < dsos->cnt; read_idx++) {
+		struct dso *dso = dsos->dsos[read_idx];
+
+		freed += dso__shrink(dso);
+
+		if (!dso__has_symbols(dso) &&
+		    !dso__header_build_id(dso) &&
+		    !dso__hit(dso) &&
+		    !dso__kernel(dso) &&
+		    refcount_read(dso__refcnt(dso)) == 1 &&
+		    mutex_trylock(&_dso__data_open_lock)) {
+			bool can_evict = dso__data(dso)->fd < 0 &&
+					 list_empty(&dso__data(dso)->open_entry) &&
+					 mutex_trylock(dso__lock(dso));
+
+			if (can_evict)
+				mutex_unlock(dso__lock(dso));
+			mutex_unlock(&_dso__data_open_lock);
+			if (can_evict) {
+				dso__set_dsos(dso, NULL);
+				dso__put(dso);
+				any_removed = true;
+				freed++;
+				continue;
+			}
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
index fb83da8ef09b..8d0c545ee544 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3446,3 +3446,35 @@ int machine__hit_all_dsos(struct machine *machine)
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
+	NO_THREAD_SAFETY_ANALYSIS
+{
+	struct rb_node *nd;
+	size_t freed;
+
+	if (!machines)
+		return 0;
+
+	freed = machine__shrink(&machines->host);
+
+	if (!down_read_trylock(&machines->lock))
+		return freed;
+
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
index 147ce343e370..1d1f46a01a38 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -337,4 +337,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 
 int machine__hit_all_dsos(struct machine *machine);
 
+size_t machine__shrink(struct machine *machine);
+size_t machines__shrink(struct machines *machines);
+
 #endif /* __PERF_MACHINE_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 56a5e57ec512..3f35c7affc29 100644
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
index ac5803d5fb4e..fdec65fcfee6 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -217,4 +217,6 @@ int perf_event__process_finished_round(const struct perf_tool *tool,
 struct perf_env *perf_session__env(struct perf_session *session);
 uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags);
 
+size_t perf_session__shrink(struct perf_session *session);
+
 #endif /* __PERF_SESSION_H */
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6082136c9662..946a2426933c 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1973,7 +1973,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	 * Modules may already have symbols from kallsyms, but those symbols
 	 * have the wrong values for the dso maps, so remove them.
 	 */
-	if (kmodule && syms_ss->symtab)
+	if (kmodule && syms_ss->symtab && !dso__symbols_shrunk(dso))
 		symbols__delete(dso__symbols(dso));
 
 	if (!syms_ss->symtab) {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 7f1fcd5c64b2..e5338c8e03dc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -164,6 +164,18 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 	s64 b;
 	size_t na, nb;
 
+	/*
+	 * Prefer a symbol that already has external references (e.g. retained
+	 * across a symbols__shrink() and subsequent reload) so existing
+	 * callers continue pointing to the canonical symbol in the DSO.
+	 */
+	a = refcount_read(symbol__refcnt(syma)) > 1 || symbol__annotated(syma);
+	b = refcount_read(symbol__refcnt(symb)) > 1 || symbol__annotated(symb);
+	if (a && !b)
+		return SYMBOL_A;
+	if (b && !a)
+		return SYMBOL_B;
+
 	/* Prefer a symbol with non zero length */
 	a = symbol__end(syma) - symbol__start(syma);
 	b = symbol__end(symb) - symbol__start(symb);
@@ -225,6 +237,7 @@ void symbols__init(struct symbols *symbols)
 	symbols->num_by_name = 0;
 	symbols->sorted = true;
 	symbols->sorted_by_name = false;
+	atomic_init(&symbols->shrunk, false);
 }
 
 static void symbols__delete_locked(struct symbols *symbols)
@@ -240,6 +253,7 @@ static void symbols__delete_locked(struct symbols *symbols)
 	symbols->num_by_name = 0;
 	symbols->sorted = true;
 	symbols->sorted_by_name = false;
+	atomic_store_explicit(&symbols->shrunk, false, memory_order_release);
 }
 
 void symbols__delete(struct symbols *symbols)
@@ -261,6 +275,70 @@ void symbols__exit(struct symbols *symbols)
 	exit_rwsem(&symbols->lock);
 }
 
+/*
+ * Evict symbols whose only reference is the @symbols array itself
+ * (refcnt == 1), retaining symbols referenced by active callers (e.g.
+ * hist_entry, map_symbol, or callchain nodes with refcnt > 1).
+ *
+ * Uses down_write_trylock() so this is safe to call from OOM recovery
+ * paths where the current thread might already hold a lock on @symbols.
+ *
+ * Returns the number of symbols evicted.
+ */
+size_t symbols__shrink(struct symbols *symbols)
+{
+	unsigned int write_idx = 0;
+	unsigned int old_sorted_cnt;
+	unsigned int new_sorted_cnt = 0;
+	size_t freed = 0;
+
+	if (!down_write_trylock(&symbols->lock))
+		return 0;
+
+	old_sorted_cnt = symbols->sorted ? symbols->cnt : symbols->sorted_cnt;
+
+	for (unsigned int read_idx = 0; read_idx < symbols->cnt; read_idx++) {
+		struct symbol *sym = symbols->symbols[read_idx];
+
+		if (refcount_read(symbol__refcnt(sym)) > 1 || symbol__annotated(sym)) {
+			if (read_idx < old_sorted_cnt)
+				new_sorted_cnt++;
+			symbols->symbols[write_idx++] = sym;
+		} else {
+			symbol__put(sym);
+			freed++;
+		}
+	}
+
+	symbols->cnt = write_idx;
+	symbols->sorted_cnt = new_sorted_cnt;
+	if (new_sorted_cnt == write_idx)
+		symbols->sorted = true;
+
+	if (freed > 0) {
+		zfree(&symbols->symbols_by_name);
+		symbols->num_by_name = 0;
+		symbols->sorted_by_name = false;
+		atomic_store_explicit(&symbols->shrunk, true, memory_order_release);
+
+		if (write_idx == 0) {
+			zfree(&symbols->symbols);
+			symbols->allocated = 0;
+			symbols->sorted = true;
+		} else if (write_idx < symbols->allocated / 2) {
+			struct symbol **shrunk = realloc(symbols->symbols,
+							 write_idx * sizeof(struct symbol *));
+			if (shrunk) {
+				symbols->symbols = shrunk;
+				symbols->allocated = write_idx;
+			}
+		}
+	}
+
+	up_write(&symbols->lock);
+	return freed;
+}
+
 static inline bool symbol__less_or_equal(const struct symbol *a, const struct symbol *b)
 {
 	if (symbol__start(a) != symbol__start(b))
@@ -602,9 +680,7 @@ void symbols__sort_read_lock(struct symbols *symbols)
 void symbols__fixup_duplicate(struct symbols *symbols)
 {
 	unsigned int write_idx = 0;
-
-	if (symbol_conf.allow_aliases)
-		return;
+	unsigned int group_start = 0;
 
 	down_write(&symbols->lock);
 	symbols__sort_locked(symbols);
@@ -614,14 +690,37 @@ void symbols__fixup_duplicate(struct symbols *symbols)
 	}
 
 	for (unsigned int read_idx = 1; read_idx < symbols->cnt; read_idx++) {
-		struct symbol *curr = symbols->symbols[write_idx];
 		struct symbol *next = symbols->symbols[read_idx];
+		struct symbol *curr;
+		unsigned int match_idx = write_idx;
+		bool matched = false;
 
-		if (symbol__start(curr) != symbol__start(next)) {
+		if (symbol__start(symbols->symbols[group_start]) != symbol__start(next)) {
 			symbols->symbols[++write_idx] = next;
+			group_start = write_idx;
 			continue;
 		}
 
+		if (!symbol_conf.allow_aliases) {
+			matched = true;
+		} else {
+			for (unsigned int k = group_start; k <= write_idx; k++) {
+				if (strcmp(symbol__name(symbols->symbols[k]),
+					   symbol__name(next)) == 0) {
+					match_idx = k;
+					matched = true;
+					break;
+				}
+			}
+		}
+
+		if (!matched) {
+			symbols->symbols[++write_idx] = next;
+			continue;
+		}
+
+		curr = symbols->symbols[match_idx];
+
 		if (choose_best_symbol(curr, next) == SYMBOL_A) {
 			if (symbol__type(next) == STT_GNU_IFUNC)
 				symbol__set_ifunc_alias(curr, true);
@@ -630,7 +729,13 @@ void symbols__fixup_duplicate(struct symbols *symbols)
 			if (symbol__type(curr) == STT_GNU_IFUNC)
 				symbol__set_ifunc_alias(next, true);
 			symbol__put(curr);
-			symbols->symbols[write_idx] = next;
+			symbols->symbols[match_idx] = next;
+			while (match_idx < write_idx &&
+			       !symbol__less_or_equal(next, symbols->symbols[match_idx + 1])) {
+				symbols->symbols[match_idx] = symbols->symbols[match_idx + 1];
+				symbols->symbols[match_idx + 1] = next;
+				match_idx++;
+			}
 		}
 	}
 	symbols->cnt = write_idx + 1;
@@ -676,44 +781,47 @@ void symbols__fixup_end(struct symbols *symbols, bool is_kallsyms)
 		 * like in:
 		 *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_hdmi]
 		 */
-		if (symbol__end(prev) == symbol__start(prev) &&
-		    symbol__start(prev) != symbol__start(curr)) {
-			const char *prev_mod;
-			const char *curr_mod;
+		if (symbol__start(prev) != symbol__start(curr)) {
+			if (symbol__end(prev) == symbol__start(prev)) {
+				const char *prev_mod;
+				const char *curr_mod;
 
-			if (!is_kallsyms) {
-				symbol__set_end(prev, symbol__start(curr));
-			} else {
-				prev_mod = strchr(symbol__name(prev), '[');
-				curr_mod = strchr(symbol__name(curr), '[');
-
-				/* Last kernel/module symbol mapped to end of page */
-				if (!prev_mod != !curr_mod) {
-					symbol__set_end(prev,
-							roundup(symbol__end(prev) + 4096, 4096));
-				/* Last symbol in the previous module */
-				} else if (prev_mod && strcmp(prev_mod, curr_mod)) {
-					symbol__set_end(prev,
-							roundup(symbol__end(prev) + 4096, 4096));
-				} else {
+				if (!is_kallsyms) {
 					symbol__set_end(prev, symbol__start(curr));
-				}
+				} else {
+					prev_mod = strchr(symbol__name(prev), '[');
+					curr_mod = strchr(symbol__name(curr), '[');
+
+					/* Last kernel/module symbol mapped to end of page */
+					if (!prev_mod != !curr_mod) {
+						symbol__set_end(prev,
+								roundup(symbol__end(prev) + 4096,
+									4096));
+					/* Last symbol in the previous module */
+					} else if (prev_mod && strcmp(prev_mod, curr_mod)) {
+						symbol__set_end(prev,
+								roundup(symbol__end(prev) + 4096,
+									4096));
+					} else {
+						symbol__set_end(prev, symbol__start(curr));
+					}
 
-				/* The next module can start within that page */
-				if (symbol__end(prev) > symbol__start(curr))
-					symbol__set_end(prev, symbol__start(curr));
+					/* The next module can start within that page */
+					if (symbol__end(prev) > symbol__start(curr))
+						symbol__set_end(prev, symbol__start(curr));
 
-				pr_debug4("%s sym:%s end:%#" PRIx64 "\n",
-					  __func__, symbol__name(prev), symbol__end(prev));
-			}
+					pr_debug4("%s sym:%s end:%#" PRIx64 "\n",
+						  __func__, symbol__name(prev), symbol__end(prev));
+				}
 
-			for (unsigned int k = i - 1; k > 0; k--) {
-				struct symbol *same = symbols->symbols[k - 1];
+				for (unsigned int k = i - 1; k > 0; k--) {
+					struct symbol *same = symbols->symbols[k - 1];
 
-				if (symbol__start(same) != symbol__start(prev) ||
-				    symbol__end(same) != symbol__start(same))
-					break;
-				symbol__set_end(same, symbol__end(prev));
+					if (symbol__start(same) != symbol__start(prev) ||
+					    symbol__end(same) != symbol__start(same))
+						break;
+					symbol__set_end(same, symbol__end(prev));
+				}
 			}
 		}
 	}
@@ -860,6 +968,118 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 	return 0;
 }
 
+static void symbols__detach_retained(struct symbols *symbols,
+				     struct symbol ***retained,
+				     unsigned int *retained_cnt,
+				     unsigned int *retained_allocated)
+{
+	down_write(&symbols->lock);
+	symbols__sort_locked(symbols);
+	*retained = symbols->symbols;
+	*retained_cnt = symbols->cnt;
+	*retained_allocated = symbols->allocated;
+	symbols->symbols = NULL;
+	symbols->cnt = 0;
+	symbols->sorted_cnt = 0;
+	symbols->allocated = 0;
+	zfree(&symbols->symbols_by_name);
+	symbols->num_by_name = 0;
+	symbols->sorted = true;
+	symbols->sorted_by_name = false;
+	up_write(&symbols->lock);
+}
+
+static void symbols__restore_retained(struct symbols *symbols,
+				      struct symbol **retained,
+				      unsigned int retained_cnt,
+				      unsigned int retained_allocated)
+{
+	down_write(&symbols->lock);
+	symbols__delete_locked(symbols);
+	symbols->symbols = retained;
+	symbols->cnt = retained_cnt;
+	symbols->sorted_cnt = retained_cnt;
+	symbols->allocated = retained_allocated;
+	symbols->sorted = true;
+	symbols__sort_locked(symbols);
+	atomic_store_explicit(&symbols->shrunk, false, memory_order_release);
+	up_write(&symbols->lock);
+}
+
+static void symbols__merge_retained(struct symbols *symbols,
+				    struct symbol **retained,
+				    unsigned int retained_cnt)
+{
+	unsigned int fresh_cnt;
+	bool need_sort = false;
+
+	if (!retained)
+		return;
+
+	down_write(&symbols->lock);
+	symbols__sort_locked(symbols);
+	fresh_cnt = symbols->cnt;
+
+	for (unsigned int i = 0; i < retained_cnt; i++) {
+		struct symbol *ret_sym = retained[i];
+		u64 start = symbol__start(ret_sym);
+		unsigned int low = 0, high = fresh_cnt;
+		unsigned int match_idx = fresh_cnt;
+
+		while (low < high) {
+			unsigned int mid = low + (high - low) / 2;
+
+			if (symbol__start(symbols->symbols[mid]) < start)
+				low = mid + 1;
+			else
+				high = mid;
+		}
+
+		for (unsigned int k = low;
+		     k < fresh_cnt && symbol__start(symbols->symbols[k]) == start;
+		     k++) {
+			bool already_retained = false;
+
+			if (strcmp(symbol__name(symbols->symbols[k]),
+				   symbol__name(ret_sym)) != 0)
+				continue;
+
+			for (unsigned int j = 0; j < i; j++) {
+				if (RC_CHK_EQUAL(symbols->symbols[k], retained[j])) {
+					already_retained = true;
+					break;
+				}
+			}
+			if (!already_retained) {
+				match_idx = k;
+				break;
+			}
+		}
+
+		if (match_idx < fresh_cnt) {
+			struct symbol *fresh_sym = symbols->symbols[match_idx];
+
+			symbol__set_end(ret_sym, symbol__end(fresh_sym));
+			if (symbol__ifunc_alias(fresh_sym))
+				symbol__set_ifunc_alias(ret_sym, true);
+			symbols->symbols[match_idx] = ret_sym;
+			symbol__put(fresh_sym);
+		} else if (__symbols__insert(symbols, ret_sym) == 0) {
+			need_sort = true;
+		}
+	}
+
+	if (need_sort)
+		symbols__sort_locked(symbols);
+
+	zfree(&symbols->symbols_by_name);
+	symbols->num_by_name = 0;
+	symbols->sorted_by_name = false;
+	atomic_store_explicit(&symbols->shrunk, false, memory_order_release);
+	up_write(&symbols->lock);
+	free(retained);
+}
+
 static int __symbols__insert_sorted(struct symbols *symbols, struct symbol *sym)
 {
 	unsigned int idx;
@@ -1449,6 +1669,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	zfree(&root->symbols_by_name);
 	root->num_by_name = 0;
 	root->sorted_by_name = false;
+	atomic_store_explicit(&root->shrunk, false, memory_order_release);
 	up_write(&root->lock);
 
 	for (unsigned int i = 0; i < old_cnt; i++) {
@@ -1679,6 +1900,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	zfree(&root->symbols_by_name);
 	root->num_by_name = 0;
 	root->sorted_by_name = false;
+	atomic_store_explicit(&root->shrunk, false, memory_order_release);
 	up_write(&root->lock);
 	free(old_symbols);
 
@@ -1711,6 +1933,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	zfree(&root->symbols_by_name);
 	root->num_by_name = 0;
 	root->sorted_by_name = false;
+	atomic_store_explicit(&root->shrunk, false, memory_order_release);
 	up_write(&root->lock);
 	free(old_symbols);
 	return -1;
@@ -2388,6 +2611,11 @@ int dso__load(struct dso *dso, struct map *map)
 	struct symsrc *syms_ss = NULL, *runtime_ss = NULL;
 	bool kmod;
 	bool perfmap;
+	bool was_shrunk;
+	bool saved_adjust_symbols;
+	struct symbol **retained = NULL;
+	unsigned int retained_cnt = 0;
+	unsigned int retained_allocated = 0;
 	struct nscookie nsc;
 	char newmapname[PATH_MAX];
 	const char *map_path = dso__long_name(dso);
@@ -2408,8 +2636,15 @@ int dso__load(struct dso *dso, struct map *map)
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
 		ret = 1;
-		goto out;
+		goto out_unlock;
 	}
+	was_shrunk = dso__symbols_shrunk(dso);
+	saved_adjust_symbols = dso__adjust_symbols(dso);
+	if (was_shrunk) {
+		symbols__detach_retained(dso__symbols(dso), &retained,
+					 &retained_cnt, &retained_allocated);
+	}
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->loaded, false, memory_order_release);
 
 	kmod = dso__is_kmod(dso);
 
@@ -2556,6 +2791,8 @@ int dso__load(struct dso *dso, struct map *map)
 		nr_plt = dso__synthesize_plt_symbols(dso, runtime_ss);
 		if (nr_plt > 0)
 			ret += nr_plt;
+		if (nr_plt > 0 || !dso__symbols(dso)->sorted)
+			symbols__fixup_duplicate(dso__symbols(dso));
 	}
 
 out_destroy:
@@ -2566,7 +2803,22 @@ int dso__load(struct dso *dso, struct map *map)
 	if (ret < 0 && strstr(dso__name(dso), " (deleted)") != NULL)
 		ret = 0;
 out:
-	dso__set_loaded(dso);
+	if (was_shrunk) {
+		if (ret > 0) {
+			symbols__merge_retained(dso__symbols(dso), retained, retained_cnt);
+		} else {
+			dso__set_adjust_symbols(dso, saved_adjust_symbols);
+			symbols__restore_retained(dso__symbols(dso), retained,
+						  retained_cnt, retained_allocated);
+			if (retained_cnt > 0)
+				ret = retained_cnt;
+		}
+		dso__set_symbols_shrunk(dso, false);
+		dso__set_loaded(dso);
+	} else {
+		dso__set_loaded(dso);
+	}
+out_unlock:
 	mutex_unlock(dso__lock(dso));
 	nsinfo__mountns_exit(&nsc);
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 066697d8da8f..7d6469d6a976 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -135,12 +135,18 @@ struct symbols {
 	 * by name.
 	 */
 	bool sorted_by_name;
+	/**
+	 * @shrunk: True when symbols have been evicted by symbols__shrink()
+	 * and may need to be reloaded on demand.
+	 */
+	_Atomic bool shrunk;
 };
 
 void symbol__delete(struct symbol *sym);
 void symbols__init(struct symbols *symbols);
 void symbols__exit(struct symbols *symbols);
 void symbols__delete(struct symbols *symbols);
+size_t symbols__shrink(struct symbols *symbols);
 void symbols__sort_read_lock(struct symbols *symbols) SHARED_LOCK_FUNCTION(symbols->lock);
 
 static inline refcount_t *symbol__refcnt(struct symbol *sym)
-- 
2.56.0.313.g2479322e68-goog

