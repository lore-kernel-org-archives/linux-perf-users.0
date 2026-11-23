Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795395833;
	b=ZqZ8pBUv8DqE9uT/TEW16E5O5ZdKYBcPFn+KWi+yP2HLg8I9yoX8CXKhHAy3VXv0xyBJ
	 8Fu5WC1boUDpcF+Rj7QNYchqgZOz3V2DcYgCB0JCTd38Ct6yhV7aZoSCzx6DGomTpUZL+
	 P7JbebNghFopmWBgNzwzu36QuRlrhM5hiQjcpxmDMSLWh64VwKAmuE62ZYU5hTduor7e2
	 om1tmwdg+vuys7wSApPwZH2UM1N8rUrJsvkurJLdgxXMe8as9yxeYAOVbXDUQeKmchqfm
	 4JvhbeoqxV4sjg+VY1azJ0n/moYXDP2zKlNqS74REpKoQeHpcQ1fIMoRFBisK2tG4jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795395833;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QRWNLAhSEzQ2ghJ+cYfCgpoK47yFn5MZzdy8l+IAuj4=;
	b=xqVWY1isEdNUjnmVjCGPo2uiiyJJFraSE6qhVs2p9zcZKsHg1f6gkGK3usy2CvZ7X2Li
	 giNASfzs5Yqv9cE3bMoWuVnmYFVtkQknYqwLFFdHc88I0acfEUHCRzBzk43twXJfSXFVS
	 WJZnsVQdu87G2FvcDkz/Ai7dHxZfzUqFFisqAtw7KqdLogXBIf69sYub8KOeC3CpuhzvF
	 150SIrL8CPNl1mQBmE+e0ga+6nUue/cRG3q5o1SRXOYJENeVBOnA/hChkRZVByisAKNVQ
	 tglElyQ2M/zaAx8VHXVpkHA68Jg6QV9xL+VMy/F32LHil9OdoBItmSrurtnU3Rgn1Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PuB5Knwe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1D606A31A;
	Mon, 23 Nov 2026 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PuB5Knwe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3CF1F000C4;
	Mon, 23 Nov 2026 01:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795395833;
	bh=QRWNLAhSEzQ2ghJ+cYfCgpoK47yFn5MZzdy8l+IAuj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PuB5Knwe9aGW2QR7iMktNczzY8pkJpJT2Abl+hvyV5SVSoK2b4GZRxLDOTfthB0n/
	 uC+SWECHZne9iyzcifSUCyPGvj+wbrAdKBirinJ+E2lHaEvd/CS9PnVbkQGkhlvwxb
	 HXM4tpJJB90rLJPOXkOdKbODBAEpsrhgYfKRAwi3uUidyIfwh0JM6Wp13IFlakTQer
	 ZHbQuh1IvRkVdZ0s/OA2R55yGFp15pGmZ3mMSDdDhRzJcpaSKNLCoDYrJRUQs0N3ML
	 TnPzD5QKwdRWU36CzZLxMbpZozYwbdn7FvSUdaicHDSxnKORuvFYmIYTFEDcLLN/XR
	 MGQtn0XuzNVHQ==
Date: Sun, 22 Nov 2026 17:03:51 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Alireza Haghdoost <haghdoost@uber.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] perf script: Add --lazy-load-symbols to load
 symbol names lazily
Message-ID: <awOQ90bOx9fbW8vo@google.com>
References: <20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com>
 <20261121-perf-symbol-memory-send-v8-5-370561cbb5a7@uber.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261121-perf-symbol-memory-send-v8-5-370561cbb5a7@uber.com>

On Sat, Nov 21, 2026 at 08:41:05AM -0800, Alireza Haghdoost wrote:
> This patch adds a --lazy-load-symbols option to perf script. With it,
> the ELF loader creates userspace .symtab and .dynsym symbols with lazy
> names, and perf reads a name only when a lookup returns that symbol.
> Eager loading stays the default.
> 
> perf script loads the whole ELF symbol table of every DSO that appears
> in a sample and keeps every symbol, with its demangled name, until exit.
> Most of those symbols are never sampled, and their names take most of
> the memory. On a large profile this is the main memory cost of perf
> script, and in a memory-limited cgroup it gets perf OOM-killed.
> 
> The loader still creates every symbol, so end fixup, duplicate
> selection, PLT synthesis and IFUNC marking do not change. It uses lazy
> names only if the string table is stored as is in the symbol table file,
> since names are read from it with pread().
> 
> A few names are still read at load time: aliases that duplicate
> selection can tell apart only by name, such as the .dynsym copies of
> .symtab symbols, and IFUNC symbols, whose names PLT synthesis uses.
> 
> The offsets are only valid in the file that perf loaded, so the loader
> records the file and its string tables with dso__set_lazy_file(), and
> perf checks the file, as the previous patch describes, before it reads
> names from it.
> 
> The kernel, modules, PPC64 .opd and .gnu_debugdata still load names
> eagerly.
> 
> On a 45,073-sample callchain profile of a large C++ service (about 1M
> symbols), lazy loading cuts max RSS from 327 MiB to 174 MiB, with
> identical output. It saves little run time, 3.56 seconds against 3.75,
> because one of the binaries exports most of its symbols, and duplicate
> selection reads the names of each .dynsym copy and of the .symtab
> symbol that it copies.
> 
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> ---

Only a few nitpicks.


>  tools/perf/Documentation/perf-script.txt |  11 ++++
>  tools/perf/builtin-script.c              |   2 +
>  tools/perf/util/symbol-elf.c             | 108 +++++++++++++++++++++++++++----
>  3 files changed, 110 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index f0228e784ced..4d04f5ecae8a 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -343,6 +343,17 @@ include::itrace.txt[]
>  
>          Default: 127
>  
> +--lazy-load-symbols::
> +	Read and demangle userspace ELF symbol names only when perf needs
> +	them. By default, perf reads every symbol name from each binary
> +	referenced by a sample. This option reduces memory use when samples
> +	reference only a small fraction of a large binary's symbols. The
> +	names are read while perf script runs. If a binary cannot be opened
> +	then, or no longer matches the one perf loaded, perf warns and shows
> +	the symbols whose names it cannot read as unknown. A binary matches
> +	if it has the same build ID and string table layout or, without a
> +	build ID, if it is the same unchanged file.
> +
>  --ns::
>  	Use 9 decimal places when displaying time (i.e. show the nanoseconds)
>  
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index b6691ebb1b4e..88aaf9cfd132 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -4287,6 +4287,8 @@ int cmd_script(int argc, const char **argv)
>  		     "Set the maximum stack depth when parsing the callchain, "
>  		     "anything beyond the specified depth will be ignored. "
>  		     "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
> +	OPT_BOOLEAN(0, "lazy-load-symbols", &symbol_conf.lazy_load_symbols,
> +		    "Read symbol names only when they are needed"),
>  	OPT_BOOLEAN(0, "reltime", &reltime, "Show time stamps relative to start"),
>  	OPT_BOOLEAN(0, "deltatime", &deltatime, "Show time stamps relative to previous event"),
>  	OPT_BOOLEAN('I', "show-info", &show_full_info,
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 468a0695809e..76f4aecb8632 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1871,6 +1871,52 @@ void dso__load_symbol_names(struct dso *dso, struct symbol **syms, size_t nr)
>  	}
>  }
>  
> +/*
> + * symbols__fixup_duplicate() compares the names of symbols at the same
> + * address only when their size, type and binding tie. Load those names.
> + */
> +static int dso__load_alias_names(struct dso *dso, int fd)
> +{
> +	struct rb_node *nd = rb_first_cached(dso__symbols(dso));
> +
> +	while (nd) {
> +		struct symbol *first = rb_entry(nd, struct symbol, rb_node);
> +		struct rb_node *end = rb_next(nd), *a, *b;
> +
> +		while (end && rb_entry(end, struct symbol, rb_node)->start == first->start)
> +			end = rb_next(end);
> +
> +		for (a = nd; a != end; a = rb_next(a)) {
> +			for (b = rb_next(a); b != end; b = rb_next(b)) {
> +				struct symbol *pair[2] = {
> +					rb_entry(a, struct symbol, rb_node),
> +					rb_entry(b, struct symbol, rb_node),
> +				};
> +
> +				if (symbol__choice_needs_names(pair[0], pair[1]) &&
> +				    read_symbol_names(dso, fd, pair, 2))
> +					return -1;
> +			}
> +		}
> +		nd = end;
> +	}
> +	return 0;
> +}
> +
> +/* PLT synthesis names IRELATIVE slots after IFUNC symbols. Load those names. */
> +static int dso__load_ifunc_names(struct dso *dso, int fd)
> +{
> +	struct symbol *pos;
> +	struct rb_node *nd;
> +
> +	symbols__for_each_entry(dso__symbols(dso), pos, nd) {
> +		if ((symbol__type(pos) == STT_GNU_IFUNC || symbol__ifunc_alias(pos)) &&
> +		    read_symbol_names(dso, fd, &pos, 1))
> +			return -1;
> +	}
> +	return 0;
> +}
> +
>  static int
>  dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  		       struct symsrc *runtime_ss, int kmodule, int dynsym)
> @@ -1888,11 +1934,21 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  	GElf_Sym sym;
>  	Elf_Scn *sec, *sec_strndx;
>  	Elf *elf;
> -	int nr = 0;
> +	int nr = 0, nr_lazy = 0;
>  	bool remap_kernel = false, adjust_kernel_syms = false;
>  	u64 max_text_sh_offset = 0;
>  	struct elf_phdr_cache phdr_cache = {};
>  	struct elf_sec_cache_entry sec_cache[ELF_SEC_CACHE_SIZE];
> +	/*
> +	 * Names are read later from the file of dso__symtab_type(). The
> +	 * .gnu_debugdata symbol table is a temporary file.
> +	 */
> +	bool lazy_allowed = symbol_conf.lazy_load_symbols && !dso__kernel(dso) &&
> +			  !kmodule && syms_ss->type == dso__symtab_type(dso) &&

I think kmodule has DSO_SPACE__KERNEL so it's enough to check only
dso__kernel().


> +			  syms_ss->type != DSO_BINARY_TYPE__GNU_DEBUGDATA &&
> +			  !runtime_ss->opdsec;
> +	bool lazy_names = false;
> +	GElf_Shdr strshdr;
>  
>  	if (kmap && !kmaps)
>  		return -1;
> @@ -1928,6 +1984,17 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  	if (symstrs == NULL)
>  		goto out_elf_end;
>  
> +	/*
> +	 * Names are read with pread(), so the string table must be stored as
> +	 * is, and later reads must find it in the same place.
> +	 */
> +	if (lazy_allowed && gelf_getshdr(sec, &strshdr) &&
> +	    strshdr.sh_type == SHT_STRTAB && !(strshdr.sh_flags & SHF_COMPRESSED) &&
> +	    !dso__set_lazy_file(dso, syms_ss->fd, dynsym,
> +				&(struct dso_lazy_strtab){ shdr.sh_link, strshdr.sh_offset,
> +							   strshdr.sh_size }))
> +		lazy_names = true;
> +
>  	sec_strndx = elf_getscn(runtime_ss->elf, runtime_ss->ehdr.e_shstrndx);
>  	if (sec_strndx == NULL)
>  		goto out_elf_end;
> @@ -2166,16 +2233,24 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  			}
>  		}
>  
> -		if (!elf_name)
> -			elf_name = elf_sym__name(&sym, symstrs);
> -		demangled = dso__demangle_sym(dso, kmodule, elf_name);
> -		if (demangled != NULL)
> -			elf_name = demangled;
> -
> -		f = symbol__new(sym.st_value, sym.st_size,
> -				GELF_ST_BIND(sym.st_info),
> -				GELF_ST_TYPE(sym.st_info), elf_name);
> -		free(demangled);
> +		if (lazy_names && sym.st_name < strshdr.sh_size) {
> +			f = symbol__new_lazy(sym.st_value, sym.st_size,
> +					     GELF_ST_BIND(sym.st_info),
> +					     GELF_ST_TYPE(sym.st_info),
> +					     strshdr.sh_offset + sym.st_name);
> +			nr_lazy++;
> +		} else {
> +			if (!elf_name)
> +				elf_name = elf_sym__name(&sym, symstrs);
> +			demangled = dso__demangle_sym(dso, kmodule, elf_name);
> +			if (demangled != NULL)
> +				elf_name = demangled;
> +
> +			f = symbol__new(sym.st_value, sym.st_size,
> +					GELF_ST_BIND(sym.st_info),
> +					GELF_ST_TYPE(sym.st_info), elf_name);
> +			free(demangled);
> +		}
>  		if (!f)
>  			goto out_elf_end;
>  
> @@ -2186,6 +2261,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  	}
>  	dso__put(curr_dso);
>  	elf_phdr_cache__exit(&phdr_cache);
> +
> +	if (lazy_names)
> +		pr_debug("%s: %d %s symbols with lazy names\n", dso__long_name(dso),
> +			 nr_lazy, dynsym ? ".dynsym" : ".symtab");

I'm afraid it'd add many debug messages for -v which is often used for
quick debugging.  Maybe pr_debug2() would be better.

Also please put parenthesis for multi-line expressions even if it's in a
statement.

Thanks,
Namhyung


>  	return nr;
>  out_elf_end:
>  	dso__put(curr_dso);
> @@ -2256,9 +2335,16 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  	if (nr > 0) {
>  		struct kmap *kmap = dso__kernel(dso) ? map__kmap(map) : NULL;
>  		struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
> +		/* Lazy names are only in syms_ss, never in the kernel or modules. */
> +		bool lazy = symbol_conf.lazy_load_symbols && !dso__kernel(dso) && !kmodule;
>  
>  		symbols__fixup_end(dso__symbols(dso), false);
> +		if (lazy && !symbol_conf.allow_aliases &&
> +		    dso__load_alias_names(dso, syms_ss->fd))
> +			return -1;
>  		symbols__fixup_duplicate(dso__symbols(dso));
> +		if (lazy && dso__load_ifunc_names(dso, syms_ss->fd))
> +			return -1;
>  		if (kmap) {
>  			/*
>  			 * We need to fixup this here too because we create new
> 
> -- 
> Git-157)
> 
