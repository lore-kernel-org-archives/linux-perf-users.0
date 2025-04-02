Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984CCF513;
	Wed,  2 Apr 2025 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608049; cv=none; b=juMtFevkwXdCA1h4hQrWDs8beeHB0iuN+q2JYyXJMLkuMStXhx3Nd79olsDcEYzV6WWYbJOhdhNwyU8PsPmY7m0O+4utVsrxPv18mfztxX492Uz70g6igpF0kOcjwLE0zR2HZ2QMwSB4sX/YBZC3erL3gaf5VlGgP7rIe6gMHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608049; c=relaxed/simple;
	bh=oqhI9Txq8nLi/B1M0SEAPL0kz4LaJ1MNCLcJpZL5gOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=McG4S/xBTFSRQCk0btqiwn+nMIWYZT/e7LHpcsnJKS2k34KWwiodNbPjtaoX017MwOz27Yq3i5BCeNmzcaWKo/xLgmrkRrpsNK6OJnx6AcasNDhaqC/yW0VvZEj788aiWASsgcjJvZQIsu9gJwDg51Rgg+hdwdV7tUqWIWbWu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHPs715J; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHPs715J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743608048; x=1775144048;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=oqhI9Txq8nLi/B1M0SEAPL0kz4LaJ1MNCLcJpZL5gOA=;
  b=bHPs715JRQQ+qbkDh7mSr2vp061hVWUV3waq7VDhag3YcpYSUuWBzmnc
   xwVmc9G1O3Ee8C1mqQRItwsRC0FuUR5pVC0ghfCD+cB2jZQrkcfTNBM0/
   pWCXaopSpSlAwH5vZa0/ENX2ziQxQBaSELXRaMKCwYGHHmSy6HR5efOe9
   EWWiH0ABpiGidpWIAwTWBHcmrjOFsnPzk87Mc1dw/TMj0/g1RQk8U1mFb
   NH3vf7zrR+jELhBti4DHHSDF2pgzODmLyxEkmSOMoC45AbQXDNVNRQLlm
   vDotuPDTdA/jq7D2E1rr9l+M8OcbbDqP2gex6gufVCeOBUlmJ3G2S73qm
   g==;
X-CSE-ConnectionGUID: R1V9wGDDRQq5gCTHYRTJqw==
X-CSE-MsgGUID: oyQcaUrxSs+sY1aeuqAFJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="45154030"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="45154030"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 08:34:06 -0700
X-CSE-ConnectionGUID: V9YDdUquRzS6yiwE0ZGD9A==
X-CSE-MsgGUID: RetGGQ/PQl+oy7HfsbYgYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="130858127"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 08:34:05 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4812A20B5736;
	Wed,  2 Apr 2025 08:34:03 -0700 (PDT)
Message-ID: <916d3ede-0067-4944-aa20-544f3f7f8c62@linux.intel.com>
Date: Wed, 2 Apr 2025 11:34:02 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] perf parse-events: Add debug dump of evlist if
 reordered
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
 Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>,
 James Clark <james.clark@linaro.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250318041442.321230-1-irogers@google.com>
 <20250318041442.321230-6-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250318041442.321230-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-03-18 12:14 a.m., Ian Rogers wrote:
> Add debug verbose output to show how evsels were reordered by
> parse_events__sort_events_and_fix_groups. For example:
> ```
> $ perf record -v -e '{instructions,cycles}' true
> Using CPUID GenuineIntel-6-B7-1
> WARNING: events were regrouped to match PMUs
> evlist after sorting/fixing: '{cpu_atom/instructions/,cpu_atom/cycles/},{cpu_core/instructions/,cpu_core/cycles/}'
> ```
>

Thanks. This is very nice.
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 5152fd5a6ead..cb76796bc5c7 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -28,6 +28,7 @@
>  #include "util/evsel_config.h"
>  #include "util/event.h"
>  #include "util/bpf-filter.h"
> +#include "util/stat.h"
>  #include "util/util.h"
>  #include "tracepoint.h"
>  
> @@ -2196,14 +2197,23 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
>  	if (ret2 < 0)
>  		return ret;
>  
> -	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus)
> -		pr_warning("WARNING: events were regrouped to match PMUs\n");
> -
>  	/*
>  	 * Add list to the evlist even with errors to allow callers to clean up.
>  	 */
>  	evlist__splice_list_tail(evlist, &parse_state.list);
>  
> +	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus) {
> +		pr_warning("WARNING: events were regrouped to match PMUs\n");
> +
> +		if (verbose > 0) {
> +			struct strbuf sb = STRBUF_INIT;
> +
> +			evlist__uniquify_name(evlist);
> +			evlist__format_evsels(evlist, &sb);

Ah, I know why you want a full list now.

A full list should be OK for pr_debug. But it may be a problem for
pr_err in patch 3. Maybe add a parameter in evlist__format_evsels() to
control if printing the full list.

Thanks,
Kan

> +			pr_debug("evlist after sorting/fixing: '%s'\n", sb.buf);
> +			strbuf_release(&sb);
> +		}
> +	}
>  	if (!ret) {
>  		struct evsel *last;
>  

