From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 4/6] perf report: Use the offset address to find inline
 frames
Date: Mon, 1 Oct 2018 11:12:40 +0530
Message-ID: <ab64d0a8-f810-2868-59ff-cb2e28811e1d@linux.ibm.com>
References: <20180928122539.29326-1-acme@kernel.org>
 <20180928122539.29326-5-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928122539.29326-5-acme@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Milian Wolff <milian.wolff@kdab.com>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Sandipan Das <sandipan@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Milian, 

Seems this has a regression:

With acme/perf/urgent:

  $ ./perf record -e cycles:u --call-graph=dwarf ls
  $ ./perf script
  ls 13585 602082.534478:      28032 cycles:u: 
                   1f1f4 __GI___tunables_init+0xffff0000d3dc00a4 (/usr/lib64/ld-2.26.so)
                   20e2b _dl_sysdep_start+0xffff0000d3dc04ab (/usr/lib64/ld-2.26.so)
                    1ca7 _dl_start_final+0xffff0000d3dc00f7 (/usr/lib64/ld-2.26.so)
                    29b3 _dl_start+0xffff0000d3dc0553 (/usr/lib64/ld-2.26.so)
                    1437 _start+0xffff0000d3dc0017 (/usr/lib64/ld-2.26.so)

After reverting this patch:

  $ git revert d9c910d5f8c3a1858f115dc9d3b157df32da70a3
  [a/perf/urgent 72cada4e6b30] Revert "perf report: Use the offset address to find inline frames"

  $ ./perf script
  ls 13585 602082.534478:      28032 cycles:u: 
            7fff9613f1f4 __GI___tunables_init+0xa4 (/usr/lib64/ld-2.26.so)
            7fff96140e2b _dl_sysdep_start+0x4ab (/usr/lib64/ld-2.26.so)
            7fff96121ca7 _dl_start_final+0xf7 (/usr/lib64/ld-2.26.so)
            7fff961229b3 _dl_start+0x553 (/usr/lib64/ld-2.26.so)
            7fff96121437 _start+0x17 (/usr/lib64/ld-2.26.so)

Thanks,
Ravi


On 09/28/2018 05:55 PM, Arnaldo Carvalho de Melo wrote:
> From: Milian Wolff <milian.wolff@kdab.com>
> 
> To correctly find inlined frames, we have to use the file offset instead
> of the virtual memory address. This was already fixed for displaying
> srcline information while displaying in commit 2a9d5050dc84fa20 ("perf
> script: Show correct offsets for DWARF-based unwinding"). We just need
> to use the same corrected address also when trying to find inline
> frames.
> 
> This is another follow-up to commit 19610184693c ("perf script: Show
> virtual addresses instead of offsets").
> 
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Sandipan Das <sandipan@linux.ibm.com>
> Fixes: 19610184693c ("perf script: Show virtual addresses instead of offsets")
> Link: http://lkml.kernel.org/r/20180926135207.30263-2-milian.wolff@kdab.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/machine.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 0cb4f8bf3ca7..73a651f10a0f 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2317,9 +2317,6 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	if (symbol_conf.hide_unresolved && entry->sym == NULL)
>  		return 0;
>  
> -	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
> -		return 0;
> -
>  	/*
>  	 * Convert entry->ip from a virtual address to an offset in
>  	 * its corresponding binary.
> @@ -2327,6 +2324,9 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	if (entry->map)
>  		addr = map__map_ip(entry->map, entry->ip);
>  
> +	if (append_inlines(cursor, entry->map, entry->sym, addr) == 0)
> +		return 0;
> +
>  	srcline = callchain_srcline(entry->map, entry->sym, addr);
>  	return callchain_cursor_append(cursor, entry->ip,
>  				       entry->map, entry->sym,
> 
