Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794983294;
	b=d86ganZd+DiD+1hZiWbalDYWXaKcsDpGWATIUrC1pakcq6bwO7jquYiVG2tvK8UGHl3n
	 GDBGoa+LGeCfkVP+a3nnL+mGE/Ymm8cnsbfXnJs7LNyJ5/ZJ9zAsOPlwsRZKs2wJlSEVl
	 5TvQx2+8N1e+Y8gCgbH0EeQ+so7KvJS/uZE8FhqAGGykf2fMVLT19/SSjHEg9EStiTpah
	 /HekFaqSUMiH69/7sEy0ueyFXRh+6bm9uy0KMYv2c0DSelwHWWhVeuysSxkIfFXUR2vy9
	 BI07lcOsbxIxCgaJA1k3sWZ7vpu53KAiZ/lwY/2naybPsurNAymS2tD/n9uxZEdg7+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794983294;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=N9CFIJBdHwVx3xXGNsYHLdhqiQo8R0GnSgbOhcY14X4=;
	b=Cd07bOQ4RaFrXc52wVnvpvT6xqdcsTRUYeCu0iQpleCcxCjg4Lu0pf9uYd2z6/ajdaq8
	 UCqZOeaO99jeK9vkHMfVQ2+03q9T0jThPOfPZ8VT3j5FPSXIbXozb4BpKwZp/XZI0I7I/
	 M5B2OEDp5Jhds5nEtXhjScNtPWgWrK2G1r5RcboVZbp+ka6/ZMjjfb8ZdA9SH0c0U7Rq6
	 faAY6Rwz6g9K12X5QY+q8ra3WvOQdYZhydPONWbTFkmHup0eyB9KecHHN8Eb4ny0kBUOX
	 s5n3qqHbM4z8t4LCmYGJabrRks8xmlfEHl9nsF/JRSCQQcRaJhaQLcqxDot0f9ffg6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oaSixYbY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DAD606A335;
	Wed, 18 Nov 2026 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oaSixYbY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB4E1F000C5;
	Wed, 18 Nov 2026 06:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794983293;
	bh=N9CFIJBdHwVx3xXGNsYHLdhqiQo8R0GnSgbOhcY14X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oaSixYbYhgSm5KIqLAQxkrWJZTvsuF22F5YYsGv7McuJywWsx1tfKJXgyhqHl5Zju
	 12udwtHxz3ArSVSDJhw36ai2/amIAkaRUOmIjWw8I3wfE0TU/kzo8YdH4W4O6zSgiY
	 XF4Y+Fi4no4HSKbymIZvv0OhPAshVFhsTuL3Y+y3uRzLdZSFMj1Kz/wVX6a7eUJk1k
	 AY2nbhd/KxNT2i241H1mdIthjZVVI9lQ93ITTxiXnJGi3lNxOMVsfezvNbrEd8L6C9
	 c7sNi3m2oLFIbR0fjlAi3ILoj8qmYjCtlTs4Nj1bU4hGRa/PJ8i6qO9KquN7olAz7x
	 QKuxZOr82HmFA==
Date: Tue, 17 Nov 2026 22:28:11 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alireza Haghdoost <haghdoost@uber.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/9] perf symbol: Switch backing storage from rbtree
 to struct symbols array
Message-ID: <av1Fe0w4_oAEPDhB@google.com>
References: <20261117185305.108003-1-irogers@google.com>
 <20261117185305.108003-6-irogers@google.com>
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
In-Reply-To: <20261117185305.108003-6-irogers@google.com>

On Tue, Nov 17, 2026 at 10:53:01AM -0800, Ian Rogers wrote:
> Previously, DSO symbols were stored in an unprotected rb_root_cached
> with a 24-byte struct rb_node embedded inside every struct symbol. That
> design had three drawbacks:
> 1. Embedding struct rb_node (3 pointers, 24 bytes on 64-bit) accounted
>    for nearly 40% of struct symbol's fixed header size and scattered
>    symbol lookups across non-contiguous heap nodes.
> 2. Unlike struct dsos and struct maps, the symbol rbtree had no lock
>    protecting concurrent lookups, sorting, and insertions.
> 3. Deduplicating symbols, splitting kallsyms, and trimming excess symbol
>    container capacity under memory pressure benefit from operating on a
>    compact array under a lock.
> 
> Replace struct rb_node in struct symbol with a locked, lazily-sorted
> pointer array in struct symbols, matching the design of struct dsos and
> struct maps:
> 
> - Introduce struct symbols containing a rw_semaphore lock, primary
>   address-sorted symbols array, secondary name-sorted symbols_by_name
>   array, counts, capacity, and sorted state flags.
> - Lazily sort symbols by start address using qsort (symbols__sort_locked)
>   and use binary search in symbols__find().
> - Update symbols__fixup_duplicate(), symbols__fixup_end(),
>   maps__split_kallsyms_for_kcore(), and maps__split_kallsyms() to
>   operate on the sorted array and compact entries in place.
> - Convert symbols__for_each_entry(), dso__for_each_symbol(), and
>   map__for_each_symbol() to callback-based iteration under
>   symbols->lock, matching dsos__for_each_dso() and maps__for_each_map().
> - Remove the unsynchronized single-entry dso->last_find_result cache and
>   dso__reset_find_symbol_cache() since binary search over a contiguous
>   array is cache-friendly.
> - Remove the direct rb_erase_cached() workaround in builtin-annotate.c's
>   add_sample().
> - Update the TUI map browser (ui/browsers/map.c) to snapshot the sorted
>   symbol array into an entries array and use ui_browser__argv_refresh
>   and ui_browser__argv_seek instead of ui_browser__rb_tree_refresh.
> 
> Using 'perf bench internals symbols':
> 
>   Before (perf binary):
>     Average DSO load + sort: 7.041 msec (+- 0.051 msec)
>     Average DSO memory usage: 1401 KB (+- 4 KB)
>     Average bulk insert + lookup: 1453.950 usec (+- 10.895 usec)
>   After (perf binary, -13.5% load, -14.6% memory, -7.7% bulk):
>     Average DSO load + sort: 6.089 msec (+- 0.039 msec)
>     Average DSO memory usage: 1197 KB (+- 3 KB)
>     Average bulk insert + lookup: 1341.500 usec (+- 21.564 usec)
> 
>   Before (libLLVM.so.21.1):
>     Average DSO load + sort: 78.599 msec (+- 0.857 msec)
>     Average DSO memory usage: 9530 KB (+- 5 KB)
>   After (libLLVM.so.21.1, -22.3% load, -8.1% memory):
>     Average DSO load + sort: 61.074 msec (+- 0.236 msec)
>     Average DSO memory usage: 8755 KB (+- 1 KB)
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/powerpc/util/sym-handling.c |  34 +-
>  tools/perf/builtin-annotate.c               |  11 -
>  tools/perf/builtin-kmem.c                   |  51 +-
>  tools/perf/tests/hists_common.c             |   5 +-
>  tools/perf/tests/symbols.c                  |  62 +-
>  tools/perf/tests/vmlinux-kallsyms.c         | 181 +++---
>  tools/perf/ui/browser.c                     |   3 +
>  tools/perf/ui/browsers/hists.c              |   3 +-
>  tools/perf/ui/browsers/map.c                |  62 +-
>  tools/perf/util/auxtrace.c                  | 109 ++--
>  tools/perf/util/db-export.c                 |   4 +-
>  tools/perf/util/dso.c                       |  50 +-
>  tools/perf/util/dso.h                       |  68 +--
>  tools/perf/util/intel-pt.c                  |  74 ++-
>  tools/perf/util/libbfd.c                    |   3 +-
>  tools/perf/util/machine.c                   |  30 +-
>  tools/perf/util/map.c                       |  36 +-
>  tools/perf/util/map.h                       |   8 +-
>  tools/perf/util/probe-event.c               |  98 +--
>  tools/perf/util/symbol-elf.c                |  12 +-
>  tools/perf/util/symbol.c                    | 643 ++++++++++++++------
>  tools/perf/util/symbol.h                    |  72 ++-
>  tools/perf/util/symbol_fprintf.c            |  25 +-
>  23 files changed, 1011 insertions(+), 633 deletions(-)
> 
> diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
> index 947bfad7aa59..f87d77262c00 100644
> --- a/tools/perf/arch/powerpc/util/sym-handling.c
> +++ b/tools/perf/arch/powerpc/util/sym-handling.c
> @@ -115,13 +115,27 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
>  }
>  
>  #ifdef HAVE_LIBELF_SUPPORT
> +struct post_process_probe_trace_events_args {
> +	struct perf_probe_event *pev;
> +	struct probe_trace_event *tev;
> +	struct map *map;
> +};
> +
> +static int post_process_probe_trace_events_cb(struct symbol *sym, void *data)
> +{
> +	struct post_process_probe_trace_events_args *args = data;
> +
> +	if (map__unmap_ip(args->map, sym->start) == args->tev->point.address) {
> +		arch__fix_tev_from_maps(args->pev, args->tev, args->map, sym);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
>  void arch__post_process_probe_trace_events(struct perf_probe_event *pev,
>  					   int ntevs)
>  {
> -	struct probe_trace_event *tev;
>  	struct map *map;
> -	struct symbol *sym = NULL;
> -	struct rb_node *tmp;
>  	int i = 0;
>  
>  	map = get_target_map(pev->target, pev->nsi, pev->uprobes);
> @@ -129,13 +143,13 @@ void arch__post_process_probe_trace_events(struct perf_probe_event *pev,
>  		return;
>  
>  	for (i = 0; i < ntevs; i++) {
> -		tev = &pev->tevs[i];
> -		map__for_each_symbol(map, sym, tmp) {
> -			if (map__unmap_ip(map, sym->start) == tev->point.address) {
> -				arch__fix_tev_from_maps(pev, tev, map, sym);
> -				break;
> -			}
> -		}
> +		struct post_process_probe_trace_events_args args = {
> +			.pev = pev,
> +			.tev = &pev->tevs[i],
> +			.map = map,
> +		};
> +
> +		map__for_each_symbol(map, post_process_probe_trace_events_cb, &args);

Please separate the map__for_each_symbol() changes as it can be
converted independently.  New users can be separate commits too.


>  	}
>  }
>  #endif /* HAVE_LIBELF_SUPPORT */
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 7cb7e03d9a21..65846110c309 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -258,17 +258,6 @@ static int add_sample(struct perf_sample *sample,
>  	    (al->sym == NULL ||
>  	     strcmp(ann->sym_hist_filter, al->sym->name) != 0)) {
>  		/* We're only interested in a symbol named sym_hist_filter */
> -		/*
> -		 * FIXME: why isn't this done in the symbol_filter when loading
> -		 * the DSO?
> -		 */
> -		if (al->sym != NULL) {
> -			struct dso *dso = map__dso(al->map);
> -
> -			rb_erase_cached(&al->sym->rb_node, dso__symbols(dso));
> -			symbol__delete(al->sym);
> -			dso__reset_find_symbol_cache(dso);
> -		}
>  		return 0;
>  	}
>  
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 8693c6b135ca..87869c717266 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -341,13 +341,33 @@ static int callcmp(const void *a, const void *b)
>  		return -1;
>  }
>  
> +static int build_alloc_func_list_cb(struct symbol *sym, void *data)
> +{
> +	regex_t *alloc_func_regex = data;
> +	struct alloc_func *func;
> +
> +	if (regexec(alloc_func_regex, sym->name, 0, NULL, 0))
> +		return 0;
> +
> +	func = realloc(alloc_func_list,
> +		       (nr_alloc_funcs + 1) * sizeof(*func));
> +	if (func == NULL)
> +		return -ENOMEM;
> +
> +	pr_debug("alloc func: %s\n", sym->name);
> +	func[nr_alloc_funcs].start = sym->start;
> +	func[nr_alloc_funcs].end   = sym->end;
> +	func[nr_alloc_funcs].name  = sym->name;
> +
> +	alloc_func_list = func;
> +	nr_alloc_funcs++;
> +	return 0;
> +}
> +
>  static int build_alloc_func_list(void)
>  {
>  	int ret;
>  	struct map *kernel_map;
> -	struct symbol *sym;
> -	struct rb_node *node;
> -	struct alloc_func *func;
>  	struct machine *machine = &kmem_session->machines.host;
>  	regex_t alloc_func_regex;
>  	static const char pattern[] = "^_?_?(alloc|get_free|get_zeroed)_pages?";
> @@ -364,30 +384,17 @@ static int build_alloc_func_list(void)
>  	kernel_map = machine__kernel_map(machine);
>  	if (map__load(kernel_map) < 0) {
>  		pr_err("cannot load kernel map\n");
> +		regfree(&alloc_func_regex);

Looks like an unrelated bug fix.

Thanks,
Namhyung


>  		return -ENOENT;
>  	}
>  
> -	map__for_each_symbol(kernel_map, sym, node) {
> -		if (regexec(&alloc_func_regex, sym->name, 0, NULL, 0))
> -			continue;
> -
> -		func = realloc(alloc_func_list,
> -			       (nr_alloc_funcs + 1) * sizeof(*func));
> -		if (func == NULL)
> -			return -ENOMEM;
> -
> -		pr_debug("alloc func: %s\n", sym->name);
> -		func[nr_alloc_funcs].start = sym->start;
> -		func[nr_alloc_funcs].end   = sym->end;
> -		func[nr_alloc_funcs].name  = sym->name;
> -
> -		alloc_func_list = func;
> -		nr_alloc_funcs++;
> -	}
> +	ret = map__for_each_symbol(kernel_map, build_alloc_func_list_cb, &alloc_func_regex);
> +	regfree(&alloc_func_regex);
> +	if (ret)
> +		return ret;
>  
> -	qsort(alloc_func_list, nr_alloc_funcs, sizeof(*func), funcmp);
> +	qsort(alloc_func_list, nr_alloc_funcs, sizeof(*alloc_func_list), funcmp);
>  
> -	regfree(&alloc_func_regex);
>  	return 0;
>  }
