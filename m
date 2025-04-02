Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4852217C21C;
	Wed,  2 Apr 2025 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743616372; cv=none; b=fSZ5MUQ0zLhtVdvPafDGV3ri7HM89SCQsbyrUZGggUlmRnSZ5JUMI+I1ohYI6Xw0V2kyi4+BruYoSV/tzcIET108a58h3TLLBRiz3mRzP+b+PIFJ155YjwbB99MJ4C7nHbnRu0eB5sSs0we1jqiS3hbCNxGje6s1KcxIFdh+rYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743616372; c=relaxed/simple;
	bh=h5NICahV7JeZ491aP7VXdSMuYMNaZpCrLTP/wgrYg5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Phxe+UxPbDEAUqApvyxHHDjQEJJKf7f3T0q9OPtSkTnbQhnyEoLgYqAzzrP5yDUrikJm0kO0OUCia2ZyUxro9C+zo3DNXDlm1mh7CCMM/1lL1FvWA5dqcmxm0Qm1BLioEry/McIiR4lWXKFuuRaYym9o4t8o8Q28IXDYQTvITGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiGc7SML; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiGc7SML"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743616371; x=1775152371;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=h5NICahV7JeZ491aP7VXdSMuYMNaZpCrLTP/wgrYg5M=;
  b=fiGc7SMLapDFt6FB01Or5x/qQ71JZaCNd9GO9JEUWoKQuwGdYl83vjeW
   n4kkhaiWURbZ5gkI1ulFq/HKY0A+ohT+FZ3E0p+haGRamwMzxnbHD/ksV
   Sqddc/hRVT9RbI0eWatMIwa0e9NYW0ADR++7MmkWj2kEu+R0+SYFacQf5
   5xKePhTGUkBoZfD/Tz/yEyP0r74v16g9UibVTmfWb43CiXkgrjjTNxbRQ
   By+qHw8hUxgfByU0PuU4Vi1i8iB7TMliyNBguMMGmHDpLhIgk7fNTRhKU
   26sXBkqO/+mC3wJ248OlnrUl6V0wDWGE+z0tP1Fd1Q7B/N4Qo6Rx7tFjC
   Q==;
X-CSE-ConnectionGUID: HkAmmnU3QVuBoy0pAY10+Q==
X-CSE-MsgGUID: +qNlenhFSGmBzdhhDpn6gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="55192707"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="55192707"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 10:52:48 -0700
X-CSE-ConnectionGUID: NK7C53LZTdSPdr1T9NjyMQ==
X-CSE-MsgGUID: o6X37gn4SDuQW65LRVBieQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="126730347"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 10:52:48 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 56B3720B5736;
	Wed,  2 Apr 2025 10:52:45 -0700 (PDT)
Message-ID: <6ba85605-39ea-40e0-a6f6-379deec30db7@linux.intel.com>
Date: Wed, 2 Apr 2025 13:52:44 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] perf parse-events: Add debug dump of evlist if
 reordered
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Howard Chu <howardchu95@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen
 <ak@linux.intel.com>, James Clark <james.clark@linaro.org>,
 Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250402164720.3847573-1-irogers@google.com>
 <20250402164720.3847573-6-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250402164720.3847573-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-02 12:47 p.m., Ian Rogers wrote:
> Add debug verbose output to show how evsels were reordered by
> parse_events__sort_events_and_fix_groups. For example:
> ```
> $ perf record -v -e '{instructions,cycles}' true
> Using CPUID GenuineIntel-6-B7-1
> WARNING: events were regrouped to match PMUs
> evlist after sorting/fixing: '{cpu_atom/instructions/,cpu_atom/cycles/},{cpu_core/instructions/,cpu_core/cycles/}'
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 5152fd5a6ead..0f8fd5bee3a7 100644
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
> +			evlist__format_evsels(evlist, &sb, 1024);

Why is the size even less than the one in pr_err?

The user probably prefer to get the complete list in the debug.

Thanks,
Kan> +			pr_debug("evlist after sorting/fixing: '%s'\n", sb.buf);
> +			strbuf_release(&sb);
> +		}
> +	}
>  	if (!ret) {
>  		struct evsel *last;
>  

