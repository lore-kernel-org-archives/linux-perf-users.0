From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf bpf examples
Date: Fri, 8 Jul 2016 00:57:50 -0700
Message-ID: <CAE40pddnMc2QOchQGJn2hkjqmRcvNJBJTAPZdRJbAyu4C60r9g@mail.gmail.com>
References: <CAE40pdfDNi-+80az4YNa9asLGyOJc2e5RcPgFxz5FK9VwgRUtw@mail.gmail.com>
 <577DB50D.3040204@huawei.com> <CAE40pdc7+gv2L7u+7CfFjmDQUv3rsV13XkAGDSrCq_FSOqLFdA@mail.gmail.com>
 <CAE40pddH3gTzJd6A_DLV6ftEDZhyew4Mbj=BLMMtNJAU87DmGw@mail.gmail.com> <577F297E.6030405@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33580 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbcGHH6V (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 8 Jul 2016 03:58:21 -0400
In-Reply-To: <577F297E.6030405@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Wangnan (F)" <wangnan0@huawei.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>

On Thu, Jul 7, 2016 at 9:18 PM, Wangnan (F) <wangnan0@huawei.com> wrote:
>
>
> On 2016/7/8 1:58, Brendan Gregg wrote:
>>
>> On Thu, Jul 7, 2016 at 10:54 AM, Brendan Gregg
>> <brendan.d.gregg@gmail.com> wrote:
>>>
>>> On Wed, Jul 6, 2016 at 6:49 PM, Wangnan (F) <wangnan0@huawei.com> wrote:
[...]
>> ... Also, has anyone looked into perf sampling (-F 99) with bpf yet?
>> Thanks,
>
>
> Theoretically, BPF program is an additional filter to
> decide whetier an event should be filtered out or pass to perf. -F 99
> is another filter, which drops samples to ensure the frequence.
> Filters works together. The full graph should be:
>
>  BPF --> traditional filter --> proc (system wide of proc specific) -->
> period
>
> See the example at the end of this mail. The BPF program returns 0 for half
> of
> the events, and the result should be symmetrical. We can get similar result
> without
> -F:
>
> # ~/perf record -a --clang-opt '-DCATCH_ODD' -e ./sampling.c dd if=/dev/zero
> of=/dev/null count=8388480
> 8388480+0 records in
> 8388480+0 records out
> 4294901760 bytes (4.3 GB) copied, 11.9908 s, 358 MB/s
> [ perf record: Woken up 28 times to write data ]
> [ perf record: Captured and wrote 303.915 MB perf.data (4194449 samples) ]
> #
> root@wn-Lenovo-Product:~# ~/perf record -a --clang-opt '-DCATCH_EVEN' -e
> ./sampling.c dd if=/dev/zero of=/dev/null count=8388480
> 8388480+0 records in
> 8388480+0 records out
> 4294901760 bytes (4.3 GB) copied, 12.1154 s, 355 MB/s
> [ perf record: Woken up 54 times to write data ]
> [ perf record: Captured and wrote 303.933 MB perf.data (4194347 samples) ]
>
>
> With -F99 added:
>
> # ~/perf record -F99 -a --clang-opt '-DCATCH_ODD' -e ./sampling.c dd
> if=/dev/zero of=/dev/null count=8388480
> 8388480+0 records in
> 8388480+0 records out
> 4294901760 bytes (4.3 GB) copied, 9.60126 s, 447 MB/s
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.402 MB perf.data (35 samples) ]
> # ~/perf record -F99 -a --clang-opt '-DCATCH_EVEN' -e ./sampling.c dd
> if=/dev/zero of=/dev/null count=8388480
> 8388480+0 records in
> 8388480+0 records out
> 4294901760 bytes (4.3 GB) copied, 9.76719 s, 440 MB/s
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.399 MB perf.data (37 samples) ]

That looks like it's doing two different things: -F99, and a
sampling.c script (SEC("func=sys_read")).

I mean just an -F99 that executes a BPF program on each sample. My
most common use for perf is:

perf record -F 99 -a -g -- sleep 30
perf report (or perf script, for making flame graphs)

But this uses perf.data as an intermediate file. With the recent
BPF_MAP_TYPE_STACK_TRACE, we could frequency count stack traces in
kernel context, and just dump a report. Much more efficient. And
improving a very common perf one-liner.

Brendan
