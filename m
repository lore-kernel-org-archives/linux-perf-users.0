Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C878F59;
	Tue, 31 Mar 2026 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774926373; cv=none; b=hPH6KBzmXmxQYUlh+4sE78tIeItRMSuClOp8tQET4KTBUOmwlpMvL78mhRAwjZViUAg2Wmix8ex7a1KaoNcLOvdSslzg14T/eagd9q8OKcq/gxaQmsDBZdQ7KQYnYPIKsIuR10cbKvLd1qLl5NcDFhHZfq26NzdW+69njLeoBBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774926373; c=relaxed/simple;
	bh=5Smner0zgl4+3+SGrmvNNFv7/cjf/Kerm21y3zNNIcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBBOjQFRrVz5Bz9zWDHrKI8OOXT2h24v7VZOoY0O/3rdWaDS4iitXDJsfDLtHouaYyDaIigPUYH+5NBEPYehPZiMcabsYrt4fBglxDQ1mDK3zs5yKPt2oDH2aJoCwfdg8+ZxAhI4jKbeYQL8sPXWKgJIdLR0vISqqldM9ssjb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZPj8My+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZPj8My+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661C9C4CEF7;
	Tue, 31 Mar 2026 03:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774926372;
	bh=5Smner0zgl4+3+SGrmvNNFv7/cjf/Kerm21y3zNNIcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZPj8My+0/nQLOEvDoKpfFWco1S2NcLzx/w9mwbVGtCc0hXncot7UGtKLOt8mn4O4
	 WYZh+0Zh7XAnFRsc4a8tpzddjvuv+M/bB6DEq6yNlVt7DxJ44C3ZjJTVxNH49VT44i
	 jzx4K4z9HBbvhhORswuo0mdNIewLVh0bbOHscL4enktDucWdO6p9SKZnct0N3PgFI0
	 xER3AmS//arWSvB48djQC3R6ZS/R5JkRX2xyngOD0rPELQIP3YBxtEriKcmm/wtngz
	 wbO74J0pEE4ZPQ8RqacSaaJyfCZhFSeZWj0NyuiwSOWxbFaStRThFxy8QQGAUxVVMS
	 4TpgqWTtiIeQg==
Date: Mon, 30 Mar 2026 20:06:10 -0700
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
Subject: Re: [PATCH v1 1/2] perf tests: Add test for uncore event sorting
Message-ID: <acs6Isec7qNVi1wh@google.com>
References: <20260325183045.1229502-1-irogers@google.com>
 <20260325183045.1229502-2-irogers@google.com>
 <4952de45-eb76-46cc-9a42-f93ec5666175@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4952de45-eb76-46cc-9a42-f93ec5666175@intel.com>

Hi Ian,

Just a few nitpicks.

On Fri, Mar 27, 2026 at 04:36:47PM -0700, Chen, Zide wrote:
> 
> 
> On 3/25/2026 11:30 AM, Ian Rogers wrote:
> > Add a test for uncore event sorting matching multiple PMUs. Uncore
> > PMUs may have a common prefix, like the PMUs uncore_imc_free_running_0
> > and uncore_imc_free_running_1 have a prefix of
> > uncore_imc_free_running. Parsing an event group like
> > "{data_read,data_write}" for those PMUs should result with two groups
> > "{uncore_imc_free_running_0/data_read/,uncore_imc_free_running_0/data_write/},
> > {uncore_imc_free_running_1/data_read/,uncore_imc_free_running_1/data_write/}"
> > which means the evsels need resorting as when initially parsed the
> > evsels are ordered with mixed PMUs:
> > "{uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_read/,
> > uncore_imc_free_running_0/data_write/,uncore_imc_free_running_1/data_write/}".
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> 
> Tested-by: Zide Chen <zide.chen@intel.com>
> 
> >  tools/perf/tests/Build                  |   1 +
> >  tools/perf/tests/builtin-test.c         |   1 +
> >  tools/perf/tests/tests.h                |   1 +
> >  tools/perf/tests/uncore-event-sorting.c | 125 ++++++++++++++++++++++++
> >  4 files changed, 128 insertions(+)
> >  create mode 100644 tools/perf/tests/uncore-event-sorting.c
> > 
> > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > index c2a67ce45941..66944a4f4968 100644
> > --- a/tools/perf/tests/Build
> > +++ b/tools/perf/tests/Build
> > @@ -3,6 +3,7 @@
> >  perf-test-y += builtin-test.o
> >  perf-test-y += tests-scripts.o
> >  perf-test-y += parse-events.o
> > +perf-test-y += uncore-event-sorting.o
> >  perf-test-y += dso-data.o
> >  perf-test-y += vmlinux-kallsyms.o
> >  perf-test-y += openat-syscall.o
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index 06507066213b..f2c135891477 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -71,6 +71,7 @@ static struct test_suite *generic_tests[] = {
> >  	&suite__basic_mmap,
> >  	&suite__mem,
> >  	&suite__parse_events,
> > +	&suite__uncore_event_sorting,
> >  	&suite__expr,
> >  	&suite__PERF_RECORD,
> >  	&suite__pmu,
> > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > index f5f1238d1f7f..ee00518bf36f 100644
> > --- a/tools/perf/tests/tests.h
> > +++ b/tools/perf/tests/tests.h
> > @@ -177,6 +177,7 @@ DECLARE_SUITE(sigtrap);
> >  DECLARE_SUITE(event_groups);
> >  DECLARE_SUITE(symbols);
> >  DECLARE_SUITE(util);
> > +DECLARE_SUITE(uncore_event_sorting);
> >  DECLARE_SUITE(subcmd_help);
> >  DECLARE_SUITE(kallsyms_split);
> >  
> > diff --git a/tools/perf/tests/uncore-event-sorting.c b/tools/perf/tests/uncore-event-sorting.c
> > new file mode 100644
> > index 000000000000..91e1a580709b
> > --- /dev/null
> > +++ b/tools/perf/tests/uncore-event-sorting.c
> > @@ -0,0 +1,125 @@
> > +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +#include "tests.h"
> > +#include "debug.h"
> > +#include "parse-events.h"
> > +#include "pmu.h"
> > +#include "pmus.h"
> > +#include "evlist.h"
> > +#include <string.h>
> > +
> > +struct match_state {
> > +	char *event1;
> > +	char *event2;
> > +};
> > +
> > +static int event_cb(void *state, struct pmu_event_info *info)
> > +{
> > +	struct match_state *m = state;
> > +
> > +	if (!m->event1) {
> > +		m->event1 = strdup(info->name);
> > +	} else if (!m->event2) {
> > +		if (strcmp(m->event1, info->name)) {
> > +			m->event2 = strdup(info->name);
> > +			return 1;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int test__uncore_event_sorting(struct test_suite *test __maybe_unused,
> > +				      int subtest __maybe_unused)
> > +{
> > +	struct evlist *evlist;
> > +	struct parse_events_error err;
> > +	struct evsel *evsel;
> > +	struct perf_pmu *pmu = NULL;
> > +	char *pmu_prefix = NULL;
> > +	struct match_state m = { NULL, NULL };
> > +	char buf[1024];
> > +	int ret;
> > +
> > +	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> > +		size_t len;
> > +		struct perf_pmu *sibling;
> > +
> > +		if (pmu->is_core)
> > +			continue;
> > +
> > +		len = pmu_name_len_no_suffix(pmu->name);
> > +		if (len == strlen(pmu->name))
> > +			continue;
> > +
> > +		sibling = pmu;
> > +		while ((sibling = perf_pmus__scan(sibling)) != NULL) {
> > +			if (sibling->is_core)
> > +				continue;
> > +			if (pmu_name_len_no_suffix(sibling->name) == len &&
> > +			    !strncmp(pmu->name, sibling->name, len))
> > +				break;
> > +		}
> > +
> > +		if (!sibling)
> > +			continue;
> > +
> > +		m.event1 = m.event2 = NULL;
> > +		perf_pmu__for_each_event(pmu, false, &m, event_cb);
> > +
> > +		if (m.event1 && m.event2) {
> > +			pmu_prefix = strndup(pmu->name, len);
> > +			break;
> > +		}
> > +		free(m.event1);
> > +	}
> > +
> > +	if (!pmu_prefix) {
> > +		pr_debug("No suitable uncore PMU found\n");
> > +		return TEST_SKIP;
> > +	}
> > +
> > +	evlist = evlist__new();
> > +	if (!evlist)
> > +		return TEST_FAIL;
> > +
> > +	snprintf(buf, sizeof(buf), "{%s/%s/,%s/%s/}",
> > +		 pmu_prefix, m.event1, pmu_prefix, m.event2);
> > +	pr_debug("Parsing: %s\n", buf);
> > +
> > +	parse_events_error__init(&err);
> > +	ret = parse_events(evlist, buf, &err);
> > +	if (ret) {
> > +		pr_debug("parse_events failed\n");
> > +		goto out_err;
> > +	}
> > +
> > +	TEST_ASSERT_VAL("Number of events is > 0", evlist->core.nr_entries > 0);
> > +	TEST_ASSERT_EQUAL("Number of events is a multiple of 2", evlist->core.nr_entries % 2, 0);

It'd be nice if we can hide libperf details in general.  But I've
realized there's no API in libperf to return the number of entries
in evlist. :(

> > +
> > +	evlist__for_each_entry(evlist, evsel) {
> > +		if (evsel__is_group_leader(evsel)) {

You can skip the loop if it's not a leader and reduce a level of
indentation.


> > +			struct evsel *next = evsel__next(evsel);
> > +
> > +			TEST_ASSERT_EQUAL("Group size is 2", evsel->core.nr_members, 2);
> > +			TEST_ASSERT_VAL("PMU match", evsel->pmu == next->pmu);
> > +			TEST_ASSERT_VAL("First event name", strstr(evsel->name, m.event1) != NULL);
> > +			TEST_ASSERT_VAL("Second event name", strstr(next->name, m.event2) != NULL);
> > +		}
> > +	}
> > +
> > +	evlist__delete(evlist);
> > +	parse_events_error__exit(&err);
> > +	free(pmu_prefix);
> > +	free(m.event1);
> > +	free(m.event2);
> > +	return TEST_OK;
> > +
> > +out_err:
> > +	evlist__delete(evlist);
> > +	parse_events_error__exit(&err);
> > +	free(pmu_prefix);
> > +	free(m.event1);
> > +	free(m.event2);
> > +	return TEST_FAIL;

Looks like the same logic.  Can we set a return value properly?

Thanks,
Namhyung


> > +}
> > +
> > +DEFINE_SUITE("Uncore event sorting", uncore_event_sorting);
> 
