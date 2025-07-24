Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9D271A9A;
	Thu, 24 Jul 2025 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389564; cv=none; b=G9Fb7abPWlWtGpSfPUGjD0Mq8PQm8A1z4CXO/QM8F6OR/21tz7EJJ5/xdCWgPmHcOreGX9WDykcz6Us7/0SeV+0hRTzTg2ITX8NuzryIKwPP77vQju9nI1ToYlKU56eClrqzMOTEcqLDMoWCvEOHXyRvame/3xPLnzsHfmLC5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389564; c=relaxed/simple;
	bh=lSWxf/o0mtm+UahIQWQbbHgU8WN5DU09MlX/hjnxy0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP4FMBoCAV76kPjPid1NbrMy7Bfe2wN9BRiVmTJzKIRj6zXaPOpDeaY7nnEbnyP/TRn0fIVdJCiaY/Ias9rHu3h1bpnglHEfPzVE6TEBRRUFGoXq9RdAJErZzbCF78lB/iHtCJsqacpc2wno6KG5jG/kom+k+uJdnNh5joTri4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVx1MFAr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVx1MFAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07808C4CEED;
	Thu, 24 Jul 2025 20:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753389563;
	bh=lSWxf/o0mtm+UahIQWQbbHgU8WN5DU09MlX/hjnxy0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVx1MFArx6k9fyYiPrKWO6uaba/9DK91Ep07RQ/MOjQgRWsRwk79+azgJgTfeUfj5
	 IxAbcXM7mr1qrNuAVbVtW7Ogl4jZvkd9mySRREalIOKKMsT80hkiQ/VabNFe2yNr2t
	 Z6cznyg2NqKVreI0piw90wO9G0YE4REMyugnpdD4roIWVX5Ev9ebcfZKH/S1bnL1oO
	 MnR+UUVWYJno9QKR3ThpM+TM0ZHO3kMFabQWKFRxJXUsUiU8BDENgX0VzB9NHbQuXA
	 Ua38Zf0/lHXDKg5v+tuPPHW5v3UdAMhavCQi16bW0gGphq/k7CbH0q4BZ4dN+/Hci9
	 1i6HCJR5k2Z/Q==
Date: Thu, 24 Jul 2025 13:39:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	James Clark <james.clark@linaro.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf topdown: Use attribute to see an event is a
 topdown metic or slots
Message-ID: <aIKZ-cSq1-4j4WLJ@google.com>
References: <20250718132750.1546457-1-irogers@google.com>
 <aIA09RLkeKjeUCnB@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIA09RLkeKjeUCnB@google.com>

On Tue, Jul 22, 2025 at 06:03:49PM -0700, Namhyung Kim wrote:
> On Fri, Jul 18, 2025 at 06:27:49AM -0700, Ian Rogers wrote:
> > The string comparisons were overly broad and could fire for the
> > incorrect PMU and events. Switch to using the config in the attribute
> > then add a perf test to confirm the attribute config values match
> > those of parsed events of that name and don't match others. This
> > exposed matches for slots events that shouldn't have matched as the
> > slots fixed counter event, such as topdown.slots_p.
> > 
> > Fixes: fbc798316bef ("perf x86/topdown: Refine helper arch_is_topdown_metrics()")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Dapeng, are you ok with this (or Ian's TMA fix v3 below)?
> 
> https://lore.kernel.org/r/20250719030517.1990983-1-irogers@google.com
 
AFAICS Ian already replied to the thread and I think it's handled.
I'm gonna take the TMA fix v3, please let me know if you can find
problems later.

Thanks,
Namhyung

> 
> > ---
> > v2: In test rename topdown_pmu to p_core_pmu for clarity.
> > ---
> >  tools/perf/arch/x86/include/arch-tests.h |  4 ++
> >  tools/perf/arch/x86/tests/Build          |  1 +
> >  tools/perf/arch/x86/tests/arch-tests.c   |  1 +
> >  tools/perf/arch/x86/tests/topdown.c      | 76 ++++++++++++++++++++++++
> >  tools/perf/arch/x86/util/evsel.c         | 46 ++++----------
> >  tools/perf/arch/x86/util/topdown.c       | 31 ++++------
> >  tools/perf/arch/x86/util/topdown.h       |  4 ++
> >  7 files changed, 108 insertions(+), 55 deletions(-)
> >  create mode 100644 tools/perf/arch/x86/tests/topdown.c
> > 
> > diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
> > index 4fd425157d7d..8713e9122d4c 100644
> > --- a/tools/perf/arch/x86/include/arch-tests.h
> > +++ b/tools/perf/arch/x86/include/arch-tests.h
> > @@ -2,6 +2,8 @@
> >  #ifndef ARCH_TESTS_H
> >  #define ARCH_TESTS_H
> >  
> > +#include "tests/tests.h"
> > +
> >  struct test_suite;
> >  
> >  /* Tests */
> > @@ -17,6 +19,8 @@ int test__amd_ibs_via_core_pmu(struct test_suite *test, int subtest);
> >  int test__amd_ibs_period(struct test_suite *test, int subtest);
> >  int test__hybrid(struct test_suite *test, int subtest);
> >  
> > +DECLARE_SUITE(x86_topdown);
> > +
> >  extern struct test_suite *arch_tests[];
> >  
> >  #endif
> > diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
> > index 01d5527f38c7..311b6b53d3d8 100644
> > --- a/tools/perf/arch/x86/tests/Build
> > +++ b/tools/perf/arch/x86/tests/Build
> > @@ -11,6 +11,7 @@ endif
> >  perf-test-$(CONFIG_X86_64) += bp-modify.o
> >  perf-test-y += amd-ibs-via-core-pmu.o
> >  perf-test-y += amd-ibs-period.o
> > +perf-test-y += topdown.o
> >  
> >  ifdef SHELLCHECK
> >    SHELL_TESTS := gen-insn-x86-dat.sh
> > diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
> > index bfee2432515b..29ec1861ccef 100644
> > --- a/tools/perf/arch/x86/tests/arch-tests.c
> > +++ b/tools/perf/arch/x86/tests/arch-tests.c
> > @@ -53,5 +53,6 @@ struct test_suite *arch_tests[] = {
> >  	&suite__amd_ibs_via_core_pmu,
> >  	&suite__amd_ibs_period,
> >  	&suite__hybrid,
> > +	&suite__x86_topdown,
> >  	NULL,
> >  };
> > diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
> > new file mode 100644
> > index 000000000000..8d0ea7a4bbc1
> > --- /dev/null
> > +++ b/tools/perf/arch/x86/tests/topdown.c
> > @@ -0,0 +1,76 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "arch-tests.h"
> > +#include "../util/topdown.h"
> > +#include "evlist.h"
> > +#include "parse-events.h"
> > +#include "pmu.h"
> > +#include "pmus.h"
> > +
> > +static int event_cb(void *state, struct pmu_event_info *info)
> > +{
> > +	char buf[256];
> > +	struct parse_events_error parse_err;
> > +	int *ret = state, err;
> > +	struct evlist *evlist = evlist__new();
> > +	struct evsel *evsel;
> > +
> > +	if (!evlist)
> > +		return -ENOMEM;
> > +
> > +	parse_events_error__init(&parse_err);
> > +	snprintf(buf, sizeof(buf), "%s/%s/", info->pmu->name, info->name);
> > +	err = parse_events(evlist, buf, &parse_err);
> > +	if (err) {
> > +		parse_events_error__print(&parse_err, buf);
> > +		*ret = TEST_FAIL;
> > +	}
> > +	parse_events_error__exit(&parse_err);
> > +	evlist__for_each_entry(evlist, evsel) {
> > +		bool fail = false;
> > +		bool p_core_pmu = evsel->pmu->type == PERF_TYPE_RAW;
> > +		const char *name = evsel__name(evsel);
> > +
> > +		if (strcasestr(name, "uops_retired.slots") ||
> > +		    strcasestr(name, "topdown.backend_bound_slots") ||
> > +		    strcasestr(name, "topdown.br_mispredict_slots") ||
> > +		    strcasestr(name, "topdown.memory_bound_slots") ||
> > +		    strcasestr(name, "topdown.bad_spec_slots") ||
> > +		    strcasestr(name, "topdown.slots_p")) {
> > +			if (arch_is_topdown_slots(evsel) || arch_is_topdown_metrics(evsel))
> > +				fail = true;
> > +		} else if (strcasestr(name, "slots")) {
> > +			if (arch_is_topdown_slots(evsel) != p_core_pmu ||
> > +			    arch_is_topdown_metrics(evsel))
> > +				fail = true;
> > +		} else if (strcasestr(name, "topdown")) {
> > +			if (arch_is_topdown_slots(evsel) ||
> > +			    arch_is_topdown_metrics(evsel) != p_core_pmu)
> > +				fail = true;
> > +		} else if (arch_is_topdown_slots(evsel) || arch_is_topdown_metrics(evsel)) {
> > +			fail = true;
> > +		}
> > +		if (fail) {
> > +			pr_debug("Broken topdown information for '%s'\n", evsel__name(evsel));
> > +			*ret = TEST_FAIL;
> > +		}
> > +	}
> > +	evlist__delete(evlist);
> > +	return 0;
> > +}
> > +
> > +static int test__x86_topdown(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> > +{
> > +	int ret = TEST_OK;
> > +	struct perf_pmu *pmu = NULL;
> > +
> > +	if (!topdown_sys_has_perf_metrics())
> > +		return TEST_OK;
> > +
> > +	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> > +		if (perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/false, &ret, event_cb))
> > +			break;
> > +	}
> > +	return ret;
> > +}
> > +
> > +DEFINE_SUITE("x86 topdown", x86_topdown);
> > diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> > index 3dd29ba2c23b..9bc80fff3aa0 100644
> > --- a/tools/perf/arch/x86/util/evsel.c
> > +++ b/tools/perf/arch/x86/util/evsel.c
> > @@ -23,47 +23,25 @@ void arch_evsel__set_sample_weight(struct evsel *evsel)
> >  bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
> >  {
> >  	struct perf_pmu *pmu;
> > -	u32 type = evsel->core.attr.type;
> >  
> > -	/*
> > -	 * The PERF_TYPE_RAW type is the core PMU type, e.g., "cpu" PMU
> > -	 * on a non-hybrid machine, "cpu_core" PMU on a hybrid machine.
> > -	 * The slots event is only available for the core PMU, which
> > -	 * supports the perf metrics feature.
> > -	 * Checking both the PERF_TYPE_RAW type and the slots event
> > -	 * should be good enough to detect the perf metrics feature.
> > -	 */
> > -again:
> > -	switch (type) {
> > -	case PERF_TYPE_HARDWARE:
> > -	case PERF_TYPE_HW_CACHE:
> > -		type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
> > -		if (type)
> > -			goto again;
> > -		break;
> > -	case PERF_TYPE_RAW:
> > -		break;
> > -	default:
> > +	if (!topdown_sys_has_perf_metrics())
> >  		return false;
> > -	}
> > -
> > -	pmu = evsel->pmu;
> > -	if (pmu && perf_pmu__is_fake(pmu))
> > -		pmu = NULL;
> >  
> > -	if (!pmu) {
> > -		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> > -			if (pmu->type == PERF_TYPE_RAW)
> > -				break;
> > -		}
> > -	}
> > -	return pmu && perf_pmu__have_event(pmu, "slots");
> > +	/*
> > +	 * The PERF_TYPE_RAW type is the core PMU type, e.g., "cpu" PMU on a
> > +	 * non-hybrid machine, "cpu_core" PMU on a hybrid machine.  The
> > +	 * topdown_sys_has_perf_metrics checks the slots event is only available
> > +	 * for the core PMU, which supports the perf metrics feature. Checking
> > +	 * both the PERF_TYPE_RAW type and the slots event should be good enough
> > +	 * to detect the perf metrics feature.
> > +	 */
> > +	pmu = evsel__find_pmu(evsel);
> > +	return pmu && pmu->type == PERF_TYPE_RAW;
> >  }
> >  
> >  bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> >  {
> > -	if (!evsel__sys_has_perf_metrics(evsel) || !evsel->name ||
> > -	    strcasestr(evsel->name, "uops_retired.slots"))
> > +	if (!evsel__sys_has_perf_metrics(evsel))
> >  		return false;
> >  
> >  	return arch_is_topdown_metrics(evsel) || arch_is_topdown_slots(evsel);
> > diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> > index d1c654839049..66b231fbf52e 100644
> > --- a/tools/perf/arch/x86/util/topdown.c
> > +++ b/tools/perf/arch/x86/util/topdown.c
> > @@ -1,6 +1,4 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include "api/fs/fs.h"
> > -#include "util/evsel.h"
> >  #include "util/evlist.h"
> >  #include "util/pmu.h"
> >  #include "util/pmus.h"
> > @@ -8,6 +6,9 @@
> >  #include "topdown.h"
> >  #include "evsel.h"
> >  
> > +// cmask=0, inv=0, pc=0, edge=0, umask=4, event=0
> > +#define TOPDOWN_SLOTS		0x0400
> > +
> >  /* Check whether there is a PMU which supports the perf metrics. */
> >  bool topdown_sys_has_perf_metrics(void)
> >  {
> > @@ -32,31 +33,19 @@ bool topdown_sys_has_perf_metrics(void)
> >  	return has_perf_metrics;
> >  }
> >  
> > -#define TOPDOWN_SLOTS		0x0400
> >  bool arch_is_topdown_slots(const struct evsel *evsel)
> >  {
> > -	if (evsel->core.attr.config == TOPDOWN_SLOTS)
> > -		return true;
> > -
> > -	return false;
> > +	return evsel->core.attr.type == PERF_TYPE_RAW &&
> > +	       evsel->core.attr.config == TOPDOWN_SLOTS &&
> > +	       evsel->core.attr.config1 == 0;
> >  }
> >  
> >  bool arch_is_topdown_metrics(const struct evsel *evsel)
> >  {
> > -	int config = evsel->core.attr.config;
> > -	const char *name_from_config;
> > -	struct perf_pmu *pmu;
> > -
> > -	/* All topdown events have an event code of 0. */
> > -	if ((config & 0xFF) != 0)
> > -		return false;
> > -
> > -	pmu = evsel__find_pmu(evsel);
> > -	if (!pmu || !pmu->is_core)
> > -		return false;
> > -
> > -	name_from_config = perf_pmu__name_from_config(pmu, config);
> > -	return name_from_config && strcasestr(name_from_config, "topdown");
> > +	// cmask=0, inv=0, pc=0, edge=0, umask=0x80-0x87, event=0
> > +	return evsel->core.attr.type == PERF_TYPE_RAW &&
> > +		(evsel->core.attr.config & 0xFFFFF8FF) == 0x8000 &&
> > +		evsel->core.attr.config1 == 0;
> >  }
> >  
> >  /*
> > diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
> > index 1bae9b1822d7..2349536cf882 100644
> > --- a/tools/perf/arch/x86/util/topdown.h
> > +++ b/tools/perf/arch/x86/util/topdown.h
> > @@ -2,6 +2,10 @@
> >  #ifndef _TOPDOWN_H
> >  #define _TOPDOWN_H 1
> >  
> > +#include <stdbool.h>
> > +
> > +struct evsel;
> > +
> >  bool topdown_sys_has_perf_metrics(void);
> >  bool arch_is_topdown_slots(const struct evsel *evsel);
> >  bool arch_is_topdown_metrics(const struct evsel *evsel);
> > -- 
> > 2.50.0.727.gbf7dc18ff4-goog
> > 
