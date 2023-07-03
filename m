Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD0FEB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Jul 2023 08:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjGCIY3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 04:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGCIY2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Jul 2023 04:24:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95534B2
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Jul 2023 01:24:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03BDD1FB;
        Mon,  3 Jul 2023 01:25:10 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4123F73F;
        Mon,  3 Jul 2023 01:24:26 -0700 (PDT)
Message-ID: <f811f7ce-bf04-b5af-ee33-ea489927649f@arm.com>
Date:   Mon, 3 Jul 2023 09:24:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Some questions about using the perf tool in ARM-SPE
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-perf-users@vger.kernel.org
References: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
 <874963e2-f97e-b463-1351-b00640b0f67b@arm.com>
 <CALDTKqg01+xJ2xu218c_QH2PbX9wdhYOiJfDieCXL5PHWV-6FQ@mail.gmail.com>
 <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com>
 <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
 <20230614012102.GJ217089@leoy-huanghe.lan>
 <cf180f9a-085b-ad9b-c477-f02d32559c0a@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <cf180f9a-085b-ad9b-c477-f02d32559c0a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 03/07/2023 09:18, Suzuki K Poulose wrote:
> Hi Leo
> On 14/06/2023 02:21, Leo Yan wrote:
>> Hi,
>>
>> On Tue, Jun 13, 2023 at 09:23:33PM +0800, 蔡沅信 wrote:
>>> OK
>>> I have a new discovery that c2c seems to support only certain Arm
>>> Neoverse (N1/N2/V1) CPUs, I wonder if cortex-X4 could support it?
>>
>> Based on Cortex-X4 TRM [1], we can see Cortex-X4 has the same SPE data
>> source packet format with Neoverse CPUs.  In theory, we can add
>> Cortex-X4's MIDR into the neoverse_spe[] array in
>> tools/perf/util/arm-spe.c to support Cortex-X4.
>>
>> Linux master branch misses the definition for Cortex-X4's MIDR [2],
>> Mark.R / Suzuki / James, could you confirm if Arm has plan or already
>> has patches for enabling Cortex-X4's MIDR?
>>
> 
> Is there a particular reason why need this in the kernel ? Usual
> policy is, kernel needs to distinguish an MIDR, only if it ever
> needs to. e.g, a CPU erratum specific to the MIDR.
> 
> Suzuki>

This is on the tool side rather than in the kernel. But yes, if the data
source encoding is the same as the existing ones please send a patch
adding X4's MIDR to the list.

Thanks
James
