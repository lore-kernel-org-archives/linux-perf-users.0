Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102A1E4A4;
	Wed, 23 Apr 2025 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416293; cv=none; b=fGkMqiCYkwPAsAY9VhBCYd5Uk0NxJioSiUHjNYKsCNtpginZFe5hr3dOJgwG7r3oqMP6Ozi4zH7wNQQUo5QUtZDPcWYf7jqKf9tMtXqwOvU1OUmcdcLB8QvMDjyHY9go3nNqSkm7NUjPF7mYeTMt9IDtYdKcc3e4BLnX/tlhRo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416293; c=relaxed/simple;
	bh=V7UiGGeU3UPmto3LMdpllZkC0y8zXQCR/LJyE9FYYwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+P03Va2C56AqNDe+hJap60Gg8URawAwBYAgORt6AQydrjSOgIMMqQbWQrMU2jn3Onp1UMzAr2AYwiqjm2oBBT0NzQqRlswRmsjHL5b3yVwbG/lh7dWGtJFsW7kfl/2YCRISTjnzrTiUMtkYEOCEnB9ZJEMtwet5jF7R4390xnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZ1Miqpt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZ1Miqpt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745416292; x=1776952292;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V7UiGGeU3UPmto3LMdpllZkC0y8zXQCR/LJyE9FYYwA=;
  b=nZ1Miqpt78j7eoPvQrkDf+exIyVmOfFPl86zshYq7112jonZlsTQQo5A
   nhOhuuLkpokJg3qYIsmCdrEXv02L/E5C4NAHpAMqxMZMCMk4vTs5tDN6c
   UovE61OmTZ1vxoBs3TIaRONZUtfgH+taJQ7UjwFIb4JPvaFYr3EkoznQZ
   cAKeJBI7iQYk0fbQXlt30n8rFZU48X9bR8B6wPWCM4mKn3u5VDb0vzTnW
   9UExSK5OStjpTyX9naBAhngy4d0e+VXytJ2yQYXHb2Mp1hPRpJfJDqEhE
   ZMvXdJ8z7BP3iFhAe34BlDQSvdF8rMoOZ9F5dyCIH/Lb7NmIGHFy6/0vi
   g==;
X-CSE-ConnectionGUID: ++3BgU9qRPKLzSQ9476N9g==
X-CSE-MsgGUID: /EUXqn/5QEuhaTMdTtl7OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57999483"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="57999483"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 06:51:31 -0700
X-CSE-ConnectionGUID: VCaw58mPS+iNbJaE7gQT8w==
X-CSE-MsgGUID: 6lYfMo74RqC3Cbso7kb5Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132852538"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 06:51:31 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id F30FD20B5736;
	Wed, 23 Apr 2025 06:51:16 -0700 (PDT)
Message-ID: <7bafc0c9-0f72-44ba-a242-51918e32808a@linux.intel.com>
Date: Wed, 23 Apr 2025 09:51:11 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86: Fix open counting event error
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250423064724.3716211-1-luogengkun@huaweicloud.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250423064724.3716211-1-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-23 2:47 a.m., Luo Gengkun wrote:
> Perf doesn't work at perf stat for hardware events:
> 
>  $perf stat -- sleep 1
>  Performance counter stats for 'sleep 1':
>              16.44 msec task-clock                       #    0.016 CPUs utilized
>                  2      context-switches                 #  121.691 /sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 54      page-faults                      #    3.286 K/sec
>    <not supported>	cycles
>    <not supported>	instructions
>    <not supported>	branches
>    <not supported>	branch-misses
> 
> The reason is that the check in x86_pmu_hw_config for sampling event is
> unexpectedly applied to the counting event.
> 
> Fixes: 88ec7eedbbd2 ("perf/x86: Fix low freqency setting issue")
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>

Yes, it should only be applied for the sampling event. The
event->attr.freq is always 0 in the counting mode.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan> ---
>  arch/x86/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 6866cc5acb0b..3a4f031d2f44 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -629,7 +629,7 @@ int x86_pmu_hw_config(struct perf_event *event)
>  	if (event->attr.type == event->pmu->type)
>  		event->hw.config |= x86_pmu_get_event_config(event);
>  
> -	if (!event->attr.freq && x86_pmu.limit_period) {
> +	if (is_sampling_event(event) && !event->attr.freq && x86_pmu.limit_period) {
>  		s64 left = event->attr.sample_period;
>  		x86_pmu.limit_period(event, &left);
>  		if (left > event->attr.sample_period)

