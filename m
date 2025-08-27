Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7184C28980F;
	Wed, 27 Aug 2025 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303572; cv=none; b=tvhFygYzzovRo7WcQUVJmbDgnMHDrXPHr4uITQHshaYmkGxyq1oQsZsq6wI9CgiLMhn6vVhHza7cKVtyGoVgPGUVPmkkPYF3/HgoJeTg8gUAWAm8Cw0WmeJCg6jM2fTBihaEYoUGwFg3kP2MWGI7ybax4Sdfw4PWo1A9J4oeLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303572; c=relaxed/simple;
	bh=3nKQ5Cu61oSMTavvRwK7vBHJ2eUEUXbnTlX4/jxGPkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7m0Ro8bzGPAtNu6NyqVyVWrp0xsQhMtDoAyAl9Wl9hri76h0Ynjp06s0HXHtD5fv6nPoI7/c1J0ZBUNelG7Om9waxfekgEFq1fFEM7Fo0PFEQVkOgPxHlO3ck9T46+uV0SPTEeGWJFeCsmljoKuT1A+XhbQKD+atFaiZL2dB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69F6C2720;
	Wed, 27 Aug 2025 07:06:01 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF29D3F738;
	Wed, 27 Aug 2025 07:06:08 -0700 (PDT)
Message-ID: <2c6d68da-fd1a-4b59-8bfc-5e1c66ceaebe@arm.com>
Date: Wed, 27 Aug 2025 15:05:58 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: perf: use us_to_ktime() where appropriate
To: Mark Rutland <mark.rutland@arm.com>, Xichao Zhao <zhao.xichao@vivo.com>
Cc: will@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250813083257.504573-1-zhao.xichao@vivo.com>
 <aK7RkB5p6L17Ffuw@J2N7QTR9R3>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aK7RkB5p6L17Ffuw@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2025 10:36 am, Mark Rutland wrote:
> [adding Robin and LAKML]
> 
> On Wed, Aug 13, 2025 at 04:32:57PM +0800, Xichao Zhao wrote:
>> The arm_ccn_pmu_poll_period_us are more suitable for using
>> the us_to_ktime(). This can make the code more concise and
>> enhance readability.
>>
>> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> 
> Superficially this looks fine to me, so:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Will, I assume that (if no-one complains) you'll pick this up when
> queueing PMU patches.

Yup, the new helper looks entirely appropriate here. We could perhaps 
take this opportunity to drop the unnecessary cast as well though, since 
automatic promotion from unsigned int to u64 is perfectly well-defined 
and unsurprising.

Thanks,
Robin.

> 
> Mark.
> 
>> ---
>>   drivers/perf/arm-ccn.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
>> index 1a0d0e1a2263..8af3563fdf60 100644
>> --- a/drivers/perf/arm-ccn.c
>> +++ b/drivers/perf/arm-ccn.c
>> @@ -565,7 +565,7 @@ module_param_named(pmu_poll_period_us, arm_ccn_pmu_poll_period_us, uint,
>>   
>>   static ktime_t arm_ccn_pmu_timer_period(void)
>>   {
>> -	return ns_to_ktime((u64)arm_ccn_pmu_poll_period_us * 1000);
>> +	return us_to_ktime((u64)arm_ccn_pmu_poll_period_us);
>>   }
>>   
>>   
>> -- 
>> 2.34.1
>>

