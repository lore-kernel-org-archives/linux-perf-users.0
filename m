Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D20C77B7A
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jun 2023 10:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjFBKpX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbjFBKpV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jun 2023 06:45:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1940FC0
        for <linux-perf-users@vger.kernel.org>; Fri,  2 Jun 2023 03:45:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41A071063;
        Fri,  2 Jun 2023 03:46:04 -0700 (PDT)
Received: from [10.57.60.80] (unknown [10.57.60.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 506E33F7BD;
        Fri,  2 Jun 2023 03:45:18 -0700 (PDT)
Message-ID: <aa998b2c-fa35-8e71-fe54-a5bffcfa30ae@arm.com>
Date:   Fri, 2 Jun 2023 11:45:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Reg: Perf report consuming too high memory
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
To:     Ian Rogers <irogers@google.com>,
        RAJESH DASARI <raajeshdasari@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
References: <CAPXMrf9mRG_uyEdkppJOjJxCREXjZsXGo2A_QEtwHM4G+nJoEA@mail.gmail.com>
 <CAP-5=fXth=1qRgH6iNKt6eAWt4MM4Xd0jn8o65BD9SDq8v6uYg@mail.gmail.com>
 <a63d33cf-de35-c41c-abb3-d55577e67d6d@arm.com>
 <36dd3607-fe6e-6f79-3932-f96b554c1d1e@arm.com>
In-Reply-To: <36dd3607-fe6e-6f79-3932-f96b554c1d1e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 02/06/2023 11:36, James Clark wrote:
> 
> 
> On 02/06/2023 11:24, James Clark wrote:
>>
>>
>> On 02/06/2023 00:30, Ian Rogers wrote:
>>> On Thu, Jun 1, 2023 at 6:51 AM RAJESH DASARI <raajeshdasari@gmail.com> wrote:
>>>>
>>>> Hi ,
>>>>
>>>> I am noticing high memory usage, oom killer is invoked and restarting
>>>> our node while running perf report command.
>>>>
>>>>  perf record -a  -g   sleep 120
>>>> [ perf record: Woken up 2472 times to write data ]
>>>> [ perf record: Captured and wrote 623.050 MB (3830374 samples) ]
>>>>
>>>> perf report
>>>>
>>>>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>>>>  119877 root      20   0 7335760   7.0g 670244 S   0.0  59.7   0:22.23 perf
>>>>
>>>> perf report command is consuming more memory, oom killer is invoked.
>>>> System details : kernel 5.4.242 + glibc 2.26 + gcc12
>>>> I tried with perf 6.x versions but I still see more memory consumption.
>>>>
>>>> I tried the same experiment on a different system under the same load
>>>> , this system has ( kernel 5.4.242 + glibc 2.24 + gcc 11)
>>>>
>>>> perf record -a  -g  sleep 120
>>>> [ perf record: Woken up 1868 times to write data ]
>>>> [ perf record: Captured and wrote 470.203 MB
>>>> /tmp/rcpprofiling/data_cg.data (3828394 samples) ]
>>>>
>>>> perf report
>>>>
>>>> PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>>>> 840045 root      20   0 1459520   1.4g 493380 R  98.1  11.8   0:31.21
>>>> perf report
>>>>
>>>>
>>>> I see that the more the perf.data file size, the more  memory it
>>>> consumes, but in this case i only see 200MB difference between the
>>>> perf.data file and also only 2k sample difference, but memory
>>>> consumption is too high in the first system.
>>>>
>>>> What could be the reason, is this expected behaviour or how to debug
>>>> why perf is consuming more memory here  . Please help me with this
>>>> query .
>>>
>>> Hi Rajesh,
>>>
>>> As you are using perf in system wide mode every running process has
>>> its memory map added to the perf.data file, this is so that a virtual
>>> address in a sample can be turned into a file offset. perf report will
>>> process the shared objects and even use objdump to annotate them. This
>>> can all be pretty costly in terms of memory but it sounds like perf is
>>> working-as-intended. Have you tried just attaching perf to the process
>>> you are interested in?
>>>
>>
>> For the mapped in binaries I would expect that to show up on virtual
>> memory used rather than resident. For a 10 second -a sleep recording on
>> my laptop perf report takes 5.9G of resident memory to show 476K samples.
>>
>> Running it with 'valgrind --tool=massiv' then 'massif-visualizer' I can
>> see it's pretty much all the allocations for the callchains:
>>
>>  4.7 GiB: zalloc (zalloc.c:8)
>>   4.3GiB: fill_node (callchain.c:585)
>>    4.3 GiB: add_child (callchain.c:646)
>>     3.6 GiB: append_chain_children (callchain.c:906)
>>      ...
>>
>> But this was a recording without --call-graph, so it's like it's using
>> 12KB per sample for one level of callchains (if you divide 5.9G by
>> 476K). Maybe that's not really an excessive amount of memory. It could
>> probably be optimised a bit but maybe the issue is the default sample
>> rate and using -a after all.
>>
> 
> Actually if I open it with --call-graph=none it only uses 670MB of
> resident memory. So a pretty huge reduction, and the report doesn't look
> so much different because it wasn't recorded with callgraphs in the
> first place. That could help with your issue Rajesh.
> 

Oh sorry I see the -g short form is for default --call-graphs, so that
explains it. All my top results in the report were only 1 deep but
that's probably because of debug symbols or something. There are
probably other much longer ones elsewhere in the report so my
calculation above can be disregarded.


>>> Thanks,
>>> Ian
>>>
>>>> Thanks,
>>>> Rajesh Dasari.
