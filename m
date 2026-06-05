Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBCA212566
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639580; cv=none; b=AgLQYN065yCUQhPQZVY/K7ZrpDUWf4lWR/Z4BB001mtBJdeUEUz6wm+njm74vFXLftKcth4SVirDxmMGQFQ2MaUS5vIrxMsAVfK3AjzmK2uB8bOk/aK/WqLx3T3w4AlnJH5OXawhivF1ein40lN7IB9eHFFa2Q+xK9pvApOctKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639580; c=relaxed/simple;
	bh=oqFL4TvznYhSYIrGYhpVHBm3iO4Y+voAW799c1B52Jw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ECMPqCM9s5AGmah8nPUe9Hr0Gor2Q6b4Cne3RWcxCisT5KwkRUAODeaP0kkH/K21itqovXsxUXUNYZbjF5BJHWesQZIavgEwepa5ZpzTKEe3nIP+JeWJcZYUKA70631Jk3JktLqOTysO+Z64UTt+GZsiG0fI1i2v1/TSoLZtRa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbPM/XtD; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbPM/XtD"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30761ab3483so5266153eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 23:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780639578; x=1781244378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=81KJd5lFxzAQE12BvQ4bUE8zyCqZmtUcO7gBCE9fIas=;
        b=kbPM/XtDUE2hEiN4x2L6v7hgSWId/IKl7apSRoIrmWeAPEAUIyP9DFnkKU48IZ9Pvt
         GQfWIR3jP3j6e2kMvBXhhog9Ph2/hZxPqmEX0eg6m+JZBuf3vDI5f1rmUAEPSDIX8HjP
         AGz8JSd96ueUJxXghpliU8u7j9vQDqP5lSWuRAUFQ4136wtwhB8cA36Q3EOEMm+vgJLK
         hMtIMNg3r0qie4JBii7si7XL9HSRms/k0f6y6dnXMSxXsMdc4/zk2nZmXKN7bISFvxN0
         dRSDAZ7ZCn2WKgWgXhalFZh7NyYEvvPkcZseUm1nxa0HiYeJbncowmdRuyqYRGBu8fbL
         rFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780639578; x=1781244378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81KJd5lFxzAQE12BvQ4bUE8zyCqZmtUcO7gBCE9fIas=;
        b=FtIgSE68Wf1Ip2Dmbb2ZjMGqhYWHWbMTEbPTRcWa5PC6Bkk3xiLCHlLEnHrIf0c+b4
         iN392vHyOX1Jl6M5kFU956jUxW4OTXcOuCIvng2yvdaq/9s74Tv8RXaXF+GYvGgvKaBg
         qgQVcqlbhgKhT/2sEvSYkffeem56cajGGZbHTO4aXNmrlAIxJUfnIDL75syxzCVIxLkD
         5ossyBZ23N8ET3dx3w7771rFWzReKtvefm6662O9lg2R9AoOZZ7jleLDqqsgU64HQN8u
         NgP9RUeiQufm/SZuJMB60fN/0S6lWnks733FbeuDGpjJzH4u00dox/nsnNHR1/bFSua3
         D9vg==
X-Forwarded-Encrypted: i=1; AFNElJ+7HF0mgXPPIsm0FmwhXeUSf9PvkVHpQBiFCGgO3/ABn0ton7eR97mJjGe1A/RKGmmp4ceNqGNJOdSlzfJ6oz/X@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRwiCVPmGFOJYOfG33UL0NeImYY2SPvkcElqusTzulbQh6zge
	87cQ+EuKhrtQGZxG5tRPtu9zF04nA6fGZifnR4wMQQszWIwvW/DdWq/0f106mVfduq4mHWOum3l
	59xgKfUEpEQ==
X-Received: from dycme23.prod.google.com ([2002:a05:693c:2417:b0:2e5:fa99:f6e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:300b:b0:2ef:9961:27fa
 with SMTP id 5a478bee46e88-3077b47c35amr932916eec.18.1780639578082; Thu, 04
 Jun 2026 23:06:18 -0700 (PDT)
Date: Thu,  4 Jun 2026 23:06:06 -0700
In-Reply-To: <20260605060610.1529996-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604172850.683329-1-irogers@google.com> <20260605060610.1529996-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605060610.1529996-2-irogers@google.com>
Subject: [PATCH v10 1/5] perf maps: Add maps__mutate_mapping
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, gmx@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
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
queries (bsearch) across an unsorted range and triggering lookup
failures.

Fix this by introducing maps__mutate_mapping() that explicitly
acquires the parent maps write semaphore lock, executes an incoming
mutation callback block to perform the field updates under lock
protection, and invalidates the sorted tracking flags prior to
releasing the write lock. This guarantees synchronization invariants,
closing the concurrent lookup race window. The adjacent module
alignment pass inside machine__create_kernel_maps() is safely
preserved as a high-performance lockless pass, as its invocation
lifecycle bounds remain strictly single-threaded by contract during
session initialization construction.  To safely support this
unconditional down_write write lock mutator without recursive
read-to-write self-deadlock upgrades during lazy symbol loading, we
introduce a public maps__load_maps() API. It copies map pointers under
a brief read lock and force-loads all modules locklessly outside the
lock. Callers (such as perf inject) must pre-load all kernel symbol
maps up front at startup using maps__load_maps(), completely bypassing
dynamic runtime mutations.

Fixes: 39b12f781271 ("perf tools: Make it possible to read object code from vmlinux")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c    | 32 +++++++++------
 tools/perf/util/maps.c       | 80 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/maps.h       |  3 ++
 tools/perf/util/symbol-elf.c | 41 +++++++++++-------
 tools/perf/util/symbol.c     | 17 ++++++--
 5 files changed, 142 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index da1ad58758af..1ea06fde14e0 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1539,22 +1539,30 @@ static void machine__set_kernel_mmap(struct machine *machine,
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
index 923935ee21b6..be77dee16041 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -576,6 +576,49 @@ void maps__remove(struct maps *maps, struct map *map)
 #endif
 }
 
+/**
+ * maps__mutate_mapping - Apply write-protected mutations to a map.
+ * @maps: The maps collection containing the map.
+ * @map: The map to mutate.
+ * @mutate_cb: Callback function that performs the actual mutations.
+ * @data: Private data passed to the callback.
+ *
+ * This acquires the write lock on the maps semaphore to safely protect
+ * concurrent readers from seeing partially mutated or unsorted map boundaries.
+ *
+ * WARNING: Acquiring down_write() here can trigger a recursive self-deadlock if
+ * the caller already holds the read lock (e.g., during maps__for_each_map() or
+ * maps__find() iteration paths that trigger lazy symbol loading). To completely
+ * avoid this deadlock, all kernel/module maps must be pre-loaded up-front (via
+ * maps__load_maps()) under a clean, single-threaded context before entering
+ * multi-threaded event processing loops.
+ */
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
@@ -626,6 +669,41 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
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
+	if (nr_maps == 0) {
+		up_read(maps__lock(maps));
+		return 0;
+	}
+	maps_copy = calloc(nr_maps, sizeof(*maps_copy));
+	if (!maps_copy) {
+		RC_CHK_ACCESS(maps)->maps_by_address_sorted = false;
+		RC_CHK_ACCESS(maps)->maps_by_name_sorted = false;
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
@@ -700,6 +778,8 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, st
 		.sym = NULL,
 	};
 
+	if (maps__load_maps(maps) < 0)
+		return NULL;
 	maps__for_each_map(maps, maps__find_symbol_by_name_cb, &args);
 	return args.sym;
 }
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
index 186e6d92ac3d..d1e93c0556dd 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1342,6 +1342,24 @@ static u64 ref_reloc(struct kmap *kmap)
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
@@ -1372,22 +1390,15 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
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
index 0c46b24ee098..2cc911af8c81 100644
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
 
@@ -2240,10 +2247,11 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
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
@@ -2283,10 +2291,11 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
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
2.54.0.1032.g2f8565e1d1-goog

