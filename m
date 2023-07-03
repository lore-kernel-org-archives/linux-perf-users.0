Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0518EB64DD
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Jul 2023 09:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjGCJm0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 05:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjGCJmX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Jul 2023 05:42:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84137CD
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Jul 2023 02:42:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCCC61FB;
        Mon,  3 Jul 2023 02:43:04 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79F693F762;
        Mon,  3 Jul 2023 02:42:21 -0700 (PDT)
Message-ID: <87b24c93-c457-6cec-736f-ab976ee1d608@arm.com>
Date:   Mon, 3 Jul 2023 10:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Some questions about using the perf tool in ARM-SPE
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        =?UTF-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>,
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
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230703093913.GA904662@leoy-huanghe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 03/07/2023 10:39, Leo Yan wrote:
> Hi Suzuki, James,
> 
> On Mon, Jul 03, 2023 at 09:24:27AM +0100, James Clark wrote:
> 
> [...]
> 
>>>>> I have a new discovery that c2c seems to support only certain Arm
>>>>> Neoverse (N1/N2/V1) CPUs, I wonder if cortex-X4 could support it?
>>>>
>>>> Based on Cortex-X4 TRM [1], we can see Cortex-X4 has the same SPE data
>>>> source packet format with Neoverse CPUs.ï¿½ In theory, we can add
>>>> Cortex-X4's MIDR into the neoverse_spe[] array in
>>>> tools/perf/util/arm-spe.c to support Cortex-X4.
>>>>
>>>> Linux master branch misses the definition for Cortex-X4's MIDR [2],
>>>> Mark.R / Suzuki / James, could you confirm if Arm has plan or already
>>>> has patches for enabling Cortex-X4's MIDR?
>>>
>>> Is there a particular reason why need this in the kernel ? Usual
>>> policy is, kernel needs to distinguish an MIDR, only if it ever
>>> needs to. e.g, a CPU erratum specific to the MIDR.
> 
> Just clarify a bit.  Since Arm SPE data source packet is
> implementation dependent, which means different CPU types can use
> different data source formats, or some CPU variants don't support data
> source packet at all; for this reason, perf tool checks CPU MIDR to
> decide if data source format can be supported or not.
> 
> Now perf tool directly includes kernel header
> arch/arm64/include/asm/cputype.h for CPU MIDR definitions, which is
> why I am asking if any one is working on adding MIDR for Cortex-X4.
> 
>> This is on the tool side rather than in the kernel. But yes, if the data
>> source encoding is the same as the existing ones please send a patch
>> adding X4's MIDR to the list.
> 
> I can do this; as elaborated above, I think we need two patches, one is
> a kernel patch for adding MIDR and another patch is for perf tool to
> consume the MIDR of X4.  I would like to know if this is expected or
> not from your side.
> 

Personally I would just add it on the tool side only. If it's not really
needed in the kernel then it doesn't make sense to add it.

But I suppose from a consistency point of view we could add it in both
places. I'm not too fussed either way.

> Thanks,
> Leo
