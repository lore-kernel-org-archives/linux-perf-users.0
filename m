From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: perf bpf examples
Date: Fri, 8 Jul 2016 12:18:06 +0800
Message-ID: <577F297E.6030405@huawei.com>
References: <CAE40pdfDNi-+80az4YNa9asLGyOJc2e5RcPgFxz5FK9VwgRUtw@mail.gmail.com>
 <577DB50D.3040204@huawei.com>
 <CAE40pdc7+gv2L7u+7CfFjmDQUv3rsV13XkAGDSrCq_FSOqLFdA@mail.gmail.com>
 <CAE40pddH3gTzJd6A_DLV6ftEDZhyew4Mbj=BLMMtNJAU87DmGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:25516 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbcGHESb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 8 Jul 2016 00:18:31 -0400
In-Reply-To: <CAE40pddH3gTzJd6A_DLV6ftEDZhyew4Mbj=BLMMtNJAU87DmGw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>



On 2016/7/8 1:58, Brendan Gregg wrote:
> On Thu, Jul 7, 2016 at 10:54 AM, Brendan Gregg
> <brendan.d.gregg@gmail.com> wrote:
>> On Wed, Jul 6, 2016 at 6:49 PM, Wangnan (F) <wangnan0@huawei.com> wrote:
>>>
>>>
>>> On 2016/7/7 4:29, Brendan Gregg wrote:
>>>> G'Day,
>>>>
>>>> Are perf bpf examples shared anywhere? I've seen many posted to lkml
>>>> (by Wang Nan), but don't see them in the linux source, or
>>>> documentation. Would be very handy to throw them all up somewhere for
>>>> searching/learning, if that hasn't already happened, eg, github.
>>>>
>>>> I was also looking to see if perf bpf supports sampling yet, but I
>>>> don't think it does. Eg, imagine a:
>>>>
>>>> perf record -F 99 -e bpf_process_samples.c -a -- sleep 10
>>>>
>>>> which would require BPF attaching to perf_swevent_hrtimer()/etc, and
>>>> also emitting a map (eg, sampled instruction pointer counts). I don't
>>>> think perf currently does either, but was hoping for a collection of
>>>> examples to double check.
>>>
>>> Currently perf-bpf doesn't support dumpping resuling maps, but
>>> we are working on it. I think you have read our uBPF approach:
>>>
>>> http://article.gmane.org/gmane.linux.kernel/2203717
>>>
>>> and
>>>
>>> http://article.gmane.org/gmane.linux.kernel/2253579
>>>
>>> in them we embeded a uBPF virtual machine to perf and give it
>>> the ability to operate the result in maps.
>>>
>>> Now we are trying another approach, introduce LLVM to perf,
>>> compile data analysis and report to code. It would be much
>>> powerful.
>>
>> Great, thanks!
>>
>> But what about a set of examples covering the existing perf+bpf
>> capabilities so far? I know you've emailed them to lkml, but has
>> someone put them all in one place yet? If not, I can go through lkml
>> and at least put them on github so we can search and learn from them.

Great. Thanks a lot.

> ... Also, has anyone looked into perf sampling (-F 99) with bpf yet? Thanks,

Theoretically, BPF program is an additional filter to
decide whetier an event should be filtered out or pass to perf. -F 99
is another filter, which drops samples to ensure the frequence.
Filters works together. The full graph should be:

  BPF --> traditional filter --> proc (system wide of proc specific) --> 
period

See the example at the end of this mail. The BPF program returns 0 for 
half of
the events, and the result should be symmetrical. We can get similar 
result without
-F:

# ~/perf record -a --clang-opt '-DCATCH_ODD' -e ./sampling.c dd 
if=/dev/zero of=/dev/null count=8388480
8388480+0 records in
8388480+0 records out
4294901760 bytes (4.3 GB) copied, 11.9908 s, 358 MB/s
[ perf record: Woken up 28 times to write data ]
[ perf record: Captured and wrote 303.915 MB perf.data (4194449 samples) ]
#
root@wn-Lenovo-Product:~# ~/perf record -a --clang-opt '-DCATCH_EVEN' -e 
./sampling.c dd if=/dev/zero of=/dev/null count=8388480
8388480+0 records in
8388480+0 records out
4294901760 bytes (4.3 GB) copied, 12.1154 s, 355 MB/s
[ perf record: Woken up 54 times to write data ]
[ perf record: Captured and wrote 303.933 MB perf.data (4194347 samples) ]


With -F99 added:

# ~/perf record -F99 -a --clang-opt '-DCATCH_ODD' -e ./sampling.c dd 
if=/dev/zero of=/dev/null count=8388480
8388480+0 records in
8388480+0 records out
4294901760 bytes (4.3 GB) copied, 9.60126 s, 447 MB/s
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.402 MB perf.data (35 samples) ]
# ~/perf record -F99 -a --clang-opt '-DCATCH_EVEN' -e ./sampling.c dd 
if=/dev/zero of=/dev/null count=8388480
8388480+0 records in
8388480+0 records out
4294901760 bytes (4.3 GB) copied, 9.76719 s, 440 MB/s
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.399 MB perf.data (37 samples) ]

However, there must be something I don't understand. It takes nearly 10 
seconds to
finish the record, so we should get nearly 1000 samples. Sometimes I can 
get about 500 samples:

# ~/perf record -F99 -a --clang-opt '-DCATCH_ODD' -e ./sampling.c dd 
if=/dev/zero of=/dev/null count=8388480
8388480+0 records in
8388480+0 records out
4294901760 bytes (4.3 GB) copied, 9.60536 s, 447 MB/s
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.431 MB perf.data (555 samples) ]

/////////////////////////////////////////////////////////////////
#include <uapi/linux/bpf.h>
#define SEC(NAME) __attribute__((section(NAME), used))
struct bpf_map_def {
     unsigned int type;
     unsigned int key_size;
     unsigned int value_size;
     unsigned int max_entries;
};
struct bpf_map_def SEC("maps") m = {
     .type = BPF_MAP_TYPE_ARRAY,
     .key_size = sizeof(int),
     .value_size = sizeof(int),
     .max_entries = 1,
};
static void *(*map_lookup_elem)(struct bpf_map_def *, void *) =
        (void *)BPF_FUNC_map_lookup_elem;
static int (*trace_printk)(const char *fmt, int fmt_size, ...) =
         (void *)BPF_FUNC_trace_printk;
char _license[] SEC("license") = "GPL";
int _version SEC("version") = LINUX_VERSION_CODE;
#ifdef CATCH_ODD
# define RET_ODD  1
# define RET_EVEN 0
#endif
#ifdef CATCH_EVEN
# define RET_ODD  0
# define RET_EVEN 1
#endif
SEC("func=sys_read")
int func(void *ctx)
{
         int key = 0, *v;
         v = map_lookup_elem(&m, &key);
         if (!v)
                 return 0;
         __sync_fetch_and_add(v, 1);
         if (*v & 1)
                 return RET_ODD;
         return RET_EVEN;
}



> Brendan
