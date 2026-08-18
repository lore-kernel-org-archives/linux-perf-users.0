Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C85446C4D9
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052756; cv=none; b=rxgv9+wNvZKUqL5vbI8XX1vi6oAT7EfymHRowLqQNDDEXYo2kZJOMpyK4M/AHB/89vBP1GJIQQbtSnCYTwWM/lUw6fGH4fcoThJNKrvFF0WmREzSYauU7YE4Wts8W2XQRZ0154c+n678sTS2PKhXq6z6fOGKyIvsr9ruo2BRl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052756; c=relaxed/simple;
	bh=oQLpwDfYoframDn/RhUR9AsGkJf1wgM3k0ZHmqUz+T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WqF1ZxYwUVuPT/nX8GykqErAcoUIVRgcZKzUWq+RU0lH3Upqv9IJD1BmItpoT/fuPKvLdXoWyMotLTJsBIA9MUYWiH+yIorz3gQ33nGZIYpOQq2wF+i1IynGjj3obOX2CMV7HAAIiUzdNGUHkDjURN/SJ7FXARCgKdmwPAwt0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hPSGl3FZQz1JMH4;
	Tue, 18 Aug 2026 19:32:15 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hPSGh6rm9z1JMH4;
	Tue, 18 Aug 2026 19:32:12 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 83C82B369;
	Tue, 18 Aug 2026 19:32:08 +0800 (CST)
Received: from [172.25.61.61] (172.25.61.61) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 18 Aug
 2026 19:32:13 +0800
Message-ID: <9bf245a2-43ea-440b-b980-317dc542d67a@hygon.cn>
Date: Tue, 18 Aug 2026 19:32:13 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] perf/x86/amd/uncore: Add Hygon uncore PMU support
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-perf-users@vger.kernel.org>
References: <20260818100118.12944-1-liuqi@hygon.cn>
 <20260818100118.12944-2-liuqi@hygon.cn>
 <20260818101627.5424B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Qi Liu <liuqi@hygon.cn>
In-Reply-To: <20260818101627.5424B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

Hi

On 8/18/2026 6:16 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Removal of Hygon L3 Uncore PMU support without a replacement in the new driver.
> --
> 
> --- Patch [1]: [PATCH v5 1/2] perf/x86/amd/uncore: Add Hygon uncore PMU support ---
> commit 1b6dd18387bea20f9f548951bf79cae006705b47
> Author: Qi Liu <liuqi@hygon.cn>
> 
> perf/x86/amd/uncore: Add Hygon uncore PMU support
> 
> This commit introduces a separate uncore PMU driver for Hygon processors to
> support Data Fabric (DF) and Data Fabric IO Die (DF_IOD) counters. It also
> removes the Hygon vendor checks from the AMD uncore driver to keep the
> vendor-specific features separated.
> 
>> diff --git a/arch/x86/events/amd/hygon_uncore.c b/arch/x86/events/amd/hygon_uncore.c
>> new file mode 100644
>> index 0000000000000..471955d6fc282
>> --- /dev/null
>> +++ b/arch/x86/events/amd/hygon_uncore.c
> 
> [ ... ]
> 
>> +static struct hygon_uncore uncores[HYGON_UNCORE_TYPE_MAX] = {
>> +	/* HYGON DF */
>> +	{
>> +		.scan = hygon_uncore_df_ctx_scan,
>> +		.init = hygon_uncore_df_ctx_init,
>> +		.move = hygon_uncore_ctx_move,
>> +		.free = hygon_uncore_ctx_free,
>> +	},
>> +	/* HYGON DF IOD */
>> +	{
>> +		.scan = hygon_uncore_df_iod_ctx_scan,
>> +		.init = hygon_uncore_df_iod_ctx_init,
>> +		.move = hygon_uncore_ctx_move,
>> +		.free = hygon_uncore_ctx_free,
>> +	}
>> +};
> 
> [ ... ]
> 
>> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
>> index dbc00b6dd69ee..6c486e1ab001a 100644
>> --- a/arch/x86/events/amd/uncore.c
>> +++ b/arch/x86/events/amd/uncore.c
> 
> [ ... ]
> 
>> @@ -1120,8 +1116,7 @@ static int __init amd_uncore_init(void)
>>   	int ret = -ENODEV;
>>   	int i;
>>   
>> -	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
>> -	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
>> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>>   		return -ENODEV;
>>   
>>   	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
> 
> [Severity: Medium]
> Does this inadvertently remove L3 uncore PMU support for Hygon systems?
> 
> Removing the Hygon vendor check in amd_uncore_init() prevents the AMD uncore
> driver from initializing on Hygon CPUs, which previously provided L3 cache PMU
> support.
> 
> Looking at the new driver in hygon_uncore.c, the uncores[] array only
> implements the DF and DF_IOD components. It does not appear to provide a
> replacement for the L3 cache PMU that was previously available.
> 
L3 and UMC PMU support for Hygon will be added in follow-up series. This series 
focuses specifically on Data Fabric uncore PMU support as the initial step.

Thanks,
Qi

