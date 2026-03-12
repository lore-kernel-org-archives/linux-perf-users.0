Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E319378D73;
	Thu, 12 Mar 2026 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327081; cv=none; b=kR2tgZaN4yf6P+y26iUUFrBzt1KuN8ZfdOlVWW39U/dmT7Fgt7/5NRkYZpdfV2dglFwJofNEakW/KPGcBJYPJX3+rcSfg/FkQC3QbPwbumuC50CDymbglUANPxB0R6vHXqnRPx/ABjOtQsxs4w0pvgjhnbw1da12aJwIK/81j7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327081; c=relaxed/simple;
	bh=IGigDOh214Cm6J2XahYE9Uk9kLoJjIgIQvuGX2pEKxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZtuLyep3jqK72Pqx+F/homJOhZHzPXiSN3nrmLBz5XMplxHzWeNd3GvxIOGbqYw/IAvDvEfdqZ20mH1oWA04HLaU78e1lt815eHm3cDbt8sLfdjTgvtR+JilvzTDLZbZ0/hQypOxFoPW1NVA1fP5gwn+MqdWCE+x1R/02IbuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7406F165C;
	Thu, 12 Mar 2026 07:51:13 -0700 (PDT)
Received: from [10.57.59.155] (unknown [10.57.59.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ECD23F7BD;
	Thu, 12 Mar 2026 07:51:18 -0700 (PDT)
Message-ID: <8f72b0f2-d517-4ac6-a593-3b654ac6344d@arm.com>
Date: Thu, 12 Mar 2026 14:51:16 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] ARM DSU PMU: 32-bit counter assumption and handling of
 64-bit event counters
To: Will Deacon <will@kernel.org>, "feng.zhou" <realsummitzhou@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, suzuki.poulose@arm.com
References: <20260206035138.1377-1-realsummitzhou@gmail.com>
 <abLNm2gs8qszYVWK@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <abLNm2gs8qszYVWK@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-03-12 2:28 pm, Will Deacon wrote:
> [+Robin and Suzuki]
> 
> On Fri, Feb 06, 2026 at 11:51:38AM +0800, feng.zhou wrote:
>> Hi Will and Mark,
>>
>> I have a question regarding the ARM DSU PMU driver implementation in
>> drivers/perf/arm_dsu_pmu.c, specifically about the counter width
>> assumptions.
>>
>> Current Implementation:
>> ======================
>> The driver currently assumes all event counters are 32-bit wide, with
>> only the cycle counter being 64-bit (lines 69-71):
>>
>> /* All event counters are 32bit, with a 64bit Cycle counter */
>> #define DSU_PMU_COUNTER_WIDTH(idx)	\
>> 	(((idx) == DSU_PMU_IDX_CYCLE_COUNTER) ? 64 : 32)
>>
>> This assumption is used throughout the code for handling counter
>> overflow and calculating deltas (e.g., line 344 in dsu_pmu_event_update).
>>
>> Issue Observed:
>> ===============
>> I've encountered overflow issues when using perf tools on newer ARM CPUs
>> where the event counters appear to be 64-bit rather than 32-bit. The
>> current implementation causes incorrect event counting and potential data
>> loss due to premature overflow handling based on the 32-bit mask.
> 
> I suspect either the hardware or the architecture have evolved since the
> driver was initially written, possibly in a non-backwards-compatible way
> which is why you see problems.
> 
>> Questions:
>> ==========
>> 1. Is the 32-bit event counter assumption based on the ARMv8 PMU
>>     specification or DSU-specific hardware documentation?
>>
>> 2. Are there known ARM CPU implementations where DSU event counters
>>     exceed 32 bits? If so, how should the driver handle this variation?
>>
>> 3. Would it be appropriate to detect the actual counter width at runtime
>>     (similar to how num_counters is probed in dsu_pmu_probe_pmu), or
>>     should this be handled through device tree / ACPI properties?
>>
>> 4. Should there be a mechanism to query the hardware for the actual
>>     counter width to ensure compatibility with future implementations?
>>
>> Thank you for your time and any insights you can provide.
> 
> Suzuki and Robin should be able to help with these...

Yup, indeed newer DSUs subtly evolved, and the patches are already in 
7.0-rc ;)

Cheers,
Robin.
