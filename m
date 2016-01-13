From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: linux 4.4, perf & BPF, and bpf_perf_event_output
Date: Wed, 13 Jan 2016 10:54:31 +0800
Message-ID: <5695BC67.9040304@huawei.com>
References: <CAE40pde1XCYDCRXgThopk_wiDN_yw26BWLGgL4iaFnkWCkpW-Q@mail.gmail.com> <569466B9.2040702@huawei.com> <CAE40pdev36+3kP_8oq=2mfbPDuH7Ya5ihEJ_Z4Pbqi=w+jgEnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:32458 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbcAMCyw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 12 Jan 2016 21:54:52 -0500
In-Reply-To: <CAE40pdev36+3kP_8oq=2mfbPDuH7Ya5ihEJ_Z4Pbqi=w+jgEnQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>



On 2016/1/13 4:56, Brendan Gregg wrote:
> On Mon, Jan 11, 2016 at 6:36 PM, Wangnan (F) <wangnan0@huawei.com> wrote:
>>
>> On 2016/1/12 8:07, Brendan Gregg wrote:
>>> G'Day,
[SNIP]

>> Yes. I have implemented this feature. Patch has posted, but not
>> in 4.4. I hope you will be able to use this feature in v4.5.
>> It depends on Arnaldo.
>>
>> There is a small example at commit message of [1]. The basic workflow is:
>>
>>   1. Create a bpf-output map in your BPF file
>>   2. Output data to it by bpf_perf_event_output in BPF source
>>   3. Create bpf-output event in perf cmdline
> Ok, I've browsed the examples, so considering this:
>
>   # perf record -g -e evt=bpf-output/no-inherit/ \
>                    -e ./test_bpf_output.c/maps.map_channel.event=evt/ -a ls
>
> Please tell me if I'm understanding these correctly:
>
> A. bpf-output is a dummy event used to pass data from kernel to user.
> ie, I'll see them as PERF_RECORD_SAMPLE in "perf script -D".

Right.

> B. bpf-output is triggered by bpf_perf_event_output().
Right.
> C. The "evt=" is giving it an alias for later reference.

Right.
> D. The "/no-inherit/" is to stop the dummy event from being used more
> than once, by child tasks.

Yes, but need more works to explain. See below.

> E. The "maps.map_channel.event=evt" ...

maps:map_channel.event=evt

"." --> ":"


See below for explaination.

> I'm not sure what "event"
> means here: is it associated with bpf_perf_event_output() being
> called? ie, bpf_perf_event_output() -> bpf-output -> .event ?. ... So
> I think this is saying that the map_channel map's
> bpf_perf_event_output() calls should be emitted via the "evt" alias,
> which we earlier defined as bpf-output.
>
> Seems like "-e evt=bpf-output/no-inherit/" is redundant (or at least
> could be an option, like "-x", but we seem to be running out of
> letters!). If the user specifies a C program, then uses
> bpf_perf_event_output(), then maybe perf should automatically begin
> recording bpf-output without the user needing to specify it. After
> all, lots of other stuff already goes into perf.data that I didn't
> explicitly ask for (like PERF_RECORD_MMAP). :)

It can be discussed. We can create a syntax sugar. Could
you please give some detail suggestions?

Without using sugar we can do other interesting things.
For example:

  # perf record -e sync_trace=bpf-output/no-inherit/ \
                -e display_trace=bpf-output/no-inherit/ \
                ...

Here we create two bpf-output events for different propose. In
BPF file let's simply output a zero size data to different events
to indicate what happen. Then 'perf script' output is enough for me,
don't need CTF conversion.

Also, in the above example we can further adding /call-graph=no/
to bpf-output, because we only need to know 'something is
happening', don't need the full call graph where we find the unusual.

>
> Also, "/maps.map_channel.event=evt/" seems redundant too, and could be
> the default behavior. ie, I'd like to just run:
>
> # perf record -g -e test_bpf_output.c -a ls
>
> And then get dummy PERF_RECORD_SAMPLE events in my perf.data that has
> the bpf_perf_event_output() details in. If I want to customize them,
> using the above -e syntax, then fine, but that would be optional.

See above. We can make a sugar on it. Could you please give
a detail suggestion?

> While this mechanism looks like it can pass bpf_perf_event_output(), I
> guess a separate question is how we can dump map data at the end of
> runs. Eg, imagine I'm using a map to store a histogram, which I want
> dumped once at the end of the run. I don't have a specific place to
> put a bpf_perf_event_output().
>
> PS. regarding SEC("func=sys_sync") -- anyway to trace a kretprobe? :)

You can use:

SEC("func=sys_sync%return")

Now let's discuss the detail of this part.

1. perf creates multiple perf event instances for an event.
    Each event is bound to a processor. For example, with a 8 core
    machine, a '-e cycles' causes 8 perf event instances.

2. Because of 1, a BPF program needs to operates multiple perf
    events.

3. Because of 2, BPF program operate perf events through a map
    with type BPF_MAP_TYPE_PERF_EVENT_ARRAY. This is why the
    interface you see is not as strightforward as you may expect.
    Also, this is the reason why perf event array needs at least
    __NR_CPUS__ slots.

4. Operating inherit perf event in BPF program is dangerous, so
    kernel doesn't allow inserting inherit event into the map in 3.
    This is the reason why we need /no-inherit/. (However, we can
    provide a sugar to autimatically turn off inherit setting
    if the event is system-wide).

5. So the working flow should be:
    1) Create perf events and give them names:
       using '-e evt=<events>'

    2) Full them into the map, using:
       /maps:map_channel.event=evt/

6. Why we need such a long string '/maps:map_channel.event=evt/' ?

    The full maps configuration syntax is:

    maps:[<arraymap>].value<indices>=[value]
    maps:[<eventmap>].event<indices>=[event]

    With this configuration we are not only allowed to fill perf event
    into map, but can also fill different initial value to normal array map.
    For example, we can put a pid of a program into an array map and use
    that pid in BPF program, without having to recompile the BPF program.
    this map is very similar to global variables.

    maps:global_vars.value[0]=`ps -e | grep X | awk '{print $1}'`
     ^           ^      ^  ^
     |           |      |  |
   prefix        |      | only set the first element
              map name  |
                        |
                we are inserting value


    maps:map_channel.event=evt
     ^           ^      ^   ^
     |           |      |   |
   prefix        |      | event alias
              map name  |
                        |
                we are filling perf event

Thank you.
