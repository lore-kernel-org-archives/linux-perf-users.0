From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Perf report --percentage
Date: Fri, 10 Jun 2016 12:14:45 +0900
Message-ID: <CAM9d7cgtA03u-XoicunM_rOquLJ2F1neYU1rM1bMu3T-ALDM5A@mail.gmail.com>
References: <6076A35470B38B408600AA0E3B4A31E767471A9E@ORSMSX114.amr.corp.intel.com>
 <1936512.XMEGsyMYkf@agathebauer> <20160609151328.GA1704@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35068 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcFJDPH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 9 Jun 2016 23:15:07 -0400
Received: by mail-vk0-f67.google.com with SMTP id t7so9314471vkf.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2016 20:15:06 -0700 (PDT)
In-Reply-To: <20160609151328.GA1704@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, shiny.sebastian@intel.com, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>

Hi Arnaldo,

On Fri, Jun 10, 2016 at 12:13 AM, Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Em Wed, Jun 08, 2016 at 09:34:58AM +0200, Milian Wolff escreveu:
>> On Dienstag, 7. Juni 2016 19:21:15 CEST Sebastian, Shiny wrote:
>> > I work with Intel and am running perf tool within Linux VMs on Windows
>> > Hyper-V.  With kernel 4.6 and corresponding perf version, percentages of
>> > call stacks at deeper levels  do not seem to add up to 100% or parent value
>> > (26.97%): example below. I have tried the -percentage flag with both
>> > 'absolute' and 'relative' values and they don't seem to change the output
>> > at all. Is this a bug or something wrong with my perf flags ?
>
>> > Commands used:
>> > #perf record  -a -g -c 10000 sleep 10
>> > #perf report -i cpu3.data.old -C 1 --no-children
>> >
>> > -   27.48%  fio          [kernel.kallsyms]  [k] __softirqentry_text_start
>> >      __softirqentry_text_start
>> >    - irq_exit
>> >       - 26.97% smp_call_function_single_interrupt
>> >          - call_function_single_interrupt
>> >             + 4.21% __blk_run_queue
>> >             + 4.09% hv_ringbuffer_write
>> >             + 1.83% 0x99c
>> >             + 1.78% __blockdev_direct_IO
>> >             + 0.96% do_blockdev_direct_IO
>> >             + 0.95% generic_make_request
>> >             + 0.86% blk_queue_bio
>> >             + 0.70% iov_iter_get_pages
>> >             + 0.64% md_make_request
>> >             + 0.55% do_io_submit
>> >               0.51% entry_SYSCALL_64_fastpath
>> >       + 0.51% hyperv_vector_handler
>>
>> Can you try to look at the output of
>>
>> perf report -i cpu3.data.old -C 1 --no-children -g graph,0
>>
>> i.e. potentially there are more entries with a cost of 0.5% or less, which by
>> default falls below the threshold.
>>
>> That said, I just tested it and it doesn't work for me either:
>
> Namyung, can you please take a look at this?

Will do.

Thanks,
Namhyung


>
>> tmp$ perf record --call-graph dwarf kwrite
>> [ perf record: Woken up 65 times to write data ]
>> [ perf record: Captured and wrote 16.308 MB perf.data (2032 samples) ]
>> tmp$ perf report -g graph,0 --no-children
>>
>> -    9.47%  kwrite           ld-2.23.so                     [.] do_lookup_x
>>    - 2.21% do_lookup_x
>>       - _dl_lookup_symbol_x
>>          + 1.42% _dl_relocate_object
>>          + 0.74% _dl_fixup
>> +    7.06%  kwrite           ld-2.23.so                     [.] strcmp
>>
>> It's also bogus when I look at it with --children:
>>
>> -   10.76%     9.47%  kwrite           ld-2.23.so           [.] do_lookup_x
>>    + 1.54% _start
>>    + 1.34% do_lookup_x
>>    + 0.61% _dl_runtime_resolve_avx
>> -    7.06%     7.06%  kwrite           ld-2.23.so           [.] strcmp
>>    + 0.42% _start
>>    + 0.22% _dl_runtime_resolve_avx
>>
>> So someone else with more insight should answer whether this output can be
>> explained somehow.
>>
>> > Older version: Perf version 4.2 on kernel 4.2 - seems to normalize them to
>> > 100%.  27.69%  swapper          [kernel.kallsyms]            [k] intel_idle
>> >
>> >                     ---intel_idle
>> >
>> >                        |--99.84%-- cpuidle_enter_state
>> >                        |
>> >                        |          cpuidle_enter
>> >                        |          call_cpuidle
>> >                        |          cpu_startup_entry
>> >                        |
>> >                        |          |--97.27%-- start_secondary
>> >                        |          |
>> >                        |           --2.73%-- rest_init
>> >                        |
>> >                        |                     start_kernel
>> >                        |                     x86_64_start_reservations
>> >                        |                     x86_64_start_kernel
>> >
>> >                         --0.16%-- [...]
>>
>> This output can be reproduced on newer perf by passing `-g fractal` to `perf
>> report`. I still get the issues as shown above though with a newer perf:
>>
>> -    9.47%  kwrite           ld-2.23.so                     [.] do_lookup_x
>>    + 23.31% do_lookup_x
>> -    7.06%  kwrite           ld-2.23.so                     [.] strcmp
>>    + 9.06% strcmp
>> +    5.71%  kwrite           ld-2.23.so                     [.] check_match
>>
>> I.e. ~74% and 91% of the samples don't seen to have a proper backtrace
>> attribution?
>>
>> Cheers
>>
>> --
>> Milian Wolff | milian.wolff@kdab.com | Software Engineer
>> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
>> Tel: +49-30-521325470
>> KDAB - The Qt Experts
>
>
