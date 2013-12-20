From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Understanding perf mem -t load results
Date: Fri, 20 Dec 2013 10:38:00 +0100
Message-ID: <CALbiyZy++Wgcoo6J7sbHHN1sWWJJKe36q4Gvtdnb0vOLjQ=nTg@mail.gmail.com>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
	<877gb5vmmn.fsf@tassilo.jf.intel.com>
	<52AE2721.8020501@insa-lyon.fr>
	<20131215234548.GP21717@two.firstfloor.org>
	<CALbiyZzWsDCANnhMsd9bsdqyjYtFNeSNUiUgvs7hSwH-w4ZZWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:62626 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134Ab3LTJiC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Dec 2013 04:38:02 -0500
Received: by mail-lb0-f181.google.com with SMTP id q8so952588lbi.26
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2013 01:38:00 -0800 (PST)
In-Reply-To: <CALbiyZzWsDCANnhMsd9bsdqyjYtFNeSNUiUgvs7hSwH-w4ZZWw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Hi,

I am still working on my quest to identify remote memory accesses
using perf. I am confused about the LFB samples collected wit "perf
mem rec". According to this Intel blog
http://software.intel.com/en-us/blogs/2010/11/11/utilizing-load-latency-event-in-performance-monitoring-to-get-line-fill-buffer-breakdown
one could use the weight information gathered by the hardware to
identify "the potential data sources of LFB sample events".

In my experiments I get LFB samples with weight equal or greater than
local RAM samples, I should I interpret these values ?

Moreover, because I am more interested in identifying remote memory
accesses sources than in effective load latency weight, I am wondering
if using the perf mem tool (using the
MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD event) is the best solution.
Couldn't I use sampling on other events such as UNCORE ones more
easily and efficiently ?

Thanks again for your help,

Manu

2013/12/16 Manuel Selva <selva.manuel@gmail.com>:
> Thanks again.
>
> I guess that by "how you configure perf" you are speaking about
> thred/cpu, kernel/user parameters ? For now I am monitoring one
> application only on a given node only and I am trying to setup things
> in order to get useful results independently of the overhead. I'll
> investigate overhead in a second time.
>
> I can't use perf stat because I need to relate perf events with my
> application's code.
>
> Manu
>
> 2013/12/16 Andi Kleen <andi@firstfloor.org>:
>> On Sun, Dec 15, 2013 at 11:03:13PM +0100, Manuel Selva wrote:
>>> Thanks for the answer Andi.
>>>
>>> Is there any way (I couldn't find in the Intel documentation) to
>>> have an approximation of the "maximum" acceptable frequency ?
>>
>> It depends on how much overhead is acceptable and how you configure
>> perf (which affects the cost of the handler) and what the executed
>> code does. You could tune it to minimize throttles.
>>
>> I would start with something like 20003
>>
>> If you only want the relative ratios of course using perf stat would
>> be better.
>>
>> -Andi
>>
>> --
>> ak@linux.intel.com -- Speaking for myself only.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
