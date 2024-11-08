Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85606233D79;
	Fri,  8 Nov 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094472; cv=none; b=jcKqo0LRd0UTrD4GgQ88Ksg0Jz770OhwVAxgok7zdq2ayF1uAReoEiu1G5iF58aKM/vyAbvoLIWsodKKMHcgE17eCLBp5GWw/C/B9O21YfsLE7OxngFAQw/hG0JUJjZ0KqIw3zCKGK8TcaUamRYDuw+JZmI2Dt7J26lFdYF52yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094472; c=relaxed/simple;
	bh=0e23Ceuspj28Gae/pnrt+3bj4sITFQ55jk93TWdRH/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdVBm7C0XrKbnG9bs3K90+VLH9FnIWGP0s1LtK4xGiP5rE01+3cLtAq8fO8kB1A8CMxcdgx0B2m44N6gBVytdShL1m3y6EFBVoUibJawbuhhD4To0sB/0+pOiy8Az+nVTeQys6Gw1fasbihTRIlSadR5PzfaU6lYPSRUIaUFlqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7iUWSLw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7iUWSLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F018C4CECD;
	Fri,  8 Nov 2024 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731094472;
	bh=0e23Ceuspj28Gae/pnrt+3bj4sITFQ55jk93TWdRH/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7iUWSLweMPN22JM1RfFEIO39gtlsikA1nmKI5Htn+pyynYFC+WfzIqM4wDseexXB
	 CjNFjCNLGBwsqUsqXnUk/Wgo2bJmpVSQWWRnejJFvz3wAN/st1ArrZZS+J6NnfKa4V
	 /GVxjV/S7sbcy8X+aGetXr6cJbO9/2h/pxZRmwmhMi1MTeoVNcNcFJmN/qbquy+V3/
	 iZck2Bu8hfjvcAmLWzyT1rF2DjDkKOwWDc+0+piCRZ1I9Tum+warnIyosz/bE5YWC4
	 +sUpe/uNBlGAp4psfzYDhifb2QFiw/0uKz8dwzzdOGJel37mdH6BIsVB2ArpIrriF3
	 PPIMjdulOCo+A==
Date: Fri, 8 Nov 2024 11:34:30 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	James Clark <james.clark@linaro.org>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 3/7] perf test: Add hwmon filename parser test
Message-ID: <Zy5nxlGZ5cZ69F5G@google.com>
References: <20241108174936.262704-1-irogers@google.com>
 <20241108174936.262704-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108174936.262704-4-irogers@google.com>

On Fri, Nov 08, 2024 at 09:49:32AM -0800, Ian Rogers wrote:
> Filename parsing maps a hwmon filename to constituent parts enum/int
> parts for the hwmon config value. Add a test case for the parsing.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |   1 +
>  tools/perf/tests/hwmon_pmu.c    | 110 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h        |   1 +
>  tools/perf/util/hwmon_pmu.c     |   2 +-
>  5 files changed, 114 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/tests/hwmon_pmu.c
> 
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 01ed9335db4d..ec4e1f034742 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -66,6 +66,7 @@ perf-test-y += sigtrap.o
>  perf-test-y += event_groups.o
>  perf-test-y += symbols.o
>  perf-test-y += util.o
> +perf-test-y += hwmon_pmu.o
>  perf-test-y += tool_pmu.o
>  
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index d2cabaa8ad92..8dcf74d3c0a3 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -71,6 +71,7 @@ static struct test_suite *generic_tests[] = {
>  	&suite__PERF_RECORD,
>  	&suite__pmu,
>  	&suite__pmu_events,
> +	&suite__hwmon_pmu,
>  	&suite__tool_pmu,
>  	&suite__dso_data,
>  	&suite__perf_evsel__roundtrip_name_test,
> diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
> new file mode 100644
> index 000000000000..f5b58486d8d3
> --- /dev/null
> +++ b/tools/perf/tests/hwmon_pmu.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +#include "debug.h"
> +#include "hwmon_pmu.h"
> +#include "tests.h"
> +#include <linux/compiler.h>
> +#include <linux/kernel.h>
> +
> +static int test__parse_hwmon_filename(struct test_suite *test __maybe_unused,
> +				      int subtest __maybe_unused)
> +{
> +	const struct hwmon_parse_test {
> +		const char *filename;
> +		enum hwmon_type type;
> +		int number;
> +		enum hwmon_item item;
> +		bool alarm;
> +		bool parse_ok;
> +	} tests[] = {
> +		{
> +			.filename = "cpu0_accuracy",
> +			.type = HWMON_TYPE_CPU,
> +			.number = 0,
> +			.item = HWMON_ITEM_ACCURACY,
> +			.alarm = false,
> +			.parse_ok = true,
> +		},
> +		{
> +			.filename = "temp1_input",
> +			.type = HWMON_TYPE_TEMP,
> +			.number = 1,
> +			.item = HWMON_ITEM_INPUT,
> +			.alarm = false,
> +			.parse_ok = true,
> +		},
> +		{
> +			.filename = "fan2_vid",
> +			.type = HWMON_TYPE_FAN,
> +			.number = 2,
> +			.item = HWMON_ITEM_VID,
> +			.alarm = false,
> +			.parse_ok = true,
> +		},
> +		{
> +			.filename = "power3_crit_alarm",
> +			.type = HWMON_TYPE_POWER,
> +			.number = 3,
> +			.item = HWMON_ITEM_CRIT,
> +			.alarm = true,
> +			.parse_ok = true,
> +		},
> +		{
> +			.filename = "intrusion4_average_interval_min_alarm",
> +			.type = HWMON_TYPE_INTRUSION,
> +			.number = 4,
> +			.item = HWMON_ITEM_AVERAGE_INTERVAL_MIN,
> +			.alarm = true,
> +			.parse_ok = true,
> +		},
> +		{
> +			.filename = "badtype5_baditem",
> +			.type = HWMON_TYPE_NONE,
> +			.number = 5,
> +			.item = HWMON_ITEM_NONE,
> +			.alarm = false,
> +			.parse_ok = false,
> +		},
> +		{
> +			.filename = "humidity6_baditem",
> +			.type = HWMON_TYPE_NONE,
> +			.number = 6,
> +			.item = HWMON_ITEM_NONE,
> +			.alarm = false,
> +			.parse_ok = false,
> +		},
> +	};
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
> +		enum hwmon_type type;
> +		int number;
> +		enum hwmon_item item;
> +		bool alarm;
> +
> +		TEST_ASSERT_EQUAL("parse_hwmon_filename",
> +				parse_hwmon_filename(
> +					tests[i].filename,
> +					&type,
> +					&number,
> +					&item,
> +					&alarm),
> +				tests[i].parse_ok
> +			);
> +		if (tests[i].parse_ok) {
> +			TEST_ASSERT_EQUAL("parse_hwmon_filename type", type, tests[i].type);
> +			TEST_ASSERT_EQUAL("parse_hwmon_filename number", number, tests[i].number);
> +			TEST_ASSERT_EQUAL("parse_hwmon_filename item", item, tests[i].item);
> +			TEST_ASSERT_EQUAL("parse_hwmon_filename alarm", alarm, tests[i].alarm);
> +		}
> +	}
> +	return TEST_OK;
> +}
> +
> +static struct test_case tests__hwmon_pmu[] = {
> +	TEST_CASE("Basic parsing test", parse_hwmon_filename),
> +	{	.name = NULL, }
> +};
> +
> +struct test_suite suite__hwmon_pmu = {
> +	.desc = "Hwmon PMU",
> +	.test_cases = tests__hwmon_pmu,
> +};
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index af284dd47e5c..cb58b43aa063 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -92,6 +92,7 @@ DECLARE_SUITE(perf_evsel__tp_sched_test);
>  DECLARE_SUITE(syscall_openat_tp_fields);
>  DECLARE_SUITE(pmu);
>  DECLARE_SUITE(pmu_events);
> +DECLARE_SUITE(hwmon_pmu);
>  DECLARE_SUITE(tool_pmu);
>  DECLARE_SUITE(attr);
>  DECLARE_SUITE(dso_data);
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index ee5fb1c41da3..f4b7b3b6a052 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -126,7 +126,7 @@ bool parse_hwmon_filename(const char *filename,
>  	fn_item_len = strlen(fn_item);
>  	if (fn_item_len > 6 && !strcmp(&fn_item[fn_item_len - 6], "_alarm")) {
>  		assert(strlen(LONGEST_HWMON_ITEM_STR) < sizeof(fn_type));
> -		strlcpy(fn_type, fn_item, fn_item_len - 6);
> +		strlcpy(fn_type, fn_item, fn_item_len - 5);

Why is it changed?

Thanks,
Namhyung


>  		fn_item = fn_type;
>  		*alarm = true;
>  	}
> -- 
> 2.47.0.277.g8800431eea-goog
> 
