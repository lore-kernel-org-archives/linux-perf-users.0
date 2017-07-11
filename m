From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf report does not resolve symbols on s390x
Date: Tue, 11 Jul 2017 16:38:28 -0300
Message-ID: <20170711193828.GI27350@kernel.org>
References: <eb00bf70-936d-e405-5867-015d4067202f@linux.vnet.ibm.com>
 <20170705155007.GH27350@kernel.org>
 <67eb6f70-fc34-95cd-b43c-349bbc24ee5d@linux.vnet.ibm.com>
 <5ead7c5a-5b91-107a-51ca-ea464fe8cfba@linux.vnet.ibm.com>
 <20170711190304.GH27350@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933558AbdGKTic (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Jul 2017 15:38:32 -0400
Content-Disposition: inline
In-Reply-To: <20170711190304.GH27350@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, zvonko.kosic@de.ibm.com, Adrian Hunter <adrian.hunter@intel.com>

Em Tue, Jul 11, 2017 at 04:03:04PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jul 07, 2017 at 02:17:25PM +0200, Thomas-Mich Richter escreveu:
> > On 07/06/2017 02:35 PM, Thomas-Mich Richter wrote:
> > > On 07/05/2017 05:50 PM, Arnaldo Carvalho de Melo wrote:
> > >> Em Wed, Jul 05, 2017 at 04:45:49PM +0200, Thomas-Mich Richter escreveu:
> > >>> I use linux 4.12 kernel and the perf report --stdio does not resolve all symbols:
> > >>> Only very few symbols are resolved and none listed in the call back chain.
> 
> > >>> Here is an example:
> 
> > >>>     50.00%    50.00%  true     [kernel.vmlinux]  [k] __rb_insert_augmented
> > >>>             |
> > >>>             ---0x6a0624
> > >>>                0x2d7c00
> > >>>                0x2d79c8
> > >>>                0x2b5a26
> > >>>                0x2da542
> > >>>                0x2da01a
> > >>>                0x2d6c2e
> > >>>                0x2d6b86
> > >>>
> > >>>     50.00%     0.00%  true     [unknown]         [k] 0x000000000011e90a
> > >>>             |
> > >>>             ---0x11e90a
> > >>>                0x2d39a4
> > >>>                0x2d3238
> > >>>                0x288140
> > >>>                0x2cf404
> > >>>                0x2df5d8
> > >>>                0x31618c
> > >>>                0x19b0ae
> 
> > >>> These addresses are all in the /proc/kallsyms and valid.
> 
> > >>> When I do a perf script it works:
> > >>> [root@s8360046 perf]# perf script
> 
> > >> This is the strange part, 'script' resolving things 'report' doesn't,
> > >> they should be using the same machinery... Since the DSO is not being
> > >> resolved on the one failing above, this would look like its some
> > >> PERF_RECORD_MMAP/PERF_RECORD_MMAP2 that is being missed, so you should
> > >> look at the processing of such records, which is done via:
> 
> > >>  perf_tool.mmap() and perf_tool.mmap2()
> 
> > >> the perf_tool ops table is passed to:
> 
> > >>   perf_session__new(&file, false, &report.tool);
> 
> > >> Which will call the mmap() and mmap2() functions to process those
> > >> records, if you look at script it has:
> 
> > >>         struct perf_script script = {
> > >>                 .tool = {
> > >>                         .sample          = process_sample_event,
> > >>                         .mmap            = perf_event__process_mmap,
> > >>                         .mmap2           = perf_event__process_mmap2,
> > >> <SNIP>
> 
> > >> and then:
> 
> > >>   session = perf_session__new(&file, false, &script.tool);
> 
> > >> Which is the same as done for report:
> > >>
> > >>           struct report report = {
> > >>                 .tool = {
> > >>                         .sample          = process_sample_event,
> > >>                         .mmap            = perf_event__process_mmap,
> > >>                         .mmap2           = perf_event__process_mmap2,
> > >> <SNIP>
> > >>
> > >>   perf_session__new(&file, false, &report.tool);
> > >>
> > >> I.e. both use the same functions to resolve PERF_RECORD_MMAP/MMAP2 records,
> > >> then you should look at how samples are processed, its static functions, tool specific
> > >> functions, both named process_sample_event, in tools/perf/builtin->{report,script}.c,
> > >> and both will basically do:
> > >>
> > >>         if (machine__resolve(machine, &al, sample) < 0) {
> > >>                 pr_debug("problem processing %d event, skipping it.\n",
> > >>                          event->header.type);
> > >>                 return -1;
> > >>         }
> > >>
> > >> That will do lookups on trees populated by perf_event__process_mmap,
> > >> perf_event__process_mmap2, and the routines handling PERF_RECORD_FORK, etc.
> > >>
> > >> Is this enough to help you go from here to investigate your problem?
>  
> > [....]
>  
> > > Somehow that al->map information gets lost and later on the calls
> > > thread__find_addr_location() this information is not available
> > > and the lookup fails. And than the hist__add_entry fails as well.
> 
> > > I am still seeing tooooo much fog.....
>  
> > The fog has lifted and I found the root cause. Digging into machine__resolve was the
> > right hint...
>  
> > What happens is this (short version)
> > machine__resolve has map and sym pointers ( al->map:0x32629190 al->sym:0x32776f40 )
> > --> sample__resolve_callchain al->map:0x32629190 al->sym:0x32776f40
> >     --> thread__resolve_callchain al->map:0x32629190 al->sym:0x32776f40
> >         --> thread__resolve_callchain_sample
> >             creates a new struct addr_location to find the ip addr and its details.
> >             --> add_callchain_ip (cpumode:2 --> user space address indicator)
> >                 --> thread__find_addr_map 
> >                     this function can not resolve the address and as a last action
> >                     tries to resolve the address within kernel address space 
> >                     --> machine__get_kernel_start
>  
> > Now this function is interesting:
>  
> > int machine__get_kernel_start(struct machine *machine)
> > {
> >         struct map *map = machine__kernel_map(machine);
> >         int err = 0;
>  
> >         /*
> >          * The only addresses above 2^63 are kernel addresses of a 64-bit
> >          * kernel.  Note that addresses are unsigned so that on a 32-bit system
> >          * all addresses including kernel addresses are less than 2^32.  In
> >          * that case (32-bit system), if the kernel mapping is unknown, all
> >          * addresses will be assumed to be in user space - see
> >          * machine__kernel_ip().
> >          */
> >         machine->kernel_start = 1ULL << 63;
> >         if (map) {
> >                 err = map__load(map);
> >                 if (map->start)
> >                         machine->kernel_start = map->start;
> >         }
> >         return err;
> > }
>  
> > It determines the kernel starts at address 1<<63 and loads the kernel address mapping.
> > On s390x
> > - The kernel starts at 0x0 (value of map->start) and thus all checks in function 
> >   thread__find_addr_map() fail and no symbol is found for the specified addresses
> >   because the kernel starts at 0x8000000000000000. Which is wrong the kernel start at 0x0.
> 
> Hi Thomas, really nice debugging session!
> 
> I'm trying the one-liner below, Adrian, can you please check this and
> provide an ack? I think that that comment about the address that it will
> default when map__load() fails needs rewriting in light of Thomas
> comments about other arches (see further below)?
> 
> I did a quick check of machine->kernel_start usage in Intel PT and since
> on x86 that assumption about partitioning the address space holds, no
> problem should be introduced by the one-liner fix, right?

Argh, this is also broken:

static inline bool machine__kernel_ip(struct machine *machine, u64 ip)
{
        u64 kernel_start = machine__kernel_start(machine);

        return ip >= kernel_start;
}

We can't judge if a address is in the kernel like that :-\
 
> - Arnaldo
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 5de2b86b9880..2e9eb6aa3ce2 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2209,7 +2209,7 @@ int machine__get_kernel_start(struct machine *machine)
>  	machine->kernel_start = 1ULL << 63;
>  	if (map) {
>  		err = map__load(map);
> -		if (map->start)
> +		if (!err)
>  			machine->kernel_start = map->start;
>  	}
>  	return err;
> 
>  
> > When I set this correctly (for example by setting kernel_start to 0x200) I get this:
> >  50.00%    50.00%  true     [kernel.vmlinux]  [k] lock_acquire
> >             |
> >             ---pgm_check_handler
> >                do_dat_exception
> >                handle_mm_fault
> >                __handle_mm_fault
> >                filemap_map_pages
> >                alloc_set_pte
> >                page_add_file_rmap
> >                lock_page_memcg
> >                lock_acquire
> > 
> > 
> > This raises 2 questions:
> > 1. s390 has a 64 bit address space for user and kernel. The processor status word (PSW)
> >    determines which address space to use. That requires the PSW in the sample. Not sure
> >    this is the case?
> > 2. How does this work on sparc and other architectures with the same addressing scheme?
> > 
> > Thanks.
> > -- 
> > Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
> > --
> > Vorsitzende des Aufsichtsrats: Martina Koederitz 
> > Geschäftsführung: Dirk Wittkopp
> > Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
