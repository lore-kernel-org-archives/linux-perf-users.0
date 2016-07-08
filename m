From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf bpf examples
Date: Fri, 8 Jul 2016 09:35:38 -0700
Message-ID: <CAE40pdfGEDJyz21aa3J6XqgfGinjpJ5E8K8paX0vdYPT0Y62bQ@mail.gmail.com>
References: <CAE40pdfDNi-+80az4YNa9asLGyOJc2e5RcPgFxz5FK9VwgRUtw@mail.gmail.com>
 <577DB50D.3040204@huawei.com> <CAE40pdc7+gv2L7u+7CfFjmDQUv3rsV13XkAGDSrCq_FSOqLFdA@mail.gmail.com>
 <CAE40pddH3gTzJd6A_DLV6ftEDZhyew4Mbj=BLMMtNJAU87DmGw@mail.gmail.com>
 <577F297E.6030405@huawei.com> <CAE40pddnMc2QOchQGJn2hkjqmRcvNJBJTAPZdRJbAyu4C60r9g@mail.gmail.com>
 <577F8473.1090208@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36410 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020AbcGHQgT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 8 Jul 2016 12:36:19 -0400
In-Reply-To: <577F8473.1090208@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Wangnan (F)" <wangnan0@huawei.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>

On Fri, Jul 8, 2016 at 3:46 AM, Wangnan (F) <wangnan0@huawei.com> wrote:
>
>
> On 2016/7/8 15:57, Brendan Gregg wrote:
>>
[...]
>> I mean just an -F99 that executes a BPF program on each sample. My
>> most common use for perf is:
>>
>> perf record -F 99 -a -g -- sleep 30
>> perf report (or perf script, for making flame graphs)
>>
>> But this uses perf.data as an intermediate file. With the recent
>> BPF_MAP_TYPE_STACK_TRACE, we could frequency count stack traces in
>> kernel context, and just dump a report. Much more efficient. And
>> improving a very common perf one-liner.
>
>
> You can't attach BPF script to samples other than kprobe and tracepoints.
> When you use 'perf record -F99 -a -g -- sleep 30', you are sampling on
> 'cycles:ppp' event. This is a hardware PMU event.

Sure, either cycles:ppp or cpu-clock (my Xen guests have no PMU,
sadly). But These are ultimately calling perf_swevent_hrtimer()/etc,
so I was wondering if someone was already looking at enhancing this
code to support BPF? Ie, BPF should be able to attach to kprobes,
uprobes, tracepoints, and timer-based samples.

> If we find a kprobe or tracepoint event which would be triggered 99 times
> in each second, we can utilize BPF_MAP_TYPE_STACK_TRACE and
> bpf_get_stackid().

Yes, that should be a workaround. It's annoying as some like
perf_swevent_hrtimer() can't be kprobed (inlined?), but I found
perf_misc_flags(struct pt_regs *regs) was called, but passing in that
regs to bpf_get_stackid() was returning "type=inv expected=ctx"
errors, despite casting. I'm guessing the BPF ctx type is special and
can't be casted, but need to dig more.

Brendan
