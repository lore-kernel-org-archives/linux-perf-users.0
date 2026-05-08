Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE637B030
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228861; cv=none; b=rUTAD9w0lKfPPX1EmDbp8P6dkm0zJLx7oYgAdSUGFpJ4EEpEgfEnTuT7+fHbahN1Z2JmpHVmxeNcRy0A4JBA3d74z5/mtoABXdmQjGp28rqnHf1STRLrqsM0tqJRDzuvQXvUtgMfg61inEwzNwSfbeQN601WqqNP4V/ozIaJOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228861; c=relaxed/simple;
	bh=qTheYH5mSiqC5/15dWn3M7Rofu4TnqK1Ab3iyySLOEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VNy6lK8zIJKyKVO2rnklQON6WpPlJvdRS0ZNZ5ycMsR3haGf8jVubMpLYk4Ns4f+KUwd6WgkxrspldKMBaSkZXxB6kK/vueCMZFor+FMdIqn8c/i4L0pO4jlCTlf2cjodtPBdGdzgaAZQIdLzsd5vSKQx+k6zNznS5GDEJ0jtIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BcrmsfDC; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BcrmsfDC"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so2618941eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 01:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778228858; x=1778833658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QikZcJA/YWUXCpBcR7ioWB0paLrJN6gmFF/oWuLh2Wk=;
        b=BcrmsfDCPQmFa69S9EKCQYyGODpuFg8v7oUSy2ruUjfj1qMP7bYKIa23RPYx8Y8tSK
         fBN6W5YDIHrnJv4MAlRs6Y8zPEjW13NsVQBAqq21Z5OwecmtdZ8679zKxA2yRiAp9Fxn
         cM3b+Gc9QWCURygpz5oSIQMlQ5rJCBSFCTg36WAliyTQG+pku9oeMdGtFhqLlhgnnKKs
         LmLDYJuVq5szHBpms/o2nYe+J3D+HJQQwHE+dbXhdJUhQyQaLSvXS2TkJeWrguPXUPX7
         95WLKoScz14vvp3P+8j731qKSddW4WOHOn4wrJVXF7AYCGzjeK58KlRe1HKk14ywLw0L
         hwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228858; x=1778833658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QikZcJA/YWUXCpBcR7ioWB0paLrJN6gmFF/oWuLh2Wk=;
        b=g9/eluIzu2B/Sav3j3zKqn7PaQLp2HcU9866cIm5X438OYAnhbhc8iINHgdrUwBZM7
         L1g+wC8wYfEttmoLqvpo/GqoYyo3+BJ7pFhd7toeapyJ03KQjdSu0yj/YqQCzkdT1kdt
         kqfy7GAS38ibgeGnoi4hGDVrysxRAOMlhCuRBhfJ0bksykzk7Koeul0IreoutbolcI2b
         rSIeRY37pOW026AXm3eubMKh1cBcY4F7OxDHgMoPd0ESTjIc7xR4Rc7Pc+NWx0PuydCO
         +vAa3V694spHsgyONMzxY2Pgn/RxVhEzn7jx/iSdZ1uiOrHFjto3vZRV4Vs/fViQgXZ3
         rgbw==
X-Forwarded-Encrypted: i=1; AFNElJ8hsLPlydI59sua1lqjwzx3k+FFbV4E9RPTm5tmK8ZIw2MxYFDRtYS20hXxZ+AkHyJed9CCYrrI8Nm3wrdmhOxX@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8gSY9hgUrU6mDWysQ5P1kGLRTAyWc90KgKCRWUpUgb70y6Be
	wqwkQL/ct0AJdTqaKwto+GdEG31FxbPyE4wMJyNepWpN5pkwb+P41tNvxONq3KT5yPbwFo99aa3
	VPBzLE8wvFg==
X-Received: from dlbcm15.prod.google.com ([2002:a05:7022:688f:b0:12a:9ef0:93ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:271a:b0:132:7ab5:6ca8
 with SMTP id a92af1059eb24-1327ab56e23mr266276c88.22.1778228857583; Fri, 08
 May 2026 01:27:37 -0700 (PDT)
Date: Fri,  8 May 2026 01:27:23 -0700
In-Reply-To: <20260508082726.2795191-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506004546.3140141-1-irogers@google.com> <20260508082726.2795191-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508082726.2795191-4-irogers@google.com>
Subject: [PATCH v6 3/6] perf maps: Add maps__mutate_mapping
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, gmx@google.com, 
	james.clark@linaro.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
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
session initialization construction. There is a potential for self
deadlock if maps__mutate_mapping is called with the lock held, such as
with maps__for_each_map but this problem also existed with the
previous remove and insert approaches.

Fixes: 39b12f781271 ("perf tools: Make it possible to read object code from vmlinux")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c    | 32 +++++++++++++++++-----------
 tools/perf/util/maps.c       | 26 +++++++++++++++++++++++
 tools/perf/util/maps.h       |  2 ++
 tools/perf/util/symbol-elf.c | 41 +++++++++++++++++++++++-------------
 tools/perf/util/symbol.c     | 17 +++++++++++----
 5 files changed, 87 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e76f8c86e62a..8d4452c70cb5 100644
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
+				     u64 start, u64 end)
+{
+	struct kernel_mmap_mutation_ctx ctx = { .start = start, .end = end };
 
-	return err;
+	return maps__mutate_mapping(machine__kernel_maps(machine),
+				     machine->vmlinux_map,
+				     kernel_mmap_mutate_cb, &ctx);
 }
 
 int machine__create_kernel_maps(struct machine *machine)
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 81a97ac34077..91345a773aa2 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -575,6 +575,32 @@ void maps__remove(struct maps *maps, struct map *map)
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
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 20c52084ba9e..de74ccbb8a12 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -61,6 +61,8 @@ size_t maps__fprintf(struct maps *maps, FILE *fp);
 
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
2.54.0.563.g4f69b47b94-goog

