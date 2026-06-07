Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69CB2D738A
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780812584; cv=none; b=U4dOXuC/1cDd951UkkKSCa7oYAgxX6ha6d964F0za6cvfImLaJ2jwOYZNmVZuz6tkl9ZKt8KQye3jEnOUNlS84oZQqMyIITDbecgJpSWVLAx/uz3HEJgvi9INQIsl6fe+zhhsGXZ4r/TMGHbzr9/xLZMX/1y5bvAezlNwM5Kwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780812584; c=relaxed/simple;
	bh=2RVcWUqIVwoyVmYrdvYeK5CQMoxlCp+CKrq/aZKQ1+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lsXkqhTkhMbC2exjjpl6hiWXfvw1kZ0HdJw4tqCf7jZ/QZsZmzdykXV2kTXYcQxXPnivvZSqmQxw/k8OvZeDtNaZaDMcvR0E0Jh8Fw37iFn3wDVHgCzp1rDZwT1JjIT9udlislT7nEEpJp4++qo3XJFy6NEJ0iWMkDIOrLG74iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PRdX4T+A; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRdX4T+A"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137fc6f8e9fso3389099c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jun 2026 23:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780812582; x=1781417382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ggl5TjTDOp3j8NcRMD+U0EgWobSr6C/ivFQe7eIhH0=;
        b=PRdX4T+AX9GSC9oxeEE02ffvM60OIaMALe84jDGKGPBDEyTMrpyLp1njHF6KwaQJrH
         sXNMpdj9QVUZ7H2phP+JV2QtulKifSluAMlhZkesEY9v7qWdJCzIDsf13I23AgCWQliN
         6hANKl4hup5XpGb1iyioPN/+moqb3YcE6q/ab7Y83mEIG28Vc5CRUjWrl1GYTInjtsJ5
         b+gOlOTqO8MvKXnxgbk0+f5DRu2VDLlgE4LvgmjzOosYUPUzOwkq0NwHopJaRsdVRQAD
         yoON2L4xqwwQcAPnlcGDnZFMrm6sasrJ28yuP1DyJlA/gp6lMyWobKgOWAOSBzqTYRm/
         SXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780812582; x=1781417382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ggl5TjTDOp3j8NcRMD+U0EgWobSr6C/ivFQe7eIhH0=;
        b=MPd4xn6mHKGKpKCfziGPrUcC/Fnc1jfePR4Mg9Yfy/pXPHZXQdMe38yCmWwJHscGYL
         vQ6im4aggiNmCKU5kVSn4L3QRl/Qu5WIV1pxC43YiKGfNKcfAIdCYhLCJPIwgTdWJepS
         JQrAYWf/fhla51rcj0qvo05Z5DgxFKNccbjO1j1Vni0XkVBvrdP39Od08w5EppRANRM9
         83SaTDR/QiWvW/eMJcy0Zf8f6oY7YLgdUncORHnbB3xIjZ/tBwhjYquoklsMZ1rI/YSV
         Zph1eGBTL3xOu3wTHuuTPgO5NE8yb8jpl7ywPtRti8RhuobNmpBlH9JQJHeLR80Op7P3
         rSFA==
X-Forwarded-Encrypted: i=1; AFNElJ+HPASoWL01Q8govkVvwubOnJ8TpHHbmkKoYs+5tAgOuIDL+w0YLxcVtXh6xCAaBKs2mEZN1s/2CqS+QPDfAgV4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8NECyfWLOMgAjH/BNX90XhyKMRN1/NvvZD8jmr0cvpAukvwmA
	uciU7YrtdSnJv7kLWJnxlWincs/nzFhdhY/g2AEl4cq0BzK/pBC2cY5Uah2SLEhQYK7H0U2Tl9y
	N8qEIxBqjVg==
X-Received: from dlec7-n1.prod.google.com ([2002:a05:701b:4287:10b0:138:15e3:14ab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:111:b0:136:6230:5834
 with SMTP id a92af1059eb24-138066fe7a4mr4798233c88.31.1780812581465; Sat, 06
 Jun 2026 23:09:41 -0700 (PDT)
Date: Sat,  6 Jun 2026 23:09:29 -0700
In-Reply-To: <20260607060933.3274263-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260606151451.2913860-1-irogers@google.com> <20260607060933.3274263-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260607060933.3274263-2-irogers@google.com>
Subject: [PATCH v17 1/5] perf maps: Add maps__mutate_mapping
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

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/util/machine.c    |  32 +++++---
 tools/perf/util/maps.c       | 149 ++++++++++++++++++++++++++++-------
 tools/perf/util/maps.h       |   3 +
 tools/perf/util/symbol-elf.c |  41 ++++++----
 tools/perf/util/symbol.c     |  17 +++-
 5 files changed, 184 insertions(+), 58 deletions(-)

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
index 923935ee21b6..b1b8efe42149 100644
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
+		up_read(maps__lock(maps));
+		return -ENOMEM;
+	}
+	for (unsigned int i = 0; i < nr_maps; i++)
+		maps_copy[i] = map__get(maps__maps_by_address(maps)[i]);
+	up_read(maps__lock(maps));
+
+	for (unsigned int i = 0; i < nr_maps; i++) {
+		if (map__load(maps_copy[i]) < 0) {
+			pr_warning("Failed to load map %s\n", dso__name(map__dso(maps_copy[i])));
+			err = -1;
+		}
+		map__put(maps_copy[i]);
+	}
+	free(maps_copy);
+	return err;
+}
+
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data)
 {
 	struct map **maps_by_address;
@@ -668,40 +746,57 @@ struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 	return result;
 }
 
-struct maps__find_symbol_by_name_args {
-	struct map **mapp;
-	const char *name;
-	struct symbol *sym;
-};
-
-static int maps__find_symbol_by_name_cb(struct map *map, void *data)
+struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp)
 {
-	struct maps__find_symbol_by_name_args *args = data;
+	struct map **maps_copy;
+	unsigned int nr_maps;
+	struct symbol *sym = NULL;
 
-	args->sym = map__find_symbol_by_name(map, args->name);
-	if (!args->sym)
-		return 0;
+	if (!maps)
+		return NULL;
 
-	if (!map__contains_symbol(map, args->sym)) {
-		args->sym = NULL;
-		return 0;
+	/*
+	 * First, ensure all maps are loaded. We pre-load them outside of any
+	 * read-to-write locks to avoid deadlocks. Even if some fail, we proceed.
+	 */
+	maps__load_maps(maps);
+
+	/*
+	 * Create a local snapshot of the maps while holding the read lock.
+	 * This prevents deadlocking if iteration triggers further map insertions.
+	 */
+	down_read(maps__lock(maps));
+	nr_maps = maps__nr_maps(maps);
+	maps_copy = calloc(nr_maps, sizeof(*maps_copy));
+	if (maps_copy) {
+		for (unsigned int i = 0; i < nr_maps; i++) {
+			struct map *map = maps__maps_by_address(maps)[i];
+
+			maps_copy[i] = map__get(map);
+		}
 	}
+	up_read(maps__lock(maps));
 
-	if (args->mapp != NULL)
-		*args->mapp = map__get(map);
-	return 1;
-}
+	if (!maps_copy)
+		return NULL;
 
-struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp)
-{
-	struct maps__find_symbol_by_name_args args = {
-		.mapp = mapp,
-		.name = name,
-		.sym = NULL,
-	};
+	for (unsigned int i = 0; i < nr_maps; i++) {
+		struct map *map = maps_copy[i];
+
+		sym = map__find_symbol_by_name(map, name);
+		if (sym && map__contains_symbol(map, sym)) {
+			if (mapp)
+				*mapp = map__get(map);
+			break;
+		}
+		sym = NULL;
+	}
+
+	for (unsigned int i = 0; i < nr_maps; i++)
+		map__put(maps_copy[i]);
 
-	maps__for_each_map(maps, maps__find_symbol_by_name_cb, &args);
-	return args.sym;
+	free(maps_copy);
+	return sym;
 }
 
 int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
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

