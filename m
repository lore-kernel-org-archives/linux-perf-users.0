Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC871D5CCC;
	Wed, 12 Feb 2025 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387860; cv=none; b=sVPpRLa25RTl/1Tzo4xn5KmP/MQjW8kthhVPd8Ju74DOx1fX6V8k0WDykGe86WZzD0D5UusPIpDykwz/7cJ4ESaguV57lvaDQyvj3tYDnBliqP+BhF8dL8coKeZnKHd4iiuiw+T42FX8oQiyV2Pbj0G/W9sCWUK229CoiAaUA0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387860; c=relaxed/simple;
	bh=iDANxj1a8pKBbLBKgMgUAZ8w+gbe0M8ohVrU0JVPfhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOHq8LgbSXtNp6nXAyIlLtvvLCNuCtuaNMX2GCmUX19ookI1cwNoWICS5U27YRbV4+yTYKd0I8411Wz4Z0x7COaD+O05+tYKZeiuiEuTxc7tdjKZHxoYdB70YTq6Z1trEIC0ETZ271ISPbfZ+9bDMNDy877OyWos/+RLcXxyF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ule1N44n; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ule1N44n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739387860; x=1770923860;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iDANxj1a8pKBbLBKgMgUAZ8w+gbe0M8ohVrU0JVPfhw=;
  b=Ule1N44nRszzT+d4ZYy28+uWcUPZLNYDp7ariF2XF4OwGcc143BwzbXj
   MZVENfbrU2C8VA1eM3kDqmQc0iRayfxc5dMUgbQyfbT5MFU6x003zms8f
   o1H6NBcHpPzpbvMXkaZMKnx65i+eOj/hlG2GebyNHD1YGFZhZjbk+vFFp
   dkeCNqHxXZCuYsIPq9XMKs454rnNzEtvI97C6cdBuNecse1cejCtaqPyL
   3dySNRqYO8nXLfwmiMeVKnRQS8MaCdXCTUl1ms1ef7zwohKpTpIvhuxd0
   oOJ95yHFPTtTo5XfLbzjc1MKE0W0JTnIod2BNV+q52jTQyjarBK6yogcc
   A==;
X-CSE-ConnectionGUID: eIsHsw0ARS2XsWu+hBylTg==
X-CSE-MsgGUID: r61dNiWmRfumwoifiA1wHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="62531822"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="62531822"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 11:17:37 -0800
X-CSE-ConnectionGUID: LEpZf7YaQqGKUwXn3Le6jg==
X-CSE-MsgGUID: XJtNep4kQg+2E5IarIu8bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="112877815"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 11:17:36 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C77FF20B5713;
	Wed, 12 Feb 2025 11:17:34 -0800 (PST)
Message-ID: <b9915fb7-ad8c-40ff-b53a-fb6936c141b1@linux.intel.com>
Date: Wed, 12 Feb 2025 14:17:33 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: Fix Tool PMU test segfault
To: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
References: <20250212163859.1489916-1-james.clark@linaro.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250212163859.1489916-1-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-12 11:38 a.m., James Clark wrote:
> tool_pmu__event_to_str() now handles skipped events by returning NULL,
> so it's wrong to re-check for a skip on the resulting string. Calling
> tool_pmu__skip_event() with a NULL string results in a segfault so
> remove the unnecessary skip to fix it:
> 
>   $ perf test -vv "parsing with PMU name"
> 
>   12.2: Parsing with PMU name:
>   ...
>   ---- unexpected signal (11) ----
>   12.2: Parsing with PMU name         : FAILED!
> 

Oops, right. Thanks for the fix.

Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> Fixes: ee8aef2d2321 ("perf tools: Add skip check in tool_pmu__event_to_str()")
> Signed-off-by: James Clark <james.clark@linaro.org>
> --->  tools/perf/tests/tool_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
> index 187942b749b7..1e900ef92e37 100644
> --- a/tools/perf/tests/tool_pmu.c
> +++ b/tools/perf/tests/tool_pmu.c
> @@ -27,7 +27,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pmu)
>  	parse_events_error__init(&err);
>  	ret = parse_events(evlist, str, &err);
>  	if (ret) {
> -		if (tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
> +		if (!tool_pmu__event_to_str(ev)) {
>  			ret = TEST_OK;
>  			goto out;
>  		}
> @@ -59,7 +59,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pmu)
>  		}
>  	}
>  
> -	if (!found && !tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
> +	if (!found && tool_pmu__event_to_str(ev)) {
>  		pr_debug("FAILED %s:%d Didn't find tool event '%s' in parsed evsels\n",
>  			 __FILE__, __LINE__, str);
>  		ret = TEST_FAIL;

