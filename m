Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CAF2BB15;
	Thu, 19 Jun 2025 01:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750295442; cv=none; b=ucRqL2rkZnNqPgPJiDkMz0MuV8m8bRNNyS1eZnraSKb+wzUZ0T0VLQDmiKchlTFnIo9oV2IzcsPaHwkIt9Ji/9pMKZeum/aAYp9l7QLzykVcUuSClgzUypsl8yZZ8D1UMg9gJFx76bN8dn0S96MysBo8aUhRVoJ0GxJcFPJrDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750295442; c=relaxed/simple;
	bh=3f/Hu88Ha+Adl0WLRJ4ljUuvhoxON8Qq+woi+kHNC90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3FIAo/elAB1cEAd/b9g5y60kXZyPmzMF6j91HcDId/MKqRFIHWnhVht3PcxQw9wU8mY7QLqGTVNq5T0yqQJPf/8woh/VYuKysWZILAOiXnMtBbKOAtTHk38MO14XW5TeuX5lfHRlUkU2U1ECOGy0nk3zneb7uvxhi+BGTvInd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXSx9s2I; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXSx9s2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750295440; x=1781831440;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3f/Hu88Ha+Adl0WLRJ4ljUuvhoxON8Qq+woi+kHNC90=;
  b=EXSx9s2IkVY1XrBq9C79QRCVtkuVa87Y+T4EODmhjHtkGG034XIVEra6
   VVBjXtVQNhvgeUNWi70XwD7Nabbvb0SChMLVWOx3BxZbpCXnh2JRH8RgO
   ge1d2UUbFyw+fiOQvYfaBtzFCljURguquLiDMh6jG6/wVWT51Jkgng1hb
   RzDrrULxPuaTm5cz0n6CWR5ePKQ/IdBcZgXIFsGnli6rYDLrFKXXqy+0C
   bw3FQ7sbl4BUtRhecA3lqdUlaCrewegR1FY/r9zMJl6WBoZd852R76N07
   Oe4VYJdc5zVCU1mfrgoqVS2ZYGcUe66hIMljyu6Mof0E1cVwaR+LbWww1
   Q==;
X-CSE-ConnectionGUID: M8ySVY4SRQ6BRPzD60E3UQ==
X-CSE-MsgGUID: rISgKEUtTkOHC/vTTx2XDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="40147899"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="40147899"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 18:10:40 -0700
X-CSE-ConnectionGUID: iY8gUImvTVO0Qcb7ebH/6w==
X-CSE-MsgGUID: Lh6EgDSmTTys4PT+nlShYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="154269144"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.144]) ([10.124.245.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 18:10:36 -0700
Message-ID: <820b6d4f-b4b1-43fb-9829-5ff617eca5f9@linux.intel.com>
Date: Thu, 19 Jun 2025 09:10:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Use early_initcall() to hook bts_init()
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Andrew Zaborowski <andrew.zaborowski@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250606111606.84350-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250606111606.84350-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Kindly ping...   Thanks.

On 6/6/2025 7:16 PM, Dapeng Mi wrote:
> After the commit 'd971342d38bf ("perf/x86/intel: Decouple BTS
>  initialization from PEBS initialization")' is introduced, x86_pmu.bts
> would initialized in bts_init() which is hooked by arch_initcall().
>
> Whereas init_hw_perf_events() is hooked by early_initcall(). Once the
> core PMU is initialized, nmi watchdog initialization is called
> immediately before bts_init() is called. It leads to the BTS buffer is
> not really initialized since bts_init() is not called and x86_pmu.bts is
> still false at that time. Worse, BTS buffer would never be initialized
> then unless all core PMU events are freed and reserve_ds_buffers()
> is called again.
>
> Thus aligning with init_hw_perf_events(), use early_initcall() to hook
> bts_init() to ensure x86_pmu.bts is initialized before nmi watchdog
> initialization.
>
> Fixes: d971342d38bf ("perf/x86/intel: Decouple BTS initialization from PEBS initialization")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/bts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 9560f693fac0..f0d9729ed255 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -642,4 +642,4 @@ static __init int bts_init(void)
>  
>  	return perf_pmu_register(&bts_pmu, "intel_bts", -1);
>  }
> -arch_initcall(bts_init);
> +early_initcall(bts_init);
>
> base-commit: e7d952cc39fca34386ec9f15f68cb2eaac01b5ae
