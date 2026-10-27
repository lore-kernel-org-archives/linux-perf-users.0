Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142947;
	b=qncLlBqEVtG1LfPX795AUI4GwLoDLczYr+V98nHuQVp+JfecFdIuPdmhRpG+eIviBKKI
	 xrDOE9NVVirq0acvFCh1NnK2p8Rj/pqAk/DvQMTbpxHBQBo4EIzUaIqZxNoxXJrkfYORU
	 m0U/qm4Z+cBq2yA9iDpQ7S2ykoo1Z0cFQe0U2zM+OtdAJaYtDoVKIbjhpZ34gSi7ZPZhg
	 jjfnCRDAJO/reZq32SqY8YN1we49Im650GpPc9GGgCB9XsTFSDukb4JeUux5uyeQXX5Xx
	 pxJjugAhAKcJJTiiYYDEsGam3y/oAtWWxKwTUd1UlRamoXI+lciqmcPSjd+UFfS+24w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Qjh9UZToylM+U02kPkXV1UrXAAuGzZXEFpLiHhH+Mww=;
	b=0uxmgC9waBrE2mW9GqKzy3UwIRtp5BeKpuEW+2qaMrvhxMFuRQmAVkW+DWRxgkP3sC81
	 4Gt9h92HqwWGK6cY/Ry2eAnEZ18jiYswC+ndkBZ/meCNK+LjVVwASzqqtGIyelrJ1JWSf
	 +vfeLMLAydjpM1IT2tuKdO7bailslHI03gKTYpHwbcIsC7OWRn83vSq5L2ojn4lvUJqK/
	 d7+zFKcpmu0st+o2i4kjnaTldaF204Zt8rk9ArIlrGujNkcdJQjQ+frbqY53Ci9MSJWmo
	 UzTUp4KaR41li+BXC9VhthZQRJSfF1ZbQi2JoHw/4q10NYGzjWzAJeDjcmMtA8fCGYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gDCdQ5xQ;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00630606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00630606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gDCdQ5xQ
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35cbea41088so487039eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142946; x=1793747746; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qjh9UZToylM+U02kPkXV1UrXAAuGzZXEFpLiHhH+Mww=;
        b=gDCdQ5xQ/OC8lGLxDk6kES5AVOcW0NIJr6sRoAD7uDrfZ61D54WZY6nYVzViOUkG/y
         KgXS4np2kwQhuP56KeJdkL/I578Gt9bwPgNqQMjA6aS9uTB/wUYsE2HmZdZAFYFZx/hg
         dZiQmP2EvzdI8l/KBRrSsqe+wT/jZzwtpb1PxEvd/o1Nbeg4a6T5bRduTB77S/PaDtLn
         ekTHkezQX4lDbgG03x3XHsvDtMnvrdHVBayeAhoeRljM7tqww+tGuir/2Xa1bGUc7PuC
         0vufucfR7ilcuUwr4qScd6UeaAfyD/DUeRjt/H0lP68i1b4c6LDF0AihMcEg1m5k+rK0
         UM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142946; x=1793747746;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qjh9UZToylM+U02kPkXV1UrXAAuGzZXEFpLiHhH+Mww=;
        b=VTdi4+JWMfonl3x6kHzgzBNENBaBTv62ox3iuYMpFRsLsZb55RQHaRSsYkUmkS86Ew
         +cbSvLSsFpBkSzyUHfHIQNlH9VXBtwjhyi/0162L78B9fMir26Y6P1BaBRL8Eqdozw51
         FHhfAabalyaG+XNqon/1unswj1aDXPzozVlUl8ZFS3Kyb28VHr/Sn+P3NxmdcixowJSt
         LjkUubmkXHrSO3qZmH1aVRL/ErvnFvt8jfCBpvl7O3bey/Rx5u0a45dDA9iQCN58zf6g
         GQlj9y6g3MH+qr8DJjADSngmtviShh9m1IrNrH8uxEv6VSohagYqHvLu3dxqyrt7wM56
         4F/g==
X-Forwarded-Encrypted: i=1; AKwUvBzIzYngrB93LVr+9q3dk7AWXh7i1+Qvi7otGiwUUWpTpF5QwpKNFOitKeRm8T4pv9/4XgMwOAGEmfu7VaPowj1t@vger.kernel.org
X-Gm-Message-State: AFq9FYKRCdNqLKMVO6S3G8SxvGKuBqFKVN8o8qU20rtAB6wSjAe3OUuL
	ez4jcNAZQNVG0QIQ5O89iHD4y9lJw9K7Muzh+ZuJnEeROboP2Hjm+GPgyd0Kglw84owiChzz9MX
	J9iuUuITUbQ==
X-Received: from dybmf12.prod.google.com ([2002:a05:7301:90c:b0:35d:bc5b:d1b7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:88c7:10b0:369:d486:457f
 with SMTP id 5a478bee46e88-36a1ff47261mr1358624eec.2.1793142945747; Tue, 27
 Oct 2026 16:15:45 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:15:05 -0700
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
Message-ID: <20261027231513.816148-12-irogers@google.com>
Subject: [PATCH v2 11/18] perf symbol-elf: Cache ELF program/section headers
 and defer symbol name lookup
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Profiling dso__load_sym_internal() on large binaries showed significant
time spent in repeated libelf section and program header lookups
(elf_section_by_idx() and elf_read_program_header()) for each symbol,
resolving elf_sym__name() before filtering out non-symbol/non-allocated
entries, and running symbols__fixup_end() and symbols__fixup_duplicate()
twice when both .symtab and .dynsym are loaded.

Speed up ELF symbol table loading in dso__load_sym_internal() and
dso__load_sym():

- Pre-load PT_LOAD program headers into struct elf_phdr_cache and cache
  per-section metadata in a 64-entry direct-mapped table in
  dso__load_sym_internal() to avoid repeated libelf section and program
  header lookups during symbol iteration.
- Defer elf_sym__name() lookup until after non-allocated and non-symbol
  entries have been filtered out, and run symbols__fixup_end() and
  symbols__fixup_duplicate() once in dso__load_sym() after loading both
  .symtab and .dynsym.

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
 tools/perf/util/symbol-elf.c | 275 +++++++++++++++++++++++++++--------
 1 file changed, 217 insertions(+), 58 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 4023174ed6db..6082136c9662 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -265,6 +265,118 @@ static int elf_read_program_header(Elf *elf, u64 vaddr, GElf_Phdr *phdr)
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
@@ -1543,6 +1655,8 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	int nr = 0;
 	bool remap_kernel = false, adjust_kernel_syms = false;
 	u64 max_text_sh_offset = 0;
+	struct elf_phdr_cache phdr_cache = {};
+	struct elf_sec_cache_entry sec_cache[ELF_SEC_CACHE_SIZE];
 
 	if (kmap && !kmaps)
 		return -1;
@@ -1634,14 +1748,18 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
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
@@ -1652,6 +1770,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		 * output:
 		 */
 		if (ehdr.e_machine == EM_ARM || ehdr.e_machine == EM_AARCH64) {
+			elf_name = elf_sym__name(&sym, symstrs);
 			if (elf_name[0] == '$' && strchr("adtx", elf_name[1])
 			    && (elf_name[2] == '\0' || elf_name[2] == '.'))
 				continue;
@@ -1659,13 +1778,19 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
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
@@ -1688,16 +1813,56 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
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
@@ -1707,30 +1872,13 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
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
@@ -1740,7 +1888,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			--sym.st_value;
 
 		if (dso__kernel(dso)) {
-			if (dso__process_kernel_symbol(dso, map, &sym, &shdr,
+			if (dso__process_kernel_symbol(dso, map, &sym, &sce->shdr,
 						       kmaps, kmap, &curr_dso,
 						       section_name,
 						       adjust_kernel_syms,
@@ -1750,17 +1898,20 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
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
@@ -1769,16 +1920,18 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
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
@@ -1796,25 +1949,13 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			goto out_elf_end;
 		nr++;
 	}
-	dso__put(curr_dso);
 
-	/*
-	 * For misannotated, zeroed, ASM function sizes.
-	 */
-	if (nr > 0) {
-		symbols__fixup_end(dso__symbols(dso), false);
-		symbols__fixup_duplicate(dso__symbols(dso));
-		if (kmap) {
-			/*
-			 * We need to fixup this here too because we create new
-			 * maps here, for things like vsyscall sections.
-			 */
-			maps__fixup_end(kmaps);
-		}
-	}
+	dso__put(curr_dso);
+	elf_phdr_cache__exit(&phdr_cache);
 	return nr;
 out_elf_end:
 	dso__put(curr_dso);
+	elf_phdr_cache__exit(&phdr_cache);
 	return -1;
 }
 
@@ -1872,6 +2013,24 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		nr += err;
 	}
 
+	/*
+	 * For misannotated, zeroed, ASM function sizes.
+	 */
+	if (nr > 0) {
+		struct kmap *kmap = dso__kernel(dso) ? map__kmap(map) : NULL;
+		struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
+
+		symbols__fixup_end(dso__symbols(dso), false);
+		symbols__fixup_duplicate(dso__symbols(dso));
+		if (kmap && kmaps) {
+			/*
+			 * We need to fixup this here too because we create new
+			 * maps here, for things like vsyscall sections.
+			 */
+			maps__fixup_end(kmaps);
+		}
+	}
+
 	return nr;
 }
 
-- 
2.56.0.313.g2479322e68-goog

