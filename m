Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21D2EB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Jul 2023 13:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjGCN2b (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 09:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjGCN2a (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Jul 2023 09:28:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBBD5E58
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Jul 2023 06:28:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53F6B2F4;
        Mon,  3 Jul 2023 06:29:11 -0700 (PDT)
Received: from [10.57.38.97] (unknown [10.57.38.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1D983F73F;
        Mon,  3 Jul 2023 06:28:27 -0700 (PDT)
Message-ID: <0ed20560-a880-9790-a7b2-5089c091fdae@arm.com>
Date:   Mon, 3 Jul 2023 14:28:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: Some questions about using the perf tool in ARM-SPE
To:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>
Cc:     =?UTF-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org
References: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
 <874963e2-f97e-b463-1351-b00640b0f67b@arm.com>
 <CALDTKqg01+xJ2xu218c_QH2PbX9wdhYOiJfDieCXL5PHWV-6FQ@mail.gmail.com>
 <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com>
 <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
 <20230614012102.GJ217089@leoy-huanghe.lan>
 <cf180f9a-085b-ad9b-c477-f02d32559c0a@arm.com>
 <f811f7ce-bf04-b5af-ee33-ea489927649f@arm.com>
 <20230703093913.GA904662@leoy-huanghe>
 <87b24c93-c457-6cec-736f-ab976ee1d608@arm.com>
 <20230703102032.GB904662@leoy-huanghe>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230703102032.GB904662@leoy-huanghe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 03/07/2023 11:20, Leo Yan wrote:
> On Mon, Jul 03, 2023 at 10:42:21AM +0100, James Clark wrote:
> 
> [...]
> 
>>>> This is on the tool side rather than in the kernel. But yes, if the data
>>>> source encoding is the same as the existing ones please send a patch
>>>> adding X4's MIDR to the list.
>>>
>>> I can do this; as elaborated above, I think we need two patches, one is
>>> a kernel patch for adding MIDR and another patch is for perf tool to
>>> consume the MIDR of X4.  I would like to know if this is expected or
>>> not from your side.
>>>
>>
>> Personally I would just add it on the tool side only. If it's not really
>> needed in the kernel then it doesn't make sense to add it.
> 
> Makes sense to me.  I will try to work out a patch, and it's good to not
> break building when kernel adds the same MIDR x4 definition.

Do we somehow sync (copy) the cputype.h for perf tool ? Or do we keep
them in sync with a patch ?

If it is the former, I wouldn't bother about updating the kernel
headers.

Also, how does the perf tool read the midr ? It is safer to read :

/sys/devices/system/cpu/cpu<N>/regs/identification/midr_el1

than relying mrs emulation, which could get you migrated to another CPU
and get a completely different MIDR_EL1 of a little CPU.

Suzuki



> 
> Thanks,
> Leo
> 
>> But I suppose from a consistency point of view we could add it in both
>> places. I'm not too fussed either way.
>>
>>> Thanks,
>>> Leo

