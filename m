From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf report does not resolve symbols on s390x
Date: Wed, 5 Jul 2017 12:50:07 -0300
Message-ID: <20170705155007.GH27350@kernel.org>
References: <eb00bf70-936d-e405-5867-015d4067202f@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751659AbdGEPuM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jul 2017 11:50:12 -0400
Content-Disposition: inline
In-Reply-To: <eb00bf70-936d-e405-5867-015d4067202f@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Em Wed, Jul 05, 2017 at 04:45:49PM +0200, Thomas-Mich Richter escreveu:
> I use linux 4.12 kernel and the perf report --stdio does not resolve all symbols:
> Only very few symbols are resolved and none listed in the call back chain.
> 
> Here is an example:
> 
>     50.00%    50.00%  true     [kernel.vmlinux]  [k] __rb_insert_augmented
>             |
>             ---0x6a0624
>                0x2d7c00
>                0x2d79c8
>                0x2b5a26
>                0x2da542
>                0x2da01a
>                0x2d6c2e
>                0x2d6b86
> 
>     50.00%     0.00%  true     [unknown]         [k] 0x000000000011e90a
>             |
>             ---0x11e90a
>                0x2d39a4
>                0x2d3238
>                0x288140
>                0x2cf404
>                0x2df5d8
>                0x31618c
>                0x19b0ae
> 
> These addresses are all in the /proc/kallsyms and valid.
> 
> When I do a perf script it works:
> [root@s8360046 perf]# perf script

This is the strange part, 'script' resolving things 'report' doesn't,
they should be using the same machinery... Since the DSO is not being
resolved on the one failing above, this would look like its some
PERF_RECORD_MMAP/PERF_RECORD_MMAP2 that is being missed, so you should
look at the processing of such records, which is done via:

 perf_tool.mmap() and perf_tool.mmap2()

the perf_tool ops table is passed to:

  perf_session__new(&file, false, &report.tool);

Which will call the mmap() and mmap2() functions to process those
records, if you look at script it has:

  
        struct perf_script script = {
                .tool = {
                        .sample          = process_sample_event,
                        .mmap            = perf_event__process_mmap,
                        .mmap2           = perf_event__process_mmap2,
<SNIP>

and then:

  session = perf_session__new(&file, false, &script.tool);

Which is the same as done for report:

          struct report report = {
                .tool = {
                        .sample          = process_sample_event,
                        .mmap            = perf_event__process_mmap,
                        .mmap2           = perf_event__process_mmap2,
<SNIP>

  perf_session__new(&file, false, &report.tool);

I.e. both use the same functions to resolve PERF_RECORD_MMAP/MMAP2 records,
then you should look at how samples are processed, its static functions, tool specific
functions, both named process_sample_event, in tools/perf/builtin->{report,script}.c,
and both will basically do:

        if (machine__resolve(machine, &al, sample) < 0) {
                pr_debug("problem processing %d event, skipping it.\n",
                         event->header.type);
                return -1;
        }

That will do lookups on trees populated by perf_event__process_mmap,
perf_event__process_mmap2, and the routines handling PERF_RECORD_FORK, etc.

Is this enough to help you go from here to investigate your problem?

- Arnaldo

> true  4384  7991.047063:     250000 cpu-clock: 
>                   19c0ae lock_acquire (/lib/modules/4.12.0perf+/build/vmlinux)
>                   31718c lock_page_memcg (/lib/modules/4.12.0perf+/build/vmlinux)
>                   2e05d8 page_add_file_rmap (/lib/modules/4.12.0perf+/build/vmlinux)
>                   2d0404 alloc_set_pte (/lib/modules/4.12.0perf+/build/vmlinux)
>                   289140 filemap_map_pages (/lib/modules/4.12.0perf+/build/vmlinux)
>                   2d4238 __handle_mm_fault (/lib/modules/4.12.0perf+/build/vmlinux)
>                   2d49a4 handle_mm_fault (/lib/modules/4.12.0perf+/build/vmlinux)
>                   11f90a do_dat_exception (/lib/modules/4.12.0perf+/build/vmlinux)
>                   6a1962 pgm_check_handler (/lib/modules/4.12.0perf+/build/vmlinux)
> 
> 
> Any ideas in which area of the perf report tool to dig into to get this fixed.
> 
> When I use -vvvvv I see all kernel symbols read in and listed, so I fail to see
> why they are not resolved.
> Maybe someone can point me to the area of code to start digging.
> 
> Thanks a lot.
> 
> -- 
> Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
> --
> Vorsitzende des Aufsichtsrats: Martina Koederitz 
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
