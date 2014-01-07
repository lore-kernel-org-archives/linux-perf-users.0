From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Understanding perf mem -t load results
Date: Tue, 7 Jan 2014 16:06:18 +0100
Message-ID: <CALbiyZyUncZZq7mU=+Hk9mYY7q3ugWiiESWSS9RSP-PfwB9u=w@mail.gmail.com>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
	<877gb5vmmn.fsf@tassilo.jf.intel.com>
	<52AE2721.8020501@insa-lyon.fr>
	<20131215234548.GP21717@two.firstfloor.org>
	<CALbiyZzWsDCANnhMsd9bsdqyjYtFNeSNUiUgvs7hSwH-w4ZZWw@mail.gmail.com>
	<CALbiyZy++Wgcoo6J7sbHHN1sWWJJKe36q4Gvtdnb0vOLjQ=nTg@mail.gmail.com>
	<20131224021822.GH20765@two.firstfloor.org>
	<52B93352.2030909@gmail.com>
	<20131224072813.GI20765@two.firstfloor.org>
	<52B93B01.4020305@gmail.com>
	<20131224212728.GK20765@two.firstfloor.org>
	<52BAB2A8.1040709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:61533 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbaAGPGU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 7 Jan 2014 10:06:20 -0500
Received: by mail-lb0-f171.google.com with SMTP id w7so356597lbi.2
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2014 07:06:18 -0800 (PST)
In-Reply-To: <52BAB2A8.1040709@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Hi Andi,

Coming back from winter break, looking at the perf user land tool (in
the kernel sources) I am still confuse about this discussion.

The perf mem record tool use the
MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD which I guess belongs to the
memory PEBS events you mentionned (isn't it ?) is reporting
information about the sources of the events. it seems that for this
purpose the IP information is used, does it mean that what perf mem
reports can be wrong because of the random IP selection mechanism you
mentionned ?

Thanks for your help and sorry for all these questions, but I can't
find an answer elswhere than on this list.

Manu

2013/12/25 Manuel Selva <selva.manuel@gmail.com>:
>
> On 12/24/2013 10:27 PM, Andi Kleen wrote:
>>>
>>> I checked what can be measured with the offcore facility. I can ask
>>> to count remote memory accesses, but now I am not sure PEBS is
>>> enable for these events. If the answer is no, I can't accurately
>>> identify remote memory accesses with offcore events ? As a
>>> consequence I am wondering if there is a way to do such thing ?
>>
>>
>> The OFFCORE events are not PEBS enabled.
>
>
> Ok, you confirm what I read in the Intel SDM.
>
>
> However the memory PEBS
>>
>> events report the same information (with some limitations) in
>> the PEBS record (and perf reports this information)
>
> By memory PEBS events, do you mean the following events ?
>
> MEM_LOAD_RETIRED.L1D_MISS
> MEM_LOAD_RETIRED.L1D_LINE_MISS
> MEM_LOAD_RETIRED.L2_MISS
> MEM_LOAD_RETIRED.L2_LINE_MISS
> MEM_LOAD_RETIRED.DTLB_MISS
>
> I can't profile memory accesses with these events, isn't it ? What do you
> mean by perf reports this infomation, which perf tool ?
>
>
>>
>> In general you cannot accurately profile all memory accesses.
>
>
> Does it means that the perf mem record tool is reporting wrong values
> concerning the source of the event ? (I checked that this tool use the load
> latency event with PEBS and you said that the IP reported by this uncore
> event is not always the correct one ?)
>
> Thanks,
>
> ----
> Manu
