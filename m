Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D13E0C78
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178113; cv=none; b=Ew80tZgRP5XI42wU9txlt2OipI1PGInrgr/b5jZ8SrenTOKdnLr5H/7N0XOCIL+a1GMKun2+p9txki9oKvEk9VQbSNYLAj7tJT6LlGLnuk8jSkEddx3PNyntxfSeLLFlwi8PYnyR3p2hNVoErXmPT0g/iLlNJ1x+uNg1MQNR7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178113; c=relaxed/simple;
	bh=ep7COZZ9+dYsiSZc2LCfDflxg3XnWPqDjplcDPy/7jQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WoclZ+DWS2VO1prAO5ETBI69ACbKNaduLF6GawTmOVsshy/ryv9dFJ6GdRF3CNTh1ZimAL2/TKBftGmYgX78rfHupF2kw1bJvTm8cl05uyIS0waVUphPJt3d3tdtSOr1zlvxSQFArQkaGTvIHoWIXDK8ABEQv+HeUM6eJBVGJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hNM83U70; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hNM83U70"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f485961555so16280782eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779178111; x=1779782911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDL9MwqmDNfF2Jy2SVEWelU+Z3ZeBcjmLtu8epKj4/4=;
        b=hNM83U70fHtT7LbQakBWfQgWG26VmywzPaueffpBtlYwbVmMJ/agr19u9JgpBJ/bYI
         PDKy1LqZeg2r/XaQVhiR29jAU3Po4dtI0PFoprPXRyb0814psD0R/T5wCBhza9KR+1cD
         R96D4CCzWPAqN7/VXRuXQR68UBZ66dFkspLL41pGQz0UbtHbq6Sixrv3Aj7Sj3hId6A3
         xutUBkmhPY4Qw56YmqtL7N3J/JR7w0QHTTBYhc8PJpW+c4VJay4bN671dESgE21DNg1A
         PXLKWuVJBp+CK5T11bwkCG6kK+Cz+By0+hOfYlxwKG6Aim8Ho4Z6EpLgl4AstaTUerqB
         9Awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178111; x=1779782911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDL9MwqmDNfF2Jy2SVEWelU+Z3ZeBcjmLtu8epKj4/4=;
        b=Q5GT1O2cRa0yCwl/irUupZp3CExLGp1U+g0lo0ESuU1UMCN6tDWTJdvoaPt05JFyDL
         o5PDfMwzWBr8QndDsa06TKE/NmMG4gXErWVGovn1ixJj/ANmoXomZ3TikeQ7fyWq21Aq
         zA+fs8Xaq1WC3A+LRxOG1KuF5PEtow9Vw+nRF6FvTzP8Mq1bVescEV7wK8DHR8AmXr7B
         Um7y/mdFAHcDJFQ65ZaQX+MZbDA4JEs7kCJiUo+KKNrKwfHjJJuKMGwexFv2ZFnkhtVG
         fxgns5PwQFCWNhKSg4jwmOCCVyDh0Rf5Z1e3Q3DB1TjKQtFS3iiUjDy3gAEEEGeQFy6k
         1xRA==
X-Forwarded-Encrypted: i=1; AFNElJ/wh1hP0tXjgQ4nlBt9WgQLH+53RQj9kZwrfPsh1JXeOwC8Pexxqu6MrVsyvQGfeyGgNmyuuQlF0Yya7OANZ5yu@vger.kernel.org
X-Gm-Message-State: AOJu0YxLxjkFg0H6XnnTMuUNsH0o5//F/9JLwUfZfHyhpwSo+z+x9ubx
	MgFWBSqj0j+4EWsj6X9TL7Ahp+dZvo9kAFsRBuk+LUf7JBef9uqH4wT4a5MJpuaIyDZxNPWvbEa
	B1n7v4xzoOQ==
X-Received: from dycop8.prod.google.com ([2002:a05:7301:9bc8:b0:304:bc:3817])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:be17:b0:2d8:7302:d21
 with SMTP id 5a478bee46e88-303986010e1mr7935832eec.16.1779178108864; Tue, 19
 May 2026 01:08:28 -0700 (PDT)
Date: Tue, 19 May 2026 01:08:21 -0700
In-Reply-To: <20260519080824.3329601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508082726.2795191-1-irogers@google.com> <20260519080824.3329601-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519080824.3329601-2-irogers@google.com>
Subject: [PATCH v7 1/4] perf maps: Add maps__mutate_mapping
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, gmx@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

During kernel ELF symbol parsing (dso__process_kernel_symbol), proc
kallsyms image loading (dso__load_kernel_sym,
dso__load_guest_kernel_sym), and dynamic kernel memory map alignment
updates (machine__update_kernel_mmap), the loader directly modifies
live virtual address boundary keys fields on map objects.  If these
boundaries are mutated while the map pointer actively resides inside
the parent maps cache array list (kmaps) outside of any lock closure,
an unsafe concurrent window is exposed where parallel worker lookup
threads (e.g., inside perf top) can mistakenly assume the cache
remains sorted based on stale parameters, executing binary search
queries (bsearch) across an unsorted range and triggering lookups
failure.

Fix this by introducing a thread-safe, atomic transactional framework
routine maps__mutate_mapping() that explicitly acquires the parent
maps write semaphore lock, executes an incoming mutation callback
block to perform the field updates under full lock protection, and
invalidates the sorted tracking flags prior to releasing the write
lock. This guarantees absolute atomic synchronization invariants,
completely closing the concurrent lookup race window. The adjacent
module alignment pass inside machine__create_kernel_maps() is safely
preserved as a high-performance lockless pass, as its invocation
lifecycle bounds remain strictly single-threaded by contract during
session initialization construction.
To safely support this unconditional down_write write lock mutator
without recursive read-to-write self-deadlock upgrades during lazy
symbol loading, we introduce a public maps__load_maps() API. It copies
map pointers under a brief read lock and force-loads all modules
locklessly outside the lock. Callers (such as perf inject) must
pre-load all kernel symbol maps up front at startup using
maps__load_maps(), completely bypassing dynamic runtime mutations.

Fixes: 39b12f781271 ("perf tools: Make it possible to read object code from vmlinux")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c    | 32 +++++++++++++--------
 tools/perf/util/maps.c       | 55 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/maps.h       |  3 ++
 tools/perf/util/symbol-elf.c | 41 +++++++++++++++++----------
 tools/perf/util/symbol.c     | 17 ++++++++---
 5 files changed, 117 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e76f8c86e62a..ea918f75e3ad 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1522,22 +1522,30 @@ static void machine__set_kernel_mmap(struct machine *machine,
 		map__set_end(machine->vmlinux_map, ~0ULL);
 }
 
-static int machine__update_kernel_mmap(struct machine *machine,
-				     u64 start, u64 end)
+struct kernel_mmap_mutation_ctx {
+	u64 start;
+	u64 end;
+};
+
+static int kernel_mmap_mutate_cb(struct map *map, void *data)
 {
-	struct map *orig, *updated;
-	int err;
+	struct kernel_mmap_mutation_ctx *ctx = data;
 
-	orig = machine->vmlinux_map;
-	updated = map__get(orig);
+	map__set_start(map, ctx->start);
+	map__set_end(map, ctx->end);
+	if (ctx->start == 0 && ctx->end == 0)
+		map__set_end(map, ~0ULL);
+	return 0;
+}
 
-	machine->vmlinux_map = updated;
-	maps__remove(machine__kernel_maps(machine), orig);
-	machine__set_kernel_mmap(machine, start, end);
-	err = maps__insert(machine__kernel_maps(machine), updated);
-	map__put(orig);
+static int machine__update_kernel_mmap(struct machine *machine,
+				       u64 start, u64 end)
+{
+	struct kernel_mmap_mutation_ctx ctx = { .start = start, .end = end };
 
-	return err;
+	return maps__mutate_mapping(machine__kernel_maps(machine),
+				     machine->vmlinux_map,
+				     kernel_mmap_mutate_cb, &ctx);
 }
 
 int machine__create_kernel_maps(struct machine *machine)
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 923935ee21b6..f9d5dc7f673f 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -576,6 +576,32 @@ void maps__remove(struct maps *maps, struct map *map)
 #endif
 }
 
+int maps__mutate_mapping(struct maps *maps, struct map *map,
+			 int (*mutate_cb)(struct map *map, void *data), void *data)
+{
+	int err = 0;
+
+	if (maps)
+		down_write(maps__lock(maps));
+
+	err = mutate_cb(map, data);
+
+	if (maps) {
+		RC_CHK_ACCESS(maps)->maps_by_address_sorted = false;
+		RC_CHK_ACCESS(maps)->maps_by_name_sorted = false;
+	}
+
+	if (maps)
+		up_write(maps__lock(maps));
+
+#ifdef HAVE_LIBDW_SUPPORT
+	if (maps)
+		libdw__invalidate_dwfl(maps, maps__libdw_addr_space_dwfl(maps));
+#endif
+
+	return err;
+}
+
 bool maps__empty(struct maps *maps)
 {
 	bool res;
@@ -626,6 +652,35 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 	return ret;
 }
 
+int maps__load_maps(struct maps *maps)
+{
+	struct map **maps_copy;
+	unsigned int nr_maps;
+	int err = 0;
+
+	if (!maps)
+		return 0;
+
+	down_read(maps__lock(maps));
+	nr_maps = maps__nr_maps(maps);
+	maps_copy = calloc(nr_maps, sizeof(*maps_copy));
+	if (!maps_copy) {
+		up_read(maps__lock(maps));
+		return -ENOMEM;
+	}
+	for (unsigned int i = 0; i < nr_maps; i++)
+		maps_copy[i] = map__get(maps__maps_by_address(maps)[i]);
+	up_read(maps__lock(maps));
+
+	for (unsigned int i = 0; i < nr_maps; i++) {
+		if (map__load(maps_copy[i]) < 0)
+			err = -1;
+		map__put(maps_copy[i]);
+	}
+	free(maps_copy);
+	return err;
+}
+
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data)
 {
 	struct map **maps_by_address;
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 5b80b199685e..4ec9b7453a3b 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -59,8 +59,11 @@ void maps__set_libdw_addr_space_dwfl(struct maps *maps, void *dwfl);
 
 size_t maps__fprintf(struct maps *maps, FILE *fp);
 
+int maps__load_maps(struct maps *maps);
 int maps__insert(struct maps *maps, struct map *map);
 void maps__remove(struct maps *maps, struct map *map);
+int maps__mutate_mapping(struct maps *maps, struct map *map,
+			 int (*mutate_cb)(struct map *map, void *data), void *data);
 
 struct map *maps__find(struct maps *maps, u64 addr);
 struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 7afa8a117139..dc4ab58857b3 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1341,6 +1341,24 @@ static u64 ref_reloc(struct kmap *kmap)
 void __weak arch__sym_update(struct symbol *s __maybe_unused,
 		GElf_Sym *sym __maybe_unused) { }
 
+struct remap_kernel_ctx {
+	u64 sh_addr;
+	u64 sh_size;
+	u64 sh_offset;
+	struct kmap *kmap;
+};
+
+static int remap_kernel_cb(struct map *map, void *data)
+{
+	struct remap_kernel_ctx *ctx = data;
+
+	map__set_start(map, ctx->sh_addr + ref_reloc(ctx->kmap));
+	map__set_end(map, map__start(map) + ctx->sh_size);
+	map__set_pgoff(map, ctx->sh_offset);
+	map__set_mapping_type(map, MAPPING_TYPE__DSO);
+	return 0;
+}
+
 static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 				      GElf_Sym *sym, GElf_Shdr *shdr,
 				      struct maps *kmaps, struct kmap *kmap,
@@ -1371,22 +1389,15 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		 * map to the kernel dso.
 		 */
 		if (*remap_kernel && dso__kernel(dso) && !kmodule) {
+			struct remap_kernel_ctx ctx = {
+				.sh_addr = shdr->sh_addr,
+				.sh_size = shdr->sh_size,
+				.sh_offset = shdr->sh_offset,
+				.kmap = kmap
+			};
+
 			*remap_kernel = false;
-			map__set_start(map, shdr->sh_addr + ref_reloc(kmap));
-			map__set_end(map, map__start(map) + shdr->sh_size);
-			map__set_pgoff(map, shdr->sh_offset);
-			map__set_mapping_type(map, MAPPING_TYPE__DSO);
-			/* Ensure maps are correctly ordered */
-			if (kmaps) {
-				int err;
-				struct map *tmp = map__get(map);
-
-				maps__remove(kmaps, map);
-				err = maps__insert(kmaps, map);
-				map__put(tmp);
-				if (err)
-					return err;
-			}
+			maps__mutate_mapping(kmaps, map, remap_kernel_cb, &ctx);
 		}
 
 		/*
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fcaeeddbbb6b..09b93e844887 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -48,6 +48,13 @@
 #include <symbol/kallsyms.h>
 #include <sys/utsname.h>
 
+static int map_fixup_cb(struct map *map, void *data __maybe_unused)
+{
+	map__fixup_start(map);
+	map__fixup_end(map);
+	return 0;
+}
+
 static int dso__load_kernel_sym(struct dso *dso, struct map *map);
 static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
 static bool symbol__is_idle(const char *name);
@@ -2121,10 +2128,11 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 	free(kallsyms_allocated_filename);
 
 	if (err > 0 && !dso__is_kcore(dso)) {
+		struct maps *kmaps = map__kmaps(map);
+
 		dso__set_binary_type(dso, DSO_BINARY_TYPE__KALLSYMS);
 		dso__set_long_name(dso, DSO__NAME_KALLSYMS, false);
-		map__fixup_start(map);
-		map__fixup_end(map);
+		maps__mutate_mapping(kmaps, map, map_fixup_cb, NULL);
 	}
 
 	return err;
@@ -2164,10 +2172,11 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
 	if (err > 0)
 		pr_debug("Using %s for symbols\n", kallsyms_filename);
 	if (err > 0 && !dso__is_kcore(dso)) {
+		struct maps *kmaps = map__kmaps(map);
+
 		dso__set_binary_type(dso, DSO_BINARY_TYPE__GUEST_KALLSYMS);
 		dso__set_long_name(dso, machine->mmap_name, false);
-		map__fixup_start(map);
-		map__fixup_end(map);
+		maps__mutate_mapping(kmaps, map, map_fixup_cb, NULL);
 	}
 
 	return err;
-- 
2.54.0.631.ge1b05301d1-goog

