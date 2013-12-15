From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Understanding perf mem -t load results
Date: Sun, 15 Dec 2013 19:27:26 +0100
Message-ID: <52ADF48E.3060605@gmail.com>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:41456 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab3LOS1a (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 15 Dec 2013 13:27:30 -0500
Received: by mail-wi0-f177.google.com with SMTP id cc10so1234949wib.4
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Dec 2013 10:27:28 -0800 (PST)
Received: from [192.168.0.10] (mut38-6-88-167-68-98.fbx.proxad.net. [88.167.68.98])
        by mx.google.com with ESMTPSA id q8sm18305394wiy.8.2013.12.15.10.27.27
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 15 Dec 2013 10:27:28 -0800 (PST)
In-Reply-To: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

Is there anyone here using the perf mem tool able to answer to my 
previous questions ?

Thanks in advance,

----
Manu

On 12/12/2013 03:06 PM, Manuel Selva wrote:
> Hi all,
>
> I am trying to understand the output of the perf mem tool on my workstation with two intel Xeon X5650.
>
> I recorded a perf.data file with memory load sampling (write sampling is not availble for these processors) as following (in the root directory of a Linux kernel source tree):
>
> perf mem -t load rec -c 1 make -j18
>
> Then I am reporting the results with
>
> perf mem rep --sort=mem
>
>   97.00%      25519343  L1 hit
>    1.31%         43687  L3 hit
>    1.15%         37253  LFB hit
>    0.32%          3156  Remote Cache (1 hop) hit
>    0.14%         38579  L3 miss
>    0.05%          6309  L2 hit
>    0.03%           231  Remote RAM (1 hop) hit
>    0.00%             8  Local RAM hit
>    0.00%             2  Uncached hit
>
> As you can see, 97% of the loads (I am sampling all loads with -c 1: is it true ?) hit the L1 cache. My first question is about this high L1 hit ration and the small number of RAM requests (231 + 8). Is it realistic to have 97% of L1 hit and only 239 RAM accesses when compiling a Linux kernel ?
>
> Writing this email and looking again into Intel SDM I am thinking that the L3 misses are what is called "unknown L3 cache miss in SDM". As a consequence the total number of memory accesses would be L3 miss + Remote RAM + Local RAM, is it correct ?
>
> The second question is the Uncached hit: is it the Un-cacheable memory in the SDM ? If yes, I guess it's also a request to RAM.
>
> Finally, it's not very clear for me what Line Fill Buffer (LFB) is exactly and I was not able to find a pointer explaining that. Do you know where I can read information about this ?
>
> Thanks,
>
> ------
> Manuel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
