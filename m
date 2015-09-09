From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Does perf randomize the sampling period?
Date: Wed, 9 Sep 2015 17:16:12 +0200
Message-ID: <55F04D3C.60908@gmail.com>
References: <1769534.mDAXVEGQ5L@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38669 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbbIIPQP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Sep 2015 11:16:15 -0400
Received: by wiclk2 with SMTP id lk2so25871573wic.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Sep 2015 08:16:14 -0700 (PDT)
In-Reply-To: <1769534.mDAXVEGQ5L@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org

Regarding perf mem record on Intel platforms, I think that the sampling 
randomization is ensured by the hardware.

----
Manu

On 09/09/2015 05:11 PM, Milian Wolff wrote:
> Hey all,
>
> does perf randomize its sampling intervals/period to prevent pattern effects?
> I found https://lkml.org/lkml/2010/3/4/51 but neither the man page on perf
> record says anything on that matter, nor does the perf wiki say it's
> supported:
>
> https://perf.wiki.kernel.org/index.php/Tutorial#Period_and_rate
>
>> There is currently no support for sampling period randomization.
>
> So is it supported, or not? If it is supported, how do I enable it? Or is this
> enabled by default?
>
> If it is not supported, why so? Is it not important to have?
>
> Thanks
>
