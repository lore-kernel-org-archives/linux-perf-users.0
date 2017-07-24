From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/2] perf record: wrong size in perf_record_mmap for last
 kernel module
Date: Mon, 24 Jul 2017 15:20:07 -0300
Message-ID: <20170724182007.GY4134@kernel.org>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
 <20170724143514.55574-2-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753587AbdGXSUT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jul 2017 14:20:19 -0400
Content-Disposition: inline
In-Reply-To: <20170724143514.55574-2-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org

Em Mon, Jul 24, 2017 at 04:35:14PM +0200, Thomas Richter escreveu:
> During work on perf report for s390 I ran into the following issue:
> 
> 0 0x318 [0x78]: PERF_RECORD_MMAP -1/0:
> 	[0x3ff804d6990(0xfffffc007fb2966f) @ 0]:
> 	x /lib/modules/4.12.0perf1+/kernel/drivers/s390/net/qeth_l2.ko
> 
> This is a PERF_RECORD_MMAP entry of the perf.data file with an invalid
> module size for qeth_l2.ko (the s390 ethernet device driver).
> Even a mainframe does not have 0xfffffc007fb2966f bytes of main memory.
> 
> It turned out that this wrong size is created by the perf record command.
> What happens is this function call sequence from __cmd_record():
> 
> perf_session__new():
> perf_session__create_kernel_maps():
> machine__create_kernel_maps():
> machine__create_modules():   Creates map for all loaded kernel modules.
> modules__parse():   Reads /proc/modules and extracts module name and
> 		    load address (1st and last column)
> machine__create_module():   Called for every module found in /proc/modules.
>                     Creates a new map for every module found and enters
> 	            module name and start address into the map. Since the
> 		    module end address is unknown it is set to zero.
> 
> This ends up with a kernel module map list sorted by module start addresses.
> All module end addresses are zero.
> 
> Last machine__create_kernel_maps() calls function map_groups__fixup_end().
> This function iterates through the maps and assigns each map entry's
> end address the successor map entry start address. The last entry of the
> map group has no successor, so ~0 is used as end to consume the remaining
> memory.
> 
> Later __cmd_record calls function record__synthesize() which in turn calls
> perf_event__synthesize_kernel_mmap() and perf_event__synthesize_modules()
> to create PERF_REPORT_MMAP entries into the perf.data file.
> 
> On s390 this results in the last module qeth_l2.ko
> (which has highest start address, see module table:
> 	[root@s8360047 perf]# cat /proc/modules
> 	qeth_l2 86016 1 - Live 0x000003ff804d6000
> 	qeth 266240 1 qeth_l2, Live 0x000003ff80296000
> 	ccwgroup 24576 1 qeth, Live 0x000003ff80218000
> 	vmur 36864 0 - Live 0x000003ff80182000
> 	qdio 143360 2 qeth_l2,qeth, Live 0x000003ff80002000
> 	[root@s8360047 perf]# )
> to be the last entry and its map has an end address of ~0.
> 
> When the PERF_RECORD_MMAP entry is created for kernel module qeth_l2.ko
> its start address and length is written. The length is calculated in line:
>     event->mmap.len   = pos->end - pos->start;
> and results in 0xffffffffffffffff - 0x3ff804d6990(*) = 0xfffffc007fb2966f
> 
> (*) On s390 the module start address is actually determined by a __weak function
> named arch__fix_module_text_start() in machine__create_module().
> 
> I think this improvable. We can use the module size (2nd column of /proc/modules)

Nice analysis, I don't recall why we ended up not using that 2nd column
of /proc/modules... :-\o

Humm, probably the modules maps were created from the entries in
/proc/kallsyms, where we don't have the size, then, just like we do
w2hen parsing symbols from /proc/kallsyms, we set the end by looking at
the next entry...

> to get each loaded kernel module size and calculate its end address.
> Only for map entries which do not have a valid end address (end is still zero)
> we can use the heuristic we have now, that is use successor start address or ~0.
> 
> Any other ideas?
> Did this issue never showed up before?
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> ---
>  tools/perf/util/machine.c    |  4 +++-
>  tools/perf/util/symbol-elf.c |  2 +-
>  tools/perf/util/symbol.c     | 21 ++++++++++++++-------
>  tools/perf/util/symbol.h     |  2 +-
>  4 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 2e9eb6a..eba28ca 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -20,6 +20,7 @@
>  #include "unwind.h"
>  #include "linux/hash.h"
>  #include "asm/bug.h"
> +#include <sys/user.h>
>  
>  #include "sane_ctype.h"
>  #include <symbol/kallsyms.h>
> @@ -1137,7 +1138,7 @@ int __weak arch__fix_module_text_start(u64 *start __maybe_unused,
>  	return 0;
>  }
>  
> -static int machine__create_module(void *arg, const char *name, u64 start)
> +static int machine__create_module(void *arg, const char *name, u64 start, u64 size)
>  {
>  	struct machine *machine = arg;
>  	struct map *map;
> @@ -1148,6 +1149,7 @@ static int machine__create_module(void *arg, const char *name, u64 start)
>  	map = machine__findnew_module_map(machine, start, name);
>  	if (map == NULL)
>  		return -1;
> +	map->end = roundup(start + size, PAGE_SIZE);
>  
>  	dso__kernel_module_get_build_id(map->dso, machine->root_dir);
>  
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index d3521d4..94b03ad 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1448,7 +1448,7 @@ static int kcore_copy__parse_kallsyms(struct kcore_copy_info *kci,
>  
>  static int kcore_copy__process_modules(void *arg,
>  				       const char *name __maybe_unused,
> -				       u64 start)
> +				       u64 start, u64 size __maybe_unused)
>  {
>  	struct kcore_copy_info *kci = arg;
>  
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index e7a98db..ab4fcf2 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -231,7 +231,8 @@ void __map_groups__fixup_end(struct map_groups *mg, enum map_type type)
>  		goto out_unlock;
>  
>  	for (next = map__next(curr); next; next = map__next(curr)) {
> -		curr->end = next->start;
> +		if (!curr->end)
> +			curr->end = next->start;
>  		curr = next;
>  	}
>  
> @@ -239,7 +240,8 @@ void __map_groups__fixup_end(struct map_groups *mg, enum map_type type)
>  	 * We still haven't the actual symbols, so guess the
>  	 * last map final address.
>  	 */
> -	curr->end = ~0ULL;
> +	if (!curr->end)
> +		curr->end = ~0ULL;
>  
>  out_unlock:
>  	pthread_rwlock_unlock(&maps->lock);
> @@ -550,7 +552,7 @@ void dso__sort_by_name(struct dso *dso, enum map_type type)
>  
>  int modules__parse(const char *filename, void *arg,
>  		   int (*process_module)(void *arg, const char *name,
> -					 u64 start))
> +					 u64 start, u64 size))
>  {
>  	char *line = NULL;
>  	size_t n;
> @@ -563,8 +565,8 @@ int modules__parse(const char *filename, void *arg,
>  
>  	while (1) {
>  		char name[PATH_MAX];
> -		u64 start;
> -		char *sep;
> +		u64 start, size;
> +		char *sep, *endptr;
>  		ssize_t line_len;
>  
>  		line_len = getline(&line, &n, file);
> @@ -596,7 +598,11 @@ int modules__parse(const char *filename, void *arg,
>  
>  		scnprintf(name, sizeof(name), "[%s]", line);
>  
> -		err = process_module(arg, name, start);
> +		size = strtoul(sep + 1, &endptr, 0);
> +		if (*endptr != ' ' && *endptr != '\t')
> +			continue;
> +
> +		err = process_module(arg, name, start, size);
>  		if (err)
>  			break;
>  	}
> @@ -943,7 +949,8 @@ static struct module_info *find_module(const char *name,
>  	return NULL;
>  }
>  
> -static int __read_proc_modules(void *arg, const char *name, u64 start)
> +static int __read_proc_modules(void *arg, const char *name, u64 start,
> +			       u64 size __maybe_unused)
>  {
>  	struct rb_root *modules = arg;
>  	struct module_info *mi;
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index beb8737..1da5ed4 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -273,7 +273,7 @@ int filename__read_build_id(const char *filename, void *bf, size_t size);
>  int sysfs__read_build_id(const char *filename, void *bf, size_t size);
>  int modules__parse(const char *filename, void *arg,
>  		   int (*process_module)(void *arg, const char *name,
> -					 u64 start));
> +					 u64 start, u64 size));
>  int filename__read_debuglink(const char *filename, char *debuglink,
>  			     size_t size);
>  
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
