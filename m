Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1F198838;
	Thu, 27 Jun 2024 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501149; cv=none; b=G2HYRCwG2rqffIT9qqCjIg8PT2IBsHrsIwmyXaGeNmpIrnq76sy+xgCjrzHNRahyogsXQNPb0S473TgvVyLRyq+PS6d4ZUjN6AX/i79VYZV6pJA/fbJRkmPOFT1aad1CUig2X4X3ORWI05UeuPLPbWBwHpQ6re6+1qymuZnvZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501149; c=relaxed/simple;
	bh=/AMk+Ap8ZKPd5uSIT+df99jZzUx7aWaLbXJg9sTRxGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaN1ihwyxHr7vP9rZiMOdTU20LiwTJzieoQrz8eg3KsXFDm7zUHWYhNy9kR83iw2cgZIht90ZnBnvTjVjq2ZUH8JVnqfNamQehfp/66kGLOrM5Gugqni/mMSX9v9H2VljqjNIuv93P7rBqzXJ6Yt5KLkgWObDCeDTSnUu/d8Sj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAdT5Dx5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAdT5Dx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719501148; x=1751037148;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/AMk+Ap8ZKPd5uSIT+df99jZzUx7aWaLbXJg9sTRxGM=;
  b=IAdT5Dx5tbEbc2s7XqJD3OHvRzwfWNWV6wxYl2k2EYMqOttBi/0R6MBW
   HDc+Bb7CI+CfMtgDp/HqfIdL9ZFcF2i7qLAglHY9M4qNPDNmrbK3uNq31
   3umC3reQur9Xrhi/K9zmwBgHAX3XEiAGk2BhTv7WJgmB4xW8M/PhYt5lq
   sBsez3E/HHtsK6iYzy5G/NU+5Jv3BezapetreaUxO9Mf4g9db6fwF6s8s
   JPLYkUCXNbgeqn6FxcSe+LVQ/d+pxUw86pdMgLCtOljrQyx3mk4OtEsmf
   VhJNuQgxgcoCQmYnX75IeaZGzqz992nP28jjIWIWLa8EjyLKPJxqT/HUl
   w==;
X-CSE-ConnectionGUID: ENNspAITQTe1yHU+sLacfg==
X-CSE-MsgGUID: 9xd0r0Y9RoK2BPA+Gav8Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="34089034"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="34089034"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 08:11:09 -0700
X-CSE-ConnectionGUID: eSm3PHprTGuMQf8EhWXu1g==
X-CSE-MsgGUID: X+U+nvMnR9i9hkLvhapWvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="49020978"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 08:11:08 -0700
Received: from [10.212.74.51] (kliang2-mobl1.ccr.corp.intel.com [10.212.74.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 43D0020B5703;
	Thu, 27 Jun 2024 08:11:06 -0700 (PDT)
Message-ID: <df56c6e1-5d99-4cbe-abd4-772e7ff948af@linux.intel.com>
Date: Thu, 27 Jun 2024 11:11:05 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf topdown: Correct leader selection with sample_read
 enabled
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240614213908.352840-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240614213908.352840-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dapeng,

On 2024-06-14 5:39 p.m., Dapeng Mi wrote:
> Addresses an issue where, in the absence of a topdown metrics event
> within a sampling group, the slots event was incorrectly bypassed as
> the sampling leader when sample_read was enabled.
> 
> perf record -e '{slots,branches}:S' -c 10000 -vv sleep 1
> 
> In this case, the slots event should be sampled as leader but the
> branches event is sampled in fact like the verbose output shows.
> 
> perf_event_attr:
>   type                             4 (cpu)
>   size                             168
>   config                           0x400 (slots)
>   sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   disabled                         1
>   sample_id_all                    1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             168
>   config                           0x4 (PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
>   { sample_period, sample_freq }   10000
>   sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   sample_id_all                    1
>   exclude_guest                    1
> 
> The sample period of slots event instead of branches event is reset to
> 0.
> 
> This fix ensures the slots event remains the leader under these
> conditions.

This should be just one of the issues with the slots/topdown related
sampling read.

If adding one more topdown event, the sampling read may still be broken.
 perf record -e "{slots,instructions,topdown-retiring}:S"  -C0 sleep 1
 WARNING: events were regrouped to match PMUs
 Error:
 The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (topdown-retiring).

That may require Yanfei's patch.
https://lore.kernel.org/lkml/20240411144852.2507143-1-yanfei.xu@intel.com/

Please give it try and summarize all the required patches for the
topdown sampling read feature.

Besides, we need a test for the sampling read as well.
Ian has provided a very good base. Please add a topdown sampling read
case on top of it as well.
https://lore.kernel.org/lkml/CAP-5=fUkg-cAXTb+3wbFOQCfdXgpQeZw40XHjfrNFbnBD=NMXg@mail.gmail.com/


Thanks,
Kan

> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/topdown.c | 42 ++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index 3f9a267d4501..aea6896bbb57 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "api/fs/fs.h"
>  #include "util/evsel.h"
> +#include "util/evlist.h"
>  #include "util/pmu.h"
>  #include "util/pmus.h"
>  #include "util/topdown.h"
> @@ -31,6 +32,32 @@ bool topdown_sys_has_perf_metrics(void)
>  	return has_perf_metrics;
>  }
>  
> +static int perf_pmus__topdown_event(void *vstate, struct pmu_event_info *info)
> +{
> +	if (!strcmp(info->name, (char *)vstate))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static bool is_topdown_metric_event(struct evsel *event)
> +{
> +	struct perf_pmu *pmu;
> +
> +	if (!topdown_sys_has_perf_metrics())
> +		return false;
> +
> +	if (event->core.attr.type != PERF_TYPE_RAW)
> +		return false;
> +
> +	pmu = perf_pmus__find_by_type(PERF_TYPE_RAW);
> +	if (pmu && perf_pmu__for_each_event(pmu, false, event->name,
> +					    perf_pmus__topdown_event))
> +		return true;
> +
> +	return false;
> +}
> +
>  #define TOPDOWN_SLOTS		0x0400
>  
>  /*
> @@ -41,11 +68,22 @@ bool topdown_sys_has_perf_metrics(void)
>   */
>  bool arch_topdown_sample_read(struct evsel *leader)
>  {
> +	struct evsel *event;
> +
>  	if (!evsel__sys_has_perf_metrics(leader))
>  		return false;
>  
> -	if (leader->core.attr.config == TOPDOWN_SLOTS)
> -		return true;
> +	if (leader->core.attr.config != TOPDOWN_SLOTS)
> +		return false;
> +
> +	/*
> +	 * If slots event as leader event but no topdown metric events in group,
> +	 * slots event should still sample as leader.
> +	 */
> +	evlist__for_each_entry(leader->evlist, event) {
> +		if (event != leader && is_topdown_metric_event(event))
> +			return true;
> +	}
>  
>  	return false;
>  }
> 
> base-commit: 92e5605a199efbaee59fb19e15d6cc2103a04ec2
