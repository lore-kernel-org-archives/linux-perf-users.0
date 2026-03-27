Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2FB74BE1;
	Fri, 27 Mar 2026 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774589901; cv=none; b=epKHuCJ0mOYgtMGgNXC9hQg3SeSyt8MUvpUDaQk2ejAINFaSHUg4wi/+B+VEwG/zUGxh1ybOJ0jnLYnYLxe9QadIuCaEm9229zBC57yWenkfFSBMqGE7bx+aPDAaFngdJ16Fy4Ux5aKVbvYQdNpOodb8+4GPLGlvI9BpoljO5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774589901; c=relaxed/simple;
	bh=vYLovzrJNJYkrFl1U4gdC5/1/eSWIqwAkeqz77SJxDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbsj6miLRFJGRSYmyg+evRHPoh5ZzZ/KbJlE6ErQ9fsv0MBqH21R9dVLQv0YOUMRWglQ3VuNEM+hG5f9RUq3ZfMDRqfN6E3gAW1li1rqc0xUAKgFaIvkk3NgosVcTl0hQBH2XyUfwcX1gruE8SLmfYzmnbgZjHfdofix/4oYcx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8BENdOg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8BENdOg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774589900; x=1806125900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vYLovzrJNJYkrFl1U4gdC5/1/eSWIqwAkeqz77SJxDw=;
  b=n8BENdOg81XKX2nkhYnNzZWHbZwwfa0FQ+aK5QbOYaSPE4slc8EPzKU7
   YYLBNh20xZF/2LAEms3+jnneV/hA+INZhqQSIAST8Gck4f7AUgxXn3rwb
   MQkm7skJ4Pxll96dQk2N/I7Os+CxV71GCTHDBhVsD7diKRv2PQNppKyih
   BL3aV81EvPe/zBr3fuaiOXFFZVWvadov4HtC5wYOw8z/kXWtCtQl1OAoa
   pXz/1OpOXW6jC49SLxqIkSJgRkY3fgRlHuv9UFzlisvrFylo/3JgUD9Ru
   1tzrWpyMoqV7TeOdyFQ6y31zlMEBAIUWQaIadtzL1Qzcvb3dw2vu9ldtT
   Q==;
X-CSE-ConnectionGUID: pHpbNbN4Rqi5hPyF4b8e4g==
X-CSE-MsgGUID: 5cHEBQe6T+CIsi4EZXXcmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="87041492"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="87041492"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 22:38:19 -0700
X-CSE-ConnectionGUID: 3gll741dQcKKAc/9ga4jGQ==
X-CSE-MsgGUID: hMigtbVVRxqD5gf9NaFC3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="263123973"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 22:38:16 -0700
Message-ID: <54f219fc-897a-48ef-871d-9e6ea49f8c0f@linux.intel.com>
Date: Fri, 27 Mar 2026 13:38:13 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tools/perf: Fix ratio_to_prev event parsing test
To: Thomas Falcon <thomas.falcon@intel.com>,
 linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>
References: <CAP-5=fUFGevUhRROdybtDCXZgWgxYzfLrq_0f8r5_Yv_VfxP+A@mail.gmail.com>
 <20260327015927.223999-1-thomas.falcon@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260327015927.223999-1-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 3/27/2026 9:59 AM, Thomas Falcon wrote:
> test__ratio_to_prev() assumed the first event in a group is the leader,
> which is not the case when the event is expanded into two event groups
> on hybrid PMU's with auto counter reload support. Instead, iterate over the
> event group generated for each core PMU. Also update "wrong leader" test to
> check that the subordinate event has the correct leader instead of checking
> that it is not the group leader. Finally, do not exit immediately if a PMU
> without auto counter reload support is found.
>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> Fixes: 56be0fe5f62c ("perf record: Add auto counter reload parse and regression tests")
> ---
> v3: Fixed early loop termination if PMU without auto counter reload support is
>     encountered first, suggested by Ian Rogers
> https://lore.kernel.org/all/CAP-5=fUFGevUhRROdybtDCXZgWgxYzfLrq_0f8r5_Yv_VfxP+A@mail.gmail.com/
>
> v2: made changes suggested by Dapeng Mi
> https://lore.kernel.org/all/997b6291-7429-4eaa-8467-1fd88e100616@linux.intel.com/
> ---
>
>  tools/perf/tests/parse-events.c | 49 +++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 21 deletions(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 1d3cc224f..05c3e899b 100644
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
> -		if (!perf_pmu__has_format(evsel->pmu, "acr_mask"))
> -			return TEST_OK;
> -
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
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (evsel != evsel__leader(evsel) ||
> +		    !perf_pmu__has_format(evsel->pmu, "acr_mask")) {
> +			continue;
>  		}
> +		leader = evsel;
> +		/* cycles */
> +		TEST_ASSERT_VAL("wrong config2", 0 == leader->core.attr.config2);
> +		TEST_ASSERT_VAL("wrong core.nr_members", leader->core.nr_members == 2);
> +		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(leader) == 0);
> +		TEST_ASSERT_EVSEL("unexpected event",
> +				  evsel__match(leader, HARDWARE, HW_CPU_CYCLES),
> +				  leader);
> +		/*
> +		 * The period value gets configured within evlist__config,
> +		 * while this test executes only parse events method.
> +		 */
> +		TEST_ASSERT_VAL("wrong period", 0 == leader->core.attr.sample_period);
> +
> +		 /* instructions/period=200000,ratio-to-prev=2.0/ */
> +		evsel = evsel__next(evsel);
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
