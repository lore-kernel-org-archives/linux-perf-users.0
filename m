Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590317;
	b=QMNg3l9Mx47Xm4nMJwRdV5nYdJ+D4lhAp9n2YnDvCCOBRu0rTW1uuAPmI5RoAXG9MqOS
	 HAAjp5rHGGeG2tvhVnI3hBj0mFjPiYFiYdGKMgRInVgyK6GLC7pNB5oh82y626bd7oPfh
	 ZM4FVDabLGhgJKp17hSB2Wnpfs58vEmYuSSP63pqPkhmMdecN89Zer8uCL8Oc3uRf5/H3
	 oSB56W7WQh66LIBtY8UNbRhTvBfI+qdg2Y3/fdHtouEqgbv9r/GFY69tWE1gKzoeA/BzG
	 3Z8mXZznyJUsvhjy9mxnYjPGcEVMKso/mSKwYQwD/7QZq16kBUbgbfmR6KEybXAgXjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hyW+4/sRNGwIBKCr0V6ezQE7+WmiU30tnXwZ5xPV8Ig=;
	b=w5grbUtWT4VABdWHef+mJ3aGLJV/IQ5NT79Uefn0RPsRHLadGYJFcT4KFLkm28XojA4z
	 nS/g0vZ+/pJn2CnGyNxxns1+LryeuwkaIQeFWXC8C+n5FR9DIvwFA3errBaFZ/paMQyZv
	 otSSEEgCxAZjxm3eIkXCluIeF5sVKeZCRk9EVkmDX1FYy1y14X9A/I/Zc970ExAFHBNbY
	 Jerhlo9lwk9VG/j/CCtDjuwp8S7ZE+zHz7+w2fRKcIo0X5fLsCcwM/tJI364j5smMPksA
	 QQsyt+6flUJgPIhpXlldpwOUmvLKH1ZVG3r9THek0GwLRdcaZw1wSOo3lJPSARPKTDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oTjjPI9p;
	arc=none smtp.remote-ip=209.85.160.70
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53660A6F41
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF53660A6F41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oTjjPI9p
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4519ef1babeso653741fac.2
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590316; x=1795195116; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hyW+4/sRNGwIBKCr0V6ezQE7+WmiU30tnXwZ5xPV8Ig=;
        b=oTjjPI9p/NItWwp0rkKbFzMf1BJXEQRcWPD02IWL4dgS0GXiZEPhxstos5mAw83XBb
         /VUJR0FPUW2brec6J4Y5675rpo757i4lhrYZrcqrP1oje0MZov8aov8nJdiUo8WCzKmO
         WMjxagCIUOib7Ncm751tl4Mj8vqrnrVSjDQ10wYhw7GmEdYZWZt8bfUiWB7L65hrjD8B
         CGs4K6iOSH6nAcXZBEPbo22IALvNshORdYTqXPpRya8Hj6tryuwL9Ov8APnIHmD+ijMi
         t4tgdgAdT9n+QWymXZ2bjY0BddM7lrSRwSdlro7Q95oH8vhHKhb3rUUx0IxgsH8LjLp1
         6qQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590316; x=1795195116;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hyW+4/sRNGwIBKCr0V6ezQE7+WmiU30tnXwZ5xPV8Ig=;
        b=yOJz/tbwPR6TtOqrZmsMo7+UkvME1E32BRS/9rLCkC0fOQT3gHkP3I/4nth4DoWPnL
         dOpry6PTNKD/HlvgoboN9S5kL/lC6t1FWZaBffWYS7rzzwqHjwxhcrF1TaI1TprvOIi+
         gg1CCsmY0j8M1Qc0lioiJL+Ciqvv1GckB9Vqg8Ph/sZL8EYXvOweAeBVN/68+EFyWLmH
         /WfGa2ILTnnDw8e3XT9ELB9uGlP0j8COwpukZ5gUWXZn+pju8Sil9SJtdWu7qFkj39X3
         pOEiIofXUpK6dD5m5JynnFXgXPK7+67NXEM9Cnv9CJjTRznp4OEciSEk2cn7tfgQ3dOy
         ENgg==
X-Forwarded-Encrypted: i=1; AL+hErGVeu1b7KTPnQTzVIREoRAS3vskGZwOKVrwUnvQ120/0o0w1p2LDQIYBVqYTDz3bPS455h1eBUso35g2THMP49E@vger.kernel.org
X-Gm-Message-State: APuU4Z+Rop3bir7RoQpVGckF0kHHl2GqziCUtGXpeX7I0UXqZR8+Rrsc
	R0wghRm7TVW3ECW2TrfZI24k171yd98p+KBVlLXMu9hl0rhqiyKpDTkI7aDbYY4rRtxMaMOhkvV
	NsHlmJy59ag==
X-Received: from oaqp14.prod.google.com ([2002:a05:6870:8a0e:b0:499:796e:9512])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:b3ce:b0:4a6:f0b3:79b3
 with SMTP id 586e51a60fabf-4afdf089b23mr3226499fac.8.1794590315270; Fri, 13
 Nov 2026 09:18:35 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:26 -0800
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com> <20261113171734.2188066-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113171734.2188066-16-irogers@google.com>
Subject: [PATCH v4 15/23] perf symbol-elf: Cache ELF program/section headers
 and defer symbol name lookup
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Profiling dso__load_sym_internal() on large binaries showed significant
time spent in repeated libelf section and program header lookups
(elf_section_by_idx() and elf_read_program_header()) for each symbol and
in resolving elf_sym__name() before filtering out non-symbol and
non-allocated entries.

Speed up ELF symbol table loading in dso__load_sym_internal():

- Pre-load PT_LOAD program headers into struct elf_phdr_cache and cache
  per-section metadata in a 64-entry direct-mapped table in
  dso__load_sym_internal() to avoid repeated libelf section and program
  header lookups during symbol iteration.
- Defer elf_sym__name() lookup until after non-allocated and non-symbol
  entries have been filtered out.

Using 'perf bench internals symbols':

  Before (perf binary):
    Average DSO load + sort: 5.808 msec (+- 0.047 msec)
  After (perf binary, -8.3%):
    Average DSO load + sort: 5.324 msec (+- 0.045 msec)

  Before (perf binary, --no-demangle):
    Average DSO load + sort: 3.948 msec (+- 0.064 msec)
  After (perf binary, --no-demangle, -13.7%):
    Average DSO load + sort: 3.408 msec (+- 0.034 msec)

  Before (libLLVM.so.21.1, --no-demangle):
    Average DSO load + sort: 22.433 msec (+- 0.260 msec)
  After (libLLVM.so.21.1, --no-demangle, -14.8%):
    Average DSO load + sort: 19.122 msec (+- 0.226 msec)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 241 ++++++++++++++++++++++++++++-------
 1 file changed, 198 insertions(+), 43 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 98b6d7c73d23..39d69c4a137f 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -267,6 +267,118 @@ static int elf_read_program_header(Elf *elf, u64 vaddr, GElf_Phdr *phdr)
 	return -1;
 }
 
+struct elf_phdr_range {
+	u64 vaddr;
+	u64 end;
+	u64 adjust;
+	GElf_Phdr phdr;
+};
+
+struct elf_phdr_cache {
+	struct elf_phdr_range inline_ranges[16];
+	struct elf_phdr_range *ranges;
+	size_t nr_ranges;
+	size_t last_idx;
+};
+
+static void elf_phdr_cache__init(struct elf_phdr_cache *cache, Elf *elf)
+{
+	size_t i, phdrnum = 0, cnt = 0;
+
+	cache->ranges = cache->inline_ranges;
+	cache->nr_ranges = 0;
+	cache->last_idx = 0;
+
+	if (!elf || elf_getphdrnum(elf, &phdrnum) || phdrnum == 0)
+		return;
+
+	if (phdrnum > ARRAY_SIZE(cache->inline_ranges)) {
+		cache->ranges = calloc(phdrnum, sizeof(*cache->ranges));
+		if (!cache->ranges) {
+			cache->ranges = cache->inline_ranges;
+			phdrnum = ARRAY_SIZE(cache->inline_ranges);
+		}
+	}
+
+	for (i = 0; i < phdrnum; i++) {
+		GElf_Phdr phdr;
+		u64 sz;
+
+		if (gelf_getphdr(elf, i, &phdr) == NULL)
+			break;
+		if (phdr.p_type != PT_LOAD)
+			continue;
+		sz = max(phdr.p_memsz, phdr.p_filesz);
+		if (!sz)
+			continue;
+		cache->ranges[cnt].vaddr = phdr.p_vaddr;
+		cache->ranges[cnt].end = phdr.p_vaddr + sz;
+		cache->ranges[cnt].adjust = phdr.p_vaddr - phdr.p_offset;
+		cache->ranges[cnt].phdr = phdr;
+		cnt++;
+	}
+	cache->nr_ranges = cnt;
+}
+
+static void elf_phdr_cache__exit(struct elf_phdr_cache *cache)
+{
+	if (cache->ranges && cache->ranges != cache->inline_ranges)
+		free(cache->ranges);
+}
+
+static const struct elf_phdr_range *
+elf_phdr_cache__find(struct elf_phdr_cache *cache, u64 vaddr)
+{
+	if (cache->nr_ranges == 0)
+		return NULL;
+
+	if (cache->last_idx < cache->nr_ranges) {
+		const struct elf_phdr_range *r = &cache->ranges[cache->last_idx];
+
+		if (vaddr >= r->vaddr && vaddr < r->end)
+			return r;
+	}
+	for (size_t i = 0; i < cache->nr_ranges; i++) {
+		const struct elf_phdr_range *r = &cache->ranges[i];
+
+		if (vaddr >= r->vaddr && vaddr < r->end) {
+			cache->last_idx = i;
+			return r;
+		}
+	}
+	return NULL;
+}
+
+#define ELF_SEC_CACHE_SIZE 64
+
+struct elf_sec_cache_entry {
+	uint32_t shndx;
+	bool valid;
+	bool is_alloc;
+	bool is_label_sec;
+	bool has_phdr;
+	u64 phdr_vaddr;
+	u64 phdr_end;
+	const char *section_name;
+	GElf_Shdr shdr;
+	GElf_Phdr phdr;
+};
+
+static inline const GElf_Phdr *
+elf_sec_cache__phdr(const struct elf_sec_cache_entry *sce,
+		    struct elf_phdr_cache *phdr_cache,
+		    u64 vaddr)
+{
+	const struct elf_phdr_range *pr;
+
+	if (sce->has_phdr && vaddr >= sce->phdr_vaddr && vaddr < sce->phdr_end)
+		return &sce->phdr;
+	pr = elf_phdr_cache__find(phdr_cache, vaddr);
+	if (!pr)
+		return NULL;
+	return &pr->phdr;
+}
+
 struct rel_info {
 	u32		nr_entries;
 	u32		*sorted;
@@ -1538,6 +1650,8 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	int nr = 0;
 	bool remap_kernel = false, adjust_kernel_syms = false;
 	u64 max_text_sh_offset = 0;
+	struct elf_phdr_cache phdr_cache = {};
+	struct elf_sec_cache_entry sec_cache[ELF_SEC_CACHE_SIZE];
 
 	if (kmap && !kmaps)
 		return -1;
@@ -1629,14 +1743,18 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	if (kmodule && adjust_kernel_syms)
 		max_text_sh_offset = max_text_section(runtime_ss->elf, &runtime_ss->ehdr);
 
+	elf_phdr_cache__init(&phdr_cache, runtime_ss->elf);
+	memset(sec_cache, 0, sizeof(sec_cache));
+
 	curr_dso = dso__get(dso);
 	elf_symtab__for_each_symbol(syms, nr_syms, idx, sym) {
 		struct symbol *f;
-		const char *elf_name = elf_sym__name(&sym, symstrs);
+		const char *elf_name = NULL;
 		char *demangled = NULL;
 		int is_label = elf_sym__is_label(&sym);
 		const char *section_name;
 		bool used_opd = false;
+		struct elf_sec_cache_entry *sce;
 
 		if (!is_label && !elf_sym__filter(&sym))
 			continue;
@@ -1647,6 +1765,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		 * output:
 		 */
 		if (ehdr.e_machine == EM_ARM || ehdr.e_machine == EM_AARCH64) {
+			elf_name = elf_sym__name(&sym, symstrs);
 			if (elf_name[0] == '$' && strchr("adtx", elf_name[1])
 			    && (elf_name[2] == '\0' || elf_name[2] == '.'))
 				continue;
@@ -1654,13 +1773,19 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		/* Reject RISCV ELF "mapping symbols" */
 		if (ehdr.e_machine == EM_RISCV) {
+			if (!elf_name)
+				elf_name = elf_sym__name(&sym, symstrs);
 			if (elf_name[0] == '$' && strchr("dx", elf_name[1]))
 				continue;
 		}
 
 		/* Reject kernel mapping symbols for kernel DSOs only */
-		if (dso__kernel(dso) && is_ignored_kernel_symbol(elf_name))
-			continue;
+		if (dso__kernel(dso)) {
+			if (!elf_name)
+				elf_name = elf_sym__name(&sym, symstrs);
+			if (is_ignored_kernel_symbol(elf_name))
+				continue;
+		}
 
 		if (runtime_ss->opdsec && sym.st_shndx == runtime_ss->opdidx) {
 			u32 offset = sym.st_value - syms_ss->opdshdr.sh_addr;
@@ -1683,16 +1808,56 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		if (sym.st_shndx == SHN_ABS)
 			continue;
 
-		sec = elf_getscn(syms_ss->elf, sym.st_shndx);
-		if (!sec) {
-			if (dynsym && ehdr.e_shnum &&
-			    sym.st_shndx < SHN_LORESERVE &&
-			    sym.st_shndx >= ehdr.e_shnum)
-				continue;
-			goto out_elf_end;
-		}
+		sce = &sec_cache[sym.st_shndx & (ELF_SEC_CACHE_SIZE - 1)];
+		if (!sce->valid || sce->shndx != sym.st_shndx) {
+			const struct elf_phdr_range *pr;
 
-		gelf_getshdr(sec, &shdr);
+			sec = elf_getscn(syms_ss->elf, sym.st_shndx);
+			if (!sec) {
+				if (dynsym && ehdr.e_shnum &&
+				    sym.st_shndx < SHN_LORESERVE &&
+				    sym.st_shndx >= ehdr.e_shnum)
+					continue;
+				goto out_elf_end;
+			}
+
+			gelf_getshdr(sec, &shdr);
+			secstrs = secstrs_sym;
+
+			/*
+			 * We have to fallback to runtime when syms' section
+			 * header has NOBITS set. NOBITS results in file offset
+			 * (sh_offset) not being incremented. So sh_offset used
+			 * below has different values for syms (invalid) and
+			 * runtime (valid).
+			 */
+			if (shdr.sh_type == SHT_NOBITS && (shdr.sh_flags & SHF_ALLOC)) {
+				sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
+				if (!sec)
+					goto out_elf_end;
+
+				gelf_getshdr(sec, &shdr);
+				secstrs = secstrs_run;
+			}
+
+			sce->shndx = sym.st_shndx;
+			sce->valid = true;
+			sce->is_alloc = (shdr.sh_flags & SHF_ALLOC) != 0;
+			if (sce->is_alloc) {
+				sce->shdr = shdr;
+				sce->section_name = elf_sec__name(&shdr, secstrs);
+				sce->is_label_sec = elf_sec__filter(&shdr, secstrs) != 0;
+				pr = elf_phdr_cache__find(&phdr_cache, shdr.sh_addr);
+				if (pr) {
+					sce->has_phdr = true;
+					sce->phdr_vaddr = pr->vaddr;
+					sce->phdr_end = pr->end;
+					sce->phdr = pr->phdr;
+				} else {
+					sce->has_phdr = false;
+				}
+			}
+		}
 
 		/*
 		 * If the attribute bit SHF_ALLOC is not set, the section
@@ -1702,30 +1867,13 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		 * the section aren't loaded to memory during process execution,
 		 * so skip them.
 		 */
-		if (!(shdr.sh_flags & SHF_ALLOC))
+		if (!sce->is_alloc)
 			continue;
 
-		secstrs = secstrs_sym;
-
-		/*
-		 * We have to fallback to runtime when syms' section header has
-		 * NOBITS set. NOBITS results in file offset (sh_offset) not
-		 * being incremented. So sh_offset used below has different
-		 * values for syms (invalid) and runtime (valid).
-		 */
-		if (shdr.sh_type == SHT_NOBITS) {
-			sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
-			if (!sec)
-				goto out_elf_end;
-
-			gelf_getshdr(sec, &shdr);
-			secstrs = secstrs_run;
-		}
-
-		if (is_label && !elf_sec__filter(&shdr, secstrs))
+		if (is_label && !sce->is_label_sec)
 			continue;
 
-		section_name = elf_sec__name(&shdr, secstrs);
+		section_name = sce->section_name;
 
 		/* On ARM, symbols for thumb functions have 1 added to
 		 * the symbol address as a flag - remove it */
@@ -1735,7 +1883,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			--sym.st_value;
 
 		if (dso__kernel(dso)) {
-			if (dso__process_kernel_symbol(dso, map, &sym, &shdr,
+			if (dso__process_kernel_symbol(dso, map, &sym, &sce->shdr,
 						       kmaps, kmap, &curr_dso,
 						       section_name,
 						       adjust_kernel_syms,
@@ -1745,17 +1893,20 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 				goto out_elf_end;
 		} else if ((used_opd && runtime_ss->adjust_symbols) ||
 			   (!used_opd && syms_ss->adjust_symbols)) {
-			GElf_Phdr phdr;
+			const GElf_Phdr *phdr;
 
-			if (elf_read_program_header(runtime_ss->elf,
-						    (u64)sym.st_value, &phdr)) {
+			phdr = elf_sec_cache__phdr(sce, &phdr_cache,
+						   (u64)sym.st_value);
+			if (!phdr) {
 				pr_debug4("%s: failed to find program header for "
 					   "symbol: %s st_value: %#" PRIx64 "\n",
-					   __func__, elf_name, (u64)sym.st_value);
+					   __func__, elf_sym__name(&sym, symstrs),
+					   (u64)sym.st_value);
 				pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
 					"sh_addr: %#" PRIx64 " sh_offset: %#" PRIx64 "\n",
-					__func__, (u64)sym.st_value, (u64)shdr.sh_addr,
-					(u64)shdr.sh_offset);
+					__func__, (u64)sym.st_value,
+					(u64)sce->shdr.sh_addr,
+					(u64)sce->shdr.sh_offset);
 				/*
 				 * Fail to find program header, let's rollback
 				 * to use shdr.sh_addr and shdr.sh_offset to
@@ -1764,16 +1915,18 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 				 * still need to handle java JIT symbols in this
 				 * case.
 				 */
-				sym.st_value -= shdr.sh_addr - shdr.sh_offset;
+				sym.st_value -= sce->shdr.sh_addr - sce->shdr.sh_offset;
 			} else {
 				pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
 					"p_vaddr: %#" PRIx64 " p_offset: %#" PRIx64 "\n",
-					__func__, (u64)sym.st_value, (u64)phdr.p_vaddr,
-					(u64)phdr.p_offset);
-				sym.st_value -= phdr.p_vaddr - phdr.p_offset;
+					__func__, (u64)sym.st_value, (u64)phdr->p_vaddr,
+					(u64)phdr->p_offset);
+				sym.st_value -= phdr->p_vaddr - phdr->p_offset;
 			}
 		}
 
+		if (!elf_name)
+			elf_name = elf_sym__name(&sym, symstrs);
 		demangled = dso__demangle_sym(dso, kmodule, elf_name);
 		if (demangled != NULL)
 			elf_name = demangled;
@@ -1791,9 +1944,11 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		nr++;
 	}
 	dso__put(curr_dso);
+	elf_phdr_cache__exit(&phdr_cache);
 	return nr;
 out_elf_end:
 	dso__put(curr_dso);
+	elf_phdr_cache__exit(&phdr_cache);
 	return -1;
 }
 
-- 
2.56.1.703.gf848ed807c-goog

