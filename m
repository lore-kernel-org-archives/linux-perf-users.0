Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D6A3B2D18
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215688; cv=none; b=mfmCYzfGBquH06LhqsBFWhkrEyBbcggSEpk8Azv9i5Xifj8Vg/Da7qcd1KqRH9uBMEHdBdCJNEIVI+4NcCq3ZmiLiWTYANrId+xa55gu6bbdeB1tnau2x2ga3vRYgQJS5BXKoOChAm7zZn/8odoxAgRIqg+G/MJu4k0UkDeJpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215688; c=relaxed/simple;
	bh=809ruM8KHwNVUwrselu9Kq2eEuZT7S38/y3Gneb2S/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6noLNcTLC/rXkoN4gqvW/x8X8m5DP9runy0BxvYX7rb88ZMyDqrfRBej+u9F4tKh7ddGCkzqXqToMleIAO+kF+V8VgwDFne4e4Py9uxDAKod6mfIGUAl8NG+/QX6ZRQ1FLPtnzYqcck+TRGsHuThVjq2QaA5MolATAbus66nD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UJ3gg+2A; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UJ3gg+2A"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AACDB2B;
	Thu, 16 Jul 2026 08:28:00 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B71E3F66F;
	Thu, 16 Jul 2026 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784215684; bh=809ruM8KHwNVUwrselu9Kq2eEuZT7S38/y3Gneb2S/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UJ3gg+2A4BlR5ZigTTiTkUqOdRIZXfgYvtp7yLO5S+2aVKeliqVPy4NAWiiLXcr7e
	 RCYxvbf2DHCDW6dd4w2hMm7apHiPqi+Vkow8AFDa+U5DXdIeVfHKajAxq2EUv0I5Sh
	 mAHAquV9xh5v5q+uqhHoM9y1HNVja2aGUy0+jfC4=
Message-ID: <4beec7e5-51b8-4fbd-978e-938ede8d3b77@arm.com>
Date: Thu, 16 Jul 2026 16:27:59 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] perf/arm_cspmu: Make IRQ more optional
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1784213435.git.robin.murphy@arm.com>
 <a6bb2c54e91712e91f95d21051d2b4b173cebc93.1784213435.git.robin.murphy@arm.com>
 <20260716151124.7AC9B1F000E9@smtp.kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260716151124.7AC9B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/2026 4:11 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [High] Unconditional swallowing of `arm_cspmu_request_irq()` error codes (such as `-EPROBE_DEFER` and `-ENOMEM`) for PMUs with >= 64-bit counters.
> 
> Pre-existing issues:
> - [High] Incorrect ordering between CPU hotplug state management and PMU registration causes Use-After-Free during teardown.
> - [High] Missing cleanup of CPU hotplug state if `platform_driver_register()` fails in module init.
> - [High] Failed `driver_attach()` in `arm_cspmu_impl_register()` leaves dangling pointers in the `impl_match` array.
> - [High] Stack-allocated bitmap cast to `u32 *` leaves memory uninitialized on Big Endian systems, causing reads of uninitialized stack memory.
> --
> 
> --- Patch [4]: [PATCH v2 4/4] perf/arm_cspmu: Make IRQ more optional ---
> commit e7afdbca83ffd562889abdf4a15a47f1af9fc395
> Author: Robin Murphy <robin.murphy@arm.com>
> 
> perf/arm_cspmu: Make IRQ more optional
> 
> This commit allows the driver to continue probing even if it fails to
> request an IRQ, provided the PMU has 64-bit counters. It assumes that
> 64-bit counters will not overflow in a realistic timeframe.
> 
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index 385d3e34694f2..007038aa7e9a6 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -1256,8 +1256,11 @@ static int arm_cspmu_device_probe(struct platform_device *pdev)
>>   		return ret;
>>   
>>   	ret = arm_cspmu_request_irq(cspmu);
>> -	if (ret)
>> -		return ret;
>> +	if (ret) {
>> +		if (counter_size(cspmu) < 64)
>> +			return ret;
> 
> [Severity: High]
> Does this unintentionally swallow error codes like -EPROBE_DEFER or
> -ENOMEM for 64-bit PMUs?

No. It does that *intentionally* - this is literally the entire point of 
the patch. If there is an IRQ and we can claim it for the sake of 
correctness then fine, but since in practice we'll never use it, there 
is no point worrying about any error, including a missing interrupt 
controller driver that might otherwise defer forever.

Robin.
