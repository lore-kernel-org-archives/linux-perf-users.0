Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6940D593
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jun 2026 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781915499; cv=none; b=kyuVDZhLKeM+VdU5ofDQdFIpmpZLS8LlCEyqfc607FUpMjHOFIJGw5BcJAxn7DF+qCIsjcW3X4GO7c+cPVIdMjf1tLJtRwenaQNGKBcPh83y2T32dJNzXj/XiK7LOSAXVcVsG7bZlV7ny2ciXELtTfBjZoUYJi3JjoCdtuN4FEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781915499; c=relaxed/simple;
	bh=aP9VryteV0sGRUsKxpGorBjNrL5CCCl/ru2DhVAzob8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUzVoU/7OYQuqPCQR+n5eU5E95Qya56FDGCvmIyZxsvO361XPWQXOt+4Znyaw/LogNxnNZmHR59OB53yUPv+zQKUmhN9BFs7NF+85MpDObGdOVeDYU0XIng2LsXhoEe+NhLCLgrkKa4TkFZvyGtdwqPnG04Rgf3AsM7qKmbVHBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lGCbwe3u; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lGCbwe3u"
Message-ID: <f888c7e9-fd4f-4ebf-baff-e45df3ef68c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781915485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INRG9hgCacGXfMNt5+OlD3xAOOeoBTUlZ1ygCBSn3Qo=;
	b=lGCbwe3uB7WEz9IIUwSfRnms2Jl5mzPvYnBXo24ItKN/LOf4qvkJy3VtkZHAnXl5K0YUhp
	nxcP7Z72bTpo28XFBLPPQJbyUbPBjWT0NDdDCMIlMmeJj3rFCa9symVsVPUdBejjErSWAB
	JdnH394iP5vdzsoLQO89c9CnFk6EeDg=
Date: Fri, 19 Jun 2026 17:31:12 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 11/21] RISC-V: perf: Modify the counter discovery
 mechanism
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org
References: <20260608-counter_delegation-v6-11-285b72ed65a9@meta.com>
 <20260609061751.59CD71F00898@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260609061751.59CD71F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/8/26 11:17 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Negative error codes returned by SBI are improperly cast to an unsigned integer, and systems with >64 counters are incorrectly aborted instead of clamped.
> --
>
> commit ea0f7376968d4f5943d9d279886b0b59e6dfd41c
> Author: Atish Patra <atishp@rivosinc.com>
> Subject: RISC-V: perf: Modify the counter discovery mechanism
>
> This commit modifies the PMU counter discovery mechanism to use a hybrid
> scheme. It utilizes counter delegation for hardware PMU counters while falling
> back to the SBI PMU for firmware counters, and updates logging appropriately.
>
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 7f21c16003f04..57ab15beab3e1 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
> [ ... ]
>
>> @@ -1159,16 +1180,42 @@ static void rvpmu_ctr_stop(struct perf_event *event, unsigned long flag)
>>   	/* TODO: Counter delegation implementation */
>>   }
>>   
>> -static int rvpmu_find_num_ctrs(void)
>> +static int rvpmu_find_ctrs(void)
>>   {
>> -	return rvpmu_sbi_find_num_ctrs();
>> -	/* TODO: Counter delegation implementation */
>> -}
>> +	u32 num_sbi_counters = 0, num_deleg_counters = 0;
>> +	u32 num_hw_ctr = 0, num_fw_ctr = 0, num_ctr = 0;
>> +	/*
>> +	 * We don't know how many firmware counters are available. Just allocate
>> +	 * for maximum counters the driver can support. The default is 64 anyways.
>> +	 */
>> +	pmu_ctr_list = kcalloc(RISCV_MAX_COUNTERS, sizeof(*pmu_ctr_list),
>> +			       GFP_KERNEL);
>> +	if (!pmu_ctr_list)
>> +		return -ENOMEM;
>>   
>> -static int rvpmu_get_ctrinfo(int nctr, unsigned long *mask)
>> -{
>> -	return rvpmu_sbi_get_ctrinfo(nctr, mask);
>> -	/* TODO: Counter delegation implementation */
>> +	if (riscv_pmu_cdeleg_available_boot())
>> +		num_deleg_counters = rvpmu_deleg_find_ctrs();
>> +
>> +	/* This is required for firmware counters even if the above is true */
>> +	if (riscv_pmu_sbi_available_boot())
>> +		num_sbi_counters = rvpmu_sbi_find_num_ctrs();
>> +
>> +	if (num_sbi_counters > RISCV_MAX_COUNTERS || num_deleg_counters > RISCV_MAX_COUNTERS)
>> +		return -ENOSPC;
> [Severity: High]
> Does this code inadvertently convert negative error codes from
> rvpmu_sbi_find_num_ctrs() into large unsigned values?
>
> Since num_sbi_counters is defined as a u32, if rvpmu_sbi_find_num_ctrs()
> returns an error code like -EOPNOTSUPP, it will wrap to a large positive
> integer, instantly satisfying the > RISCV_MAX_COUNTERS condition. This seems
> to mask the original error code.
>
> If the > RISCV_MAX_COUNTERS condition is met, the function returns -ENOSPC
> early. Can this leak the pmu_ctr_list allocated via kcalloc() just above,
> since there is no free before the return?

Valid. Fixed in v7.

> Additionally, could this introduce a regression for platforms legitimately
> exposing more than 64 counters? Previously, the driver appeared to safely
> clamp the usable count to 64 and continue, whereas this new logic seems to
> abort the driver probe entirely.

That's the current max counter supported by the driver. So it is fine to 
abort

until such a case arises to avoid confusion.

> [ ... ]
>
