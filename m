From: Andreas Hollmann <hollmann@in.tum.de>
Subject: Re: Does perf randomize the sampling period?
Date: Wed, 9 Sep 2015 17:24:03 +0200
Message-ID: <CAGz0_-2OoEQqvMud3vzqH69TELGqJThanrU9ar_p_his6Uzsfg@mail.gmail.com>
References: <1769534.mDAXVEGQ5L@milian-kdab2>
	<55F04D3C.60908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:62456 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754529AbbIIPYI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Sep 2015 11:24:08 -0400
Received: (Authenticated sender: hollmann)
	by mail.in.tum.de (Postfix) with ESMTPSA id F3E871C2455
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2015 17:24:05 +0200 (CEST)
Received: by qgt47 with SMTP id 47so10561414qgt.2
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Sep 2015 08:24:03 -0700 (PDT)
In-Reply-To: <55F04D3C.60908@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org

According to this paper

Establishing a Base of Trust with Performance
Counters for Enterprise Workloads

software randomization is not available in perf.

"We program the PMU to sample with prime and
non-prime periods. Due to perf limitations, software-
based period randomization was unavailable, but the
hardware randomizes the 4 least significant bits."


2015-09-09 17:16 GMT+02:00 Manuel Selva <selva.manuel@gmail.com>:
> Regarding perf mem record on Intel platforms, I think that the sampling
> randomization is ensured by the hardware.
>
> ----
> Manu
>
> On 09/09/2015 05:11 PM, Milian Wolff wrote:
>>
>> Hey all,
>>
>> does perf randomize its sampling intervals/period to prevent pattern
>> effects?
>> I found https://lkml.org/lkml/2010/3/4/51 but neither the man page on perf
>> record says anything on that matter, nor does the perf wiki say it's
>> supported:
>>
>> https://perf.wiki.kernel.org/index.php/Tutorial#Period_and_rate
>>
>>> There is currently no support for sampling period randomization.
>>
>>
>> So is it supported, or not? If it is supported, how do I enable it? Or is
>> this
>> enabled by default?
>>
>> If it is not supported, why so? Is it not important to have?
>>
>> Thanks
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
