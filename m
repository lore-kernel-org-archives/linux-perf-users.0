Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7EE1D6DC5;
	Wed, 15 Jan 2025 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736968437; cv=none; b=inA0bRb5GxdHVdur6KWwQ4PhmfJu7Xr8B77bT238UqyGv00rEUZ2Sbtr7d35WmGB4LEsxG0nkgEPGbhDjDzySZzJ8qQQTHMaBzGWO7FYcL5d+qgCV0A4xp/PglyHVl+5hJ2+4ptyIGERhP61aOvyLMM5e3CHn3VxYDBldPKiNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736968437; c=relaxed/simple;
	bh=5j6uNe4JOhp42a3UoL5OduNrPDr39cMDCmgVSF3r97A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqEVoX6rk84iLviZy3QlYEvZpDiIixvoOckHrmvCPE1/AUOcf9XdVkp8zljNwUel3oHGTuqLIyr+HHBm4ibBDzGAGZ0Dz/1ASmmi8+JaDw4FwdvntjywsPOufOWS4BlAIaJKtRqL9FhbM7WIQmvxmPciMdJHxm/izQEi7DvYJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSVUitwa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSVUitwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736968436; x=1768504436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5j6uNe4JOhp42a3UoL5OduNrPDr39cMDCmgVSF3r97A=;
  b=GSVUitwa62BiGcq15mKzWmOJk0WNicwS3H2EbF+FI3AaLBcqHR6k5tAX
   rxtK9CTjd6yBG6RgRmGiGyXww2+JQKV1Ra7Ed+XfBk9Y3Zhn7cb+tAU5l
   ES8dtWlspB28ohohsR0aIlN2TqEsPrxyjwLG3CIxZ4dOQF9IPt9W5r56u
   GbEEDj6P2qak7GI76gjBn1tn7V9yuECrqgwA8rMje37VBa1qkvqY+PaOI
   KsWg1b+jHwkVsMbYeGCHD8idhFpAApCu4/5tkdHJCGdoTe4kFzjyIcS8X
   Bo/J7RTVgjUrzSsg6ZetAq9niCfDkGIY0XSCwGJR2Lhj7s5Msgcdqlo7T
   w==;
X-CSE-ConnectionGUID: KktN/Iy1Rs206dE7XCLhhQ==
X-CSE-MsgGUID: oNFzaGmdSq6Af9mV1D5cTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37551014"
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="37551014"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 11:13:55 -0800
X-CSE-ConnectionGUID: ffDA660eTXGxC+h2JfpaUQ==
X-CSE-MsgGUID: XbMXCM2+Szu7c1RfnfCzHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="105824598"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 11:13:54 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9EA3120B5713;
	Wed, 15 Jan 2025 11:13:52 -0800 (PST)
Message-ID: <62c13793-f4b4-4e2e-b6bc-0de2427ea93e@linux.intel.com>
Date: Wed, 15 Jan 2025 14:13:51 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [UNTESTED][PATCH] perf/x86: Fix limit_period() for 'freq mode
 events'
To: Ravi Bangoria <ravi.bangoria@amd.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 eranian@google.com, irogers@google.com, bp@alien8.de, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com
References: <20250115154949.3147-1-ravi.bangoria@amd.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250115154949.3147-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-15 10:49 a.m., Ravi Bangoria wrote:
> For the freq mode event ...
> 
> event->attr.sample_period contains sampling freq, not the sample period.
> So, use actual sample period (event->hw.sample_period) while calling
> limit_period().
> 
> Kernel dynamically adjusts event sample period after every sample to meet
> the desire sampling freq. For this, kernel starts with sample period = 1
> and gradually increase it. Instead of simply returning error, start
> calibrating freq with the minimum sample period provided by limit_period().
> 
> Similarly, value provided along with ioctl(PERF_EVENT_IOC_PERIOD) contains
> new freq not the sample period. Avoid calling limit_period() for freq mode
> event in the ioctl() code path.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
> UNTESTED: limit_period() is mostly defined by Intel PMUs and I don't have
> any of those test machines.
> 
>  arch/x86/events/core.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index c75c482d4c52..924aa35676d3 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -629,10 +629,22 @@ int x86_pmu_hw_config(struct perf_event *event)
>  		event->hw.config |= x86_pmu_get_event_config(event);
>  
>  	if (event->attr.sample_period && x86_pmu.limit_period) {
> -		s64 left = event->attr.sample_period;
> -		x86_pmu.limit_period(event, &left);
> -		if (left > event->attr.sample_period)
> -			return -EINVAL;
> +		if (event->attr.freq) {
> +			s64 left = event->hw.sample_period;
> +
> +			x86_pmu.limit_period(event, &left);
> +			if (left != event->hw.sample_period) {
> +				event->hw.sample_period = left;
> +				event->hw.last_period = left;
> +				local64_set(&event->hw.period_left, left);
> +			}

For a better start period, I'd prefer the below patch.
https://lore.kernel.org/lkml/20241022130414.2493923-1-kan.liang@linux.intel.com/

The limit_period() check was introduced in the c46e665f0377 ("perf/x86:
Add INST_RETIRED.ALL workarounds"). For my understanding, it's to check
the !freq case. If so, I'm thinking something as below.

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 79a4aad5a0a3..6467ecc65486 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -630,7 +630,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type == event->pmu->type)
 		event->hw.config |= x86_pmu_get_event_config(event);

-	if (event->attr.sample_period && x86_pmu.limit_period) {
+	if (!event->attr.freq && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
 		x86_pmu.limit_period(event, &left);
 		if (left > event->attr.sample_period)


> +		} else {
> +			s64 left = event->attr.sample_period;
> +
> +			x86_pmu.limit_period(event, &left);
> +			if (left > event->attr.sample_period)
> +				return -EINVAL;
> +		}
>  	}
>  
>  	/* sample_regs_user never support XMM registers */
> @@ -2648,6 +2660,9 @@ static int x86_pmu_check_period(struct perf_event *event, u64 value)
>  	if (x86_pmu.check_period && x86_pmu.check_period(event, value))
>  		return -EINVAL;
>  
> +	if (event->attr.freq)
> +		return 0;
> +

The ioctl(PERF_EVENT_IOC_PERIOD) can be used to set both freq and
period. But according to the implementation, yes, the
perf_event_check_period() should be only for the !freq mode.

If so, we may change the generic code.

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f91ba29048ce..a9a04d4f3619 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5960,14 +5960,15 @@ static int _perf_event_period(struct perf_event
*event, u64 value)
 	if (!value)
 		return -EINVAL;

-	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
-		return -EINVAL;
-
-	if (perf_event_check_period(event, value))
-		return -EINVAL;
-
-	if (!event->attr.freq && (value & (1ULL << 63)))
-		return -EINVAL;
+	if (event->attr.freq) {
+		if (value > sysctl_perf_event_sample_rate)
+			return -EINVAL;
+	} else {
+		if (perf_event_check_period(event, value))
+			return -EINVAL;
+		if (value & (1ULL << 63))
+			return -EINVAL;
+	}

 	event_function_call(event, __perf_event_period, &value);

Thanks,
Kan

>  	if (value && x86_pmu.limit_period) {
>  		s64 left = value;
>  		x86_pmu.limit_period(event, &left);

