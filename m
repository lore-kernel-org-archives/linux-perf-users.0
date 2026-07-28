Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B887C34E741;
	Tue, 28 Jul 2026 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240242; cv=none; b=PL7wkYH7Od8ngDk7r8dCjqrU5SqYdMtvbjQzAlz758/soNjKtxmtj2HPoJNF9TbnzTA9HwD4nx9SKIK7Vzd6lAl27m9tFGuC5QwqqF2qoiAa/J34bacB5mmjiWGeqUdYDRHeNcCEFyGkr6LPh9F5ilfTFR+g/4N9DECbx7Ljbus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240242; c=relaxed/simple;
	bh=QPMGxfL7sRTASsW/WHWUTA/jar9afmNRd3cjtJDfS60=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UtD19umO7XK/u+ITsOjU9P2BPl8NBRYC8dTrA22FH9f27lDqyPRaMkQ16i5V/KWLMWtq3wga161xuoHiZI/21mByGU/3plpi15TCvPCdugavo6H2zvVnQShBuSXqsYFkCN4JBilrRXHPZLOxI7ez59TMZqdxuUebb3JP4NOpO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lI2HlSLE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lI2HlSLE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35E3E168F;
	Tue, 28 Jul 2026 05:03:54 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D980E3F86F;
	Tue, 28 Jul 2026 05:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785240238; bh=QPMGxfL7sRTASsW/WHWUTA/jar9afmNRd3cjtJDfS60=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=lI2HlSLEWWdzGRHJUWPkDET2bYIhr+PKaIuu/cVoXdNqZOKj2PnlZn8Rx6MLNH+F0
	 WeD7R+qbMzYIRM67Ka4N1ZcUXfJsMH78O6Hc1MPjbVUE4iwhsPzCOhFHmuEU3MKK5P
	 vIL2NjO7vAlNUN6P5TLN9tSgX/hiZKT88cPCR3e4=
Message-ID: <54c60aa5-6fd7-44fd-9a9c-2d7e658e8c7f@arm.com>
Date: Tue, 28 Jul 2026 13:03:50 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf: Generic hotplug/cpumask for system PMUs
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1784911757.git.robin.murphy@arm.com>
 <d85ac6d5f5f6383be5b882b6694052eac8062ced.1784911757.git.robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <d85ac6d5f5f6383be5b882b6694052eac8062ced.1784911757.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2026 6:48 pm, Robin Murphy wrote:
[...]
> @@ -12918,6 +12943,17 @@ int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
>   	INIT_LIST_HEAD(&pmu->events);
>   	spin_lock_init(&pmu->events_lock);
>   
> +	/*
> +	 * Finally, if appropriate give the PMU a chance to pick an initial CPU
> +	 * affinity for its cpumask, or initialise any general per-CPU state.
> +	 * Note that we're serialised against perf_event_{init,exit}_cpu()
> +	 * themselves here by virtue of pmus_lock.
> +	 */
> +	if (pmu->init_cpu) {
> +		for_each_online_cpu(cpu)

Having thought about it, while the drivers I want to convert should all 
be fine with a potential double-init, I guess it is true that an 
outgoing CPU in between CPUHP_AP_PERF_ONLINE and CPUHP_TEARDOWN_CPU 
would still be in cpu_online_mask with interrupts enabled, and thus 
potentially able to be picked by the driver callback, and thus end up 
inaccessible unless and until that CPU comes back again. So indeed for 
true race elimination this probably should use perf_online_mask. I'll 
save spamming a v3 until I get some feedback that the overall idea is 
worth pursuing at all, though.

(But I shall continue to ignore the rest of the twaddle from word-salad 
models which apparently can't differentiate "initialise" from "allocate"...)

Thanks,
Robin.

> +			smp_call_function_single(cpu, perf_scope_init_cpu, pmu, 1);
> +	}
> +
>   	/*
>   	 * Now that the PMU is complete, make it visible to perf_try_init_event().
>   	 */
