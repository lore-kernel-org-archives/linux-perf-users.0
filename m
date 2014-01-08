From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Understanding perf mem -t load results
Date: Wed, 8 Jan 2014 10:50:38 +0100
Message-ID: <CALbiyZwG8z_yL+wJuUs2GsD9sVoEgGM0Y3JERnzFhPKLgqQrYA@mail.gmail.com>
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
	<CALbiyZyUncZZq7mU=+Hk9mYY7q3ugWiiESWSS9RSP-PfwB9u=w@mail.gmail.com>
	<87wqib4h5m.fsf@tassilo.jf.intel.com>
	<CALbiyZyaxvbx77oVFKWbbnCx69A6GkA5=n50G7M8=+iZTyPq8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:57298 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbaAHJuj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 8 Jan 2014 04:50:39 -0500
Received: by mail-la0-f51.google.com with SMTP id ec20so967099lab.10
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2014 01:50:38 -0800 (PST)
In-Reply-To: <CALbiyZyaxvbx77oVFKWbbnCx69A6GkA5=n50G7M8=+iZTyPq8g@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Ok I wrongly interpreted one of your previous answer and my confusion
comes from there. Sorry. UNCORE events can't be used to sample on IP,
but of course the MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD event used
by perf mem is not an UNCORE one.

Thanks

Manu



2014/1/8 Manuel Selva <selva.manuel@gmail.com>:
> Thanks.
>
> I get the point about sampling, but my question was more about the
> sources of memory accesses. In previous answer, you told me that the
> PERF_SAMPLE_IP field is filled with "the IP of a random core on the
> socket that happens to read the uncore registers", so my last question
> is about the result presented by perf mem report tool.
>
> This tool (like perf report) reports a Symbol and a Shared Object
> colums. I am thus wondering how can the entries in these columns be
> correct if the IP for each sample is wrong ?
>
> Manu
>
> 2014/1/7 Andi Kleen <andi@firstfloor.org>:
>> Manuel Selva <selva.manuel@gmail.com> writes:
>>
>>
>>> The perf mem record tool use the
>>> MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD which I guess belongs to the
>>> memory PEBS events you mentionned (isn't it ?) is reporting
>>
>> Yes.
>>
>>> information about the sources of the events. it seems that for this
>>> purpose the IP information is used, does it mean that what perf mem
>>> reports can be wrong because of the random IP selection mechanism you
>>> mentionned ?
>>
>> The CPU can theoretically execute billions of loads/stores every second.
>> There is no way any reporting mechanism can keep up with that.
>> So the only thing you can do is to sample (only collect
>> every N operations), with a fairly large period.
>>
>> -Andi
>>
>> --
>> ak@linux.intel.com -- Speaking for myself only
