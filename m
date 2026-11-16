Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810887;
	b=5d3BDpB+uVVpN79oNCnb2z5F19MEZMC0sUEWVUt/bb8b7iJqw2YlhVizbFYYNhpdon2L
	 B5uk9D4wHFMxTlUiZVqc1edXNQG9EPesnICerZQW6HpwBrC8wFNDXsQrPmfn3GCGowcgl
	 0JEG38OzSxvYrJdhG5mfEkzjks5/DyHJ7iQBh58imfVS46sSg47miN3bHPsDmDbWmrM9V
	 QxQ3vBBeFefvcqj/45+ATjeDlTn/oX/ecshg17QOhliRHe8Yq/Dn60Yla1QL5I2YV5Q8L
	 uareVgHa/yvGyJ9YILRBsYe4ubCQoJtzJ8+8HsZkcTZP4sbCZehdXXHtfzt3yH8gMHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=n8I4e6WwzPdadWauG9q85r4iw2+jMDW/P3u9sMBwB5c=;
	b=HiIWNtBt4suwqOxoWI4nUJF6OIcfWvY0ZjSzkXKF5BqGwwAYwH0Iymxk6ssEOzTc83uY
	 AnJJLceOcFHmnSqH9mo/arDY59QFUvphEgk4et8FolegwjVFHJ6h8/kd75oCNK0WHYx/P
	 zMEUvDSwdwOMzo4raoiYm7tMLMRFr4k8j+Y+68TSjIELwU1iWgPMVmKcv2w3Wk1MxIItm
	 KGy3DkPVfHRzmHSPv78McndS0BQw7J4Wy2Xkn0EtvvkapIP2STOb6k+xzTgJaIS6XeKit
	 BKkTLWFI2+ukh4iHG1sc/m88nimQxQGkvROtmUNHFC1Ld8AXaGFYcdvQe3zWTvpCG4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TTwJlT3H;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45B606A33F
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC45B606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TTwJlT3H
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4ab4f652f9bso1790878b6e.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 22:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794810885; x=1795415685; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n8I4e6WwzPdadWauG9q85r4iw2+jMDW/P3u9sMBwB5c=;
        b=TTwJlT3Hl9r6+3/5Z9BbLV/BPJTzCz0ka0l2y2HsbTMjMZDIHEPHl7W1yrSHUkDVs0
         I09RVSWO+dnbTpl49FsWiJhWaVrhF4slcdslxQXoPjP2/quNUPMo+eXsOLSfiFk1skgo
         5jnJAvS3cQ8222ZjAamNjMDFib7J6tntvHMHrsdsAeQ4KnsAGRl/kHZCiUN1S46rlCaX
         AFVX7AH+fFb7w4dnnhW27s3yoLLxzkT0BNhvWaXdoL+SEl1mc5ZR+tNvlB5DTx2h9qdh
         Z0meLJR4nchsNCFGxXziroqQ0I3Ka1nyOG/oRML5g04mLq7hcFCBm5M9ktqTUwth9U/8
         GYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794810885; x=1795415685;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n8I4e6WwzPdadWauG9q85r4iw2+jMDW/P3u9sMBwB5c=;
        b=aaoWHBpv7dz01dyeUKzegjvGyC0wLDmeWLsFKSZqqXosLZRemZXPIwXPvetTHCUKtN
         CMkRaVytwGt6AywrWpXNYQQ2cbKTvEUSsHMNQ1LOKRrp8/sFvpVSKwexv2HWcRkn3vCa
         6mlqnwD2XNjBjkWaOdVWTI3RV1gXz/zmn+0FleFhBvlboalf416bHjTiEZrKxVvxHB4T
         osIxIA1A5OsixFS2Gvs5ych9XKF5V5nqk3wGQ5tIV7yZvzJSVmToZVnD3tNPoPjj8rFt
         UOJcl6PIZIzbInadTg1Iu+TovsLiVFBTdvwXGV6sq7I8p5iBPRQGjCRAhX0LRQkViDDG
         Dsgg==
X-Forwarded-Encrypted: i=1; AL+hErF0qqV/zlHrZDpJeljVYwkYrwHa6QvlpqD1uWZfRslj3NrF3kytZZgNWSdgw1zi9YwODw3b/2bEuszeboNliTgC@vger.kernel.org
X-Gm-Message-State: APuU4Z8OQWsIUnTLNnHAR85LAugk6k8UYyF+bhlAVNx719EFHwPUgPuk
	I5S/SGEnWaXJwAwGhMU4HaMaFwVRM9LPB7OQ6weEWhtksc/j8IIAYLthgqxZQI2iQouiTT8T3Mj
	1ZDEJ2Wmt/g==
X-Received: from oiya10-n2.prod.google.com ([2002:a05:6809:200a:20b0:56e:4664:e4f0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:308a:b0:4b9:a88b:888b
 with SMTP id 5614622812f47-56e64dfeb26mr9994035b6e.33.1794810885325; Sun, 15
 Nov 2026 22:34:45 -0800 (PST)
Date: Sun, 15 Nov 2026 22:34:29 -0800
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
Message-ID: <20261116063435.2817923-4-irogers@google.com>
Subject: [PATCH v5 3/9] perf symbol-elf: Cache ELF program/section headers and
 defer symbol name lookup
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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
 tools/perf/util/symbol-elf.c | 239 ++++++++++++++++++++++++++++-------
 1 file changed, 196 insertions(+), 43 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 98b6d7c73d23..2b7f9e30916d 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -267,6 +267,116 @@ static int elf_read_program_header(Elf *elf, u64 vaddr, GElf_Phdr *phdr)
 	return -1;
 }
 
+struct elf_phdr_range {
+	u64 vaddr;
+	u64 end;
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
@@ -1538,6 +1648,8 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	int nr = 0;
 	bool remap_kernel = false, adjust_kernel_syms = false;
 	u64 max_text_sh_offset = 0;
+	struct elf_phdr_cache phdr_cache = {};
+	struct elf_sec_cache_entry sec_cache[ELF_SEC_CACHE_SIZE];
 
 	if (kmap && !kmaps)
 		return -1;
@@ -1629,14 +1741,18 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
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
@@ -1647,6 +1763,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		 * output:
 		 */
 		if (ehdr.e_machine == EM_ARM || ehdr.e_machine == EM_AARCH64) {
+			elf_name = elf_sym__name(&sym, symstrs);
 			if (elf_name[0] == '$' && strchr("adtx", elf_name[1])
 			    && (elf_name[2] == '\0' || elf_name[2] == '.'))
 				continue;
@@ -1654,13 +1771,19 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
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
@@ -1683,16 +1806,56 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
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
@@ -1702,30 +1865,13 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
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
@@ -1735,7 +1881,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			--sym.st_value;
 
 		if (dso__kernel(dso)) {
-			if (dso__process_kernel_symbol(dso, map, &sym, &shdr,
+			if (dso__process_kernel_symbol(dso, map, &sym, &sce->shdr,
 						       kmaps, kmap, &curr_dso,
 						       section_name,
 						       adjust_kernel_syms,
@@ -1745,17 +1891,20 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
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
@@ -1764,16 +1913,18 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
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
@@ -1791,9 +1942,11 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
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

