Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF972222A9;
	Tue, 31 Mar 2026 03:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774926522; cv=none; b=OImnhZ2A/BPG2B11VFfoY5oaaHEfisdU1TVcJmY6325Y+hke1AmtmpgnP2OZBuaBTQfu9VBJt8Nfnv/nVQXe2P2+GuEUT3HkcZRmasq9ItKWw/eoXegBUF2430TlWGIe6oHC3fLikKco08GvEET+6DFEGM9O/3Ha9jQ/XqaZDSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774926522; c=relaxed/simple;
	bh=gAB1I798vQbwoQFeZbpkMQ3UGt72dmKOgU+Lc1R66Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbF65jzssoNuXa9dbLQ0fkHQsHSXnbpn3Jparag074liOSukNk27/jqRzM8/EHDB2ucvguzbgCFmnQ4QVvgz6DRMkMOtIT84y1o6dE2R+CKx7MC69F+E2B+mg/iQTSTcbg4bjMoI7IaqpWnqCDPRnIbsypsxVNdSspPQZFc+fMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZNJ/rg9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZNJ/rg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B08FC4CEF7;
	Tue, 31 Mar 2026 03:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774926521;
	bh=gAB1I798vQbwoQFeZbpkMQ3UGt72dmKOgU+Lc1R66Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZNJ/rg9pZrpHunbP7KXqnm55rndYnIzTAyYUfOQetvAQZ1Hun/jhWIWD7YmMhhkg
	 tPfgqMaIhEiRprRzyXIc4G9JKeHHmw/05l/vnuQttR5YJboiS5EEO0XmGJGAjdUtso
	 8l1kzbFZZVmBtpDzM2PNf+Jm1dh1n6KG8Wm+CV38Vfg36sRJCdmA+FXJp7vdn3YngU
	 OLwoHNaqJGAepuDaMujJC6EX6LPvFS1xbkIBVlj+MBvRAuaI+H+1glwfWxYrjvuGOw
	 j96S2Cs3wYtr6l/wzAwY7TJF/bBAgK1Aq2dpnJJy9QCHihPTo0ytL/uVbkalpNIRnb
	 9RzPsgP0+rdnA==
Date: Mon, 30 Mar 2026 20:08:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf arch x86 tests: Add test for topdown event
 sorting
Message-ID: <acs6txqcncbwCFZA@google.com>
References: <20260325183045.1229502-1-irogers@google.com>
 <20260325183045.1229502-3-irogers@google.com>
 <51dd73f1-d5b1-4fec-b94d-5a57bfb409c1@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51dd73f1-d5b1-4fec-b94d-5a57bfb409c1@intel.com>

On Mon, Mar 30, 2026 at 02:53:45PM -0700, Chen, Zide wrote:
> 
> 
> On 3/25/2026 11:30 AM, Ian Rogers wrote:
> > Add a test to capture the comment in
> > tools/perf/arch/x86/util/evlist.c. Test that slots and
> > topdown-retiring get appropriately sorted with respect to instructions
> > when they're all specified together. When the PMU requires topdown
> > event grouping (indicated by the pressence of the slots event) metric
> > events should be after slots, which should be the group leader.
> > 
> > Add a related test that when the slots event isn't given it is
> > injected into the appropriate group.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/tests/topdown.c | 137 +++++++++++++++++++++++++++-
> >  1 file changed, 136 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
> > index 3ee4e5e71be3..aca7faa16fc7 100644
> > --- a/tools/perf/arch/x86/tests/topdown.c
> > +++ b/tools/perf/arch/x86/tests/topdown.c
> > @@ -75,4 +75,139 @@ static int test__x86_topdown(struct test_suite *test __maybe_unused, int subtest
> >  	return ret;
> >  }
> >  
> > -DEFINE_SUITE("x86 topdown", x86_topdown);
> > +static int test_sort(const char *str, int expected_slots_group_size,
> > +		     int expected_instructions_group_size)
> > +{
> > +	struct evlist *evlist;
> > +	struct parse_events_error err;
> > +	struct evsel *evsel;
> > +	int ret;
> > +
> > +	evlist = evlist__new();
> > +	if (!evlist)
> > +		return TEST_FAIL;
> > +
> > +	parse_events_error__init(&err);
> > +	ret = parse_events(evlist, str, &err);
> > +	if (ret) {
> > +		pr_debug("parse_events failed for %s\n", str);
> > +		goto out_err;
> > +	}
> > +
> > +	evlist__for_each_entry(evlist, evsel) {
> > +		if (evsel__is_group_leader(evsel)) {

Same thing.  Please reduce the indentation.


> > +			if (strstr(evsel->name, "slots")) {
> > +				/*
> > +				 * Slots as a leader means the PMU is for a perf
> > +				 * metric group as the slots event isn't present
> > +				 * when not.
> > +				 */
> > +				TEST_ASSERT_EQUAL("slots group size", evsel->core.nr_members,
> > +						  expected_slots_group_size);
> > +				if (expected_slots_group_size == 3) {
> > +					struct evsel *next = evsel__next(evsel);
> > +					struct evsel *next2 = evsel__next(next);
> > +
> > +					TEST_ASSERT_VAL("slots second event is instructions",
> > +							strstr(next->name, "instructions")
> > +							!= NULL);
> > +					TEST_ASSERT_VAL("slots third event is topdown-retiring",
> > +							strstr(next2->name, "topdown-retiring")
> > +							!= NULL);
> > +				} else if (expected_slots_group_size == 2) {
> > +					struct evsel *next = evsel__next(evsel);
> > +
> > +					TEST_ASSERT_VAL("slots second event is topdown-retiring",
> > +							strstr(next->name, "topdown-retiring")
> > +							!= NULL);
> > +				}
> > +			} else if (strstr(evsel->name, "instructions")) {
> > +				TEST_ASSERT_EQUAL("instructions group size", evsel->core.nr_members,
> > +						  expected_instructions_group_size);
> > +				if (expected_instructions_group_size == 2) {
> > +					/*
> > +					 * The instructions event leads a group
> > +					 * with a topdown-retiring event,
> > +					 * neither of which need reordering for
> > +					 * perf metric event support.
> > +					 */
> > +					struct evsel *next = evsel__next(evsel);
> > +
> > +					TEST_ASSERT_VAL("instructions second event is topdown-retiring",
> > +							strstr(next->name, "topdown-retiring")
> > +							!= NULL);
> > +				}
> > +			} else if (strstr(evsel->name, "topdown-retiring")) {
> > +				/*
> > +				 * A perf metric event where the PMU doesn't
> > +				 * require slots as a leader.
> > +				 */
> > +				TEST_ASSERT_EQUAL("topdown-retiring group size",
> > +						  evsel->core.nr_members, 1);
> > +			} else if (strstr(evsel->name, "cycles")) {
> > +				TEST_ASSERT_EQUAL("cycles group size", evsel->core.nr_members, 1);
> > +			}
> > +		}
> > +	}
> > +
> > +	evlist__delete(evlist);
> > +	parse_events_error__exit(&err);
> > +	return TEST_OK;
> > +
> > +out_err:
> > +	evlist__delete(evlist);
> > +	parse_events_error__exit(&err);
> > +	return TEST_FAIL;

Also, please share the code and use a different return value.

> > +}
> > +
> > +static int test__x86_topdown_sorting(struct test_suite *test __maybe_unused,
> > +				     int subtest __maybe_unused)
> > +{
> > +	if (!topdown_sys_has_perf_metrics())
> > +		return TEST_OK;
> 
> I'm wondering if it makes more sense to return TEST_SKIP? As well as for
> other calls to topdown_sys_has_perf_metrics().

Makes sense.

Thanks,
Namhyung

> 
> Other than that, Tested-by: Zide Chen <zide.chen@intel.com>
> 
> 
> 
> > +	TEST_ASSERT_EQUAL("all events in a group",
> > +			  test_sort("{instructions,topdown-retiring,slots}", 3, 2), TEST_OK);
> > +	TEST_ASSERT_EQUAL("all events not in a group",
> > +			  test_sort("instructions,topdown-retiring,slots", 2, 1), TEST_OK);
> > +	TEST_ASSERT_EQUAL("slots event in a group but topdown metrics events outside the group",
> > +			  test_sort("{instructions,slots},topdown-retiring", 2, 1), TEST_OK);
> > +	TEST_ASSERT_EQUAL("slots event and topdown metrics events in two groups",
> > +			  test_sort("{instructions,slots},{topdown-retiring}", 2, 1), TEST_OK);
> > +	TEST_ASSERT_EQUAL("slots event and metrics event are not in a group and not adjacent",
> > +			  test_sort("{instructions,slots},cycles,topdown-retiring", 2, 1), TEST_OK);
> > +
> > +	return TEST_OK;
> > +}
> > +
> > +static int test__x86_topdown_slots_injection(struct test_suite *test __maybe_unused,
> > +					     int subtest __maybe_unused)
> > +{
> > +	if (!topdown_sys_has_perf_metrics())
> > +		return TEST_OK;
> > +
> > +	TEST_ASSERT_EQUAL("all events in a group",
> > +			  test_sort("{instructions,topdown-retiring}", 3, 2), TEST_OK);
> > +	TEST_ASSERT_EQUAL("all events not in a group",
> > +			  test_sort("instructions,topdown-retiring", 2, 1), TEST_OK);
> > +	TEST_ASSERT_EQUAL("event in a group but topdown metrics events outside the group",
> > +			  test_sort("{instructions},topdown-retiring", 2, 1), TEST_OK);
> > +	TEST_ASSERT_EQUAL("event and topdown metrics events in two groups",
> > +			  test_sort("{instructions},{topdown-retiring}", 2, 1), TEST_OK);
> > +	TEST_ASSERT_EQUAL("event and metrics event are not in a group and not adjacent",
> > +			  test_sort("{instructions},cycles,topdown-retiring", 2, 1), TEST_OK);
> > +
> > +	return TEST_OK;
> > +}
> > +
> > +static struct test_case x86_topdown_tests[] = {
> > +	TEST_CASE("topdown events", x86_topdown),
> > +	TEST_CASE("topdown sorting", x86_topdown_sorting),
> > +	TEST_CASE("topdown slots injection", x86_topdown_slots_injection),
> > +	{ .name = NULL, }
> > +};
> > +
> > +struct test_suite suite__x86_topdown = {
> > +	.desc = "x86 topdown",
> > +	.test_cases = x86_topdown_tests,
> > +};
> 
