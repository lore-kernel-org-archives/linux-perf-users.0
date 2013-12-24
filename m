From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Understanding perf mem -t load results
Date: Tue, 24 Dec 2013 08:10:10 +0100
Message-ID: <52B93352.2030909@gmail.com>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr> <877gb5vmmn.fsf@tassilo.jf.intel.com> <52AE2721.8020501@insa-lyon.fr> <20131215234548.GP21717@two.firstfloor.org> <CALbiyZzWsDCANnhMsd9bsdqyjYtFNeSNUiUgvs7hSwH-w4ZZWw@mail.gmail.com> <CALbiyZy++Wgcoo6J7sbHHN1sWWJJKe36q4Gvtdnb0vOLjQ=nTg@mail.gmail.com> <20131224021822.GH20765@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:42180 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab3LXHKO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 Dec 2013 02:10:14 -0500
Received: by mail-wi0-f170.google.com with SMTP id hq4so11189098wib.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Dec 2013 23:10:12 -0800 (PST)
In-Reply-To: <20131224021822.GH20765@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Thanks,

"You cannot use uncore events to sample IPs" means that the values 
corresponding to PERF_SAMPLE_IP are not correct ? Some benchmarks I did 
by sampling ME_INST_RETIRED with PERF_SAMPLE_IP let me think that I was 
able to get the source of th event. The IP value was coherent. Maybe 
this is not always the case.

I am thus going to look a offcore request to sample remote memory 
accesses with correct IPs values.

Manu

On 12/24/2013 03:18 AM, Andi Kleen wrote:
>> In my experiments I get LFB samples with weight equal or greater than
>> local RAM samples, I should I interpret these values ?
>
> The measured latency can include the pipeline latency.
>
>> Moreover, because I am more interested in identifying remote memory
>> accesses sources than in effective load latency weight, I am wondering
>> if using the perf mem tool (using the
>> MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD event) is the best solution.
>> Couldn't I use sampling on other events such as UNCORE ones more
>> easily and efficiently ?
>
> You cannot use uncore events to sample on IPs.
>
> -Andi
>
