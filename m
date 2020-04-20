From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf symbol: Fix kernel symbol address display
Date: Mon, 20 Apr 2020 17:46:17 -0300
Message-ID: <20200420204617.GA23638@kernel.org>
References: <20200415070744.59919-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200415070744.59919-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Apr 15, 2020 at 09:07:44AM +0200, Thomas Richter escreveu:
> Running commands
> 
>    ./perf record -e rb0000 -- find .
>    ./perf report -v

Or when pressing 'V' in the TUI.
 
> reveals symbol names and its addresses. There is a mismatch between

Yeah, an address that at some point was put there to help with debugging
the symbol resolution, IIRC how it looked like when looking at

  readelf -sW vmlinux

Or any other DSO, for instance, for a glibc symbol here:

Using 'perf report -s pid,dso,sym' then pressing 'V':

   1.55%    20325:perf  /usr/lib64/libc-2.30.so   0x161825   B [.] __strlen_avx2

[acme@five perf]$ readelf -sW /usr/lib64/libc-2.30.so | grep strlen_avx2
 24371: 0000000000161810   414 FUNC    LOCAL  DEFAULT   15 __strlen_avx2
[acme@five perf]$ 

Can you check if doing in /lib/modules/.../build/vmlinux produces what
appears when 'V' is in place?

And perhaps we can also show the DSO offset and the rip as it gets laid
out in memory in the end? So we have all the informations?

- Arnaldo

> kernel symbol and address. Here is an example for kernel symbol
> check_chain_key:
> 
>  3.55%  find /lib/modules/.../build/vmlinux  0xf11ec  v [k] check_chain_key
> 
> This address is off by 0xff000 as can be seen with:
> 
> [root@t35lp46 ~]# fgrep check_chain_key /proc/kallsyms
> 00000000001f00d0 t check_chain_key
> [root@t35lp46 ~]# objdump -t ~/linux/vmlinux| fgrep check_chain_key
> 00000000001f00d0 l     F .text	00000000000001e8 check_chain_key
> [root@t35lp46 ~]#
> 
> This function is located in main memory 0x1f00d0 - 0x1f02b4. It has
> several entries in the perf data file with the correct address:
> 
> [root@t35lp46 perf]# ./perf report -D -i perf.data.find-bad | \
> 				fgrep SAMPLE| fgrep 0x1f01ec
> PERF_RECORD_SAMPLE(IP, 0x1): 22228/22228: 0x1f01ec period: 1300000 addr: 0
> PERF_RECORD_SAMPLE(IP, 0x1): 22228/22228: 0x1f01ec period: 1300000 addr: 0
> 
> The root cause happens when reading symbol tables during perf report.
> A long gdb call chain leads to
> 
>    machine__deliver_events
>      perf_evlist__deliver_event
>        perf_evlist__deliver_sample
>          build_id__mark_dso_hits
> 	   thread__find_map(1)      Read correct address from sample entry
> 	     map__load
> 	       dso__load            Some more functions to end up in
> 	         ....
> 		 dso__load_sym.
> 
> Function dso__load_syms  checks for kernel relocation and symbol
> adjustment for the kernel and results in kernel map adjustment of
> 	 kernel .text segment address (0x100000 on s390)
> 	 kernel .text segment offset in file (0x1000 on s390).
> This results in all kernel symbol addresses to be changed by subtracting
> 0xff000 (on s390). For the symbol check_chain_key we end up with
> 
>     0x1f00d0 - 0x100000 + 0x1000 = 0xf11d0
> 
> and this address is saved in the perf symbol table. This calculation is
> also applied by the mapping functions map__mapip() and map__unmapip()
> to map IP addresses to dso mappings.
> 
> During perf report processing functions
> 
>    process_sample_event    (builtin-report.c)
>      machine__resolve
>        thread__find_map
>      hist_entry_iter_add
> 
> are called. Function thread__find_map(1)
> takes the correct sample address and applies the mapping function
> map__mapip() from the kernel dso and saves the modified address
> in struct addr_location for further reference. From now on this address
> is used.
> 
> Funktion process_sample_event() then calls hist_entry_iter_add() to save
> the address in member ip of struct hist_entry.
> 
> When samples are displayed using
> 
>     perf_evlist__tty_browse_hists
>       hists__fprintf
>         hist_entry__fprintf
> 	  hist_entry__snprintf
> 	    __hist_entry__snprintf
> 	      _hist_entry__sym_snprintf()
> 
> This simply displays the address of the symbol and ignores the dso <-> map
> mappings done in function thread__find_map. This leads to the address
> mismatch.
> 
> Output before:
> 
> ot@t35lp46 perf]# ./perf report -v | fgrep check_chain_key
>      3.55%  find     /lib/modules/5.6.0d-perf+/build/vmlinux
>      						0xf11ec v [k] check_chain_key
> [root@t35lp46 perf]#
> 
> Output after:
> 
> [root@t35lp46 perf]# ./perf report -v | fgrep check_chain_key
>      3.55%  find     /lib/modules/5.6.0d-perf+/build/vmlinux
>      						0x1f01ec v [k] check_chain_key
> [root@t35lp46 perf]#
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  tools/perf/util/sort.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index ab0cfd790ad0..0695b3f6460f 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -297,8 +297,14 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
>  
>  	if (verbose > 0) {
>  		char o = map ? dso__symtab_origin(map->dso) : '!';
> +		u64 rip = ip;
> +
> +		if (map && map->dso && map->dso->kernel
> +		    && map->dso->adjust_symbols)
> +			rip = map->unmap_ip(map, ip);
> +
>  		ret += repsep_snprintf(bf, size, "%-#*llx %c ",
> -				       BITS_PER_LONG / 4 + 2, ip, o);
> +				       BITS_PER_LONG / 4 + 2, rip, o);
>  	}
>  
>  	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", level);
> -- 
> 2.25.1
> 

-- 

- Arnaldo
