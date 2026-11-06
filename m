Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991639;
	b=qkaKvWCnUZfAq7ZhJsfmdGxPLg7xX8s/cLonWLSARo/Y25LNtbMHob5CfgmBg5HT5iRq
	 6Ichp50c8A4dlhHmVvK78snCswW48mbt1BZnW3em4fTrJUFfPkrX76Pdctf5vcRPJj6e3
	 eywb69gr6BVEVVm4sLbgW9ucc9jFZqY+iD3bebhpdF92fzutsnntJtsR6Q2hWXBuxYMjp
	 UY36llRaqaBGATO9vfMOAQMspyZvOwI/C9oIUdP3kfp7e/qsU4hrzIeI2cxzKfidUaq/X
	 BxQFMMMAe00N0VEoLpOqgUHVSA93yMSJlAOaEOz9Zc/INDkVrFi1otVunX8OlEt+A3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991639;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GdNer88pGmusqvGHPd0KumXo7JJ6TTkP7yBHRbdWp1U=;
	b=kgdUy7vDabxGiiSYV4/wW2+YcsIH7/wk8JRIj9AjpQCZbEMtWqNREgY67ClptB3D2pAC
	 EnpLpVIcvo8tXrqAQd4h6oiVDgUWPzDTyMVTMLVD/ZwJdrw3h+Hm/12yQtykU1YNeFQYh
	 k9kIbrVa1j6fHKq66EyxO47hKQu1UPdhKAKtFbBCbhhJzchE1KUjTzE38rAT6jKanPwWI
	 rYkw4dtfWYUKUYEsxmz0hjvu1EqE+YscJS+vi+YLzF5dwoe5lXAuu60fozd3+mlOQd6ka
	 l1DGWgVVSLtKkEAh0N5Pe/kyIjMPpLInC/ZrnvEilBPF1/KvWqwCG3kDSC71dxa1Z1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gAhndznP;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD7E606A329
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 19:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFD7E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gAhndznP
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19EFE1650;
	Fri,  6 Nov 2026 11:00:35 -0800 (PST)
Received: from [10.57.91.130] (unknown [10.57.91.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9DA93F8C6;
	Fri,  6 Nov 2026 11:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793991638; bh=vAhKlaxtIJtUaUUFkf4m71CpxjcFvsJUxlFtiJBAkMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gAhndznPmhH84Ce1OzEMS6hPVXDz/i8OyQ2Wr0uWeGDi7iajMqNXJEBg0HTBmvgJW
	 ETby+lSTbVr0KDsmJFDTwqYz+PShSTlTeUCHUMRiIUPVwtCz3xiApaLRC5RnLDiOip
	 TWSPjbT87taelDQUbsmXZDmDh1+4i8yDfQUVNdnk=
Message-ID: <4111d978-5277-46e5-82a4-dd92bc7099da@arm.com>
Date: Fri, 6 Nov 2026 19:00:35 +0000
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
Subject: Re: [PATCH v4 2/4] perf: Add Arm Bus Monitor Unit driver
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1793986672.git.robin.murphy@arm.com>
 <7bf3b15677548c7e0c88aa03fa18a2b5673ab363.1793986672.git.robin.murphy@arm.com>
 <sashiko-outbox-202020@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <sashiko-outbox-202020@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-11-06 6:23 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] perf: arm-bmu: driver omitted when
>    ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU is n or m
> --
> 
> commit 0be62f2184bd603abec9ec13cdc4790db8588fea
> Author: Robin Murphy <robin.murphy@arm.com>
> 
> perf: Add Arm Bus Monitor Unit driver
> 
> This commit adds a perf driver for Arm's Bus Monitor Unit in
> drivers/perf/arm_cspmu/ to support transaction matching and counting across
> interface monitoring units.
> 
>> diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
>> index 25bd55f036a4f..48c2a3ac7fab5 100644
>> --- a/drivers/perf/arm_cspmu/Kconfig
>> +++ b/drivers/perf/arm_cspmu/Kconfig
>> @@ -34,3 +34,9 @@ config ARM_SYSTEM_PMU
>>   	help
>>   	  Support additional event filtering attributes for the CoreSight-based
>>   	  PMU blocks found in various parts of Arm Compute Subsystems and SoCs.
>> +
>> +config ARM_BMU
>> +	tristate "ARM Bus Monitor Unit"
>> +	depends on (ARM64 && ACPI) || COMPILE_TEST
>> +	help
>> +	  Support perf event counting on Arm Bus Monitor Unit devices.
>> diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
>> index 90c3cd7101577..4e0b420a2b55f 100644
>> --- a/drivers/perf/arm_cspmu/Makefile
>> +++ b/drivers/perf/arm_cspmu/Makefile
>> @@ -9,3 +9,5 @@ arm_cspmu_module-y := arm_cspmu.o
>>   obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += nvidia_cspmu.o
>>   obj-$(CONFIG_AMPERE_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += ampere_cspmu.o
>>   obj-$(CONFIG_ARM_SYSTEM_PMU) += arm_syspmu.o
>> +
>> +obj-$(CONFIG_ARM_BMU) += arm-bmu.o
> 
> [Severity: Medium]
> Will arm-bmu.o be skipped during the build when
> CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU is disabled or modular?
> 
> Unlike the other drivers in this directory, CONFIG_ARM_BMU does not depend on
> CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU, but drivers/perf/Makefile only
> descends into arm_cspmu/ via:
> 
> drivers/perf/Makefile:
> 	obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
> 
> When CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=n, Kbuild never enters
> drivers/perf/arm_cspmu/ and arm-bmu.o is not built at all; when
> CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=m and CONFIG_ARM_BMU=y, arm_cspmu/
> is only visited for modules and the built-in arm-bmu driver is omitted from
> vmlinux.
> 
> drivers/perf/Makefile should also add arm_cspmu/ for CONFIG_ARM_BMU (or use
> obj-y += arm_cspmu/).
> 

Unlikely to be an issue in practice for the moment, as the users who 
want arm-bmu also want arm_syspmu anyway (did you notice I sent them 
together as a series?). However the existing double-conditional 
compilation does seem a bit silly in general, so I've sent a quick patch 
to clean that up separately.

Thanks,
Robin.
