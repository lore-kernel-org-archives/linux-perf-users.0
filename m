Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989913;
	b=SWpvmtvw2Jevs9wXN1cq0oYIkfLCG+ozDTa6NeY4nr9nc4pPZaJh1CC5NmSx+AQVutIH
	 V82L4FewhTBewR2B63zWSvxF47SqPmtOfOJq/GyGPRr6zxmY0HwHZzWjdURnWsikstuhX
	 RKapc5+JGz/iTgQ8hda9uIE7rZGkhORUDQGg3JMvHjlWjce+cWC+clRZkXeft8I9TZkCo
	 zFg0/8iOQHKP7Fj4Aok+4ekjlwOOUC9vYYOR+fW+6ASxVtUTBAKq8ggeJT/w3u8d7SYBB
	 Lasf0TQ7YGQWZM7Nb/0vZbXaEiTynkq95iryuAMWzSC0vJeTOhMPzblDa1458GqMeug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989913;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Y5WQ/M1+RHkh0LOByno43m5sDI3jNIMmkTA0JIJi3zQ=;
	b=FgZ1QXOrRR3TmpRaBWn1rz7vlGP+6IXhF9xlj2JOUOx0Qro3rCsrmrOtO/w6ugByDhwF
	 A0y4Fkkl/JgpCOfkwGDpicR3mtd2hWa3nO2sPO/mG4pwttnAN4NyQ65hZJZrSbxWLTcHu
	 l/6kEAYOcGFj3ytYgrknyeTwB6FSuKVWJtMGAVPYU6L1wXpILNLfXGjJUBTAoCtdSHb0k
	 jC1n1WLu+qcieLmb3uMHXItRwN339PORIFyTy1S0qIE8LmN+7c0Www8pdKt+SgH2sAQq4
	 PvQ7aaoQW+gHtJOTKE8xjbwJLLvAO4FJwuXaMbKBG+yYWBO9Qv6W4iFfjn1XZGKdHKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VzEAUNRD;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA4606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 18:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DDA4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VzEAUNRD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78C001650;
	Fri,  6 Nov 2026 10:31:48 -0800 (PST)
Received: from [10.57.91.130] (unknown [10.57.91.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 069A33F673;
	Fri,  6 Nov 2026 10:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793989911; bh=3Dn9EDzzMxdd+CgUKLKWiOQ+dJK8ULASfykEi2qFJVE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VzEAUNRDKEfyhDli+MoEgjFcbKO48IOqGNw+ErE6LqW+IghrqezO6h5A9xbKfPYqA
	 4AsFsk9b1Hf2yY6GpsYhQ6tK+j99nQVxInfqWQlfSZ1tAPyYJbYZ2vz9Ra/tekBBNF
	 HPhHvG6oSQaKmM6DefzOfbDuAg2Z694BGw4Xqdq0=
Message-ID: <20ab965b-bbe0-4550-be16-24e104e2dac4@arm.com>
Date: Fri, 6 Nov 2026 18:31:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] perf/arm_cspmu: Add Arm system PMU
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1793986672.git.robin.murphy@arm.com>
 <2cf79599d522539440a53adb4221dfc5a4d7b9e6.1793986672.git.robin.murphy@arm.com>
 <sashiko-outbox-202006@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <sashiko-outbox-202006@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-11-06 6:17 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] perf/arm_cspmu: arm_cspmu_init_impl_ops() defers probe when
>    ARM_SYSTEM_PMU=n
> --
> 
> commit ae4570e49b496427e88dd55c46f9506b33a8b68e
> Author: Robin Murphy <robin.murphy@arm.com>
> 
> perf/arm_cspmu: Add Arm system PMU
> 
> This commit adds the arm_syspmu backend module to support an additional
> 64-bit event filter register (PMEVFILT3R) on Arm system PMUs with product
> ID 0x9c3.
> 
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index 912f03ce3ef5f..9f298ea1a9745 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -358,6 +358,13 @@ static struct arm_cspmu_impl_match impl_match[] = {
>>   		.module		= NULL,
>>   		.impl_init_ops	= NULL,
>>   	},
>> +	{
>> +		.module_name	= "arm_syspmu",
>> +		.pmiidr_val	= ARM_CSPMU_IMPL_ID_ARM,
>> +		.pmiidr_mask	= PMIIDR_IMPLEMENTER,
>> +		.module		= NULL,
>> +		.impl_init_ops	= NULL,
>> +	},
>>   	{
>>   		.module_name	= "ampere_cspmu",
>>   		.pmiidr_val	= ARM_CSPMU_IMPL_ID_AMPERE,
> 
> [Severity: Medium]
> Does adding an unconditional impl_match[] entry for ARM_CSPMU_IMPL_ID_ARM
> cause arm_cspmu_init_impl_ops() to defer probing indefinitely when
> CONFIG_ARM_SYSTEM_PMU is disabled?
> 
> Previously, CoreSight PMUs with Arm's implementer ID did not match any
> entry in impl_match[] and probed using the generic ops.  With this entry
> present, arm_cspmu_init_impl_ops() requires the arm_syspmu module to
> register match->impl_init_ops:
> 
> drivers/perf/arm_cspmu/arm_cspmu.c:arm_cspmu_init_impl_ops() {
>      ...
> 		if (match->impl_init_ops) {
>      ...
> 		} else {
> 			request_module_nowait(match->module_name);
> 			ret = dev_err_probe(cspmu->dev, -EPROBE_DEFER,
> 					    "Waiting for module %s to load\n",
> 					    match->module_name);
> 		}
>      ...
> }
> 
> Because CONFIG_ARM_SYSTEM_PMU has no default in Kconfig, existing configs
> with CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU enabled will have
> CONFIG_ARM_SYSTEM_PMU=n, leaving every Arm-implemented CoreSight PMU
> (including non-0x9c3 devices where arm_syspmu_init_ops() is a no-op)
> permanently stuck in -EPROBE_DEFER.

Sure, let me know what other Arm Ltd. PMU implementations those are, and 
I'll get back to you with how much I care...

Plus there's nothing here that's any different from the existing Ampere 
and NVIDIA cases. Perhaps we could #ifdef the impl_match entries if 
anyone really thought it mattered, but that would be a general matter 
for the arm_cspmu framework itself, not this patch.

Thanks,
Robin.
