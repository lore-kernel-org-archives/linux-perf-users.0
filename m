Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6AA377EDC;
	Wed,  1 Apr 2026 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080107; cv=none; b=pYgj2+ffqAXgF4BKQBqKXE/BrDBIeYiV0DEOB7PiaGhwhgaxjiGGfr2IpBfDhkxMdFK18JWn/G8uJ0JgqSBytpwlxLLeHoXbSzplUK8rP6z2WDxx8P2p9A028NeMVhBlVs9AcGvLX1CekVrJcXj4JlhU1u8jThHt9cfFuLlJhp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080107; c=relaxed/simple;
	bh=vQmgK7Njb0+w9+vX8N/zXXY5zjc0tpmp78p8/QCW8lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3OpldkpjVc57iCYXO2/2vY0QYLT3AmfR6SbE6Ca6l800wGeIFUgzrfS/JIzTYGZLUyyja6FxcD/hAPXG6tTeLh+VIZRuPmuGQiTYPBiY+UqID76k5Gv/pn4XfCfhUdd0VPSd18Z6FK8GBYgnTPnFWUZbJ0UxeAkt4jTNZsW+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sak99sm/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sak99sm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D3CC4CEF7;
	Wed,  1 Apr 2026 21:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775080107;
	bh=vQmgK7Njb0+w9+vX8N/zXXY5zjc0tpmp78p8/QCW8lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sak99sm/cJDJJSKtx5Y0kxFmlrt1b9GkEsuCTy6NsNtYGP8N7hUZXIdKY9B7LAcyY
	 8NLWSM0mpSCdegezoZ1reNsNhzLNNB/R7WPz55iyyqgA05d5k6t3Df2RppLEHjS2DZ
	 3sX478WDVHHN6LBNAd9Aacy4yUiYAQWSV7wGRx3zwfcpQVdBe7WXEj6tsaELw+oqpM
	 /B83LOp4++ecYhGzm63whjXS7rrJiGeKTET6SCTyJQ5vnMWCbBYBU1mxq2A9qhlhRm
	 MMm5zLjq0fPMX4Ie4fF4QRTixSIOjMpvmjvR54wutP4WciDM1SdGCh36a+S6RExXbT
	 SRdZ+QpOaq4fQ==
Date: Wed, 1 Apr 2026 14:48:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: 9erthalion6@gmail.com, acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, collin.funk1@gmail.com,
	german.gomez@arm.com, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, zide.chen@intel.com
Subject: Re: [PATCH v3 1/2] perf tests: Add test for uncore event sorting
Message-ID: <ac2SqEbH_-0BBNc0@google.com>
References: <20260331165207.4016392-1-irogers@google.com>
 <20260331185419.4085479-1-irogers@google.com>
 <20260331185419.4085479-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331185419.4085479-2-irogers@google.com>

On Tue, Mar 31, 2026 at 11:54:18AM -0700, Ian Rogers wrote:
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

I got this:

  --- start ---                                                                   
  test child forked, pid 1168839                                                  
  Using CPUID AuthenticAMD-23-31-0                                                
  Parsing: {amd_iommu/amd_iommu_0/ign_rd_wr_mmio_1ff8h//,amd_iommu/amd_iommu_0/cmd_processed_inv//}
  parse_events failed                                                             
  ---- end(-1) ----
    6: Uncore event sorting                                            : FAILED!

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Zide Chen <zide.chen@intel.com>
> ---
>  tools/perf/tests/Build                  |   1 +
>  tools/perf/tests/builtin-test.c         |   1 +
>  tools/perf/tests/tests.h                |   1 +
>  tools/perf/tests/uncore-event-sorting.c | 122 ++++++++++++++++++++++++
>  4 files changed, 125 insertions(+)
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
> index 000000000000..7e61e46283d5
> --- /dev/null
> +++ b/tools/perf/tests/uncore-event-sorting.c
> @@ -0,0 +1,122 @@
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
> +		ret = TEST_FAIL;
> +		goto out_err;
> +	}
> +
> +	TEST_ASSERT_VAL("Number of events is > 0", evlist->core.nr_entries > 0);
> +	TEST_ASSERT_EQUAL("Number of events is a multiple of 2", evlist->core.nr_entries % 2, 0);
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		struct evsel *next;
> +
> +		if (!evsel__is_group_leader(evsel))
> +			continue;
> +
> +		next = evsel__next(evsel);
> +		TEST_ASSERT_EQUAL("Group size is 2", evsel->core.nr_members, 2);
> +		TEST_ASSERT_VAL("PMU match", evsel->pmu == next->pmu);
> +		TEST_ASSERT_VAL("First event name", strstr(evsel__name(evsel), m.event1) != NULL);
> +		TEST_ASSERT_VAL("Second event name", strstr(evsel__name(next), m.event2) != NULL);
> +	}
> +	ret = TEST_OK;
> +
> +out_err:
> +	evlist__delete(evlist);
> +	parse_events_error__exit(&err);
> +	free(pmu_prefix);
> +	free(m.event1);
> +	free(m.event2);
> +	return ret;
> +}
> +
> +DEFINE_SUITE("Uncore event sorting", uncore_event_sorting);
> -- 
> 2.53.0.1118.gaef5881109-goog
> 
