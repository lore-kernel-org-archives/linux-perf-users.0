Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91F31FECB0;
	Fri, 18 Jul 2025 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828669; cv=none; b=BwkCETNgvH5Ax79Y4Yb2CPcZUfkqaBibyYjNTIRKYsvHsV7uWJfQ9/uRy6ntm7cJqA47o1pQ4nc4FGaPOBomZnnURmfq25yJKV6AUqvutUEGnUCt+sEaR37zjoc6/JOvFwl/b4T+EoG108mI9QEpBT7vhdHMtfJq3tMKNcJDipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828669; c=relaxed/simple;
	bh=61z/xe1qunfOI1Llb7wsW93E4ZDJLhjbmywwjahBT+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KR0fEJQbTP4fVJFRDFyJ0fFsV3P10XttuE28aeUCKZCLtjg13BiNgmoiSRThdJ4+KF1zpVfA6MaKKJRo6Em+ne65zjsF+fFN6XuvsOyEaXOKOOpEPFFKPTIX+I6IdH6veiftZoAfD6ZAdeSDsy9RnGCQZgzhyY1r98iKH+0FxpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVeTyWHQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVeTyWHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752828668; x=1784364668;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=61z/xe1qunfOI1Llb7wsW93E4ZDJLhjbmywwjahBT+8=;
  b=OVeTyWHQ8wPHG2xu8P1CTLzUYL47ETQSWGtECVeO+eur48YbFLRYLm5L
   axErSHOazYIfi8Im0Rt1G79xQYstaMK0HEIRahcoqI4hSmOTeB/Y0lScu
   vz5y2VQGUn9lAX/P9AkFcrt39EU0Efzpo0GpsPRCeN3Azry6027wlfk8T
   r8mmcjdyi6srwgME8O5JvgJntmNY+1xE1/GRFFqPhRW2lkcyxFCP+HRfc
   8ebEt5YnspmX4vvRrDFK5zggcLPifQBFFmQgVDXlci7YnhrO9j5mWUsvH
   Kzec8SMEiMS6VwHj503er1JqE7qic5RfESDKloQWvI0kWXef4ka5GIcqE
   Q==;
X-CSE-ConnectionGUID: GfupsNZfRg2UDe3xg6EZ8g==
X-CSE-MsgGUID: PTW53q/1Stec1tDoHWPSgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="66567434"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="66567434"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 01:51:07 -0700
X-CSE-ConnectionGUID: DBcIUwK8Tn+cICBZHrbEWA==
X-CSE-MsgGUID: 7NK6KnZvQXOvcrd2kI46xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="163633516"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.106]) ([10.124.240.106])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 01:51:04 -0700
Message-ID: <11829e3e-6d43-44f9-b008-6f6b828b7144@linux.intel.com>
Date: Fri, 18 Jul 2025 16:51:00 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf topdown: Use attribute to see an event is a
 topdown metic or slots
To: Ian Rogers <irogers@google.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@linaro.org>,
 Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250718071734.1444891-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250718071734.1444891-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/18/2025 3:17 PM, Ian Rogers wrote:
> The string comparisons were overly broad and could fire for the
> incorrect PMU and events. Switch to using the config in the attribute
> then add a perf test to confirm the attribute config values match
> those of parsed events of that name and don't match others. This
> exposed matches for slots events that shouldn't have matched as the
> slots fixed counter event, such as topdown.slots_p.
>
> Fixes: fbc798316bef ("perf x86/topdown: Refine helper arch_is_topdown_metrics()")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/include/arch-tests.h |  4 ++
>  tools/perf/arch/x86/tests/Build          |  1 +
>  tools/perf/arch/x86/tests/arch-tests.c   |  1 +
>  tools/perf/arch/x86/tests/topdown.c      | 76 ++++++++++++++++++++++++
>  tools/perf/arch/x86/util/evsel.c         | 46 ++++----------
>  tools/perf/arch/x86/util/topdown.c       | 31 ++++------
>  tools/perf/arch/x86/util/topdown.h       |  4 ++
>  7 files changed, 108 insertions(+), 55 deletions(-)
>  create mode 100644 tools/perf/arch/x86/tests/topdown.c
>
> diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
> index 4fd425157d7d..8713e9122d4c 100644
> --- a/tools/perf/arch/x86/include/arch-tests.h
> +++ b/tools/perf/arch/x86/include/arch-tests.h
> @@ -2,6 +2,8 @@
>  #ifndef ARCH_TESTS_H
>  #define ARCH_TESTS_H
>  
> +#include "tests/tests.h"
> +
>  struct test_suite;
>  
>  /* Tests */
> @@ -17,6 +19,8 @@ int test__amd_ibs_via_core_pmu(struct test_suite *test, int subtest);
>  int test__amd_ibs_period(struct test_suite *test, int subtest);
>  int test__hybrid(struct test_suite *test, int subtest);
>  
> +DECLARE_SUITE(x86_topdown);
> +
>  extern struct test_suite *arch_tests[];
>  
>  #endif
> diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
> index 01d5527f38c7..311b6b53d3d8 100644
> --- a/tools/perf/arch/x86/tests/Build
> +++ b/tools/perf/arch/x86/tests/Build
> @@ -11,6 +11,7 @@ endif
>  perf-test-$(CONFIG_X86_64) += bp-modify.o
>  perf-test-y += amd-ibs-via-core-pmu.o
>  perf-test-y += amd-ibs-period.o
> +perf-test-y += topdown.o
>  
>  ifdef SHELLCHECK
>    SHELL_TESTS := gen-insn-x86-dat.sh
> diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
> index bfee2432515b..29ec1861ccef 100644
> --- a/tools/perf/arch/x86/tests/arch-tests.c
> +++ b/tools/perf/arch/x86/tests/arch-tests.c
> @@ -53,5 +53,6 @@ struct test_suite *arch_tests[] = {
>  	&suite__amd_ibs_via_core_pmu,
>  	&suite__amd_ibs_period,
>  	&suite__hybrid,
> +	&suite__x86_topdown,
>  	NULL,
>  };
> diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
> new file mode 100644
> index 000000000000..ba2c163945d8
> --- /dev/null
> +++ b/tools/perf/arch/x86/tests/topdown.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "arch-tests.h"
> +#include "../util/topdown.h"
> +#include "evlist.h"
> +#include "parse-events.h"
> +#include "pmu.h"
> +#include "pmus.h"
> +
> +static int event_cb(void *state, struct pmu_event_info *info)
> +{
> +	char buf[256];
> +	struct parse_events_error parse_err;
> +	int *ret = state, err;
> +	struct evlist *evlist = evlist__new();
> +	struct evsel *evsel;
> +
> +	if (!evlist)
> +		return -ENOMEM;
> +
> +	parse_events_error__init(&parse_err);
> +	snprintf(buf, sizeof(buf), "%s/%s/", info->pmu->name, info->name);
> +	err = parse_events(evlist, buf, &parse_err);
> +	if (err) {
> +		parse_events_error__print(&parse_err, buf);
> +		*ret = TEST_FAIL;
> +	}
> +	parse_events_error__exit(&parse_err);
> +	evlist__for_each_entry(evlist, evsel) {
> +		bool fail = false;
> +		bool topdown_pmu = evsel->pmu->type == PERF_TYPE_RAW;
> +		const char *name = evsel__name(evsel);
> +
> +		if (strcasestr(name, "uops_retired.slots") ||
> +		    strcasestr(name, "topdown.backend_bound_slots") ||
> +		    strcasestr(name, "topdown.br_mispredict_slots") ||
> +		    strcasestr(name, "topdown.memory_bound_slots") ||
> +		    strcasestr(name, "topdown.bad_spec_slots") ||
> +		    strcasestr(name, "topdown.slots_p")) {
> +			if (arch_is_topdown_slots(evsel) || arch_is_topdown_metrics(evsel))
> +				fail = true;
> +		} else if (strcasestr(name, "slots")) {
> +			if (arch_is_topdown_slots(evsel) != topdown_pmu ||
> +			    arch_is_topdown_metrics(evsel))
> +				fail = true;
> +		} else if (strcasestr(name, "topdown")) {
> +			if (arch_is_topdown_slots(evsel) ||
> +			    arch_is_topdown_metrics(evsel) != topdown_pmu)
> +				fail = true;
> +		} else if (arch_is_topdown_slots(evsel) || arch_is_topdown_metrics(evsel)) {
> +			fail = true;
> +		}
> +		if (fail) {
> +			pr_debug("Broken topdown information for '%s'\n", evsel__name(evsel));
> +			*ret = TEST_FAIL;
> +		}
> +	}
> +	evlist__delete(evlist);
> +	return 0;
> +}
> +
> +static int test__x86_topdown(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> +{
> +	int ret = TEST_OK;
> +	struct perf_pmu *pmu = NULL;
> +
> +	if (!topdown_sys_has_perf_metrics())
> +		return TEST_OK;
> +
> +	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> +		if (perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/false, &ret, event_cb))
> +			break;
> +	}
> +	return ret;
> +}
> +
> +DEFINE_SUITE("x86 topdown", x86_topdown);
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index 3dd29ba2c23b..9bc80fff3aa0 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -23,47 +23,25 @@ void arch_evsel__set_sample_weight(struct evsel *evsel)
>  bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
>  {
>  	struct perf_pmu *pmu;
> -	u32 type = evsel->core.attr.type;
>  
> -	/*
> -	 * The PERF_TYPE_RAW type is the core PMU type, e.g., "cpu" PMU
> -	 * on a non-hybrid machine, "cpu_core" PMU on a hybrid machine.
> -	 * The slots event is only available for the core PMU, which
> -	 * supports the perf metrics feature.
> -	 * Checking both the PERF_TYPE_RAW type and the slots event
> -	 * should be good enough to detect the perf metrics feature.
> -	 */
> -again:
> -	switch (type) {
> -	case PERF_TYPE_HARDWARE:
> -	case PERF_TYPE_HW_CACHE:
> -		type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
> -		if (type)
> -			goto again;
> -		break;
> -	case PERF_TYPE_RAW:
> -		break;
> -	default:
> +	if (!topdown_sys_has_perf_metrics())
>  		return false;
> -	}
> -
> -	pmu = evsel->pmu;
> -	if (pmu && perf_pmu__is_fake(pmu))
> -		pmu = NULL;
>  
> -	if (!pmu) {
> -		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> -			if (pmu->type == PERF_TYPE_RAW)
> -				break;
> -		}
> -	}
> -	return pmu && perf_pmu__have_event(pmu, "slots");
> +	/*
> +	 * The PERF_TYPE_RAW type is the core PMU type, e.g., "cpu" PMU on a
> +	 * non-hybrid machine, "cpu_core" PMU on a hybrid machine.  The
> +	 * topdown_sys_has_perf_metrics checks the slots event is only available
> +	 * for the core PMU, which supports the perf metrics feature. Checking
> +	 * both the PERF_TYPE_RAW type and the slots event should be good enough
> +	 * to detect the perf metrics feature.
> +	 */
> +	pmu = evsel__find_pmu(evsel);
> +	return pmu && pmu->type == PERF_TYPE_RAW;

Do I miss something? But it seems not check if the PMU has slots event here. 


>  }
>  
>  bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>  {
> -	if (!evsel__sys_has_perf_metrics(evsel) || !evsel->name ||
> -	    strcasestr(evsel->name, "uops_retired.slots"))
> +	if (!evsel__sys_has_perf_metrics(evsel))
>  		return false;
>  
>  	return arch_is_topdown_metrics(evsel) || arch_is_topdown_slots(evsel);
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index d1c654839049..66b231fbf52e 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "api/fs/fs.h"
> -#include "util/evsel.h"
>  #include "util/evlist.h"
>  #include "util/pmu.h"
>  #include "util/pmus.h"
> @@ -8,6 +6,9 @@
>  #include "topdown.h"
>  #include "evsel.h"
>  
> +// cmask=0, inv=0, pc=0, edge=0, umask=4, event=0
> +#define TOPDOWN_SLOTS		0x0400
> +
>  /* Check whether there is a PMU which supports the perf metrics. */
>  bool topdown_sys_has_perf_metrics(void)
>  {
> @@ -32,31 +33,19 @@ bool topdown_sys_has_perf_metrics(void)
>  	return has_perf_metrics;
>  }
>  
> -#define TOPDOWN_SLOTS		0x0400
>  bool arch_is_topdown_slots(const struct evsel *evsel)
>  {
> -	if (evsel->core.attr.config == TOPDOWN_SLOTS)
> -		return true;
> -
> -	return false;
> +	return evsel->core.attr.type == PERF_TYPE_RAW &&
> +	       evsel->core.attr.config == TOPDOWN_SLOTS &&
> +	       evsel->core.attr.config1 == 0;
>  }
>  
>  bool arch_is_topdown_metrics(const struct evsel *evsel)
>  {
> -	int config = evsel->core.attr.config;
> -	const char *name_from_config;
> -	struct perf_pmu *pmu;
> -
> -	/* All topdown events have an event code of 0. */
> -	if ((config & 0xFF) != 0)
> -		return false;
> -
> -	pmu = evsel__find_pmu(evsel);
> -	if (!pmu || !pmu->is_core)
> -		return false;
> -
> -	name_from_config = perf_pmu__name_from_config(pmu, config);
> -	return name_from_config && strcasestr(name_from_config, "topdown");
> +	// cmask=0, inv=0, pc=0, edge=0, umask=0x80-0x87, event=0
> +	return evsel->core.attr.type == PERF_TYPE_RAW &&
> +		(evsel->core.attr.config & 0xFFFFF8FF) == 0x8000 &&
> +		evsel->core.attr.config1 == 0;
>  }
>  
>  /*
> diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
> index 1bae9b1822d7..2349536cf882 100644
> --- a/tools/perf/arch/x86/util/topdown.h
> +++ b/tools/perf/arch/x86/util/topdown.h
> @@ -2,6 +2,10 @@
>  #ifndef _TOPDOWN_H
>  #define _TOPDOWN_H 1
>  
> +#include <stdbool.h>
> +
> +struct evsel;
> +
>  bool topdown_sys_has_perf_metrics(void);
>  bool arch_is_topdown_slots(const struct evsel *evsel);
>  bool arch_is_topdown_metrics(const struct evsel *evsel);
