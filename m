From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf report does not resolve symbols on s390x
Date: Thu, 6 Jul 2017 14:35:27 +0200
Message-ID: <67eb6f70-fc34-95cd-b43c-349bbc24ee5d@linux.vnet.ibm.com>
References: <eb00bf70-936d-e405-5867-015d4067202f@linux.vnet.ibm.com>
 <20170705155007.GH27350@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751927AbdGFMfd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Jul 2017 08:35:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v66CYYsw042985
        for <linux-perf-users@vger.kernel.org>; Thu, 6 Jul 2017 08:35:33 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bhm2v3jw1-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jul 2017 08:35:32 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 6 Jul 2017 13:35:30 +0100
In-Reply-To: <20170705155007.GH27350@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 07/05/2017 05:50 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jul 05, 2017 at 04:45:49PM +0200, Thomas-Mich Richter escreveu:
>> I use linux 4.12 kernel and the perf report --stdio does not resolve all symbols:
>> Only very few symbols are resolved and none listed in the call back chain.
>>
>> Here is an example:
>>
>>     50.00%    50.00%  true     [kernel.vmlinux]  [k] __rb_insert_augmented
>>             |
>>             ---0x6a0624
>>                0x2d7c00
>>                0x2d79c8
>>                0x2b5a26
>>                0x2da542
>>                0x2da01a
>>                0x2d6c2e
>>                0x2d6b86
>>
>>     50.00%     0.00%  true     [unknown]         [k] 0x000000000011e90a
>>             |
>>             ---0x11e90a
>>                0x2d39a4
>>                0x2d3238
>>                0x288140
>>                0x2cf404
>>                0x2df5d8
>>                0x31618c
>>                0x19b0ae
>>
>> These addresses are all in the /proc/kallsyms and valid.
>>
>> When I do a perf script it works:
>> [root@s8360046 perf]# perf script
> 
> This is the strange part, 'script' resolving things 'report' doesn't,
> they should be using the same machinery... Since the DSO is not being
> resolved on the one failing above, this would look like its some
> PERF_RECORD_MMAP/PERF_RECORD_MMAP2 that is being missed, so you should
> look at the processing of such records, which is done via:
> 
>  perf_tool.mmap() and perf_tool.mmap2()
> 
> the perf_tool ops table is passed to:
> 
>   perf_session__new(&file, false, &report.tool);
> 
> Which will call the mmap() and mmap2() functions to process those
> records, if you look at script it has:
> 
>   
>         struct perf_script script = {
>                 .tool = {
>                         .sample          = process_sample_event,
>                         .mmap            = perf_event__process_mmap,
>                         .mmap2           = perf_event__process_mmap2,
> <SNIP>
> 
> and then:
> 
>   session = perf_session__new(&file, false, &script.tool);
> 
> Which is the same as done for report:
> 
>           struct report report = {
>                 .tool = {
>                         .sample          = process_sample_event,
>                         .mmap            = perf_event__process_mmap,
>                         .mmap2           = perf_event__process_mmap2,
> <SNIP>
> 
>   perf_session__new(&file, false, &report.tool);
> 
> I.e. both use the same functions to resolve PERF_RECORD_MMAP/MMAP2 records,
> then you should look at how samples are processed, its static functions, tool specific
> functions, both named process_sample_event, in tools/perf/builtin->{report,script}.c,
> and both will basically do:
> 
>         if (machine__resolve(machine, &al, sample) < 0) {
>                 pr_debug("problem processing %d event, skipping it.\n",
>                          event->header.type);
>                 return -1;
>         }
> 
> That will do lookups on trees populated by perf_event__process_mmap,
> perf_event__process_mmap2, and the routines handling PERF_RECORD_FORK, etc.
> 
> Is this enough to help you go from here to investigate your problem?
> 
> - Arnaldo
> 

Thanks for the explanation. I investigated the process_sample_event()
from the builtin-report.c and builtin-script.c. I used the same perf.data
file:

[root@s8360046 perf]# ./perf script -D -vvvvv > /tmp/script.out 2>&1
[root@s8360046 perf]# ./perf report -D -vvvvv > /tmp/report.out 2>&1
[root@s8360046 perf]#  fgrep PERF_RECORD_MMAP //tmp/script.out|wc -l
10
[root@s8360046 perf]#  fgrep PERF_RECORD_MMAP //tmp/report.out|wc -l
10
[root@s8360046 perf]#

Both tools see the same number of PREF_RECORD_MMAP* events and
use the same data base.

Next I digged into process_sample_event() call chains and added printf's.
All lines marked with a star (*) are my printf's

builtin-script.c:
I see a long list of symbol__new debug info, showing kernel symbols and addresses.

After a PERF_RECORD_SAMPLE(IP, 0x1):
7991046816204 0x518 [0x80]: PERF_RECORD_SAMPLE(IP, 0x1): 4384/4384: 0x487b12 period: 250000 addr: 0
... FP chain: nr:10
.....  0: ffffffffffffff80
.....  1: 00000000002d6b86
.....  2: 00000000002d6c2e
.....  3: 00000000002da01a
.....  4: 00000000002da542
.....  5: 00000000002b5a26
.....  6: 00000000002d79c8
.....  7: 00000000002d7c00
.....  8: 00000000006a0624
.....  9: fffffffffffffe00
* process_sample_event 1
... thread: true:4384
* dso__load_vmlinux_path i:0 vmlinux err:-1
* dso__load_vmlinux_path i:1 /boot/vmlinux err:-1
* dso__load_vmlinux_path i:2 /boot/vmlinux-4.12.0perf+ err:-1
* dso__load_vmlinux_path i:3 /usr/lib/debug/boot/vmlinux-4.12.0perf+ err:-1
* dso__load_vmlinux_path i:4 /lib/modules/4.12.0perf+/build/vmlinux err:21340
...... dso: /lib/modules/4.12.0perf+/build/vmlinux
* machine__resolve al->filtered:0 al->map:0x352aec20 al->sym:0x3540c9d0
* process_sample_event al:0x488b12 sym:0x3540c9d0 map:0-0xa47000@0x1000
* process_sample_event name:__rb_insert_augmented
true  4384  7991.046816:     250000 cpu-clock:
* thread__find_addr_location pid:4384 al->map:0x352aec20 al->sym:0x3545b7a0
* thread__find_addr_location pid:4384 al->map:0x352aec20 al->sym:0x353150a0
* thread__find_addr_location pid:4384 al->map:0x352aec20 al->sym:0x3542d910
* thread__find_addr_location pid:4384 al->map:0x352aec20 al->sym:0x35408d60
* thread__find_addr_location pid:4384 al->map:0x352aec20 al->sym:0x353d0100
* thread__find_addr_location pid:4384 al->map:0x352aec20 al->sym:0x35458ef0
* thread__find_addr_location pid:4384 al->map:0x352aec20 al->sym:0x35427250
* thread__find_addr_location pid:4384 al->map:0x352aec20 al->sym:0x353b4900

The first symbol is __rb_insert_augmented. It is found in the kernel map.
The call chain is:
process_sample_event(builtin-script.c)
machine__resolve()
process_event(builtin-script.c)
thread__resolve_callchain(util/machine.c)
thread__resolve_callchain_sample(util/machine.c)
add_callchain_ip(./util/machine.c)
thread__find_addr_location(./util/event.c)

The interesting thing is function machine__resolve(). It has a valid map
and sym pointer and this map (pointer to the kernel symbol table) is
used for the callchain. So we end up with a call chain and resolved symbols.



builtin-report.c:
I see a long list of symbol__new debug info, showing kernel symbols and addresses.

7991046816204 0x518 [0x80]: PERF_RECORD_SAMPLE(IP, 0x1): 4384/4384: 0x487b12 period: 250000 addr: 0
... FP chain: nr:10
.....  0: ffffffffffffff80
.....  1: 00000000002d6b86
.....  2: 00000000002d6c2e
.....  3: 00000000002da01a
.....  4: 00000000002da542
.....  5: 00000000002b5a26
.....  6: 00000000002d79c8
.....  7: 00000000002d7c00
.....  8: 00000000006a0624
.....  9: fffffffffffffe00
* process_sample_event 1
... thread: true:4384
* dso__load_vmlinux_path i:0 vmlinux err:-1
* dso__load_vmlinux_path i:1 /boot/vmlinux err:-1
* dso__load_vmlinux_path i:2 /boot/vmlinux-4.12.0perf+ err:-1
* dso__load_vmlinux_path i:3 /usr/lib/debug/boot/vmlinux-4.12.0perf+ err:-1
* dso__load_vmlinux_path i:4 /lib/modules/4.12.0perf+/build/vmlinux err:21340
...... dso: /lib/modules/4.12.0perf+/build/vmlinux
* machine__resolve al->filtered:0 al->map:0x76ca190 al->sym:0x7827f40
* process_sample_event al:0x488b12 sym:0x7827f40 map:0-0xa47000@0x1000 <-- printed after machine__resolve
* sample__resolve_callchain al->map:0x425cc190 al->sym:0x42729f40
* thread__resolve_callchain al->map:0x425cc190 al->sym:0x42729f40
* thread__resolve_callchain_sample al->map:0x425cc190 al->sym:0x42729f40
* thread__find_addr_location pid:4384 al->addr,0x6a0624 al->map:(nil) al->sym:(nil)
* thread__find_addr_location pid:4384 al->addr,0x2d7c00 al->map:(nil) al->sym:(nil)
* thread__find_addr_location pid:4384 al->addr,0x2d79c8 al->map:(nil) al->sym:(nil)
* thread__find_addr_location pid:4384 al->addr,0x2b5a26 al->map:(nil) al->sym:(nil)
* thread__find_addr_location pid:4384 al->addr,0x2da542 al->map:(nil) al->sym:(nil)
* thread__find_addr_location pid:4384 al->addr,0x2da01a al->map:(nil) al->sym:(nil)
* thread__find_addr_location pid:4384 al->addr,0x2d6c2e al->map:(nil) al->sym:(nil)
* thread__find_addr_location pid:4384 al->addr,0x2d6b86 al->map:(nil) al->sym:(nil)
* hist_entry_iter__add sample__resolve_callchain:0
* hists__add_entry al->addr:0x488b12, symbol:0x7827f40
* hists__add_entry start:0x488ad8 end:0x488d90 len:21 name:__rb_insert_augmented
* hist_iter__report_callback 1
* hists__add_entry al->addr:0x6a0624, symbol:(nil)
* hist_iter__report_callback 1
* hists__add_entry al->addr:0x2d7c00, symbol:(nil)
* hist_iter__report_callback 1
* hists__add_entry al->addr:0x2d79c8, symbol:(nil)
* hist_iter__report_callback 1
* hists__add_entry al->addr:0x2b5a26, symbol:(nil)
...

Function machine__resolve(util/event.c) returns the al->map and al->sym
pointers as in the builtin-script case.
The call chain is:
process_sample_event(builtin-report.c)
machine__resolve()
hist_entry_iter__add(./util/hist.c)
sample__resolve_callchain(util/callchain.c)
thread__resolve_callchain(util/machine.c)
thread__resolve_callchain_sample(util/machine.c)
add_callchain_ip(./util/machine.c)
thread__find_addr_location(./util/event.c)

Somehow that al->map information gets lost and later on the calls
thread__find_addr_location() this information is not available
and the lookup fails. And than the hist__add_entry fails as well.

I am still seeing tooooo much fog.....

This is not a threading issue??? That is perf report spawns threads and
one thread takes longer than the other thread and on s390x I hat some kind
of strange scheduling???
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
