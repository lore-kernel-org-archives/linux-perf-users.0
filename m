Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA23A9879;
	Wed, 16 Sep 2026 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522866; cv=none; b=FOo2NETPbUcj4u6nVbSKsoWiJY2Yj0/H/ZaeCtgNzU7G+y+v110eIzYvrEqxqIQ0VcvfPqXSY32lkmFeM1/kq92z1lWmi9ZnD6cMeJAtAwvyDfWCr6CYcMt5mXTJx0HUpVlgYjuHh+aE7S5thZQWyH8Wo5KXIhhggNf6YnDcS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522866; c=relaxed/simple;
	bh=agmYimEHpg/WywJkNR6ulrp9OjIO6GuziVUGHcxmAc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+FM7iXN101HAespMumGeFiDaSTsTIscK3G2nDFuPxkRJH/aoOY4EDXh3Ct9nQyvCG3v5mBWCJcE8GCzpYyN075imYbGMhL7pNquTAI8DX9S4M3j0iDyYSpPp8KmYPXOZ/KVmz5NDtWVwjWe2jEaIv7Ea9IQFRWNQn7YwKQDjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiTuvBVI; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiTuvBVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789522856; x=1821058856;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=agmYimEHpg/WywJkNR6ulrp9OjIO6GuziVUGHcxmAc4=;
  b=UiTuvBVI1I3hhl/JoefdJpyNFscSVs/cfjVx7Nmeh9KCI+g5AK2Oka0a
   u9T3TVKH23A3Zp2TZXyxZvAiRsWIzdS3Ls3THUqdganYAZYR/wgjUyi+i
   CzVso/vGt6rG25KRBaCpy/nTZO9i29mZI+i1YvylC98E7BzmMquyHR6Ua
   yPh0oRBQA1+wAJmUuPTJAKyemyvKM9Hrg3w5z5xC9K1smLGwUHUUD93rD
   NFS5vMihP6ADboevSM0O806Vy7375qMgBtNrIRCNXmAH8uZCsj53NpZ9E
   n5iugSmuVnbp3mLAKm0tfxX2gYRb50I5wVRnRrsDReSHJ294KK3CrWaO7
   g==;
X-CSE-ConnectionGUID: QhnfBEAgS1ecMqFCR5VYQQ==
X-CSE-MsgGUID: wbCykvK0QL27e4xglDLdkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="406603"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="406603"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:40:49 -0700
X-CSE-ConnectionGUID: AdYR1bMOQmOHfV//gRoOHA==
X-CSE-MsgGUID: zdvxLyJfQ2aYc2iZMQXVkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="275142738"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:40:46 -0700
Message-ID: <f2b62bcb-b5a1-48e9-93c8-644ab3ac4439@linux.intel.com>
Date: Wed, 16 Sep 2026 09:40:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf: Add checks to prevent null ptr access
To: Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
 <20260904181625.1394082-2-vinay.belgaumkar@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260904181625.1394082-2-vinay.belgaumkar@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/5/2026 2:16 AM, Vinay Belgaumkar wrote:
> Sashiko recommended some additional checks to prevent null pointer
> access. Check for revoked states inside perf_event_read_local(), as
> the pmu event may have already been freed at this point. Add a null

Could you please show where perf_event_read_local() could be called after
the event is revoked?

BTW, the prefix should be "perf/core:" instead of "perf:" by following
current naming convention.

Thanks.


> check inside __perf_event_read_cpu() as well before accessing the pmu
> ptr.
>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> ---
>  kernel/events/core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7777e82aad5e..059f82f0cadd 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4788,14 +4788,19 @@ static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int
>  
>  static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
>  {
> +	struct pmu *pmu = READ_ONCE(event->pmu);
>  	int local_cpu = smp_processor_id();
>  	u16 local_pkg, event_pkg;
>  
>  	if ((unsigned)event_cpu >= nr_cpu_ids)
>  		return event_cpu;
>  
> +	if (!pmu)
> +		return -ENODEV;
> +
>  	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
> -		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
> +		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope,
> +										event_cpu);
>  
>  		if (cpumask && cpumask_test_cpu(local_cpu, cpumask))
>  			return local_cpu;
> @@ -4917,6 +4922,11 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>  		goto out;
>  	}
>  
> +	if (READ_ONCE(event->state) <= PERF_EVENT_STATE_REVOKED) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Get the event CPU numbers, and adjust them to local if the event is
>  	 * a per-package event that can be read locally
