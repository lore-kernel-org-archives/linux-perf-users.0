Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443722343C5;
	Tue, 18 Feb 2025 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874710; cv=none; b=JE2ScuwlEDYV0s1fiDN5yByC4hZxnLHT39KxnCdznSC73Rn+oz7WaQQiIZx7CnzWics0vxaHU/NY3PwJnMRKF5ChGXGQ4vf4L6TFYgnYktg+3CwL/FkAqODQ5ajZlgRklaaewuQnjS2b1NXocY8fpVs4iG0HpegFSUI172kVrRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874710; c=relaxed/simple;
	bh=qPKoMG2CpPHMmPIEpvnZcV7HmhE7XE3gK1J58Dp7ywk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpMJvumLfaUmiKIq6E9LOKFlYrRFqGUSB8GqT/9W02yF+ioNvuK5H25RUfPB8y7gdQ8sqM3+/GpDf4wFpK118gz0NokZqDLtoB3H2NNb/Awac1UWS+Crfzr4mN2D8dI8bOtfOScyFNNV8cmKeLDyO7XhRPFsgPx0K45E+5/0osc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82F5C13D5;
	Tue, 18 Feb 2025 02:32:07 -0800 (PST)
Received: from [10.57.39.83] (unknown [10.57.39.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DDB23F6A8;
	Tue, 18 Feb 2025 02:31:46 -0800 (PST)
Message-ID: <d5040b5c-564d-4abf-be22-d2aa1183b633@arm.com>
Date: Tue, 18 Feb 2025 10:31:42 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: don't claim resource during ioremap() for
 CMN700 with ACPI
To: Yin Fengwei <fengwei_yin@linux.alibaba.com>, will@kernel.org,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jie.li.linux@linux.alibaba.com
References: <20250218012111.30068-1-fengwei_yin@linux.alibaba.com_quarantine>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250218012111.30068-1-fengwei_yin@linux.alibaba.com_quarantine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-18 1:21 am, Yin Fengwei wrote:
> Currently, arm-cmn PMU driver assumes ACPI claim resource
> for CMN600 + ACPI. But with CMN700 + ACPI, the device probe
> failed because of resource claim failes when ioremap() is
> called:
> [   10.837300] arm-cmn ARMHC700:00: error -EBUSY: can't request region for resource [mem 0x40000000-0x4fffffff]
> [   10.847310] arm-cmn ARMHC700:00: probe with driver arm-cmn failed with error -16
> [   10.854726] arm-cmn ARMHC700:02: error -EBUSY: can't request region for resource [mem 0x40040000000-0x4004fffffff]
> [   10.865085] arm-cmn ARMHC700:02: probe with driver arm-cmn failed with error -16
> 
> Let CMN700 + ACPI do same as CMN600 + ACPI to allow CMN700
> work in ACPI env.

No, the CMN-600 routine is a special case for CMN-600 having two nested 
memory resources of its own. CMN-700 and everything else only have one 
memory resource, so that is not appropriate. What else is claiming the 
region to cause a conflict?

Thanks,
Robin.

> Signed-off-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> ---
> I am also wondering whether we could just drop the CMN600 part id
> check here if ACPI companion device claimed the resource?
> 
>   drivers/perf/arm-cmn.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index ef959e66db7c..8b5322a2aa6e 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2559,7 +2559,8 @@ static int arm_cmn_probe(struct platform_device *pdev)
>   	cmn->part = (unsigned long)device_get_match_data(cmn->dev);
>   	platform_set_drvdata(pdev, cmn);
>   
> -	if (cmn->part == PART_CMN600 && has_acpi_companion(cmn->dev)) {
> +	if (((cmn->part == PART_CMN600) || (cmn->part == PART_CMN700)) &&
> +			has_acpi_companion(cmn->dev)) {
>   		rootnode = arm_cmn600_acpi_probe(pdev, cmn);
>   	} else {
>   		rootnode = 0;
> @@ -2649,7 +2650,7 @@ MODULE_DEVICE_TABLE(of, arm_cmn_of_match);
>   static const struct acpi_device_id arm_cmn_acpi_match[] = {
>   	{ "ARMHC600", PART_CMN600 },
>   	{ "ARMHC650" },
> -	{ "ARMHC700" },
> +	{ "ARMHC700", PART_CMN700 },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(acpi, arm_cmn_acpi_match);

