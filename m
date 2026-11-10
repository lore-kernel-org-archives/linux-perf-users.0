Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348547;
	b=jeQ+nsT5Sgmio9ak+yBph3KIWwo1CML5+yVrVvIkQFu0zc3eFMb5TPvxFNcQYrDRoVBb
	 Oefm5k7GE3h+iyXxgYczTuqv90UfejIVl2kMaf8N7MrGyPLCUASicjjLfkOlMLJauz0dz
	 wUW3959yM1v8ttNF1hIG99DMaTibqn+btLARID8MDszLoxNp8uzTCpAgrVobXBjoDUStJ
	 Ruk7xPTynLrQZZP+rwTiM+5o2t6ExlArRlMBumk9EcOE28NURC7I0ST+mC52RvBoxG2tn
	 28W3Is8AbZWmL7Muau5XB8qW8hbX35tTAIv2u/XJLDme8FqpMaXt6KaEYC88v/DbrAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=vGQiNP+IBjnTdDD8bdhsdarwy3drChwyEkUSUVvhp+w=;
	b=AC2ABgDmb26bcG5m9TsuorV1cKms7xQR31IWCG3rtOcE8FJngOFP7a2cqwXAhnfOaJoU
	 gmsEVwQCG3Oo0gEncep3hQ0Q3pFBSXnDWm4qx4DZhY5iZFrn3hcrRH2dTEYZ0C28PdJ1r
	 5Xy/NaFRQoEU/JjWNlqzBu8pIjkv8vSJpKzuOxZAcSM/leOBkN816pyp1nfSCItweJppT
	 pU/pmtJCMCaMkvC3k8Dr4O1guad3XBDHdKXEfwShBzsul+bgJgIut27SrsZn5a/noUkQC
	 qyp5nbK87znYmjjvXR1GLVtXt0aWP5mybBpQfGTntLMqlcSWWXxe8u253rtt/VvWZlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BhjrHElF;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F45C606AE13
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F45C606AE13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BhjrHElF
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36ecd5db581so3651102eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794348546; x=1794953346; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vGQiNP+IBjnTdDD8bdhsdarwy3drChwyEkUSUVvhp+w=;
        b=BhjrHElFnmfAWd4LlJwwtYvnvMKOmzDdIzSD/aVK3VeOfnsQR7QvHJ0x0Mts+Bp055
         nCQJ/bNUmXS71kW2bijHtt8OAQDvrpWDw4hDJwuL1dEUstdrE9AKXkvKcwI40HZ9nIl7
         u9dOAgOuz7QlogHXwUsjFO7lhJvskEifIimDML7s9Utcb3nlB5ETtnzWmWdMthsqb5x/
         HXO6+PzLf3jDpYbMVZCnVNk4xt+w2jmwmfPmdGXCy/5yeZEHLoWzH46ZEDMA/BPKoI7P
         VSKBxeGL1b04VKrfzw0RrRqBF6YNP6M0eItoJqmtrIqn8taH8KMfVN99vaWNb9/qNuwv
         39JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348546; x=1794953346;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vGQiNP+IBjnTdDD8bdhsdarwy3drChwyEkUSUVvhp+w=;
        b=V99BJ4n2eqiGce7kznqiat62kuVP0mbCfI9G4s2fa2JlpDUSH3utO/xaaiwZifJt3p
         P3zCTCsuM5Xr4fMeHbAzq6Il2Y1fkJodT1FlQaoIXSYYPqeQezIn1KI+Vm3nzH/Q6ZMA
         CSxmBjh267ewi0C2p98qkdjGn76N6MYuI2ngozo12RZZ6pZisnrooilok1O2N7RhZjqX
         GmvTl9J0wFw2fnT0Oy6QHAO0hZkbVecE0za2yC2wYROOz2q+5GKLSE0FVUpG11mylqMH
         fG7IPTRzyNZfMTai1+2FgEukoebCxp8IKHfyjmjkmH6sCKdzS+G9sfMfhX3MUPKbewyv
         SYSQ==
X-Forwarded-Encrypted: i=1; AL+hErHg11Q+gqvl+zZ7+0aTywe6AgPT6Fv0fW4JPh+dNBWGYMDQxIw4TWxtrn5ULoQgRfYT3AHGZIfM66Oi2W1fPybK@vger.kernel.org
X-Gm-Message-State: APuU4Z/gGR4ygq9VJZRKMMUqNTShiZFXsElTWRiMITd8UYF7jSFiGP5+
	3byY8IKx0aCkfBFiizzeuzZcPVNxPyEfTMR5uKmnwcFUGFqXcIDrrfWxPHeAhDE7NuZHVOY3GNR
	So64OaAardA==
X-Received: from dycqz3.prod.google.com ([2002:a05:7301:df43:b0:360:7b4:106a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dd09:b0:36e:20ee:b288
 with SMTP id 5a478bee46e88-37685d717b8mr826214eec.12.1794348545229; Tue, 10
 Nov 2026 14:09:05 -0800 (PST)
Date: Tue, 10 Nov 2026 14:08:00 -0800
In-Reply-To: <20261110220803.2503416-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027231513.816148-1-irogers@google.com> <20261110220803.2503416-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110220803.2503416-18-irogers@google.com>
Subject: [PATCH v3 17/20] perf symbol: Add memory shrinking for symbols, DSOs,
 and machines
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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
   and trims unused over-allocated tail capacity in the symbols array,
   using down_write_trylock() so shrinking never deadlocks if invoked
   while a symbol table lock is already held on the current stack.

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
 tools/perf/util/dso.c     | 198 ++++++++++++++++++++++++++++++++++----
 tools/perf/util/dso.h     |  13 ++-
 tools/perf/util/dsos.c    |  69 +++++++++++++
 tools/perf/util/dsos.h    |   2 +
 tools/perf/util/machine.c |  32 ++++++
 tools/perf/util/machine.h |   3 +
 tools/perf/util/session.c |   8 ++
 tools/perf/util/session.h |   2 +
 tools/perf/util/symbol.c  |  73 +++++++++++++-
 tools/perf/util/symbol.h  |   3 +
 10 files changed, 381 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 35a5c65030af..184d49935bfd 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2,6 +2,7 @@
 #include "dso.h"
 
 #include <errno.h>
+#include <stdatomic.h>
 #include <stdlib.h>
 
 #include <asm/bug.h>
@@ -1075,12 +1076,12 @@ static int bpf_size(struct dso *dso)
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
 
@@ -1089,6 +1090,13 @@ dso_cache__free(struct dso *dso)
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
 
@@ -1243,27 +1251,30 @@ static struct dso_cache *dso_cache__populate(struct dso *dso,
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
@@ -1803,7 +1814,7 @@ int dso__name_len(const struct dso *dso)
 
 bool dso__loaded(const struct dso *dso)
 {
-	return RC_CHK_ACCESS(dso)->loaded;
+	return atomic_load_explicit(&RC_CHK_ACCESS(dso)->loaded, memory_order_acquire);
 }
 
 bool dso__sorted_by_name(const struct dso *dso)
@@ -1835,7 +1846,7 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->binary_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->dbginfo_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->is_64_bit = (sizeof(void *) == 8);
-		dso->loaded = 0;
+		atomic_init(&dso->loaded, false);
 		dso->rel = 0;
 		dso->has_srcline = 1;
 		dso->a2l_fails = 1;
@@ -1896,6 +1907,154 @@ void dso__delete(struct dso *dso)
 	RC_CHK_FREE(dso);
 }
 
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
+	if (dso__dsos(dso) && refcount_read(dso__refcnt(dso)) == 1 &&
+	    dso__can_shrink_symbols(dso) && dso__has_symbols(dso) &&
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
 struct dso *dso__get(struct dso *dso)
 {
 	struct dso *result;
@@ -1909,7 +2068,8 @@ struct dso *dso__get(struct dso *dso)
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
index f23cf9957aec..7f217815ec07 100644
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
@@ -783,6 +784,14 @@ static inline bool dso__has_symbols(const struct dso *dso)
 	return RC_CHK_ACCESS(dso)->symbols.cnt > 0;
 }
 
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
index e927e707abac..f6868ffcc3e1 100644
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
@@ -493,3 +496,69 @@ int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data)
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
+		    !dso__is_vdso(dso) &&
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
index 7c83321eea76..dad06eb865e6 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3440,3 +3440,35 @@ int machine__hit_all_dsos(struct machine *machine)
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
index 9d211a745049..9d7c87bcbbea 100644
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
@@ -254,6 +255,74 @@ void symbols__exit(struct symbols *symbols)
 	exit_rwsem(&symbols->lock);
 }
 
+bool symbols__try_delete_unannotated(struct symbols *symbols,
+				     void (*pre_delete)(void *ctx), void *ctx)
+{
+	if (!down_write_trylock(&symbols->lock))
+		return false;
+
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
+ * Uses down_write_trylock() so this is safe to call from OOM recovery
+ * paths where the current thread might already hold a lock on @symbols.
+ *
+ * Returns the number of buffers reclaimed/shrunk.
+ */
+size_t symbols__shrink(struct symbols *symbols)
+{
+	size_t freed = 0;
+
+	if (!down_write_trylock(&symbols->lock))
+		return 0;
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
 static inline bool symbol__less_or_equal(const struct symbol *a, const struct symbol *b)
 {
 	return symbol__start(a) <= symbol__start(b);
@@ -2404,8 +2473,9 @@ int dso__load(struct dso *dso, struct map *map)
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
 		ret = 1;
-		goto out;
+		goto out_unlock;
 	}
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->loaded, false, memory_order_release);
 
 	kmod = dso__is_kmod(dso);
 
@@ -2563,6 +2633,7 @@ int dso__load(struct dso *dso, struct map *map)
 		ret = 0;
 out:
 	dso__set_loaded(dso);
+out_unlock:
 	mutex_unlock(dso__lock(dso));
 	nsinfo__mountns_exit(&nsc);
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 97cdc2e962c6..e68248be38c5 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -140,6 +140,9 @@ void symbol__delete(struct symbol *sym);
 void symbols__init(struct symbols *symbols);
 void symbols__exit(struct symbols *symbols);
 void symbols__delete(struct symbols *symbols);
+bool symbols__try_delete_unannotated(struct symbols *symbols,
+				     void (*pre_delete)(void *ctx), void *ctx);
+size_t symbols__shrink(struct symbols *symbols);
 void symbols__sort_read_lock(struct symbols *symbols) SHARED_LOCK_FUNCTION(symbols->lock);
 
 static inline __attribute__((nonnull)) u64 symbol__start(const struct symbol *sym)
-- 
2.56.0.542.g3ef89b7020-goog

