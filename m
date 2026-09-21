Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68461FF7C8;
	Mon, 21 Sep 2026 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789949983; cv=none; b=QTdfGEIslxKXa8Vojp2pQvWGzZcWS3Onuo0DIaDUIvGj+gczo52HrutHkgELB0zQTBwCbcMO01LYViHH+542ijBwVUolEWI85SAYgyVvrq3r3Aig8OcDBNSfSatDPJQK91FXgnRLDIgzTmJBPBeTFHYVIvpxli0v0mYbQDHkL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789949983; c=relaxed/simple;
	bh=d/Ppme2wSmVTPnWQSJxsOMhtK31Y/QykexE6E2zgdZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7Q7Xb4I7KUm1oGXl881dKmSOaNlXti0mx8wp+3mN+iTXy3IH1/s0T21mbQIeiPErOjulNFeALtjVPRfIToU7F6SbPcPTQYVwDEB6+Hh7FOA7hq9lP4USLzgopuROVK1puIxaF83hjVK/xex/3SWsKqKTbqwV7I3uG+PDrpVMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DikzuigD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DikzuigD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFE11F000FF;
	Mon, 21 Sep 2026 00:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789949981;
	bh=niow0hJmIOiUfWZG1ep+ZdOnU6shzQQAooIcjMbvPhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DikzuigDY/6aaZyHrseCTeQAgPFrhy1LjrmOIbKXZhjV8NR6L3lW2RlNSLe63oRGv
	 BMdD41HhkuRv92GVar3qq8Gl/FScnDfEpOmmFPTni5sHgqr/3acrRZT8gSDlUPFjPD
	 BbgO01WV88DO8rg5MhIRwNXGiIZt7NxCwddQTDiake3Ckllx/pjRsynzzanuxkXeVG
	 W7JyOPo1+tr+4D1zp/b3YUQnjFJ86eo+toz6RipgKxLnW9FKBdBThTelE2uiELhcHg
	 RHlUDK2nxg4BHPRh4/zBU2NCNMSkFD+pV/7M9JRfku7uaR9Iy6/f+Yt+U1G7AEFjvL
	 R8JssLHrtFTvw==
Date: Sun, 20 Sep 2026 17:19:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] perf script: Add --lazy-load-symbols for lazy
 symbol loading
Message-ID: <arB4G744iWiSPAnV@z2>
References: <20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com>
 <20260919-perf-symbol-memory-send-v2-3-495b8f00ad7c@uber.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919-perf-symbol-memory-send-v2-3-495b8f00ad7c@uber.com>

On Sat, Sep 19, 2026 at 07:33:58PM -0700, Alireza Haghdoost via B4 Relay wrote:
> From: Alireza Haghdoost <haghdoost@uber.com>
> 
> perf script eagerly materializes eligible symbols from every DSO
> encountered in samples. On a production fixture, it loaded about 765k
> symbols to resolve about 45k distinct (DSO, symbol) frames, exceeding the
> memory available in a memory-constrained cgroup.
> 
> This patch adds --lazy-load-symbols for userspace ELF DSOs. It builds a
> compact sorted index, resolves sampled addresses by binary search, reads
> symbol names through a private data-source DSO, and caches resolved symbols
> in the existing rb-tree. The private DSO uses the normal DSO data cache, so
> the exact split-debuginfo source can be reopened after descriptor eviction.
> If the source cannot be read during preflight, perf discards the index and
> eagerly loads that DSO instead.
> 
> On the same fixture, peak RssAnon drops from 265 MiB to 39 MiB and wall
> time from 3.1 seconds to 1.85 seconds. Memory optimizations usually cost
> time; this one does not because lazy loading skips many unnecessary
> calloc() calls and demangling operations.
> 
> Lazy loading is most effective when samples reference only a small
> fraction of the available symbols, such as profiles spanning many large
> DSOs. It still builds an index proportional to the total symbol count.
> Eager loading remains available for dense symbol coverage or cases
> requiring its broader ELF and architecture support.
> 
> This does not claim full parity with the eager loader. Lazy loading
> supports the common userspace ELF symtab/dynsym case; .gnu_debugdata and
> PPC64 .opd continue through the eager loader.
> 
> Materialization is serialized with the DSO lock. Name lookups materialize
> the remaining index before constructing the name-sorted array. Lazy loading
> shares eager duplicate and IFUNC selection, and clips ranges that cross
> .plt before synthesizing PLT symbols.
> 
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> ---
[SNIP]
> +static int dso__build_ondemand_index(struct dso *dso, struct symsrc *syms_ss,
> +				     struct symsrc *runtime_ss,
> +				     int dynsym)
> +{
> +	struct dso_ondemand *od;
> +	Elf *elf = syms_ss->elf;
> +	GElf_Ehdr ehdr = syms_ss->ehdr;
> +	GElf_Shdr shdr;
> +	GElf_Shdr strshdr;
> +	Elf_Scn *strscn, *sec_strndx;
> +	Elf_Data *syms;
> +	GElf_Sym sym;
> +	Elf_Data *secstrs = NULL;
> +	size_t i, index_bytes, reservation_peak;
> +	u32 count = 0, j;
> +	u32 *name_offsets;
> +	u64 nr_entries, strtab_offset;
> +	u64 probe_off;
> +	u8 probe;
> +
> +	/*
> +	 * GNU debugdata is backed by a temporary decompressed fd rather than a
> +	 * reopenable source path. Keep using the eager loader for that case.
> +	 */
> +	if (syms_ss->type == DSO_BINARY_TYPE__GNU_DEBUGDATA)
> +		return 0;
> +
> +	if (dynsym)
> +		shdr = syms_ss->dynshdr;
> +	else
> +		shdr = syms_ss->symshdr;
> +
> +	syms = elf_getdata(dynsym ? syms_ss->dynsym : syms_ss->symtab, NULL);
> +	if (!syms)
> +		return -1;
> +
> +	if (!shdr.sh_entsize)
> +		return 0;
> +
> +	nr_entries = shdr.sh_size / shdr.sh_entsize;
> +	if (nr_entries > UINT32_MAX)
> +		return -EOVERFLOW;
> +
> +	strscn = elf_getscn(elf, shdr.sh_link);
> +	if (!strscn || !gelf_getshdr(strscn, &strshdr))
> +		return -1;
> +	strtab_offset = strshdr.sh_offset;
> +
> +	/*
> +	 * Section name string table, used to match the eager path's
> +	 * elf_sec__filter() (text/data section check for STT_NOTYPE labels).
> +	 */
> +	sec_strndx = elf_getscn(elf, ehdr.e_shstrndx);
> +	if (sec_strndx)
> +		secstrs = elf_getdata(sec_strndx, NULL);
> +
> +	for (i = 0; i < nr_entries; i++) {
> +		if (!gelf_getsym(syms, i, &sym))
> +			continue;
> +		if (ondemand_sym_ok(elf, secstrs, &sym, shdr.sh_link,
> +				    ehdr.e_machine))
> +			count++;
> +	}
> +
> +	if (!count)
> +		return 0;
> +	if (check_mul_overflow((size_t)count, sizeof(*od->sorted),
> +			       &index_bytes))
> +		return -EOVERFLOW;
> +
> +	/*
> +	 * Account the index against the symbol memory budget: at 24
> +	 * bytes/symbol it is the dominant on-demand cost and must count
> +	 * toward --max-symbol-bytes just like struct symbol allocations do.
> +	 */
> +	if (!symbol__try_account_bytes(index_bytes)) {
> +		symbol_budget_warning();
> +		return 0; /* fall back to the eager loader's per-symbol budget */
> +	}
> +	reservation_peak = symbol__bytes_used();
> +
> +	od = zalloc(sizeof(*od));
> +	if (!od) {
> +		symbol__unaccount_bytes(index_bytes);
> +		return -1;
> +	}
> +
> +	od->sorted = zalloc(index_bytes);
> +	if (!od->sorted) {
> +		symbol__unaccount_bytes(index_bytes);
> +		free(od);
> +		return -1;
> +	}
> +	od->nr_alloc = count;	/* allocated; the deduped count may shrink */
> +	name_offsets = malloc(count * sizeof(*name_offsets));
> +	if (!name_offsets) {
> +		symbol__unaccount_bytes(index_bytes);
> +		free(od->sorted);
> +		free(od);
> +		return -1;
> +	}
> +
> +	j = 0;
> +	for (i = 0; i < nr_entries; i++) {
> +		u64 adjusted;
> +		GElf_Phdr phdr;
> +
> +		if (!gelf_getsym(syms, i, &sym))
> +			continue;
> +		if (!ondemand_sym_ok(elf, secstrs, &sym, shdr.sh_link,
> +				     ehdr.e_machine))
> +			continue;
> +
> +		adjusted = sym.st_value;
> +
> +		if ((ehdr.e_machine == EM_ARM) &&
> +		    (GELF_ST_TYPE(sym.st_info) == STT_FUNC) &&
> +		    (adjusted & 1))
> +			--adjusted;
> +
> +		/*
> +		 * Program header adjustment, identical to the eager loop:
> +		 * read the PT_LOAD containing the symbol from the runtime
> +		 * ELF (the debug-info file may have zeroed p_offset), and
> +		 * fall back to the section-header bias when no program
> +		 * header matches -- exactly what the eager path does when
> +		 * elf_read_program_header fails.
> +		 */
> +		if (elf_read_program_header(runtime_ss->elf, adjusted,
> +					    &phdr) == 0) {
> +			adjusted -= phdr.p_vaddr - phdr.p_offset;
> +		} else {
> +			Elf_Scn *sym_sec = elf_getscn(elf, sym.st_shndx);
> +			GElf_Shdr sym_shdr;
> +
> +			if (sym_sec && gelf_getshdr(sym_sec, &sym_shdr))
> +				adjusted -= sym_shdr.sh_addr - sym_shdr.sh_offset;
> +		}
> +
> +		od->sorted[j].start = adjusted;
> +		od->sorted[j].end = sym.st_size; /* st_size for now, converted later */
> +		/*
> +		 * Sort equal-start aliases in original symtab order to match
> +		 * rb-tree insertion order. Restore st_name after sorting.
> +		 */
> +		name_offsets[j] = sym.st_name;
> +		od->sorted[j].name_off = j;
> +		od->sorted[j].binding = GELF_ST_BIND(sym.st_info);
> +		od->sorted[j].type = GELF_ST_TYPE(sym.st_info);
> +		j++;
> +	}
> +	count = j;
> +	if (!count) {
> +		symbol__unaccount_bytes(index_bytes);
> +		free(name_offsets);
> +		free(od->sorted);
> +		free(od);
> +		return 0;
> +	}
> +
> +	qsort(od->sorted, count, sizeof(*od->sorted), cmp_sym_idx);
> +	for (i = 0; i < count; i++)
> +		od->sorted[i].name_off = name_offsets[od->sorted[i].name_off];
> +	free(name_offsets);
> +
> +	/*
> +	 * Match the eager loader's ordering: fill zero-sized ranges before
> +	 * choosing among equal-start aliases, so the size preference sees
> +	 * the same synthesized lengths as symbols__fixup_duplicate().
> +	 */
> +	for (i = 0; i < count; i++) {
> +		u64 size = od->sorted[i].end; /* was st_size */
> +
> +		if (size > 0)
> +			od->sorted[i].end = od->sorted[i].start + size;
> +		else if (i + 1 < count)
> +			od->sorted[i].end = od->sorted[i + 1].start;
> +		else
> +			od->sorted[i].end = roundup(od->sorted[i].start, 4096) + 4096;
> +	}
> +
> +	if (!symbol_conf.allow_aliases) {
> +		u32 out = 0;

I think we agreed to factor out this block of code.

> +
> +		for (i = 0; i < count; i++) {
> +			u32 best = i;
> +			const char *na = NULL, *nb;
> +			char *da = NULL, *db;
> +			bool has_ifunc = od->sorted[i].type == STT_GNU_IFUNC;
> +
> +			na = elf_strptr(elf, shdr.sh_link,
> +					od->sorted[best].name_off);
> +			if (na) {
> +				da = dso__demangle_sym(dso, 0, na);
> +				if (da)
> +					na = da;
> +			}
> +
> +			for (j = i + 1; j < count &&
> +			     od->sorted[j].start == od->sorted[i].start; j++) {
> +				int choice;
> +
> +				has_ifunc |= od->sorted[j].type == STT_GNU_IFUNC;
> +				nb = elf_strptr(elf, shdr.sh_link,
> +						od->sorted[j].name_off);
> +				if (!na || !nb)
> +					continue;
> +
> +				db = dso__demangle_sym(dso, 0, nb);
> +				if (db)
> +					nb = db;
> +
> +				choice = symbol__choose_best(
> +						od->sorted[best].end -
> +						od->sorted[best].start,
> +						od->sorted[best].type,
> +						od->sorted[best].binding, na,
> +						od->sorted[j].end -
> +						od->sorted[j].start,
> +						od->sorted[j].type,
> +						od->sorted[j].binding, nb);
> +				if (choice == SYMBOL_B) {
> +					best = j;
> +					free(da);
> +					da = db;
> +					na = nb;
> +				} else {
> +					free(db);
> +				}
> +			}
> +
> +			free(da);
> +			od->sorted[out++] = od->sorted[best];
> +			if (has_ifunc && od->sorted[out - 1].type != STT_GNU_IFUNC)
> +				od->sorted[out - 1].flags |= SYM_IDX_FLAG_IFUNC_ALIAS;
> +			i = j - 1; /* skip past all aliases of this start */
> +		}
> +
> +		if (out < count) {
> +			struct sym_idx *shrunk;
> +
> +			shrunk = realloc(od->sorted, out * sizeof(*od->sorted));
> +			if (shrunk) {
> +				od->sorted = shrunk;
> +				symbol__unaccount_bytes((od->nr_alloc - out) *
> +						       sizeof(*od->sorted));
> +				od->nr_alloc = out;
> +			}
> +		}
> +		count = out;
> +	}
> +
> +	/*
> +	 * The interval binary search requires non-overlapping ranges.  In
> +	 * the default deduplicated mode, prefer the symbol with the nearest
> +	 * preceding start when an ELF st_size overlaps the next symbol.
> +	 */
> +	if (!symbol_conf.allow_aliases) {
> +		for (i = 0; i + 1 < count; i++) {
> +			if (od->sorted[i].end > od->sorted[i + 1].start)
> +				od->sorted[i].end = od->sorted[i + 1].start;
> +		}
> +	}
> +
> +	/*
> +	 * Keep an exact-path data DSO for the symbol source.  This may differ
> +	 * from the runtime image (for example, split debuginfo), so using the
> +	 * primary DSO's data cache could read an unrelated string-table offset.
> +	 * The standard DSO data cache manages descriptor eviction and reopening.
> +	 */

Yes, it's a known problem and I hope to address it soon.  Can you please
make the path handling a separate commit?  I think it's an independent
fix for split debuginfo.


> +	od->data_dso = dso__new(syms_ss->name);
> +	if (!od->data_dso ||
> +	    dso__data_set_path(od->data_dso, syms_ss->name) < 0)
> +		goto out_decline_source;
> +	dso__set_binary_type(od->data_dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
> +	dso__set_nsinfo(od->data_dso, nsinfo__get(dso__nsinfo(dso)));
> +
> +	/*
> +	 * Open the managed source while eager fallback is still possible.
> +	 * A later failure would otherwise turn materialization into a miss.
> +	 */
> +	if (od->sorted[0].name_off >= strshdr.sh_size)
> +		goto out_decline_source;
> +	if (check_add_overflow(strtab_offset,
> +			       (u64)od->sorted[0].name_off, &probe_off))
> +		goto out_decline_source;
> +	if (dso__data_read_offset(od->data_dso, NULL, probe_off, &probe, 1) != 1)
> +		goto out_decline_source;
> +
> +	od->strtab_offset = strtab_offset;
> +	od->strtab_size = strshdr.sh_size;
> +	od->nr_sorted = count;
> +
> +	dso__set_ondemand(dso, od);
> +
> +	pr_debug("%s: on-demand index: %u symbols (%zu bytes, %zu bytes total) budget=%zu\n",
> +		 dso__long_name(dso), count,
> +		 od->nr_alloc * sizeof(*od->sorted), symbol__bytes_used(),
> +		 reservation_peak);
> +
> +	return 1;
> +
> +out_decline_source:
> +	if (od->data_dso) {
> +		dso__data_close(od->data_dso);
> +		dso__put(od->data_dso);
> +	}
> +	symbol__unaccount_bytes(od->nr_alloc * sizeof(*od->sorted));
> +	free(od->sorted);
> +	free(od);
> +	return 0;
> +}
[SNIP]
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 32eef666f748..3ca9655c36fd 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -143,72 +143,80 @@ int __weak arch__compare_symbol_names_n(const char *namea, const char *nameb,
>  	return strncmp(namea, nameb, n);
>  }
>  
> -int __weak arch__choose_best_symbol(struct symbol *syma,
> -				    struct symbol *symb __maybe_unused)
> +int __weak arch__choose_best_symbol(const char *syma_name)
>  {
>  	/* Avoid "SyS" kernel syscall aliases */
> -	if (strlen(syma->name) >= 3 && !strncmp(syma->name, "SyS", 3))
> +	if (strlen(syma_name) >= 3 && !strncmp(syma_name, "SyS", 3))
>  		return SYMBOL_B;
> -	if (strlen(syma->name) >= 10 && !strncmp(syma->name, "compat_SyS", 10))
> +	if (strlen(syma_name) >= 10 && !strncmp(syma_name, "compat_SyS", 10))
>  		return SYMBOL_B;
>  
>  	return SYMBOL_A;
>  }
>  
> -static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
> +int symbol__choose_best(u64 a_size, u8 a_type, u8 a_binding,
> +			const char *a_name,
> +			u64 b_size, u8 b_type, u8 b_binding,
> +			const char *b_name)
>  {
>  	s64 a;
>  	s64 b;
>  	size_t na, nb;
>  
>  	/* Prefer a symbol with non zero length */
> -	a = syma->end - syma->start;
> -	b = symb->end - symb->start;
> -	if ((b == 0) && (a > 0))
> +	if ((b_size == 0) && (a_size > 0))
>  		return SYMBOL_A;
> -	else if ((a == 0) && (b > 0))
> +	else if ((a_size == 0) && (b_size > 0))
>  		return SYMBOL_B;
>  
> -	if (symbol__type(syma) != symbol__type(symb)) {
> -		if (symbol__type(syma) == STT_NOTYPE)
> +	if (a_type != b_type) {
> +		if (a_type == STT_NOTYPE)
>  			return SYMBOL_B;
> -		if (symbol__type(symb) == STT_NOTYPE)
> +		if (b_type == STT_NOTYPE)
>  			return SYMBOL_A;
>  	}
>  
>  	/* Prefer a non weak symbol over a weak one */
> -	a = symbol__binding(syma) == STB_WEAK;
> -	b = symbol__binding(symb) == STB_WEAK;
> +	a = a_binding == STB_WEAK;
> +	b = b_binding == STB_WEAK;
>  	if (b && !a)
>  		return SYMBOL_A;
>  	if (a && !b)
>  		return SYMBOL_B;
>  
>  	/* Prefer a global symbol over a non global one */
> -	a = symbol__binding(syma) == STB_GLOBAL;
> -	b = symbol__binding(symb) == STB_GLOBAL;
> +	a = a_binding == STB_GLOBAL;
> +	b = b_binding == STB_GLOBAL;
>  	if (a && !b)
>  		return SYMBOL_A;
>  	if (b && !a)
>  		return SYMBOL_B;
>  
>  	/* Prefer a symbol with less underscores */
> -	a = prefix_underscores_count(syma->name);
> -	b = prefix_underscores_count(symb->name);
> +	a = prefix_underscores_count(a_name);
> +	b = prefix_underscores_count(b_name);
>  	if (b > a)
>  		return SYMBOL_A;
>  	else if (a > b)
>  		return SYMBOL_B;
>  
>  	/* Choose the symbol with the longest name */
> -	na = strlen(syma->name);
> -	nb = strlen(symb->name);
> +	na = strlen(a_name);
> +	nb = strlen(b_name);
>  	if (na > nb)
>  		return SYMBOL_A;
>  	else if (na < nb)
>  		return SYMBOL_B;
>  
> -	return arch__choose_best_symbol(syma, symb);
> +	return arch__choose_best_symbol(a_name);
> +}
> +
> +static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
> +{
> +	return symbol__choose_best(syma->end - syma->start,
> +				   symbol__type(syma), symbol__binding(syma), syma->name,
> +				   symb->end - symb->start,
> +				   symbol__type(symb), symbol__binding(symb), symb->name);
>  }

To reduce the size of the patch, I think it's better to split this as a
separate commit.  Please consider minimize the patch size in general to
help reviewers. :)

Thanks,
Namhyung

>  
>  void symbols__fixup_duplicate(struct rb_root_cached *symbols)
> @@ -1989,11 +1997,19 @@ int dso__load(struct dso *dso, struct map *map)
>  		}
>  
>  #ifdef HAVE_LIBBFD_SUPPORT
> +#ifdef HAVE_LIBELF_SUPPORT
> +		if (is_reg && !symbol_conf.lazy_load_symbols)
> +#else
>  		if (is_reg)
> +#endif
>  			bfdrc = dso__load_bfd_symbols(dso, name);
>  #endif
>  		if (is_reg && bfdrc < 0)
>  			sirc = symsrc__init(ss, dso, name, symtab_type);
> +#if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBELF_SUPPORT)
> +		if (is_reg && symbol_conf.lazy_load_symbols && sirc < 0)
> +			bfdrc = dso__load_bfd_symbols(dso, name);
> +#endif
>  
>  		if (nsexit)
>  			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index f7331edf0b71..99563c9ff610 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -233,6 +233,10 @@ size_t symbol__bytes_used(void);
>  void symbol__account_bytes(size_t bytes);
>  bool symbol__try_account_bytes(size_t bytes);
>  void symbol__unaccount_bytes(size_t bytes);
> +int symbol__choose_best(u64 a_size, u8 a_type, u8 a_binding,
> +			const char *a_name,
> +			u64 b_size, u8 b_type, u8 b_binding,
> +			const char *b_name);
>  size_t __symbol__fprintf_symname_offs(const struct symbol *sym,
>  				      const struct addr_location *al,
>  				      bool unknown_as_addr,
> @@ -308,7 +312,7 @@ const char *arch__normalize_symbol_name(const char *name);
>  int arch__compare_symbol_names(const char *namea, const char *nameb);
>  int arch__compare_symbol_names_n(const char *namea, const char *nameb,
>  				 unsigned int n);
> -int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
> +int arch__choose_best_symbol(const char *syma_name);
>  
>  enum symbol_tag_include {
>  	SYMBOL_TAG_INCLUDE__NONE = 0,
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index 6a16c5badd5e..0f8d044eba20 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -74,6 +74,7 @@ struct symbol_conf {
>  			no_buildid_mmap2,
>  			guest_code,
>  			lazy_load_kernel_maps,
> +			lazy_load_symbols,
>  			keep_exited_threads,
>  			annotate_data_member,
>  			annotate_data_sample,
> 
> -- 
> Git-157)
> 
> 
