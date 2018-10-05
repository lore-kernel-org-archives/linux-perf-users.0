From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf record: use unmapped IP for inline callchain cursors
Date: Fri, 5 Oct 2018 11:11:10 -0300
Message-ID: <20181005141110.GB20250@kernel.org>
References: <20181002073949.3297-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181002073949.3297-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Oct 02, 2018 at 09:39:49AM +0200, Milian Wolff escreveu:
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Reported-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> # Tested-by:
> # Reviewed-by:
> # Suggested-b:
> Fixes: bfe16b0653 ("perf report: Don't crash on invalid inline debug information")

No, the patch that Ravi pointed out as causing the regression wasn't the
one above, it was this one:

"perf report: Use the offset address to find inline frames"

I'm reworking this again...

- Arnaldo

> ---
>  tools/perf/util/machine.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 73a651f10a0f..111ae858cbcb 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2286,7 +2286,8 @@ static int append_inlines(struct callchain_cursor *cursor,
>  	if (!symbol_conf.inline_name || !map || !sym)
>  		return ret;
>  
> -	addr = map__rip_2objdump(map, ip);
> +	addr = map__map_ip(map, ip);
> +	addr = map__rip_2objdump(map, addr);
>  
>  	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
>  	if (!inline_node) {
> @@ -2317,6 +2318,9 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	if (symbol_conf.hide_unresolved && entry->sym == NULL)
>  		return 0;
>  
> +	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
> +		return 0;
> +
>  	/*
>  	 * Convert entry->ip from a virtual address to an offset in
>  	 * its corresponding binary.
> @@ -2324,9 +2328,6 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	if (entry->map)
>  		addr = map__map_ip(entry->map, entry->ip);
>  
> -	if (append_inlines(cursor, entry->map, entry->sym, addr) == 0)
> -		return 0;
> -
>  	srcline = callchain_srcline(entry->map, entry->sym, addr);
>  	return callchain_cursor_append(cursor, entry->ip,
>  				       entry->map, entry->sym,
> -- 
> 2.19.0
