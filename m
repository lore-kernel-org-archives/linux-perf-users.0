Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810895;
	b=EDyeo04oKuSrrdjkTAIMp0+/BEajqhCU1+UlC8c3macTAY8hg66TlA/11E8v/aVhUhUU
	 2slZv4d5t+d2R5Uig5y8amn/e15Z94yBajOSrH5jOyOYrig9HYeuPRTw52fJ/XewL55fQ
	 f2KIzaqE2y9W9u4iu4zW12PRhB/waf9Y6zz03PtVmY6Jk8HErr/8t3F331yBbTgKbbNcL
	 +hoUjMr3VBcSae09lbZ3VA0xywTu3DHlk33O53F4DndPJu+wYjfOewOYtbQNtKGjOOmHW
	 clHNhZEPWaljzbY3POxkXaNKrkHOH3qtZvJ37QhcwV6cL9gLHHKkE0otlz/YF8enDWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=wPy/Ks9GtjoR67/JiqWkVgdMRu7+K0pLJXssj+f4I7k=;
	b=2Y80VJQFq+qAG8eueGb1PWRQwDu9oEuf0+uyKNjZEEqbSY8ks9Tj5Y1Tl5L0nEyBroF+
	 KkPEm8+UIv9S8sdPU6FirdsXRovC+loo9dBudmEsQ3uBaHbXy6X9y5uNc8j7ZGkxb1Ve4
	 83ozoXtznTea/2y3VFei5GmV/AsV20RyYoMs73OJb2mUR30vIPssZc0YXhDu7QBKBt55M
	 33msOrPCIArYoJcfOwJ8+LLbo+0THCyNxwtXt2yF5uEie3PcHlp4YHI4D40UHBrymrFD2
	 4ONPhpXPDSpqZKEngGlm8UXIPY965EF8jXFTZfXs5HF99nlgRZbrLf5DS9Uovogh9ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LSphxBym;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3103606A8BC
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3103606A8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LSphxBym
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso4582977eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 22:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794810894; x=1795415694; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wPy/Ks9GtjoR67/JiqWkVgdMRu7+K0pLJXssj+f4I7k=;
        b=LSphxBymGM1vC/DnVt6o66YxzRCSSd1Lzt8JdC+yV4qNduGvQmVBzUtn8cTo9RHchC
         JENMnG4kniUV00+PpxS0axCMAo0TxaC2jA6mpbbUNneOLWUu2UHB1HcGlBnWFzpQUKYk
         SMCaUyQUrVwjTNH5SxrpwBhjPvDPqxGtZCuL0G8hObolofl3gGhQOvIRBrCll4AGYxPo
         JbAfBKtXJVpVQo0vl+lufb6uGT4pJT6NethMc2z4P9gRhudPLs8pKOGOppsoGMfnhMsW
         Kl3BTbaVgSy7pWvKMjnoS/ZyMgSAuUGV+xzkp/qS2758nKEADR8JWRoSVD3RzBx66F6b
         Libg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794810894; x=1795415694;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wPy/Ks9GtjoR67/JiqWkVgdMRu7+K0pLJXssj+f4I7k=;
        b=fgkxjjia+3niyqaUftNmVq690PZUU3FzweATz+pdS4G+HHTRYJjc1Wx5GILwvED4Sy
         agL8E03kg63hpovrInEK/pKdzrtKfGUpDKVRmeH9H2APi3PnU99+0Q2C9JPVzkIs9aAb
         hlmXO873DnmUde1l2whyleCzFbftOEvOtWXq+BxRH67vsO3fYUsJdktENzga4VJTxVe1
         NGH3MZr3445q3Ytn3AtrkzAGhS+Kf3KnnoR4olACiEF6G9q5Nu93no4pjaj5gCN9Oglp
         0QxmET7f8akjlXA0//ZnPFy7Bxoo0DPtiLWGQSm8yvoyslfSwiIfB3PRb8IMieNRQAIp
         gjwA==
X-Forwarded-Encrypted: i=1; AL+hErHeiKuhH7dod+jGixRaRS7UyOfbKiEACLIjsn3BQrI/VnSV7gaGFdgWktCOzSA+7luA5kfj6Qi9cyY+TLExzHa8@vger.kernel.org
X-Gm-Message-State: APuU4Z8tQJyJO+Tsl30c46fPgtTU3cguvn5iNhitdAhZNpa+FifU4oI9
	/zwEZ7ZbG+62Sz7C0JM+kovEn+MNB8dz1REiOd0jTpHfsuXoNn2Wjfwovo16XbsGSL1fCrg8P7y
	rVDDG38eTWA==
X-Received: from dyaw16-n2.prod.google.com ([2002:a05:693c:4150:20b0:34c:9660:9612])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:4003:b0:369:9af5:7bc9
 with SMTP id 5a478bee46e88-3796696128emr9921142eec.23.1794810893701; Sun, 15
 Nov 2026 22:34:53 -0800 (PST)
Date: Sun, 15 Nov 2026 22:34:33 -0800
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
Message-ID: <20261116063435.2817923-8-irogers@google.com>
Subject: [PATCH v5 7/9] perf symbol: Add memory shrinking for symbols, DSOs,
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
index f23cf9957aec..962e1ad0c463 100644
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
index 8a47d1a44e5c..e8b1445fd198 100644
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
@@ -2428,8 +2491,9 @@ int dso__load(struct dso *dso, struct map *map)
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
 		ret = 1;
-		goto out;
+		goto out_unlock;
 	}
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->loaded, false, memory_order_release);
 
 	kmod = dso__is_kmod(dso);
 
@@ -2587,6 +2651,7 @@ int dso__load(struct dso *dso, struct map *map)
 		ret = 0;
 out:
 	dso__set_loaded(dso);
+out_unlock:
 	mutex_unlock(dso__lock(dso));
 	nsinfo__mountns_exit(&nsc);
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index ce7be4b18a11..d70c01609017 100644
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
2.56.1.703.gf848ed807c-goog

