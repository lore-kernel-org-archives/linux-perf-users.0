From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Understanding perf mem -t load results
Date: Wed, 25 Dec 2013 11:25:44 +0100
Message-ID: <52BAB2A8.1040709@gmail.com>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr> <877gb5vmmn.fsf@tassilo.jf.intel.com> <52AE2721.8020501@insa-lyon.fr> <20131215234548.GP21717@two.firstfloor.org> <CALbiyZzWsDCANnhMsd9bsdqyjYtFNeSNUiUgvs7hSwH-w4ZZWw@mail.gmail.com> <CALbiyZy++Wgcoo6J7sbHHN1sWWJJKe36q4Gvtdnb0vOLjQ=nTg@mail.gmail.com> <20131224021822.GH20765@two.firstfloor.org> <52B93352.2030909@gmail.com> <20131224072813.GI20765@two.firstfloor.org> <52B93B01.4020305@gmail.com> <20131224212728.GK20765@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:41038 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3LYKZr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Dec 2013 05:25:47 -0500
Received: by mail-we0-f176.google.com with SMTP id p61so6455454wes.7
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Dec 2013 02:25:46 -0800 (PST)
In-Reply-To: <20131224212728.GK20765@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org


On 12/24/2013 10:27 PM, Andi Kleen wrote:
>> I checked what can be measured with the offcore facility. I can ask
>> to count remote memory accesses, but now I am not sure PEBS is
>> enable for these events. If the answer is no, I can't accurately
>> identify remote memory accesses with offcore events ? As a
>> consequence I am wondering if there is a way to do such thing ?
>
> The OFFCORE events are not PEBS enabled.

Ok, you confirm what I read in the Intel SDM.

However the memory PEBS
> events report the same information (with some limitations) in
> the PEBS record (and perf reports this information)
By memory PEBS events, do you mean the following events ?

MEM_LOAD_RETIRED.L1D_MISS
MEM_LOAD_RETIRED.L1D_LINE_MISS
MEM_LOAD_RETIRED.L2_MISS
MEM_LOAD_RETIRED.L2_LINE_MISS
MEM_LOAD_RETIRED.DTLB_MISS

I can't profile memory accesses with these events, isn't it ? What do 
you mean by perf reports this infomation, which perf tool ?

>
> In general you cannot accurately profile all memory accesses.

Does it means that the perf mem record tool is reporting wrong values 
concerning the source of the event ? (I checked that this tool use the 
load latency event with PEBS and you said that the IP reported by this 
uncore event is not always the correct one ?)

Thanks,

----
Manu
