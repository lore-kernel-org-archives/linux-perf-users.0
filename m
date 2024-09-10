Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8A13A885;
	Tue, 10 Sep 2024 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947453; cv=none; b=KjOhHMrMU6WeVhQvzSqX0+feeDElH0Q6tBV+lYY1vxMhW2IJYKE/be5zNH5FnzO29rVWd9uVP+Phf5PXdWjWBbKFtdebNTw5Da/j9NwLxD3XE00NpLaOWJIXXNxmh4QVAe0MXpZDgpkGzziTcoDeQHRCRR7QLArghFAL4dqEfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947453; c=relaxed/simple;
	bh=KaFqVznIit54yg+jLGZTE9bSNfvtxNmjEVeqVMGx0eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQTEDK7mXXjr8J9E25fdnLNIgoLAjH6TTxW9sf6RGFP6rKt9ipqkPiEjLZ2Mf2nK6T7aL5t/6ypBccGIed4ht4XV8J67OrsM8cnL1jlWARlOkeRMeznpl3zyOQPUJTQlyUqQHpGhnkZ97TxxYachHHHDe0fzLvH26fKNSf+3O64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt9l083O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt9l083O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52BAC4CEC3;
	Tue, 10 Sep 2024 05:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725947453;
	bh=KaFqVznIit54yg+jLGZTE9bSNfvtxNmjEVeqVMGx0eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bt9l083O3uU93OV6GGcVAL5+Q858mPl7a9YOHFqB46ksWVNLhcxEMr6eyXHrBYxc+
	 sBCTr7OvxkQdzp88UUtAOxMdJ6YSxfLSVhjl03xx1w2zK/HFx0qnXOKkBmKqBUkOxV
	 i5dge9K4CxLocCIiD3UflGQPVTkm04RWBd+pD9HpTz0tI3ek6/ko2+twJl0vxMA8H8
	 GiEp/Y4Y/7zIJOf7CjQyigBNBWj65U13W3gH+i5RuAl9a36CFK5phax5jOSa8tn2T2
	 z59ohJwGV84CP0Gv4gkQNGiGq/pzXg/9dEUVDIqBpe53MWL8dfkpMoFzLE++mf0dab
	 LFJOmiEaDXD0g==
Date: Mon, 9 Sep 2024 22:50:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Junhao He <hejunhao3@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 13/15] perf tests: Add tool PMU test
Message-ID: <Zt_eOhg7I81oGeo2@google.com>
References: <20240907050830.6752-1-irogers@google.com>
 <20240907050830.6752-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240907050830.6752-14-irogers@google.com>

On Fri, Sep 06, 2024 at 10:08:28PM -0700, Ian Rogers wrote:
> Ensure parsing with and without PMU creates events with the expected
> config values. This ensures the tool.json doesn't get out of sync with
> tool_pmu_event enum.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |   1 +
>  tools/perf/tests/tests.h        |   1 +
>  tools/perf/tests/tool_pmu.c     | 111 ++++++++++++++++++++++++++++++++
>  4 files changed, 114 insertions(+)
>  create mode 100644 tools/perf/tests/tool_pmu.c
> 
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 5671ee530019..a771e4928247 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -67,6 +67,7 @@ perf-test-y += sigtrap.o
>  perf-test-y += event_groups.o
>  perf-test-y += symbols.o
>  perf-test-y += util.o
> +perf-test-y += tool_pmu.o
>  
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
>  perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 470a9709427d..3b30f258c395 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -73,6 +73,7 @@ static struct test_suite *generic_tests[] = {
>  	&suite__PERF_RECORD,
>  	&suite__pmu,
>  	&suite__pmu_events,
> +	&suite__tool_pmu,
>  	&suite__dso_data,
>  	&suite__perf_evsel__roundtrip_name_test,
>  #ifdef HAVE_LIBTRACEEVENT
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 6ea2be86b7bf..1ed76d4156b6 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -83,6 +83,7 @@ DECLARE_SUITE(perf_evsel__tp_sched_test);
>  DECLARE_SUITE(syscall_openat_tp_fields);
>  DECLARE_SUITE(pmu);
>  DECLARE_SUITE(pmu_events);
> +DECLARE_SUITE(tool_pmu);
>  DECLARE_SUITE(attr);
>  DECLARE_SUITE(dso_data);
>  DECLARE_SUITE(dso_data_cache);
> diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
> new file mode 100644
> index 000000000000..94d0dd8fd3cb
> --- /dev/null
> +++ b/tools/perf/tests/tool_pmu.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +#include "debug.h"
> +#include "evlist.h"
> +#include "parse-events.h"
> +#include "tests.h"
> +#include "tool_pmu.h"
> +
> +static int do_test(enum tool_pmu_event ev, bool with_pmu)
> +{
> +	struct evlist *evlist = evlist__new();
> +	struct evsel *evsel;
> +	struct parse_events_error err;
> +	int ret;
> +	char str[128];
> +	bool found = false;
> +
> +	if (!evlist) {
> +		pr_err("evlist allocation failed\n");
> +		return TEST_FAIL;
> +	}
> +
> +	if (with_pmu)
> +		snprintf(str, sizeof(str), "tool/%s/", tool_pmu__event_to_str(ev));
> +	else
> +		strncpy(str, tool_pmu__event_to_str(ev), sizeof(str));
> +
> +	parse_events_error__init(&err);
> +	ret = parse_events(evlist, str, &err);
> +	if (ret) {
> +		evlist__delete(evlist);
> +		if (tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
> +			ret = TEST_OK;
> +			goto out;
> +		}
> +
> +		pr_debug("FAILED %s:%d failed to parse event '%s', err %d\n",
> +			 __FILE__, __LINE__, str, ret);
> +		parse_events_error__print(&err, str);
> +		ret = TEST_FAIL;
> +		goto out;
> +	}
> +
> +	ret = TEST_OK;
> +	if (with_pmu ? (evlist->core.nr_entries != 1) : (evlist->core.nr_entries < 1)) {
> +		pr_debug("FAILED %s:%d Unexpected number of events for '%s' of %d\n",
> +			 __FILE__, __LINE__, str, evlist->core.nr_entries);
> +		ret = TEST_FAIL;
> +		goto out;
> +	}
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (perf_pmu__is_tool(evsel->pmu)) {
> +			if (evsel->core.attr.config != ev) {
> +				pr_debug("FAILED %s:%d Unexpected config for '%s', %lld != %d\n",
> +					__FILE__, __LINE__, str, evsel->core.attr.config, ev);
> +				ret = TEST_FAIL;
> +				goto out;
> +			}
> +			found = true;
> +		}
> +	}
> +
> +	if (!found && !tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
> +		pr_debug("FAILED %s:%d Didn't find tool event '%s' in parsed evsels\n",
> +			 __FILE__, __LINE__, str);
> +		ret = TEST_FAIL;
> +	}
> +
> +out:
> +	evlist__delete(evlist);
> +	return ret;
> +}
> +
> +static int test__tool_pmu_without_pmu(struct test_suite *test __maybe_unused,
> +				      int subtest __maybe_unused)
> +{
> +	int i;
> +
> +	tool_pmu__for_each_event(i) {
> +		int ret = do_test(i, /*with_pmu=*/false);
> +
> +		if (ret != TEST_OK)
> +			return ret;
> +	}
> +	return TEST_OK;
> +}
> +
> +static int test__tool_pmu_with_pmu(struct test_suite *test __maybe_unused,
> +				   int subtest __maybe_unused)
> +{
> +	int i;
> +
> +	tool_pmu__for_each_event(i) {
> +		int ret = do_test(i, /*with_pmu=*/true);
> +
> +		if (ret != TEST_OK)
> +			return ret;
> +	}
> +	return TEST_OK;
> +}
> +
> +static struct test_case tests__tool_pmu[] = {
> +	TEST_CASE("Parsing without PMU name", tool_pmu_without_pmu),
> +	TEST_CASE("Parsing with PMU name", tool_pmu_with_pmu),
> +	{	.name = NULL, }

An unusual indentation.

Thanks,
Namhyung


> +};
> +
> +struct test_suite suite__tool_pmu = {
> +	.desc = "Tool PMU",
> +	.test_cases = tests__tool_pmu,
> +};
> -- 
> 2.46.0.469.g59c65b2a67-goog
> 
