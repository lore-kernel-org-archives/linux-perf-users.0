Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEBC3AAF44;
	Thu, 17 Sep 2026 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629868; cv=none; b=C+Wq8RSjROptOOGbGn/xuyKV+TiZcMP5NZ8LKDUwuc0dhWv/zf2cKtTw/zQ66xPzFK9VgVoa1HvR32dYvLdVsY/+pOW2UW67R/KpHxtygnh8ztsyeHsqHqe43MRrvPiH+OMDlE5rHt9nGLPxrJFLquhLswAt2Ue9FxcYrbSdpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629868; c=relaxed/simple;
	bh=8QQUyvlU75nDbdY6PFEERD/VX84sauJZrsBoQQsir2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfoQFMcc9rCdRAcN/aYeuvsf5Y7phU3CVVtwgxyC0oEu6biUeBD67fZx4hvZlcihkov1GRq3fuO8/c0OFXvCCXnRMj9Dr/NcA87BiOtfn8KxvVqi61UsxzXSqDXBrcDsPOJc8cuC/sXqYzlDafqw/VgbV+3jR+LaE1C11bRgIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMBautA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMBautA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ABC1F000FF;
	Thu, 17 Sep 2026 07:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789629866;
	bh=4uBWeGgNKyQdWrmVC+PtW8V9U2hoOZ2YIsOFP5Lm+0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OMBautA6/TdKcER8UP71/lY8KZ/4UOYCSyIb0jgqSaXKwwZ4qmjrm2A3QsdB6vW4S
	 JNtl7uwtBhl70EKRREpq4r5IKgT3g3pD4VAJngvemvMY4603FRN6dLzdD7wyeb0lS8
	 fpM8kdL6p4hIhx27WM0WChBG5FmO1Nh5h+/mq5qj+IBkWxogMwgLeeTAaNdeM10TS2
	 TI/377hFgbkn+laciqVijpnmMGkIhQj7aK260Dbt0Pa1KyfDNdaAR4oVianue6vyHx
	 7PS4XFft2av6sXwRbg4jwHPRyES9a2TiGDYty5gRfwNtnf0DkB4l8NNPpQatdP5pCa
	 FO7mrQr2c9nhw==
Date: Thu, 17 Sep 2026 00:24:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andrii Nakryiko <andriin@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] perf script: Add --lazy-load-symbols for lazy symbol
 loading
Message-ID: <aquVqBiZbVYceOJ2@z2>
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
 <20260915-perf-symbol-memory-send-v1-3-1d3360e21f07@uber.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915-perf-symbol-memory-send-v1-3-1d3360e21f07@uber.com>

On Tue, Sep 15, 2026 at 11:42:45AM -0700, Alireza Haghdoost via B4 Relay wrote:
> From: Alireza Haghdoost <haghdoost@uber.com>
> 
> perf script eagerly materializes eligible symbols from every DSO
> encountered in samples. On a production fixture, it loaded about 765k
> symbols to resolve about 45k distinct (DSO, symbol) frames, exceeding the
> memory available in a memory-constrained cgroup.
> 
> This patch adds --lazy-load-symbols for userspace ELF DSOs. It builds a
> compact sorted index, resolves sampled addresses by binary search, reads
> symbol names with pread(), and caches resolved symbols in the existing
> rb-tree. Lazy lookup retains one CLOEXEC file descriptor per indexed DSO.
> If the descriptor cannot be retained, perf discards the index and eagerly
> loads that DSO instead.
> 
> On the same fixture, peak RssAnon drops from 265 MiB to 39 MiB and wall
> time from 3.1 seconds to 1.85 seconds. Memory optimizations usually cost
> time; this one does not because lazy loading skips many unnecessary
> calloc() calls and demangling operations. Output was byte-identical on
> the tested x86-64 workloads and an aarch64 capture.

Interesting!

> 
> Lazy loading is most effective when samples reference only a small
> fraction of the available symbols, such as profiles spanning many large
> DSOs. It still builds an index proportional to the total symbol count.
> Eager loading remains available for dense symbol coverage or cases
> requiring its broader ELF and architecture support.
> 
> This does not claim full parity with the eager loader. Lazy loading
> supports the common userspace ELF symtab/dynsym case, with these known
> differences:
> 
>   - .gnu_debugdata merging and PPC64 .opd are not handled.
>   - SHT_NOBITS re-reading, IFUNC PLT naming, and exact-tie alias ordering
>     are unreachable or output-equivalent on x86-64.

I'm curious how it could handle map__find_symbol_by_name().

> 
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> Assisted-by: Kimi:K3
> ---
>  tools/perf/builtin-script.c      |   4 +-
>  tools/perf/util/dso.c            |  10 +
>  tools/perf/util/dso.h            |  29 ++
>  tools/perf/util/map.c            |   9 +-
>  tools/perf/util/symbol-elf.c     | 560 ++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/symbol-minimal.c |  11 +
>  tools/perf/util/symbol.c         |  58 ++--
>  tools/perf/util/symbol.h         |   4 +
>  tools/perf/util/symbol_conf.h    |   1 +
>  9 files changed, 664 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 50fa6ca6455a..81e56378d3d2 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -4037,7 +4037,7 @@ static int parse_callret_trace(const struct option *opt __maybe_unused,
>  }
>  
>  static int parse_max_symbol_bytes(const struct option *opt,
> -				  const char *str, int unset)
> +				const char *str, int unset)
>  {
>  	unsigned long *max_bytes = (unsigned long *)opt->value;
>  	static struct parse_tag size_tags[] = {
> @@ -4166,6 +4166,8 @@ int cmd_script(int argc, const char **argv)
>  	OPT_CALLBACK(0, "max-symbol-bytes", &symbol_conf.max_symbol_bytes,
>  		     "size", "Limit bytes for ELF struct symbol (e.g. 128M; 0=unlimited)",
>  		     parse_max_symbol_bytes),
> +	OPT_BOOLEAN(0, "lazy-load-symbols", &symbol_conf.lazy_load_symbols,
> +		    "Resolve symbols lazily instead of loading full symtabs"),

Please add documentation as well.


>  	OPT_BOOLEAN(0, "reltime", &reltime, "Show time stamps relative to start"),
>  	OPT_BOOLEAN(0, "deltatime", &deltatime, "Show time stamps relative to previous event"),
>  	OPT_BOOLEAN('I', "show-info", &show_full_info,
[SNIP]
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 914e42d21f70..e4d77e46e883 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -2,6 +2,7 @@
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <errno.h>
> +#include <stdint.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> @@ -600,6 +601,32 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
>   * And always look at the original dso, not at debuginfo packages, that
>   * have the PLT data stripped out (shdr_rel_plt.sh_type == SHT_NOBITS).
>   */

It seems the above comment belongs to the original function.


> +static void dso__clip_ondemand_symbols_at(struct dso *dso, u64 addr)
> +{
> +	struct dso_ondemand *od = dso__ondemand(dso);
> +	struct sym_idx *sym;
> +	u32 lo = 0, hi, mid;
> +
> +	if (!od)
> +		return;
> +
> +	hi = od->nr_sorted;
> +	while (lo < hi) {
> +		mid = (lo + hi) / 2;
> +		if (od->sorted[mid].start < addr)
> +			lo = mid + 1;
> +		else
> +			hi = mid;
> +	}

Why not use bsearch()?

> +
> +	if (!lo)
> +		return;
> +
> +	sym = &od->sorted[lo - 1];
> +	if (sym->end > addr)
> +		sym->end = addr;
> +}
> +
>  int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
>  {
>  	uint32_t idx;
> @@ -623,6 +650,8 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
>  	if (!elf_section_by_name(elf, &ehdr, &shdr_plt, ".plt", NULL))
>  		return 0;
>  
> +	dso__clip_ondemand_symbols_at(dso, shdr_plt.sh_offset);

Why is this needed?

> +
>  	/*
>  	 * A symbol from a previous section (e.g. .init) can have been expanded
>  	 * by symbols__fixup_end() to overlap .plt. Truncate it before adding
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
> +	size_t i;
> +	u32 count = 0, j;
> +	u64 nr_entries, strtab_offset;
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
> +	/*
> +	 * File offset of the string table linked from the symbol table.
> +	 * Symbol names are pread() from the file at lookup time, so we
> +	 * only need the offset and size here, not the strings themselves.
> +	 */
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
> +	/* Count symbols that pass the filter (same filter as fill below) */
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
> +	if (count > SIZE_MAX / sizeof(*od->sorted))
> +		return -EOVERFLOW;
> +
> +	/*
> +	 * Account the index against the symbol memory budget: at 24
> +	 * bytes/symbol it is the dominant on-demand cost and must count
> +	 * toward --max-symbol-bytes just like struct symbol allocations do.
> +	 */
> +	if (symbol_conf.max_symbol_bytes &&
> +	    symbol__bytes_used() + count * sizeof(struct sym_idx) >
> +	    symbol_conf.max_symbol_bytes) {
> +		symbol_budget_warning();
> +		return 0; /* fall back to the eager loader's per-symbol budget */
> +	}
> +
> +	od = zalloc(sizeof(*od));
> +	if (!od)
> +		return -1;
> +
> +	od->sorted = malloc(count * sizeof(*od->sorted));
> +	if (!od->sorted) {
> +		free(od);
> +		return -1;
> +	}
> +	od->nr_alloc = count;	/* allocated; the deduped count may shrink */
> +
> +	/* Fill the index with adjusted addresses */
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
> +		/* ARM Thumb bit fix (same as eager path, FUNC only) */
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
> +		od->sorted[j].name_off = sym.st_name; /* strtab-relative */
> +		od->sorted[j].binding = GELF_ST_BIND(sym.st_info);
> +		od->sorted[j].type = GELF_ST_TYPE(sym.st_info);
> +		j++;
> +	}
> +
> +	/* Sort by adjusted start address */
> +	qsort(od->sorted, count, sizeof(*od->sorted), cmp_sym_idx);
> +
> +	/* Alias dedup: keep only the best symbol for each start address */
> +	if (!symbol_conf.allow_aliases) {

Probably better to factor out the dedup logic into a function.


> +		u32 out = 0;
> +
> +		for (i = 0; i < count; i++) {
> +			u32 best = i;
> +			const char *na = NULL, *nb;
> +			char *da = NULL, *db;
> +
> +			/* name_off is the strtab index (st_name) */
> +			na = elf_strptr(elf, shdr.sh_link,
> +					od->sorted[best].name_off);
> +			if (na) {
> +				da = dso__demangle_sym(dso, 0, na);
> +				if (da)
> +					na = da;
> +			}
> +
> +			/* Find the best among all entries with this start */
> +			for (j = i + 1; j < count &&
> +			     od->sorted[j].start == od->sorted[i].start; j++) {
> +				nb = elf_strptr(elf, shdr.sh_link,
> +						od->sorted[j].name_off);
> +				if (!na || !nb)
> +					continue;
> +
> +				/* Demangle for comparison, matching eager path */
> +				db = dso__demangle_sym(dso, 0, nb);
> +				if (db)
> +					nb = db;
> +
> +				/* od->sorted[].end holds st_size at this point */
> +				if (choose_best_symbol_raw(
> +					    od->sorted[best].end,
> +					    od->sorted[best].type,
> +					    od->sorted[best].binding, na,
> +					    od->sorted[j].end,
> +					    od->sorted[j].type,
> +					    od->sorted[j].binding, nb) == SYMBOL_B) {
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
> +			i = j - 1; /* skip past all aliases of this start */
> +		}
> +
> +		if (out < count) {
> +			struct sym_idx *shrunk;
> +
> +			shrunk = realloc(od->sorted, out * sizeof(*od->sorted));
> +			if (shrunk) {
> +				od->sorted = shrunk;
> +				od->nr_alloc = out;
> +			}
> +		}
> +		count = out;
> +	}
> +
> +	/* Convert st_size to end addresses */
> +	for (i = 0; i < count; i++) {
> +		u64 size = od->sorted[i].end; /* was st_size */
> +
> +		if (size > 0)
> +			od->sorted[i].end = od->sorted[i].start + size;
> +		else if (i + 1 < count)
> +			od->sorted[i].end = od->sorted[i + 1].start;
> +		else
> +			/* Match symbols__fixup_end's last-symbol formula. */
> +			od->sorted[i].end = roundup(od->sorted[i].start, 4096) + 4096;
> +	}
> +
> +	/*
> +	 * Keep a private fd open for pread() of symbol names.  Dup with
> +	 * O_CLOEXEC so children don't inherit it, and so that
> +	 * symsrc__destroy() can close the original regardless of whether
> +	 * it is a real file or a temporary debugdata extraction.
> +	 *
> +	 * If the dup fails (e.g. fd exhaustion), decline by returning 0
> +	 * without setting the index: the caller falls back to the eager
> +	 * loader so the DSO still gets symbols rather than going symbol-less.
> +	 */
> +	od->fd = fcntl(syms_ss->fd, F_DUPFD_CLOEXEC, 0);
> +	if (od->fd < 0) {
> +		free(od->sorted);
> +		free(od);
> +		return 0;
> +	}
> +	od->strtab_offset = strtab_offset;
> +	od->strtab_size = strshdr.sh_size;
> +	od->nr_sorted = count;
> +
> +	symbol__account_bytes(od->nr_alloc * sizeof(*od->sorted));
> +
> +	dso__set_ondemand(dso, od);
> +
> +	pr_debug("%s: on-demand index: %u symbols\n",
> +		 dso__long_name(dso), count);
> +
> +	return 1;
> +}
> +
> +/*
> + * Read a NUL-terminated symbol name from the file's string table at
> + * file offset @off.  The fast path uses a stack buffer; if the NUL is
> + * not found within it (names can exceed 1 KiB for template-heavy C++
> + * mangled names), grow a heap buffer geometrically from 4 KiB, doubling
> + * until the terminator is found or the strtab is exhausted.  This keeps
> + * a single long name cheap even when it sits near the start of a large
> + * (tens of MB) strtab, while bounding a corrupt/missing terminator by
> + * the remaining strtab size.
> + *
> + * Returns a pointer to the name (either @buf or a heap allocation) and
> + * sets *@to_free to the buffer that must be free()d (NULL for @buf).
> + * Returns NULL on read error or if no NUL terminator exists within the
> + * strtab bounds.
> + */

We have dso-cache APIs to read file data (dso__data_read_offset) and it
manages file descriptors so you don't need to worry about FD exhaustion.


> +static const char *ondemand_read_name(int fd, u64 strtab_offset,
> +				      u64 strtab_size, u64 name_off,
> +				      char *buf, size_t buflen,
> +				      char **to_free)
> +{
> +	ssize_t n;
> +	u64 remain;
> +	u64 file_off;
> +	size_t cap;
> +
> +	*to_free = NULL;
> +
> +	/* name_off is strtab-relative (the symbol's st_name). */
> +	if (name_off >= strtab_size)
> +		return NULL;
> +	file_off = strtab_offset + name_off;
> +	remain = strtab_size - name_off;
> +
> +	/*
> +	 * Fast path: stack buffer, expect the name to fit.  Cap at the
> +	 * remaining strtab so a missing terminator can't read past the
> +	 * section into adjacent file data.
> +	 */
> +	n = pread(fd, buf, min((u64)(buflen - 1), remain), file_off);
> +	if (n <= 0)
> +		return NULL;
> +	buf[n] = '\0';
> +	if (memchr(buf, '\0', n))
> +		return buf;
> +
> +	/*
> +	 * Slow path: the name is longer than buflen.  Grow a heap buffer
> +	 * geometrically, doubling until the terminator appears, so a long
> +	 * name costs O(name length), not O(remaining strtab size).
> +	 */
> +	cap = 4096;
> +	for (;;) {
> +		char *tmp;
> +		size_t want = cap;
> +
> +		if (want > remain)
> +			want = remain;
> +		if (want == 0)
> +			break;
> +
> +		tmp = *to_free ? realloc(*to_free, want + 1) : malloc(want + 1);
> +		if (!tmp) {
> +			free(*to_free);
> +			*to_free = NULL;
> +			return NULL;
> +		}
> +		*to_free = tmp;
> +
> +		n = pread(fd, *to_free, want, file_off);
> +		if (n <= 0) {
> +			free(*to_free);
> +			*to_free = NULL;
> +			return NULL;
> +		}
> +		(*to_free)[n] = '\0';
> +
> +		if (memchr(*to_free, '\0', n))
> +			return *to_free;
> +
> +		/*
> +		 * Read the whole remaining strtab (or hit EOF) with no
> +		 * terminator: corrupt file, bail instead of re-reading.
> +		 */
> +		if (want >= remain || (u64)n >= remain)
> +			break;
> +
> +		/* Avoid size_t overflow on absurdly large strtabs. */
> +		if (cap > SIZE_MAX / 2)
> +			break;
> +		cap *= 2;
> +	}
> +
> +	free(*to_free);
> +	*to_free = NULL;
> +	return NULL;
> +}
> +
> +struct symbol *dso__find_symbol_ondemand(struct dso *dso, u64 addr)
> +{
> +	struct dso_ondemand *od = dso__ondemand(dso);
> +	u32 lo, hi, mid;
> +	const char *name;
> +	char namebuf[1024];
> +	char *name_heap = NULL;
> +	char *demangled;
> +	struct symbol *s = NULL;
> +
> +	if (!od || !od->sorted || od->fd < 0)
> +		return NULL;
> +
> +	lo = 0;
> +	hi = od->nr_sorted;
> +	while (lo < hi) {
> +		mid = (lo + hi) / 2;
> +		if (addr < od->sorted[mid].start)
> +			hi = mid;
> +		else if (addr >= od->sorted[mid].end)
> +			lo = mid + 1;
> +		else
> +			goto found;
> +	}

bsearch()?

Thanks,
Namhyung

> +
> +	/* Not found */
> +	return NULL;
> +
> +found:
> +	/*
> +	 * Check the budget before doing any name I/O or demangling, so an
> +	 * over-budget DSO stops paying pread+demangle on every later miss.
> +	 */
> +	if (symbol_conf.max_symbol_bytes &&
> +	    symbol__bytes_used() >= symbol_conf.max_symbol_bytes) {
> +		symbol_budget_warning();
> +		return NULL;
> +	}
> +
> +	name = ondemand_read_name(od->fd, od->strtab_offset, od->strtab_size,
> +				  od->sorted[mid].name_off,
> +				  namebuf, sizeof(namebuf), &name_heap);
> +	if (!name)
> +		return NULL;
> +
> +	demangled = dso__demangle_sym(dso, 0, name);
> +	if (demangled)
> +		name = demangled;
> +
> +	s = symbol__new(od->sorted[mid].start,
> +			od->sorted[mid].end - od->sorted[mid].start,
> +			od->sorted[mid].binding,
> +			od->sorted[mid].type, name);
> +	free(demangled);
> +	free(name_heap);
> +	if (s)
> +		__symbols__insert(dso__symbols(dso), s);
> +	return s;
> +}
