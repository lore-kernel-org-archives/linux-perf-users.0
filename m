From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: linux 4.4, perf & BPF, and bpf_perf_event_output
Date: Tue, 12 Jan 2016 12:56:11 -0800
Message-ID: <CAE40pdev36+3kP_8oq=2mfbPDuH7Ya5ihEJ_Z4Pbqi=w+jgEnQ@mail.gmail.com>
References: <CAE40pde1XCYDCRXgThopk_wiDN_yw26BWLGgL4iaFnkWCkpW-Q@mail.gmail.com>
 <569466B9.2040702@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33314 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbcALU4l (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 12 Jan 2016 15:56:41 -0500
Received: by mail-ig0-f174.google.com with SMTP id z14so153207203igp.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Jan 2016 12:56:41 -0800 (PST)
In-Reply-To: <569466B9.2040702@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Wangnan (F)" <wangnan0@huawei.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>

On Mon, Jan 11, 2016 at 6:36 PM, Wangnan (F) <wangnan0@huawei.com> wrote:
>
>
> On 2016/1/12 8:07, Brendan Gregg wrote:
>>
>> G'Day,
>>
>> Congrats Wang Nan on the new perf bpf features in 4.4! I just
>> revisited where I was at with them now that it's official, and have a
>> couple of questions.
>>
>> So I can run something like this:
>>
>> ---syncsnoop.c---
>> /* perf.data: default event record only; trace_pipe:
>> bpf_trace_printk() output */
>> #include <uapi/linux/bpf.h>
>> #include "bpf_helpers.h"
>>
>> SEC("func=sys_sync")
>> int bpf_func__sys_sync(void *ctx)
>> {
>>      char fmt[] = "sync()\n";
>>      bpf_trace_printk(fmt, sizeof (fmt));
>>      return 1;
>> };
>>
>> char _license[] SEC("license") = "GPL";
>> int _version SEC("version") = LINUX_VERSION_CODE;
>> ------
>>
>> With: perf record -a --clang-opt "-DLINUX_VERSION_CODE=0x40400"
>> --event syncsnoop.c sleep 5
>>
>> And it works. I get PERF_RECORD_SAMPLE entries in perf.data, and my
>> custom strings in /sys/kernel/debug/tracing/trace_pipe.
>>
>> Q1. Given bpf_trace_printk() & trace_pipe is a hack, is there a way
>> yet to print my custom strings to perf.data? Eg, something like
>> bpf_perf_event_output() to change the format string of the event.
>> Currently I just get:
>>
>> # perf script
>>              sync 30207 [002]  2509.576984: perf_bpf_probe:func:
>> (ffffffff81221b20)
>>              sync 30209 [003]  2509.766632: perf_bpf_probe:func:
>> (ffffffff81221b20)
>>              sync 30229 [003]  2509.936299: perf_bpf_probe:func:
>> (ffffffff81221b20)
>>              sync 30230 [004]  2510.099059: perf_bpf_probe:func:
>> (ffffffff81221b20)
>>              sync 30231 [004]  2510.289351: perf_bpf_probe:func:
>> (ffffffff81221b20)
>
> Yes. I have implemented this feature. Patch has posted, but not
> in 4.4. I hope you will be able to use this feature in v4.5.
> It depends on Arnaldo.
>
> There is a small example at commit message of [1]. The basic workflow is:
>
>  1. Create a bpf-output map in your BPF file
>  2. Output data to it by bpf_perf_event_output in BPF source
>  3. Create bpf-output event in perf cmdline

Ok, I've browsed the examples, so considering this:

 # perf record -g -e evt=bpf-output/no-inherit/ \
                  -e ./test_bpf_output.c/maps.map_channel.event=evt/ -a ls

Please tell me if I'm understanding these correctly:

A. bpf-output is a dummy event used to pass data from kernel to user.
ie, I'll see them as PERF_RECORD_SAMPLE in "perf script -D".
B. bpf-output is triggered by bpf_perf_event_output().
C. The "evt=" is giving it an alias for later reference.
D. The "/no-inherit/" is to stop the dummy event from being used more
than once, by child tasks.
E. The "maps.map_channel.event=evt" ... I'm not sure what "event"
means here: is it associated with bpf_perf_event_output() being
called? ie, bpf_perf_event_output() -> bpf-output -> .event ?. ... So
I think this is saying that the map_channel map's
bpf_perf_event_output() calls should be emitted via the "evt" alias,
which we earlier defined as bpf-output.

Seems like "-e evt=bpf-output/no-inherit/" is redundant (or at least
could be an option, like "-x", but we seem to be running out of
letters!). If the user specifies a C program, then uses
bpf_perf_event_output(), then maybe perf should automatically begin
recording bpf-output without the user needing to specify it. After
all, lots of other stuff already goes into perf.data that I didn't
explicitly ask for (like PERF_RECORD_MMAP). :)

Also, "/maps.map_channel.event=evt/" seems redundant too, and could be
the default behavior. ie, I'd like to just run:

# perf record -g -e test_bpf_output.c -a ls

And then get dummy PERF_RECORD_SAMPLE events in my perf.data that has
the bpf_perf_event_output() details in. If I want to customize them,
using the above -e syntax, then fine, but that would be optional.

While this mechanism looks like it can pass bpf_perf_event_output(), I
guess a separate question is how we can dump map data at the end of
runs. Eg, imagine I'm using a map to store a histogram, which I want
dumped once at the end of the run. I don't have a specific place to
put a bpf_perf_event_output().

PS. regarding SEC("func=sys_sync") -- anyway to trace a kretprobe? :)

thanks,

Brendan
