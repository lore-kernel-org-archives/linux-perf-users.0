From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 12/12] perf maps: Set maps pointer in the kmap area for
 kernel maps
Date: Thu, 19 Dec 2019 10:24:14 +0100
Message-ID: <20191219092414.GC8141@krava>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-13-acme@kernel.org>
 <20191218090504.GE19062@krava>
 <20191218182254.GA13282@kernel.org>
 <20191218190120.GB13282@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191218190120.GB13282@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Dec 18, 2019 at 04:01:20PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 18, 2019 at 03:22:54PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Dec 18, 2019 at 10:05:04AM +0100, Jiri Olsa escreveu:
> > After looking at this some more, I retract this patch and instead the
> > two-liner at the end of this message seems enough.
> 
> So here is the full cset, I have not made changes to the other patches,
> 
> - Arnaldo
> 
> commit 178427a192bcbe3ad93dd0637c3dceaa3ccef31e
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Wed Dec 18 15:23:14 2019 -0300
> 
>     perf map: Set kmap->kmaps backpointer for main kernel map chunks
>     
>     When a map is create to represent the main kernel area (vmlinux) with
>     map__new2() we allocate an extra area to store a pointer to the 'struct
>     maps' for the kernel maps, so that we can access that struct when
>     loading ELF files or kallsyms, as we will need to split it in multiple
>     maps, one per kernel module or ELF section (such as ".init.text").
>     
>     So when map->dso->kernel is non-zero, it is expected that
>     map__kmap(map)->kmaps to be set to the tree of kernel maps (modules,
>     chunks of the main kernel, bpf progs put in place via
>     PERF_RECORD_KSYMBOL, the main kernel).
>     
>     This was not the case when we were splitting the main kernel into chunks
>     for its ELF sections, which ended up making 'perf report --children'
>     processing a perf.data file with callchains to trip on
>     __map__is_kernel(), when we press ENTER to see the popup menu for main
>     histogram entries that starts at a symbol in the ".init.text" ELF
>     section, e.g.:
>     
>     -    8.83%     0.00%  swapper     [kernel.vmlinux].init.text  [k] start_kernel
>          start_kernel
>          cpu_startup_entry
>          do_idle
>          cpuidle_enter
>          cpuidle_enter_state
>          intel_idle
>     
>     Fix it.
>     
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Link: https://lkml.kernel.org/n/tip-vcokue57w4goyzweg2rr5i80@git.kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 6658fbf196e6..1965aefccb02 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -920,6 +920,9 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  		if (curr_map == NULL)
>  			return -1;
>  
> +		if (curr_dso->kernel)
> +			map__kmap(curr_map)->kmaps = kmaps;
> +
>  		if (adjust_kernel_syms) {
>  			curr_map->start  = shdr->sh_addr + ref_reloc(kmap);
>  			curr_map->end	 = curr_map->start + shdr->sh_size;
> 

looks good ;-)

jirka
