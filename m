From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 1/3] perf report: Fix OOM error in TUI mode on s390
Date: Wed, 22 May 2019 15:08:12 -0300
Message-ID: <20190522180812.GI30271@kernel.org>
References: <20190522144601.50763-1-tmricht@linux.ibm.com>
 <20190522144601.50763-2-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190522144601.50763-2-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, May 22, 2019 at 04:45:59PM +0200, Thomas Richter escreveu:
> Debugging a OOM error using the TUI interface revealed this issue
> on s390:
> 
> [tmricht@m83lp54 perf]$ cat /proc/kallsyms |sort
> ....
> 00000001119b7158 B radix_tree_node_cachep
> 00000001119b8000 B __bss_stop
> 00000001119b8000 B _end
> 000003ff80002850 t autofs_mount	[autofs4]
> 000003ff80002868 t autofs_show_options	[autofs4]
> 000003ff80002a98 t autofs_evict_inode	[autofs4]
> ....
> 
> There is a huge gap between the last kernel symbol
> __bss_stop/_end and the first kernel module symbol
> autofs_mount (from autofs4 module).
> 
> After reading the kernel symbol table via functions:
> 
>  dso__load()
>  +--> dso__load_kernel_sym()
>       +--> dso__load_kallsyms()
> 	   +--> __dso_load_kallsyms()
> 	        +--> symbols__fixup_end()
> 
> the symbol __bss_stop has a start address of 1119b8000 and
> an end address of 3ff80002850, as can be seen by this debug statement:
> 
>   symbols__fixup_end __bss_stop start:0x1119b8000 end:0x3ff80002850
> 
> The size of symbol __bss_stop is 0x3fe6e64a850 bytes!
> It is the last kernel symbol and fills up the space until
> the first kernel module symbol.
> 
> This size kills the TUI interface when executing the following
> code:
> 
>   process_sample_event()
>     hist_entry_iter__add()
>       hist_iter__report_callback()
>         hist_entry__inc_addr_samples()
>           symbol__inc_addr_samples(symbol = __bss_stop)
>             symbol__cycles_hist()
>                annotated_source__alloc_histograms(...,
> 				                symbol__size(sym),
> 		                                ...)
> 
> This function allocates memory to save sample histograms.
> The symbol_size() marco is defined as sym->end - sym->start, which
> results in above value of 0x3fe6e64a850 bytes and
> the call to calloc() in annotated_source__alloc_histograms() fails.

Humm, why are we getting samples in that area? Is it some JITted thing
like BPF? What is it?

Why not just not consider the calloc failure as fatal, and when/if the
user asks for annotation on such symbol, tell the user that it wasn't
possible to allocate N bytes for it?

- Arnaldo
 
> Samples are generated when functions execute.
> To fix this I suggest to allow histogram entries only for functions.
> Therefore ignore symbol entries which are not of type STT_FUNC.
> 
> Output before:
> [tmricht@m83lp54 perf]$ ./perf --debug stderr=1 report -vvvvv \
> 					      -i ~/slow.data 2>/tmp/2
> [tmricht@m83lp54 perf]$ tail -5 /tmp/2
>   __symbol__inc_addr_samples(875): ENOMEM! sym->name=__bss_stop,
> 		start=0x1119b8000, addr=0x2aa0005eb08, end=0x3ff80002850,
> 		func: 0
> problem adding hist entry, skipping event
> 0x938b8 [0x8]: failed to process type: 68 [Cannot allocate memory]
> [tmricht@m83lp54 perf]$
> 
> Output after:
> [tmricht@m83lp54 perf]$ ./perf --debug stderr=1 report -vvvvv \
> 					      -i ~/slow.data 2>/tmp/2
> [tmricht@m83lp54 perf]$ tail -5 /tmp/2
>    symbol__inc_addr_samples map:0x1597830 start:0x110730000 end:0x3ff80002850
>    symbol__hists notes->src:0x2aa2a70 nr_hists:1
>    symbol__inc_addr_samples sym:unlink_anon_vmas src:0x2aa2a70
>    __symbol__inc_addr_samples: addr=0x11094c69e
>    0x11094c670 unlink_anon_vmas: period++ [addr: 0x11094c69e, 0x2e, evidx=0]
>    	=> nr_samples: 1, period: 526008
> [tmricht@m83lp54 perf]$
> 
> There is no error about failed memory allocation and the TUI interface
> shows all entries.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---
>  tools/perf/util/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 0b8573fd9b05..005cad111586 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -929,7 +929,7 @@ static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
>  {
>  	struct annotated_source *src;
>  
> -	if (sym == NULL)
> +	if (sym == NULL || sym->type != STT_FUNC)
>  		return 0;
>  	src = symbol__hists(sym, evsel->evlist->nr_entries);
>  	if (src == NULL)
> -- 
> 2.19.1

-- 

- Arnaldo
