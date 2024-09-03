Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCA15574F;
	Tue,  3 Sep 2024 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388907; cv=none; b=pOyZbCZ+/o/Omk0pLSdnummriJj5/oN6IX1aXXM2WpChUcY2lk8GQruH8n/P0phUr2usysJzuNdyIOvL1+AOgyeFyhsTMPDfBJV0knvA/wZHq8vZq1njTxnHEyT9Q7yz0DuA0rlbKaRUhPe0VGIfu4RZhvBPwOQS9Q9i9Mhkits=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388907; c=relaxed/simple;
	bh=ovQBxupDZwgGU+HNXgPAi4OEVfyc757WP6fI8XGi3wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q1THdVFxfR4yJpoOA2BUU4vmHcRngnJZYqosLmP3LenQhwn0vM7avIylx0GlaDMaMjb8ShpQcAd72Ypcyx+PNE+RJDGNrTPez8cKHsPyndHBN4FXa1BSvX0OXX3gIY8wErDyyzkWj0DVLweaDdoXFpbo3Kpq+8R75QwDgsueNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfTw2diR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfTw2diR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725388906; x=1756924906;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ovQBxupDZwgGU+HNXgPAi4OEVfyc757WP6fI8XGi3wo=;
  b=MfTw2diR+i9wklEBnapxd5E6GIA9he+fFFmVse/8ZXC5u8SJA4H8NkK6
   1A0eizy4udFC+3nmmUeLBv46Ail2CePXZozf077+t5gP/vW09ik9y/YMX
   Z3INUPbPbSq8O/kMDv00uAPnoJwQ2hgFm4Iv7X6GP5NCF8iDOsEhz0Z8I
   z1MBiPtbu5MHx+TSfBJpVnN7uAuKwO4RP3AGF3HnscjaI1FdiPDFk0JWV
   5UEIpleWzZer9qmSTFmcqSkIc+b4qgJj1hrD7P4S5s8nE9r378LpYd5zy
   2UlOoZp/lPv6ZG7T3C1ECKp12wEOiAL1xJt/MCl+m3Djvh41i0RO/5Mc7
   A==;
X-CSE-ConnectionGUID: rWkA3jZ5RZeb7otOoF6Jrw==
X-CSE-MsgGUID: 1Ica2SVwSwio4QwN0Zwbsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23525895"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="23525895"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:41:45 -0700
X-CSE-ConnectionGUID: rc3FvuviSdmHsLbn5HSqTA==
X-CSE-MsgGUID: 70Hue1dMQT6yAPFty6naLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="102419517"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:41:39 -0700
Message-ID: <32ad6b65-c7fc-426c-84a6-203ccd964444@intel.com>
Date: Tue, 3 Sep 2024 21:41:33 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] perf auxtrace: Bails out after finding the event
 for the map index
To: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20240823113306.2310957-1-leo.yan@arm.com>
 <20240823113306.2310957-7-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240823113306.2310957-7-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/08/24 14:33, Leo Yan wrote:
> After finding the corresponding event for the passed buffer index, it is
> safe to say the found event has been used. Then, the tool can check the
> event status and bails out if it has been disabled.

I don't really understand why this is a separate patch.  Maybe it
should be merged with the next one?

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/auxtrace.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index e7b582d92811..2acf63efab1d 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -688,15 +688,15 @@ int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
>  		if (evsel__is_aux_event(evsel)) {
>  			int cpu_map_idx;
>  
> -			if (evsel->disabled)
> -				return 0;
> -
>  			cpu_map_idx = evlist__find_cpu_map_idx(itr->evlist,
>  							       evsel, idx);
>  			/* No map is found in per CPU mmap */
>  			if (cpu_map_idx == -ENOENT)
>  				return cpu_map_idx;
>  
> +			if (evsel->disabled)
> +				return 0;
> +
>  			if (cpu_map_idx >= 0)
>  				return evlist__enable_event_idx(evsel, 1, cpu_map_idx);
>  			else

