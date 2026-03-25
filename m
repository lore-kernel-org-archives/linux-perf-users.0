Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F8317BA2;
	Wed, 25 Mar 2026 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774408343; cv=none; b=KIgZcSFC75mXS2ToS9HHkuUMCEaTVBN6v4lKyVy8P4uzNNRybZ15DXn7YcGiKIqoshPFpUdpuJ42Wlu3MG4tvZZx7ZCudO2shMoRL/nwqo3NsJInbQVfQEDEaz4FOesg+CNPzDFw7zjZFRctSRqWvjpbZM8UKkiFzUWErfTAIiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774408343; c=relaxed/simple;
	bh=Q2eG7cR5L0mtw9UOvB+f2JpooCI3tVXEI/q4vkhFLlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqsDp+L0SvwWpBu/GRY2oVcyE6Z41QWAC6IxaC9xwhkck3J2J9ay+MmObeA3aTOiyELRlWQ1Gybrm/letRbziq3bQ+Vtl+RCLcLUgZ/ccs+rRxsHSEMKmU0P17L7L2Bn90URBNb3VqW/rlwEeYCZnESYE2Olw4LsMp2Ktv/zP8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRMxLM4R; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRMxLM4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774408340; x=1805944340;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q2eG7cR5L0mtw9UOvB+f2JpooCI3tVXEI/q4vkhFLlg=;
  b=bRMxLM4RMVxPjKwhOzwFBaPcxETgKHO32y4StIUIql5nSCzhi3XjKfBj
   ayB/0YGwWGVee4hmskV0k5NwPNcWCnfZFEJSofKy0yGukkCdpObm/x9s+
   SbBKhTFbO4Zawo99T6JgrfyrQ+v2fkpr0sortzfMQYuBNxZMvRpGYs5xJ
   w4n/4EoXj9sPInGyOy07PfGATx5D/2RVJPs1PT9nCssiS9mpUtfU+01jV
   Ia4rWA3PfiBC5N831HEOBhnlkAu0qAJdEwYR87INfadsn6VR16TLg3168
   RHOGHdKxUjUElDz/Nx1QiLI1xRT4wBelczdmruDvOhu1GEIGPRMWX3OWN
   g==;
X-CSE-ConnectionGUID: wSDUva2GQWGPWsI6UhFm6Q==
X-CSE-MsgGUID: HvN+gg3hT4KKUJ8SiMCkaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="98058886"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="98058886"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 20:12:20 -0700
X-CSE-ConnectionGUID: bShNW7dkTZ6zY7XdPv8IYg==
X-CSE-MsgGUID: wyf4RMOgQ/KFJME5ZS2amA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="226184113"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 20:12:18 -0700
Message-ID: <997b6291-7429-4eaa-8467-1fd88e100616@linux.intel.com>
Date: Wed, 25 Mar 2026 11:12:15 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/perf: Fix ratio_to_prev event parsing test
To: thomas.falcon@intel.com, linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
References: <20260324222517.18848-1-thomas.falcon@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260324222517.18848-1-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/25/2026 6:25 AM, thomas.falcon@intel.com wrote:
> From: Thomas Falcon <thomas.falcon@intel.com>
>
> test__ratio_to_prev() assumed the first event in a group is the leader,
> which is not the case when the event is expanded into two event groups
> on hybrid PMU's with auto counter reload support. This patch updates the
> test to iterate over the event group generated for each core PMU. Also
> update "wrong leader" test to check that the subordinate event has the
> correct leader instead of checking that it is not the group leader.
>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> Fixes: 56be0fe5f62c ("perf record: Add auto counter reload parse and regression tests")
> ---
>  tools/perf/tests/parse-events.c | 45 +++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 1d3cc224fbc2..cd48e6b2bb57 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -1796,31 +1796,38 @@ static bool test__acr_valid(void)
>  
>  static int test__ratio_to_prev(struct evlist *evlist)
>  {
> -	struct evsel *evsel;
> +	struct evsel *evsel, *leader;
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 2 * perf_pmus__num_core_pmus() == evlist->core.nr_entries);
>  
> -	 evlist__for_each_entry(evlist, evsel) {
> +	for (int i = 0; i < num_core_entries(evlist); i++) {
> +		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));

could we use the "leader" to replace "evsel" for all the "TEST_ASSERT_VAL"
of cycles event? That make code look more clearer. Then the above sentence
can be simplified to this,

```
leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));

```


>  		if (!perf_pmu__has_format(evsel->pmu, "acr_mask"))
>  			return TEST_OK;
>  
> -		if (evsel == evlist__first(evlist)) {
> -			TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
> -			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> -			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
> -			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> -			TEST_ASSERT_EVSEL("unexpected event",
> -					evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
> -					evsel);
> -		} else {
> -			TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
> -			TEST_ASSERT_VAL("wrong leader", !evsel__is_group_leader(evsel));
> -			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 0);
> -			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
> -			TEST_ASSERT_EVSEL("unexpected event",
> -					evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS),
> -					evsel);
> -		}
> +		/* cycles */
> +		TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
> +		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> +		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
> +		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> +		TEST_ASSERT_EVSEL("unexpected event",
> +				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
> +				  evsel);
> +		/*
> +		 * The period value gets configured within evlist__config,
> +		 * while this test executes only parse events method.
> +		 */
> +		TEST_ASSERT_VAL("wrong period", 0 == evsel->core.attr.sample_period);
> +
> +		 /* instructions/period=200000,ratio-to-prev=2.0/ */
> +		evsel = evsel__next(evsel);

and here, the code needs to be changed to

```

evsel = evsel__next(leader);

```


> +		TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
> +		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> +		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 0);
> +		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
> +		TEST_ASSERT_EVSEL("unexpected event",
> +				  evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS),
> +				  evsel);
>  		/*
>  		 * The period value gets configured within evlist__config,
>  		 * while this test executes only parse events method.
