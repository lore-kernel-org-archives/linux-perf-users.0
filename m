Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C4C3A7589;
	Mon, 30 Mar 2026 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907630; cv=none; b=ukneeCj8XfE2WWskcRfKykWtC96PbaD3rzuEZA4OhfjoAYY2Ii+QJOYssmsx/Wwf+JGP/zjToYHjgcK/xN9MGf4Ui1xVzRAqwh3GlDaPB93bifwwDb4Bz6ADmb4B0ieFQABp2yjx581y66fJZ68mTE8jds1l3weyTk0Z4B3Qe1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907630; c=relaxed/simple;
	bh=J7HmcXtpk/uYhgRTQvZ2NOEe0B573Qm8hH1eTjn8dBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A37uFjXEvsy9Mqh8p8DJzed9xzylxQbwx4qEbs+2TZg6caHMbBFgi+cUiJUuVt+fA0fAdWUuOa1zG81/PCllwQ/I0p/4z1M9wieTEC7OaNnyD9O3dszEqpPt0l6ZKVQYDqT3Y8igsNs9NBJOvRMFMBNLPcan4jmEBpw1rG8lYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S962qUaK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S962qUaK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774907628; x=1806443628;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=J7HmcXtpk/uYhgRTQvZ2NOEe0B573Qm8hH1eTjn8dBE=;
  b=S962qUaKObpOx1rxrFGF54W/Oa1KIXFKwsinYl6bynLTEZQnEE5mVEKK
   DwtmS+MI7+9THTbKQP2bdXE365/q8cYv62bTqMDeAaEdfum5fV960Qf2I
   lGVyu9doESk7u7Av5DuP0y/ULoisFhRmQ/J7BPPaRbhEZkZHtyz3jxXQE
   NYpuZpCBc23CItCKFVutA5bBQxSw91zb6OH+vqrTtx5GAGGiM4Dx6CvCr
   5pEKuvxdSw7TGCS7PwmGLs+DvD4bZxAp9cuqdhuxRUznWLvHJMQLnJ9LW
   x78qtHE43S85zDHGtSb8Zy+685Eojynt1TF7c0NsikOopO0t0lRfS1vmR
   Q==;
X-CSE-ConnectionGUID: 8FBv7MvzRF+/Ye4PXL16pA==
X-CSE-MsgGUID: ei1whkuTTIyN4NJ3oxKWSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86529505"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="86529505"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:53:46 -0700
X-CSE-ConnectionGUID: 4A/bUmqQTAOHkqimeOfuFA==
X-CSE-MsgGUID: zWlGGykkRgKw7vGgmQWuvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="230978012"
Received: from unknown (HELO [10.241.241.148]) ([10.241.241.148])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:53:45 -0700
Message-ID: <51dd73f1-d5b1-4fec-b94d-5a57bfb409c1@intel.com>
Date: Mon, 30 Mar 2026 14:53:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf arch x86 tests: Add test for topdown event
 sorting
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>,
 Dmitrii Dolgov <9erthalion6@gmail.com>, German Gomez <german.gomez@arm.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260325183045.1229502-1-irogers@google.com>
 <20260325183045.1229502-3-irogers@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260325183045.1229502-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/25/2026 11:30 AM, Ian Rogers wrote:
> Add a test to capture the comment in
> tools/perf/arch/x86/util/evlist.c. Test that slots and
> topdown-retiring get appropriately sorted with respect to instructions
> when they're all specified together. When the PMU requires topdown
> event grouping (indicated by the pressence of the slots event) metric
> events should be after slots, which should be the group leader.
> 
> Add a related test that when the slots event isn't given it is
> injected into the appropriate group.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/tests/topdown.c | 137 +++++++++++++++++++++++++++-
>  1 file changed, 136 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
> index 3ee4e5e71be3..aca7faa16fc7 100644
> --- a/tools/perf/arch/x86/tests/topdown.c
> +++ b/tools/perf/arch/x86/tests/topdown.c
> @@ -75,4 +75,139 @@ static int test__x86_topdown(struct test_suite *test __maybe_unused, int subtest
>  	return ret;
>  }
>  
> -DEFINE_SUITE("x86 topdown", x86_topdown);
> +static int test_sort(const char *str, int expected_slots_group_size,
> +		     int expected_instructions_group_size)
> +{
> +	struct evlist *evlist;
> +	struct parse_events_error err;
> +	struct evsel *evsel;
> +	int ret;
> +
> +	evlist = evlist__new();
> +	if (!evlist)
> +		return TEST_FAIL;
> +
> +	parse_events_error__init(&err);
> +	ret = parse_events(evlist, str, &err);
> +	if (ret) {
> +		pr_debug("parse_events failed for %s\n", str);
> +		goto out_err;
> +	}
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (evsel__is_group_leader(evsel)) {
> +			if (strstr(evsel->name, "slots")) {
> +				/*
> +				 * Slots as a leader means the PMU is for a perf
> +				 * metric group as the slots event isn't present
> +				 * when not.
> +				 */
> +				TEST_ASSERT_EQUAL("slots group size", evsel->core.nr_members,
> +						  expected_slots_group_size);
> +				if (expected_slots_group_size == 3) {
> +					struct evsel *next = evsel__next(evsel);
> +					struct evsel *next2 = evsel__next(next);
> +
> +					TEST_ASSERT_VAL("slots second event is instructions",
> +							strstr(next->name, "instructions")
> +							!= NULL);
> +					TEST_ASSERT_VAL("slots third event is topdown-retiring",
> +							strstr(next2->name, "topdown-retiring")
> +							!= NULL);
> +				} else if (expected_slots_group_size == 2) {
> +					struct evsel *next = evsel__next(evsel);
> +
> +					TEST_ASSERT_VAL("slots second event is topdown-retiring",
> +							strstr(next->name, "topdown-retiring")
> +							!= NULL);
> +				}
> +			} else if (strstr(evsel->name, "instructions")) {
> +				TEST_ASSERT_EQUAL("instructions group size", evsel->core.nr_members,
> +						  expected_instructions_group_size);
> +				if (expected_instructions_group_size == 2) {
> +					/*
> +					 * The instructions event leads a group
> +					 * with a topdown-retiring event,
> +					 * neither of which need reordering for
> +					 * perf metric event support.
> +					 */
> +					struct evsel *next = evsel__next(evsel);
> +
> +					TEST_ASSERT_VAL("instructions second event is topdown-retiring",
> +							strstr(next->name, "topdown-retiring")
> +							!= NULL);
> +				}
> +			} else if (strstr(evsel->name, "topdown-retiring")) {
> +				/*
> +				 * A perf metric event where the PMU doesn't
> +				 * require slots as a leader.
> +				 */
> +				TEST_ASSERT_EQUAL("topdown-retiring group size",
> +						  evsel->core.nr_members, 1);
> +			} else if (strstr(evsel->name, "cycles")) {
> +				TEST_ASSERT_EQUAL("cycles group size", evsel->core.nr_members, 1);
> +			}
> +		}
> +	}
> +
> +	evlist__delete(evlist);
> +	parse_events_error__exit(&err);
> +	return TEST_OK;
> +
> +out_err:
> +	evlist__delete(evlist);
> +	parse_events_error__exit(&err);
> +	return TEST_FAIL;
> +}
> +
> +static int test__x86_topdown_sorting(struct test_suite *test __maybe_unused,
> +				     int subtest __maybe_unused)
> +{
> +	if (!topdown_sys_has_perf_metrics())
> +		return TEST_OK;

I'm wondering if it makes more sense to return TEST_SKIP? As well as for
other calls to topdown_sys_has_perf_metrics().

Other than that, Tested-by: Zide Chen <zide.chen@intel.com>



> +	TEST_ASSERT_EQUAL("all events in a group",
> +			  test_sort("{instructions,topdown-retiring,slots}", 3, 2), TEST_OK);
> +	TEST_ASSERT_EQUAL("all events not in a group",
> +			  test_sort("instructions,topdown-retiring,slots", 2, 1), TEST_OK);
> +	TEST_ASSERT_EQUAL("slots event in a group but topdown metrics events outside the group",
> +			  test_sort("{instructions,slots},topdown-retiring", 2, 1), TEST_OK);
> +	TEST_ASSERT_EQUAL("slots event and topdown metrics events in two groups",
> +			  test_sort("{instructions,slots},{topdown-retiring}", 2, 1), TEST_OK);
> +	TEST_ASSERT_EQUAL("slots event and metrics event are not in a group and not adjacent",
> +			  test_sort("{instructions,slots},cycles,topdown-retiring", 2, 1), TEST_OK);
> +
> +	return TEST_OK;
> +}
> +
> +static int test__x86_topdown_slots_injection(struct test_suite *test __maybe_unused,
> +					     int subtest __maybe_unused)
> +{
> +	if (!topdown_sys_has_perf_metrics())
> +		return TEST_OK;
> +
> +	TEST_ASSERT_EQUAL("all events in a group",
> +			  test_sort("{instructions,topdown-retiring}", 3, 2), TEST_OK);
> +	TEST_ASSERT_EQUAL("all events not in a group",
> +			  test_sort("instructions,topdown-retiring", 2, 1), TEST_OK);
> +	TEST_ASSERT_EQUAL("event in a group but topdown metrics events outside the group",
> +			  test_sort("{instructions},topdown-retiring", 2, 1), TEST_OK);
> +	TEST_ASSERT_EQUAL("event and topdown metrics events in two groups",
> +			  test_sort("{instructions},{topdown-retiring}", 2, 1), TEST_OK);
> +	TEST_ASSERT_EQUAL("event and metrics event are not in a group and not adjacent",
> +			  test_sort("{instructions},cycles,topdown-retiring", 2, 1), TEST_OK);
> +
> +	return TEST_OK;
> +}
> +
> +static struct test_case x86_topdown_tests[] = {
> +	TEST_CASE("topdown events", x86_topdown),
> +	TEST_CASE("topdown sorting", x86_topdown_sorting),
> +	TEST_CASE("topdown slots injection", x86_topdown_slots_injection),
> +	{ .name = NULL, }
> +};
> +
> +struct test_suite suite__x86_topdown = {
> +	.desc = "x86 topdown",
> +	.test_cases = x86_topdown_tests,
> +};

