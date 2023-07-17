Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEB9EB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Jul 2023 09:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjGQJFO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Jul 2023 05:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGQJFM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Jul 2023 05:05:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC856E55
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jul 2023 02:05:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEE7ED75;
        Mon, 17 Jul 2023 02:05:53 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77F853F73F;
        Mon, 17 Jul 2023 02:05:09 -0700 (PDT)
Message-ID: <14ebfd67-02e1-72a5-38fa-119a2886a268@arm.com>
Date:   Mon, 17 Jul 2023 10:05:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Some questions about using the perf tool in ARM-SPE
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, Namhyung Kim <namhyung@gmail.com>
Cc:     James Clark <james.clark@arm.com>,
        =?UTF-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com>
 <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
 <20230614012102.GJ217089@leoy-huanghe.lan>
 <cf180f9a-085b-ad9b-c477-f02d32559c0a@arm.com>
 <f811f7ce-bf04-b5af-ee33-ea489927649f@arm.com>
 <20230703093913.GA904662@leoy-huanghe>
 <87b24c93-c457-6cec-736f-ab976ee1d608@arm.com>
 <20230703102032.GB904662@leoy-huanghe>
 <0ed20560-a880-9790-a7b2-5089c091fdae@arm.com>
 <CAM9d7chz+7szVG8-XWrFGyiCPXFRc2zfq8s7VqMcqx3J7QCeyQ@mail.gmail.com>
 <20230717055713.GA79840@leoy-huanghe.lan>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230717055713.GA79840@leoy-huanghe.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 17/07/2023 06:57, Leo Yan wrote:
> Hi Suzuki,
> 
> On Wed, Jul 05, 2023 at 10:33:18AM -0700, Namhyung Kim wrote:
>> On Mon, Jul 3, 2023 at 6:33 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>> On 03/07/2023 11:20, Leo Yan wrote:
>>>> On Mon, Jul 03, 2023 at 10:42:21AM +0100, James Clark wrote:
> 
> [...]
> 
>>> Do we somehow sync (copy) the cputype.h for perf tool ? Or do we keep
>>> them in sync with a patch ?
>>>
>>> If it is the former, I wouldn't bother about updating the kernel
>>> headers.
>>
>> In general, perf tool has a copy of kernel headers and there's a script
>> called check-headers.sh to verify they are in sync.  We don't
>> recommend kernel patches to touch the tool's copy.  And it's done
>> by tool devs separately.
> 
> We have the kernel header arch/arm64/include/asm/cputype.h, tools have a
> copy which is placed in tools/arch/arm64/include/asm/cputype.h.
> 
> As Namhyung explained, usually the kernel header is firstly changed and
> then the tool developers send a separate patch to sync with kernel
> header.  You could see a recent example by Arnaldo's patch [1].
> 
> By following this working model, I sent patch series to add Cortex-X4
> CPU part and MIDR definitions.  I personally think this is the best
> way for us to keep the alignment between the kernel header and tools
> header [2].  Please let me know if this doable or not?
Sure, if the tool relies on syncing the kernel headers, thats fine.

> 
> Sorry for late response due to vacation :)

No worries, I will dig the series from the mailing list and
respond there. Thanks for sending this out.

Suzuki

> 
> Thanks,
> Leo
> 
> [1] https://lore.kernel.org/lkml/ZLFQ%2Ftu%2FATQwDEIW@kernel.org/
> [2] https://lore.kernel.org/lkml/20230717054327.79815-1-leo.yan@linaro.org/

