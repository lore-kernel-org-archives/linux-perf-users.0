From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf report does not resolve symbols on s390x
Date: Thu, 6 Jul 2017 09:23:05 +0200
Message-ID: <7cb7a888-cb18-cbe3-f08b-39b4d062db36@linux.vnet.ibm.com>
References: <eb00bf70-936d-e405-5867-015d4067202f@linux.vnet.ibm.com>
 <20170705155007.GH27350@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753072AbdGFHXQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Jul 2017 03:23:16 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v667JENE136430
        for <linux-perf-users@vger.kernel.org>; Thu, 6 Jul 2017 03:23:10 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bhg54sgff-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jul 2017 03:23:10 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 6 Jul 2017 08:23:08 +0100
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

Thanks a lot for the direction to dig into. I am quiet new to perf and still
do not have an understanding of all the structures and how their interact together.

Maybe there is some documentation of the internals of perf someone can share with
me? Or post it to the mailing list.

Thanks.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
