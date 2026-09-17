Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CF631E821;
	Thu, 17 Sep 2026 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605008; cv=none; b=VWnZmv8F8Bwc3VL+O0zXo//ELIvceT5hmbTZcO+/dgVdZv+0laPXVXZkiijpIYUHkN5wzR4Ary3yyNDw58FydCK7EqDQmii+BRGW9yaR9JQx6erqzz0AfuscGL8zDm36OB4NVI3QGmvMsy+6dw9Ji3iUYqEybPd4v+B/+gdq+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605008; c=relaxed/simple;
	bh=MwgnMizjbSkgZmTri3y/Y54Ha4HWRPv3L5wbZ38af78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7tOxeaxy7MR1J9yGwc8FiIOIarmD9hBJLoz4dq4cS46z6MQSaDMLkrtF3VB5jxn0Y8VGsABQbbfMP6EIGlfosX7SvOYQmeZd5kKABK99kCJ/EfPxhmn00g70LOyz1TrUeKRtOfdJUymzMdO3X5KN4qqnh/7Bs/BmSWRW/8U7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqoGTZ64; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqoGTZ64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789605007; x=1821141007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MwgnMizjbSkgZmTri3y/Y54Ha4HWRPv3L5wbZ38af78=;
  b=jqoGTZ64qVyiX3j2s5K+6FtTGUcPyevvTtaIm3USCDTebQFyVMc7XgrR
   bCHU7b4UTH8hYt0mr76IRh1+mpZbJNkcbwoCbT4ayMPTbyxUHZ5Z0rIxj
   rfp0AfOpGHskqd1jYDk1uoEDfF6HViWxBcYVFmZhSe1NYQnsJ3/T0zlWs
   6OnGgJS4ZRViksACke5VgV0ryGqLKwdUI7PTH84qAjsYDG4ZfqwnVsw0v
   l038p+W2ghO0KbYayk2eHbPglkLmLNo+1hPjshq6Gf8xlocRHTpycIusz
   xOzsSbGP8e4VumUsh1sSuDK/AD0mF4G3Mi1wxS3zDHXm5jZXbEEpEAjpz
   A==;
X-CSE-ConnectionGUID: CdMIlkxFSlSNpCLEE/iQMQ==
X-CSE-MsgGUID: gEjR00/FQZuT6oXJ7zE9xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89836371"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89836371"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 17:30:06 -0700
X-CSE-ConnectionGUID: 5EDc1lXLTi6S63uLIQPhHw==
X-CSE-MsgGUID: WC+3Buz3QzOL2cuvJvnsNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269232615"
Received: from unknown (HELO [10.238.2.103]) ([10.238.2.103])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 17:30:02 -0700
Message-ID: <97bd275d-d279-4000-b1e0-75a2022fa49e@linux.intel.com>
Date: Thu, 17 Sep 2026 08:29:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf topdown: Don't require config1==0 for a slots event
To: Zide Chen <zide.chen@intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 James Clark <james.clark@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, thomas.falcon@intel.com,
 xudong.hao@intel.com
References: <20260916202740.257376-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260916202740.257376-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 9/17/2026 4:27 AM, Zide Chen wrote:
> arch_is_topdown_slots() requires config1 == 0, so it misidentified
> "cpu/slots,metrics_clear=1/" as not being the slots event, and an
> additional slots event gets inserted, which fails event scheduling
> since the group now needs two fixed counter 3.
>
>   $ perf stat -e "{cpu/slots,metrics_clear=1/,cpu/topdown-retiring/}" -- sleep 1
>   WARNING: events were regrouped to match PMUs
>        <not counted>      slots
>      <not supported>      cpu/slots,metrics_clear=1/
>        <not counted>      cpu/topdown-retiring/
>
> Drop the config1 == 0 check from arch_is_topdown_slots(). This is
> safe: config1 has no bearing on the event's identifying config value
> (TOPDOWN_SLOTS, 0x0400).
>
> The attr.type == PERF_TYPE_RAW check is what actually matters: only the
> core PMU is registered with PERF_TYPE_RAW, and on x86, 0x400 is
> guaranteed to be slots event on core CPU.
>
> arch_is_topdown_metrics() keeps its own config1 == 0 check, since
> genuine metrics events have no "metrics_clear" and config1 remains 0.
>
> Add a test verifying that an explicit "slots,metrics_clear=1" event in
> a group does not trigger an extra slots event injection.
>
> Fixes: 5b546de9cc17 ("perf topdown: Use attribute to see an event is a topdown metic or slots")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  tools/perf/arch/x86/tests/topdown.c | 28 ++++++++++++++++++++++++++++
>  tools/perf/arch/x86/util/topdown.c  |  3 +--
>  2 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
> index 2b6f47ce4932..b1ce9f83db00 100644
> --- a/tools/perf/arch/x86/tests/topdown.c
> +++ b/tools/perf/arch/x86/tests/topdown.c
> @@ -229,10 +229,38 @@ static int test__x86_topdown_slots_injection(struct test_suite *test __maybe_unu
>  	return TEST_OK;
>  }
>  
> +/*
> + * An explicit "slots,metrics_clear=1" event is still the slots event and
> + * must not cause an extra slots event to be injected into the group.
> + */
> +static int test__x86_topdown_metrics_clear(struct test_suite *test __maybe_unused,
> +					   int subtest __maybe_unused)
> +{
> +	struct perf_pmu *pmu;
> +	char event_str[128];
> +	int ret;
> +
> +	if (!topdown_sys_has_perf_metrics())
> +		return TEST_OK;
> +
> +	pmu = perf_pmus__find_by_type(PERF_TYPE_RAW);
> +	if (!pmu || !perf_pmu__has_format(pmu, "metrics_clear"))
> +		return TEST_OK;
> +
> +	snprintf(event_str, sizeof(event_str),
> +		 "{%s/slots,metrics_clear=1/,%s/topdown-retiring/}",
> +		 pmu->name, pmu->name);
> +	ret = test_sort(event_str, 2, 1);
> +	TEST_ASSERT_EQUAL("explicit metrics_clear slots event isn't duplicated", ret, TEST_OK);
> +
> +	return TEST_OK;
> +}
> +
>  static struct test_case x86_topdown_tests[] = {
>  	TEST_CASE("topdown events", x86_topdown),
>  	TEST_CASE("topdown sorting", x86_topdown_sorting),
>  	TEST_CASE("topdown slots injection", x86_topdown_slots_injection),
> +	TEST_CASE("topdown metrics_clear no extra slots", x86_topdown_metrics_clear),
>  	{ .name = NULL, }
>  };
>  
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index bafd285119d7..64bc64e335a2 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -37,8 +37,7 @@ bool topdown_sys_has_perf_metrics(void)
>  bool arch_is_topdown_slots(const struct evsel *evsel)
>  {
>  	return evsel->core.attr.type == PERF_TYPE_RAW &&
> -	       evsel->core.attr.config == TOPDOWN_SLOTS &&
> -	       evsel->core.attr.config1 == 0;
> +	       evsel->core.attr.config == TOPDOWN_SLOTS;
>  }
>  
>  bool arch_is_topdown_metrics(const struct evsel *evsel)
