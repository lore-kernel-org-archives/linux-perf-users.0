From: Stephane Eranian <eranian@google.com>
Subject: Re: Fwd: Intel PEBS Load Latency Measurement
Date: Wed, 6 Nov 2013 14:41:13 +0100
Message-ID: <CABPqkBSpvU3rLD5XzAXOuymCtN1tU19oYjFMA154j2vTXasNrg@mail.gmail.com>
References: <52380863.4090606@insa-lyon.fr>
	<526E4A46.2060003@insa-lyon.fr>
	<87r4b47qgv.fsf@sejong.aot.lge.com>
	<CALbiyZy_JE+wai7d_=r-XzE+FdHRitTiAuPmANtRt7Qpet8fTg@mail.gmail.com>
	<CALbiyZyOUYL3dKo_OaXK6SMXmMBF3N47gGv0MAjRirsFzyPDMw@mail.gmail.com>
	<87iowc4iug.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:42456 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756152Ab3KFNlP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 6 Nov 2013 08:41:15 -0500
Received: by mail-oa0-f53.google.com with SMTP id j17so2121639oag.40
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2013 05:41:14 -0800 (PST)
In-Reply-To: <87iowc4iug.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Manuel Selva <selva.manuel@gmail.com>, linux-perf-users@vger.kernel.org

Hi Manuel,

On Fri, Nov 1, 2013 at 9:38 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> Hi Manuel,
>
> I'm CC-ing Stephane who is the author of the perf mem tool.  Stephane,
> could you please answer the questions below if you have some time?
>
> Thanks,
> Namhyung
>
>
> On Tue, 29 Oct 2013 10:12:39 +0100, Manuel Selva wrote:
>> Hi Namhyung,
>>
>> Many thanks for your answer and the function you pointed. I think I
>> now have all the required understanding of the perf_event_open syscall
>> to do what I want.
>>
>> I still have two questions regarding Intel (I am on a Westmere-Ep Xeon
>> X5650) Load latency feature and its usage by the perf mem tool.
>>
>> 1- In the Intel software developer guide we can read: "load operations
>> are randomly selected by hardware and tagged to carry information
>> related to data source locality and latency" I am wondering what does
>> it mean, are we doing sampling at two different levels ? First the
>> hardware chooses some load instructions to tag, and then each time X
>> (sampling period in events count specified by software) such tagged
>> instructions with a latency greater than a software specify threshold
>> we record a sample with some information. What is the sampling rate of
>> the hardware tagging mechanism, is it enough to get some interesting
>> results ?
>>
The Load latency facility combines basic PEBS + a threshold mechanism
to filter only certain types of loads based on their latencies.

The mem_trans_retired:latency_above_threshold counts the number of
loads retired that qualify for the threshold. This is the event you are
actually sampling on. When that counter overflows, the retired load
is sampled. If you set the counter to -P, it will overflow after P occurrences
of the event. Now, it is clear that to get there you need to wait until
the load retires, otherwise you don't know the latency. Note that
latency here means instruction latency not just data access latency.
So, I suspect underneath there is indeed some tagging mechanism.
It can track only one load at a time. To avoid bias, the tagging mechanism
uses some randomization scheme. I don't know how this tagging mechanism
actually works. But clearly you may track loads that don't qualify for the
threshold, they won't increment the counter and therefore will never be
captured by perf_events.


>> 2- How does the perf mem tool (with the load option) with of course
>> the help of the kernel uses this feature ? After a quick browsing of
>> the code, here is my understanding, is it correct ?
>> The PEBS load latency feature is enabled with the minimal possible
>> latency (3 cycles) to do sampling on all loads and with a given
>> default sampling period (x tagged load events with latency greater or
>> equal to 3). In addition to these "loads events" the perf mem tool
>> asks the kernel to record events about processes naming, and memory
>> mappings of code to be able to retrieve offline the source code
>> associated to instruction pointers present in samples.
>>
Yes, your description is correct. The one difference compared
with regular code sampling is that we also ask the kernel to record
data mmaps, so we get a chance to symbolize data addresses (global
variables only).

Hope this helps.

>> Thanks again for your help,
>>
>> Manu
>>
>>
>> 2013/10/29 Namhyung Kim <namhyung@kernel.org>
>>>
>>> Hi Manuel,
>>>
>>> On Mon, 28 Oct 2013 12:28:06 +0100, Manuel Selva wrote:
>>> > Hi,
>>> >
>>> > I am coming back on this subject after working on other stuff for
>>> > several weeks. Andi pointed me to the userland tool 'perf mem'
>>> > introduced in "recent" kernels (can't find the version) that is using
>>> > the kernel perf_event_open system call to profile memory accesses.
>>> >
>>> > I guess the answer to my question is in the code of this tool, but
>>> > before stepping deeper inside it, I wanted to ask you (Linux perf
>>> > experts) few questions, to be sure I am on the right track.
>>> >
>>> > For now, I just configured a perf_event_attr to perform sampling of
>>> > PERF_COUNT_HW_INSTRUCTIONS at a given period. Can you confirm than the
>>> > sample_period means "the kernel will generate a sample (with fields
>>> > asked through sample_type) every sample_period instructions ?
>>>
>>> Yes.
>>>
>>> >
>>> > Then after calling the perf_event_open system call I mmap the file
>>> > descriptor returned with an arbitrary size of X pages (with X = 1 +
>>> > 2^n).
>>> >
>>> > I then start recording events with ioctl on the file descriptor
>>> > returned by perf_event_open. I am now wondering how to access the
>>> > samples. My main concern is about the meaning of the data_head and
>>> > data_tail fields of the metadata page located at the beginning of the
>>> > memory mmaped. In understand that my samples are located just after
>>> > this metadata page, and that these head and tail pointers are used to
>>> > indicate where we are in the reading of the samples, is it correct ?
>>>
>>> Correct.
>>>
>>>
>>> > While reading samples, should I use/modify these head and tail
>>> > pointers, if yes what is the purpose of that ?
>>>
>>> The head is updated by kernel, you only need to update the tail after
>>> reading.  Please see perf_record__mmap_read().
>>>
>>> >
>>> > I am going now to look for the perf mem code, to try to understand
>>> > that from my side, but I am interested in any hint on the subject that
>>> > may help me.
>>> >
>>> > Many thanks in advance for your help,
>>>
>>> Hope this helps,
>>> Namhyung
