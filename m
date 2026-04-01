Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86EB26E711;
	Wed,  1 Apr 2026 03:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014423; cv=none; b=bgJgqBnqHXml/9uZZaRd4e6IxaByDRPdRAdHa4C4CBYvjEoVn+GxOEx19VQElKM9FTKFFaAIaQpX5vuxOnPrfSg6yRZXdTyKxxUTPh5cEMA8I/Ds3Wds7ZGXYsQ+BCq1iaVyzEA5EuVPP54XB0EdJNLPNwQxdxX4vwFaFsO+WJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014423; c=relaxed/simple;
	bh=MsIHcnNE/2NC6JK0y+0LkdkqoWno6lOAjHYKldqSoT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpllCnKXvMmCkv9TOPwEHD/hq6MPklGc0cfhwN531Q75gFn/y8MusY8DJnsMZtooTjU4haar6grbCbOVdxfcqeNTEqipVBQ9AQPipeljCIOVGRwWKX3JjH2Q9jiaXlw/qkvNTBfCq8TTlL/HKi3tR7VQz/G28pjj5qW9WX9MHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf3Iu63a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf3Iu63a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E149DC4CEF7;
	Wed,  1 Apr 2026 03:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775014423;
	bh=MsIHcnNE/2NC6JK0y+0LkdkqoWno6lOAjHYKldqSoT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mf3Iu63av+RO84JHr5UkjY2VMi7oPXd+r3U5TCLPLwnrB76QRfKsiiOOkYPBHY5mb
	 NXrB86/a1iZHNr/b1qf/2TUJVRh0RgIRrl0yFbemAbZz+GjUVmxrOsue0vtT3Ctzcu
	 59t5UAmce+eINYERbOuZc/PuDj44Kr8uxYlBmvl8FoQE9b8LC1Qgw2vLxCDEynJbU8
	 CdKrPk8gk3yGby6x/fYEwpGJkpadH25SWxUxyjYnMC7NnrYkFnBZrxnw8rHtCbutGm
	 9V945MnAy/yDRd1H5RWghVgYRcA1P2sOXmuUGo1SKysyP0rU7SHUSfQJqvIuf+Bbd/
	 Ef5ykE5bAgB9A==
Date: Tue, 31 Mar 2026 20:33:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: 9erthalion6@gmail.com, acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, collin.funk1@gmail.com,
	german.gomez@arm.com, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, zide.chen@intel.com
Subject: Re: [PATCH v3 2/2] perf arch x86 tests: Add test for topdown event
 sorting
Message-ID: <acySFKORtDwArHXl@google.com>
References: <20260331165207.4016392-1-irogers@google.com>
 <20260331185419.4085479-1-irogers@google.com>
 <20260331185419.4085479-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331185419.4085479-3-irogers@google.com>

On Tue, Mar 31, 2026 at 11:54:19AM -0700, Ian Rogers wrote:
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
> Tested-by: Zide Chen <zide.chen@intel.com>
> ---
>  tools/perf/arch/x86/tests/topdown.c | 134 +++++++++++++++++++++++++++-
>  1 file changed, 133 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
> index 3ee4e5e71be3..ee8d673a0e7b 100644
> --- a/tools/perf/arch/x86/tests/topdown.c
> +++ b/tools/perf/arch/x86/tests/topdown.c
> @@ -75,4 +75,136 @@ static int test__x86_topdown(struct test_suite *test __maybe_unused, int subtest
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
> +	int ret = TEST_FAIL;
> +	bool slots_seen = false;
> +
> +	evlist = evlist__new();
> +	if (!evlist)
> +		return TEST_FAIL;
> +
> +	parse_events_error__init(&err);
> +	ret = parse_events(evlist, str, &err);
> +	if (ret) {
> +		pr_debug("parse_events failed for %s\n", str);

It should set ret to TEST_FAIL.  I'll add that this time.

Thanks,
Namhyung


> +		goto out_err;
> +	}
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (!evsel__is_group_leader(evsel))
> +			continue;
> +
> +		if (strstr(evsel__name(evsel), "slots")) {
> +			/*
> +			 * Slots as a leader means the PMU is for a perf metric
> +			 * group as the slots event isn't present when not.
> +			 */
> +			slots_seen = true;
> +			TEST_ASSERT_EQUAL("slots group size", evsel->core.nr_members,
> +					expected_slots_group_size);
> +			if (expected_slots_group_size == 3) {
> +				struct evsel *next = evsel__next(evsel);
> +				struct evsel *next2 = evsel__next(next);
> +
> +				TEST_ASSERT_VAL("slots second event is instructions",
> +						strstr(evsel__name(next), "instructions")
> +						!= NULL);
> +				TEST_ASSERT_VAL("slots third event is topdown-retiring",
> +						strstr(evsel__name(next2), "topdown-retiring")
> +						!= NULL);
> +			} else if (expected_slots_group_size == 2) {
> +				struct evsel *next = evsel__next(evsel);
> +
> +				TEST_ASSERT_VAL("slots second event is topdown-retiring",
> +						strstr(evsel__name(next), "topdown-retiring")
> +						!= NULL);
> +			}
> +		} else if (strstr(evsel__name(evsel), "instructions")) {
> +			TEST_ASSERT_EQUAL("instructions group size", evsel->core.nr_members,
> +					  expected_instructions_group_size);
> +			if (expected_instructions_group_size == 2) {
> +				/*
> +				 * The instructions event leads a group with a
> +				 * topdown-retiring event, neither of which need
> +				 * reordering for perf metric event support.
> +				 */
> +				struct evsel *next = evsel__next(evsel);
> +
> +				TEST_ASSERT_VAL("instructions second event is topdown-retiring",
> +						strstr(evsel__name(next), "topdown-retiring")
> +						!= NULL);
> +			}
> +		} else if (strstr(evsel__name(evsel), "topdown-retiring")) {
> +			/*
> +			 * A perf metric event where the PMU doesn't require
> +			 * slots as a leader.
> +			 */
> +			TEST_ASSERT_EQUAL("topdown-retiring group size", evsel->core.nr_members, 1);
> +		} else if (strstr(evsel__name(evsel), "cycles")) {
> +			TEST_ASSERT_EQUAL("cycles group size", evsel->core.nr_members, 1);
> +		}
> +	}
> +	TEST_ASSERT_VAL("slots seen", slots_seen);
> +	ret = TEST_OK;
> +out_err:
> +	evlist__delete(evlist);
> +	parse_events_error__exit(&err);
> +	return ret;
> +}
> +
> +static int test__x86_topdown_sorting(struct test_suite *test __maybe_unused,
> +				     int subtest __maybe_unused)
> +{
> +	if (!topdown_sys_has_perf_metrics())
> +		return TEST_OK;
> +
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
> -- 
> 2.53.0.1118.gaef5881109-goog
> 
