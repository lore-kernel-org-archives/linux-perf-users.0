Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495EFC04A68
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Jul 2022 12:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbiG1M3F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 08:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbiG1M3E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Jul 2022 08:29:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31E4161734;
        Thu, 28 Jul 2022 05:29:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72FFE106F;
        Thu, 28 Jul 2022 05:29:04 -0700 (PDT)
Received: from [10.1.31.137] (e127744.cambridge.arm.com [10.1.31.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 709313F73B;
        Thu, 28 Jul 2022 05:29:02 -0700 (PDT)
Subject: Re: [PATCH] perf/tests: Fix test case 95 on s390 and use same event
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, james.clark@arm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
References: <20220727141439.712582-1-tmricht@linux.ibm.com>
 <3dc28d5e-46ce-fd33-82c1-4e27b60dfef0@arm.com>
 <550e7e9f-19cb-0b1f-fd3e-f0d958b4e75b@linux.ibm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <3cb2c002-e4e3-c7b4-148d-5e2d0c406b84@arm.com>
Date:   Thu, 28 Jul 2022 13:28:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <550e7e9f-19cb-0b1f-fd3e-f0d958b4e75b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 28/07/2022 13:20, Thomas Richter wrote:
> On 7/28/22 11:25, German Gomez wrote:
>> Thanks for the fix, Thomas
>>
>> On 27/07/2022 15:14, Thomas Richter wrote:
>>> On linux-next tree perf test 95 was added recently.
>>> s390 does not support branch sampling at all and the test case fails
>>> despite for checking branch support before hand.
>>> The check for support of branching
>>> uses the software event named dummy, as seen in the line:
>>>
>>>  perf record -b -o- -e dummy -B true > /dev/null 2>&1 || exit 2
>> Just curious, do you know why the command succeeds in this platform (and
>> potentially others)?
>>
>> I got the idea of using "dummy" from [1] but only tested on arm64 and
>> x86. I thought the platforms would reject it if -b was not implemented
>> regardless of the event. Did I misunderstand the use of dummy?
>>
>> Thanks,
>> German
>>
>> [1] https://lore.kernel.org/all/20220617073840.GA45710@leoy-ThinkPad-X240s/
>>
> Well, dummy is a predefined event of type software, you see that when you add
> some -v options as in 
> # perf record -e dummy -vvv
> DEBUGINFOD_URLS=
> Using CPUID IBM,3931,704,A01,3.7,002f
> nr_cblocks: 0
> affinity: SYS
> mmap flush: 1
> comp level: 0
> ------------------------------------------------------------
> perf_event_attr:
>   type                             1      <----------- type 1 is software
>   size                             128
>   config                           0x9
>   { sample_period, sample_freq }   4000
>
>
> So this event is never sent to an hardware PMU (which would have type 0) and thus
> mostly succeeds where as the perf record command without event uses default
> event cycles. And that one is sent to hardware PMU on s390...

Thanks for explaining! My bad for missing this.

Acked-by: German Gomez <german.gomez@arm.com>

>
