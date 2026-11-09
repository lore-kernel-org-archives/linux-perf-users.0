Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199877;
	b=LqFIGGSJdaHS9WpVC7t2Frnd3+HI/JEzmpxQHg8F2Yy6TC+AYQsJko2N4jvX5blK/XpR
	 x9E+kmFLuloN7hSyu8XU6PsmOre/b6yGs8SBEVwWpFEb0rEKeZRNPmef7Few6OUH+HRYl
	 kwfF8SCGxjhcjMTSXBKW3BgMtb5XZ4olAVh+xUtAQrlom5PFw68bt6z1G7S52xjAwBsZs
	 UviDqbfuCW0GBI915rlvfC/VJ7oZos60Mv8JGf/BHiHiwpW7xG3gpnUlE9u3CQMTzP9Lv
	 n4U5zLby8Ldrm+ro5zmXUUXmv6sEoOdyrre9efUtmfz0coHNt6ot0XtJ9RPG43dSn9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199877;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UHfIuj9XV86YENs0+tBiGTF9GmpaSycoxACTNNGEH9Q=;
	b=VuU7J7Z3BcsL5lFUwupOfad6gjlvMTxhXil1WKgL7iSS+agaqEg65Di71/yK9zOYQ84p
	 XNj7Qk9GGIIM1Y2EeiVoG/z2adF+h2vV28zZPq1039ildgknM9aTQWGrrjgQ1H3ajPTDu
	 alRhejRlGJHGo3JVeNx1RqV0pGGLpZfXN42vG+K3y+qeUO/un+WBTF0BeqeDDaWiCZStf
	 b44ULSxUW0eZCpL8fvkkslTsRYJSV6RnEo/4dhSf2WzQX6kxdvZgRU+Yv7Vgmt85g/ZRp
	 5qJKpFtM+QR6YLoWOf+08YU8GeLYC3HFfZsjRnYHKpYWscHK+PL8CZG5SQAzuDuAiwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVO32l8c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D4606A31C;
	Mon,  9 Nov 2026 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVO32l8c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDC71F0089F;
	Mon,  9 Nov 2026 04:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794199876;
	bh=UHfIuj9XV86YENs0+tBiGTF9GmpaSycoxACTNNGEH9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RVO32l8cPT0ci8PDbTcje7fjECHBpPeSw4Cpp0Qt0Yged78bYuJj3ubHg91vE5DDh
	 iC5xRaZU9qK8mBDEH9ecODthWuQJeh6cuMzs+4j1WGFwB8fs4cZSp2sAHR8uyX994Z
	 Dd27Z8O0/+wmD5j4MJNrjaRaBX5FBXIWcdUnnVvRewCF69th0/Njn13kahLAhseVfs
	 nJIZ4R4rPOOcwkjbahhQeQe2EVF8UaXSA1Bc+Q1N/YOEI/DhKTbX7jlMrc7h5QTIWd
	 Vd2gVK63RSXv8Pk5xKR9ZCM20TQWF6VggBrqjcQ/3G3G6QGkfr9+u3GzdaXiC8w6K1
	 LaTGaL6rxrEIA==
Date: Sun, 8 Nov 2026 20:51:14 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jakub Brnak <jbrnak@redhat.com>, Leo Yan <leo.yan@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] perf libdw: Find the CU by iterating all CUs when
 aranges are missing
Message-ID: <avFRQh8EL_Ab9Qcs@z2>
References: <20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org>
 <20261106-james-perf-test-fixes-v2-1-9a912662f822@linaro.org>
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
In-Reply-To: <20261106-james-perf-test-fixes-v2-1-9a912662f822@linaro.org>

Hello James,

On Fri, Nov 06, 2026 at 10:48:07AM +0000, James Clark wrote:
> libdw__addr2line() finds the CU with dwfl_module_getsrc() and
> dwfl_module_addrdie(), which use dwarf_getaranges(). In elfutils 0.190
> this only reads .debug_aranges, which can be partial. For example, when
> Perf is built with LLVM=1, clang doesn't emit .debug_aranges by default
> so the lookup then fails and no source lines are found for most of the
> Perf binary.
> 
> This used to be hidden by falling back to the next addr2line style, but
> now missing information stops the fallback since commit (62d7cdc8d587
> "perf libdw: Optimize fallback logic for missing DWARF").
> 
> find_cu_die() in annotate-data.c already handles partial aranges by
> iterating all CUs in .debug_info and checking them with dwarf_haspc().
> Move it to dwarf-aux.c, then look up the line in that CU with
> dwarf_getsrc_die() and use the same CU for unwinding inlines. While
> moving it, don't treat a dwarf_haspc() error as a match.
> 
> This fixes the "test addr2line inline unwinding" test when Perf is built
> with LLVM:
> 
>   $ perf test -vvv "test addr2line inline unwinding"
>   ...
>   Inline unwinding fp verification test [Failed missing inlined functions]
>   ...
>   Inline unwinding dwarf verification test [Failed missing inlined functions]
>   ...
>   Inline unwinding lbr verification test [Failed missing inlined functions]
>   ---- end(-1) ----
>    79: test addr2line inline unwinding : FAILED!
> 
> Fixes: 88c51002d06f ("perf addr2line: Add a libdw implementation")
> Signed-off-by: James Clark <james.clark@linaro.org>

Can you please rebase this one again?  It seems to clash with the recent
C++ data type profiling support.  I'm processing other patches as they
are independent fixes.

Thanks,
Namhyung


> ---
>  tools/perf/util/annotate-data.c | 27 +--------------------------
>  tools/perf/util/dwarf-aux.c     | 37 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h     |  3 +++
>  tools/perf/util/libdw.c         | 19 ++++++++++---------
>  4 files changed, 51 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 25e3169ea8ad..8092ef9d2045 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -523,31 +523,6 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
>  	return result;
>  }
>  
> -static bool find_cu_die(struct debuginfo *di, u64 pc, Dwarf_Die *cu_die)
> -{
> -	Dwarf_Off off, next_off;
> -	size_t header_size;
> -
> -	if (dwarf_addrdie(di->dbg, pc, cu_die) != NULL)
> -		return cu_die;
> -
> -	/*
> -	 * There are some kernels don't have full aranges and contain only a few
> -	 * aranges entries.  Fallback to iterate all CU entries in .debug_info
> -	 * in case it's missing.
> -	 */
> -	off = 0;
> -	while (dwarf_nextcu(di->dbg, off, &next_off, &header_size,
> -			    NULL, NULL, NULL) == 0) {
> -		if (dwarf_offdie(di->dbg, off + header_size, cu_die) &&
> -		    dwarf_haspc(cu_die, pc))
> -			return true;
> -
> -		off = next_off;
> -	}
> -	return false;
> -}
> -
>  enum type_match_result {
>  	PERF_TMR_UNKNOWN = 0,
>  	PERF_TMR_OK,
> @@ -1827,7 +1802,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  	pc = map__rip_2objdump(dloc->ms->map, dloc->ip);
>  
>  	/* Get a compile_unit for this address */
> -	if (!find_cu_die(dloc->di, pc, &cu_die)) {
> +	if (!cu_find_by_addr(dloc->di->dbg, pc, &cu_die)) {
>  		pr_debug_dtp("cannot find CU for address %"PRIx64"\n", pc);
>  		ann_data_stat.no_cuinfo++;
>  		return -1;
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 54f8b5ec74a2..742fccba5376 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -106,6 +106,43 @@ static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
>  	return line;
>  }
>  
> +/**
> + * cu_find_by_addr - Find the CU DIE that contains an address
> + * @dbg: a Dwarf handle
> + * @addr: An address
> + * @cu_die: a buffer to store the found CU DIE
> + *
> + * Find the CU DIE whose ranges contain @addr. dwarf_addrdie() uses
> + * dwarf_getaranges() which didn't work until elfutils 0.191. Release notes:
> + *
> + *   * NEWS *
> + *   libdw: dwarf_addrdie now supports binaries lacking a .debug_aranges
> + *   section.
> + *
> + * Clang doesn't emit them by default, so fall back to iterating all CUs in
> + * case it's missing.
> + *
> + * Return @cu_die if found, otherwise NULL.
> + */
> +Dwarf_Die *cu_find_by_addr(Dwarf *dbg, Dwarf_Addr addr, Dwarf_Die *cu_die)
> +{
> +	Dwarf_Off off = 0, next_off;
> +	size_t header_size;
> +
> +	if (dwarf_addrdie(dbg, addr, cu_die) && dwarf_haspc(cu_die, addr) == 1)
> +		return cu_die;
> +
> +	while (dwarf_nextcu(dbg, off, &next_off, &header_size,
> +			    NULL, NULL, NULL) == 0) {
> +		if (dwarf_offdie(dbg, off + header_size, cu_die) &&
> +		    dwarf_haspc(cu_die, addr) == 1)
> +			return cu_die;
> +
> +		off = next_off;
> +	}
> +	return NULL;
> +}
> +
>  /**
>   * cu_find_lineinfo - Get a line number and file name for given address
>   * @cu_die: a CU DIE
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 6f9145510adc..cc3fd61374c4 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -23,6 +23,9 @@ const char *cu_find_realpath(Dwarf_Die *cu_die, const char *fname);
>  /* Get DW_AT_comp_dir (should be NULL with older gcc) */
>  const char *cu_get_comp_dir(Dwarf_Die *cu_die);
>  
> +/* Find the CU DIE that contains the given address */
> +Dwarf_Die *cu_find_by_addr(Dwarf *dbg, Dwarf_Addr addr, Dwarf_Die *cu_die);
> +
>  /* Get a line number and file name for given address */
>  int cu_find_lineinfo(Dwarf_Die *cudie, Dwarf_Addr addr,
>  		     const char **fname, int *lineno);
> diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> index e660623338d5..90767361f485 100644
> --- a/tools/perf/util/libdw.c
> +++ b/tools/perf/util/libdw.c
> @@ -170,7 +170,9 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
>  {
>  	Dwfl *dwfl;
>  	Dwfl_Module *mod;
> -	Dwfl_Line *dwline;
> +	Dwarf_Line *dwline;
> +	Dwarf_Die cu_mem, *cudie;
> +	Dwarf *dw;
>  	Dwarf_Addr bias;
>  	const char *src;
>  	int lineno = 0;
> @@ -197,7 +199,8 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
>  	 * between the regular ELF addr2line addresses and those to use with
>  	 * libdw.
>  	 */
> -	if (!dwfl_module_getdwarf(mod, &bias)) {
> +	dw = dwfl_module_getdwarf(mod, &bias);
> +	if (!dw) {
>  		/*
>  		 * Free the Dwfl session so the mmap'd ELF binary is unmapped
>  		 * immediately, and mark the DSO as lacking srcline/DWARF info
> @@ -211,7 +214,8 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
>  	}
>  
>  	/* Find source line information for the address. */
> -	dwline = dwfl_module_getsrc(mod, addr + bias);
> +	cudie = cu_find_by_addr(dw, addr, &cu_mem);
> +	dwline = cudie ? dwarf_getsrc_die(cudie, addr) : NULL;
>  	if (!dwline) {
>  		/* conclusively missing information -> abort fallbacks */
>  		ret = 0;
> @@ -219,8 +223,8 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
>  	}
>  
>  	/* Get line information. */
> -	src = dwfl_lineinfo(dwline, /*addr=*/NULL, &lineno, /*col=*/NULL, /*mtime=*/NULL,
> -			    /*length=*/NULL);
> +	src = dwarf_linesrc(dwline, /*mtime=*/NULL, /*length=*/NULL);
> +	dwarf_lineno(dwline, &lineno);
>  
>  	if (file)
>  		*file = src ? strdup(src) : NULL;
> @@ -229,8 +233,6 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
>  
>  	/* Optionally unwind inline function call chain. */
>  	if (unwind_inlines && node) {
> -		Dwarf_Addr unused_bias;
> -		Dwarf_Die *cudie = dwfl_module_addrdie(mod, addr + bias, &unused_bias);
>  		struct libdw_a2l_cb_args args = {
>  			.dso = dso,
>  			.sym = sym,
> @@ -248,8 +250,7 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
>  		}
>  
>  		/* Walk from the parent down to the leaf. */
> -		if (cudie)
> -			cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
> +		cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
>  
>  		if (!args.leaf_srcline_used)
>  			free(args.leaf_srcline);
> 
> -- 
> 2.43.0
> 
