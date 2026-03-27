Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C533D4F2;
	Fri, 27 Mar 2026 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654611; cv=none; b=r133qWVrkUW8nUqJGYIImC3KsXkQWvoR4rRJcU66LG1ijt00rccFdMF08Iq79wxj+OkClXQtC338PkUD5MZrzTcYjs9ryefMDx4oh0SvZ/zRzdTz9gCmsksB7Y/4jnLf16nNPQDLoRpRW5hjmjW1mL3cryD8NcjYMODe+e3O6Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654611; c=relaxed/simple;
	bh=yqKU/hxCou745aNQopxzn2NC0bKGSHQNdIG74+bKyoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aPtBRjIQNINwyOopYIxLC2f5CzorVe3OnvC7MKXdT/h7A+GyT/P10onE2bSv7uhETu+RE6jXUQK9UzsfctwHfQqvV7bO4a/n7x6Ml3SJdIlbKd0nPQWTjWYW6S/OwfyJ7odCgAkqSJEkLLvzGNMcP5ReA+47IakU1u3AeWNB4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRg8bJQr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRg8bJQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774654610; x=1806190610;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=yqKU/hxCou745aNQopxzn2NC0bKGSHQNdIG74+bKyoA=;
  b=fRg8bJQr9JTsmai5UXZo9YEQcZU37io+nEqYAq9pCbp4xU3s0gMhaa8C
   W2zFF/MLBsur7jDkBn+qKUgPR3Sh+mS+wBxKQMV+JV5m49+Tcy+otrYPj
   rlBrMTddVm/KeUFiqRXAGYeDx969lvRwe5FDDupHvFrylx+AziKr7XOV0
   vhUJnGi47CLIsyWlwN8tgyVa8Mpk4rmJNFvT5vTvOqTVs9y6YtQBkCWpl
   Ti4KBqHXUZhlhczYkTxjq00dmkStz4md7C7WLZZ3z2XRz9VjwJ668Cb22
   fa9rwOQ/+rkj7QtOFadyJSS7oB3+IeizuRg0zIWrDUNlLKic51/xhVhhY
   g==;
X-CSE-ConnectionGUID: ntcqGklmTGivdSb1+FOQwA==
X-CSE-MsgGUID: 8s4Ym6SqQOm/rSsSI1BL7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="93315721"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="93315721"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 16:36:49 -0700
X-CSE-ConnectionGUID: d4AIO7jZRWS3jEkWK1Hy6A==
X-CSE-MsgGUID: nA4IVH2jS+6ufEAKnb/jIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="248490417"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.240.169]) ([10.241.240.169])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 16:36:48 -0700
Message-ID: <4952de45-eb76-46cc-9a42-f93ec5666175@intel.com>
Date: Fri, 27 Mar 2026 16:36:47 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf tests: Add test for uncore event sorting
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>,
 Dmitrii Dolgov <9erthalion6@gmail.com>, German Gomez <german.gomez@arm.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260325183045.1229502-1-irogers@google.com>
 <20260325183045.1229502-2-irogers@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260325183045.1229502-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/25/2026 11:30 AM, Ian Rogers wrote:
> Add a test for uncore event sorting matching multiple PMUs. Uncore
> PMUs may have a common prefix, like the PMUs uncore_imc_free_running_0
> and uncore_imc_free_running_1 have a prefix of
> uncore_imc_free_running. Parsing an event group like
> "{data_read,data_write}" for those PMUs should result with two groups
> "{uncore_imc_free_running_0/data_read/,uncore_imc_free_running_0/data_write/},
> {uncore_imc_free_running_1/data_read/,uncore_imc_free_running_1/data_write/}"
> which means the evsels need resorting as when initially parsed the
> evsels are ordered with mixed PMUs:
> "{uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_read/,
> uncore_imc_free_running_0/data_write/,uncore_imc_free_running_1/data_write/}".
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

Tested-by: Zide Chen <zide.chen@intel.com>

>  tools/perf/tests/Build                  |   1 +
>  tools/perf/tests/builtin-test.c         |   1 +
>  tools/perf/tests/tests.h                |   1 +
>  tools/perf/tests/uncore-event-sorting.c | 125 ++++++++++++++++++++++++
>  4 files changed, 128 insertions(+)
>  create mode 100644 tools/perf/tests/uncore-event-sorting.c
> 
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index c2a67ce45941..66944a4f4968 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -3,6 +3,7 @@
>  perf-test-y += builtin-test.o
>  perf-test-y += tests-scripts.o
>  perf-test-y += parse-events.o
> +perf-test-y += uncore-event-sorting.o
>  perf-test-y += dso-data.o
>  perf-test-y += vmlinux-kallsyms.o
>  perf-test-y += openat-syscall.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 06507066213b..f2c135891477 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -71,6 +71,7 @@ static struct test_suite *generic_tests[] = {
>  	&suite__basic_mmap,
>  	&suite__mem,
>  	&suite__parse_events,
> +	&suite__uncore_event_sorting,
>  	&suite__expr,
>  	&suite__PERF_RECORD,
>  	&suite__pmu,
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index f5f1238d1f7f..ee00518bf36f 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -177,6 +177,7 @@ DECLARE_SUITE(sigtrap);
>  DECLARE_SUITE(event_groups);
>  DECLARE_SUITE(symbols);
>  DECLARE_SUITE(util);
> +DECLARE_SUITE(uncore_event_sorting);
>  DECLARE_SUITE(subcmd_help);
>  DECLARE_SUITE(kallsyms_split);
>  
> diff --git a/tools/perf/tests/uncore-event-sorting.c b/tools/perf/tests/uncore-event-sorting.c
> new file mode 100644
> index 000000000000..91e1a580709b
> --- /dev/null
> +++ b/tools/perf/tests/uncore-event-sorting.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +#include "tests.h"
> +#include "debug.h"
> +#include "parse-events.h"
> +#include "pmu.h"
> +#include "pmus.h"
> +#include "evlist.h"
> +#include <string.h>
> +
> +struct match_state {
> +	char *event1;
> +	char *event2;
> +};
> +
> +static int event_cb(void *state, struct pmu_event_info *info)
> +{
> +	struct match_state *m = state;
> +
> +	if (!m->event1) {
> +		m->event1 = strdup(info->name);
> +	} else if (!m->event2) {
> +		if (strcmp(m->event1, info->name)) {
> +			m->event2 = strdup(info->name);
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int test__uncore_event_sorting(struct test_suite *test __maybe_unused,
> +				      int subtest __maybe_unused)
> +{
> +	struct evlist *evlist;
> +	struct parse_events_error err;
> +	struct evsel *evsel;
> +	struct perf_pmu *pmu = NULL;
> +	char *pmu_prefix = NULL;
> +	struct match_state m = { NULL, NULL };
> +	char buf[1024];
> +	int ret;
> +
> +	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> +		size_t len;
> +		struct perf_pmu *sibling;
> +
> +		if (pmu->is_core)
> +			continue;
> +
> +		len = pmu_name_len_no_suffix(pmu->name);
> +		if (len == strlen(pmu->name))
> +			continue;
> +
> +		sibling = pmu;
> +		while ((sibling = perf_pmus__scan(sibling)) != NULL) {
> +			if (sibling->is_core)
> +				continue;
> +			if (pmu_name_len_no_suffix(sibling->name) == len &&
> +			    !strncmp(pmu->name, sibling->name, len))
> +				break;
> +		}
> +
> +		if (!sibling)
> +			continue;
> +
> +		m.event1 = m.event2 = NULL;
> +		perf_pmu__for_each_event(pmu, false, &m, event_cb);
> +
> +		if (m.event1 && m.event2) {
> +			pmu_prefix = strndup(pmu->name, len);
> +			break;
> +		}
> +		free(m.event1);
> +	}
> +
> +	if (!pmu_prefix) {
> +		pr_debug("No suitable uncore PMU found\n");
> +		return TEST_SKIP;
> +	}
> +
> +	evlist = evlist__new();
> +	if (!evlist)
> +		return TEST_FAIL;
> +
> +	snprintf(buf, sizeof(buf), "{%s/%s/,%s/%s/}",
> +		 pmu_prefix, m.event1, pmu_prefix, m.event2);
> +	pr_debug("Parsing: %s\n", buf);
> +
> +	parse_events_error__init(&err);
> +	ret = parse_events(evlist, buf, &err);
> +	if (ret) {
> +		pr_debug("parse_events failed\n");
> +		goto out_err;
> +	}
> +
> +	TEST_ASSERT_VAL("Number of events is > 0", evlist->core.nr_entries > 0);
> +	TEST_ASSERT_EQUAL("Number of events is a multiple of 2", evlist->core.nr_entries % 2, 0);
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (evsel__is_group_leader(evsel)) {
> +			struct evsel *next = evsel__next(evsel);
> +
> +			TEST_ASSERT_EQUAL("Group size is 2", evsel->core.nr_members, 2);
> +			TEST_ASSERT_VAL("PMU match", evsel->pmu == next->pmu);
> +			TEST_ASSERT_VAL("First event name", strstr(evsel->name, m.event1) != NULL);
> +			TEST_ASSERT_VAL("Second event name", strstr(next->name, m.event2) != NULL);
> +		}
> +	}
> +
> +	evlist__delete(evlist);
> +	parse_events_error__exit(&err);
> +	free(pmu_prefix);
> +	free(m.event1);
> +	free(m.event2);
> +	return TEST_OK;
> +
> +out_err:
> +	evlist__delete(evlist);
> +	parse_events_error__exit(&err);
> +	free(pmu_prefix);
> +	free(m.event1);
> +	free(m.event2);
> +	return TEST_FAIL;
> +}
> +
> +DEFINE_SUITE("Uncore event sorting", uncore_event_sorting);

