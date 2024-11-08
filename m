Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3039233D79;
	Fri,  8 Nov 2024 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094318; cv=none; b=eIoHWgQDPZbshf1clX3gO9gvmbjvsp8Qwtb3poekSD11As3ZS6SlUwf1VrehyTI3u95lBhPQN6ilR1i5UnZ/XK1i1vdROuTWUqbG5MXJqXeJDqHMqOsXhry6ZDYB3dUa2mzVsRS3qDISxu/PFTXtw7TkmNPAECYYURK1HBfVzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094318; c=relaxed/simple;
	bh=fbNcxV7JKZ03VhdP/6pKkK7jXVfB49a1CDflPop2MLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0N83izkxgn02OmzsaPRV3+P55O645D5ixbqKWMu+OPeiTuHvoVvDWqJLXusfhBMbA7+BD65Hgxy3tV7pakgzMeykOqS4TGtKFIflOHn0kD1x/Dw4QK17d6mWednoXK4HMx5tq+BhyIQwrxBdPflBfaaDuwdLXcmaVjXr1ARJeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv2DPOgs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv2DPOgs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA21C4CECD;
	Fri,  8 Nov 2024 19:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731094318;
	bh=fbNcxV7JKZ03VhdP/6pKkK7jXVfB49a1CDflPop2MLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qv2DPOgs0fI1N25oFnYLBIc6POppRQtP5eBMa5sq+wk+lSlVxEYyAwuqUebI04u0G
	 D03e+W9k2+JRufGstpEdKWUBkoYhYctxwOjOWaIYuaSI64tsJHL6oQZCly9cFbz0Li
	 RP2UT6vVDLDkm4/vRuKSrSnSkbC3ZHJ7wzfRjweyI73Wian/tzz8PMQm1g0tkedjGq
	 tfRz7OjYclGHKwSBGLg5EE4RLcmXN5FXCd+33REGdJAM/Ixq7v9qd2dojuISjfYDgi
	 uSREr23lke9rOjBxdpYwKYbaADw2b94K3IfTSeHVyobKF25PHm9dfku7CLchxPfGS7
	 ks9tLlP8Ik9HA==
Date: Fri, 8 Nov 2024 11:31:55 -0800
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
Subject: Re: [PATCH v7 0/7] Hwmon PMUs
Message-ID: <Zy5nKxruRDahwPue@google.com>
References: <20241108174936.262704-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108174936.262704-1-irogers@google.com>

On Fri, Nov 08, 2024 at 09:49:29AM -0800, Ian Rogers wrote:
> Following the convention of the tool PMU, create a hwmon PMU that
> exposes hwmon data for reading. For example, the following shows
> reading the CPU temperature and 2 fan speeds alongside the uncore
> frequency:
> ```
> $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/ -M UNCORE_FREQ -I 1000
>      1.001153138              52.00 'C   temp_cpu
>      1.001153138              2,588 rpm  fan1
>      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
>      1.001153138                  8      tool/num_cpus_online/
>      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET                 #     1.08 UNCORE_FREQ
>      1.001153138      1,012,773,595      duration_time
> ...
> ```
> 
> Additional data on the hwmon events is in perf list:
> ```
> $ perf list
> ...
> hwmon:
> ...
>   temp_core_0 OR temp2
>        [Temperature in unit coretemp named Core 0. crit=100'C,max=100'C crit_alarm=0'C. Unit:
>         hwmon_coretemp]
> ...
> ```
> 
> v7: Try to address feedback from Namhyung wrt size/comprehensibility
>     of the hwmon PMU patch. To better explain the config encoding put
>     the parser into a patch ahead of the PMU patch and add a unit
>     test. This shows how a hwmon filename can be moved back-and-forth
>     with a config value as a single patch (two with the test). The
>     hwmon PMU patch is then putting the wrapping around that for the
>     pmus', parse_event's and evsel reading's benefit.

Thanks for doing this!
Namhyung

>     
>     The alternate approach of not caring about the mapping, name to
>     config value, and using the evsel->name wasn't followed. In the
>     tool PMU it was made so we can go back-and-forth between event
>     names and a type+config, this removed the tool enum value from the
>     evsel as now tool events were more 1st class and evsel should
>     really just be a wrapper on a perf_event_attr. Using the
>     evsel->name wasn't doing that and so the approach of mapping
>     filenames and configs, as better highlighted in this series was
>     pursued.
> 
>     It is expected future PMUs won't be able to cleanly map fixed
>     strings to config values, in those cases tables would be
>     necessary. Making a hwmon PMU do this and then removing it to
>     follow the parsing/mapping done in patch 2 here, would have been a
>     lot of additional work which then would be removed.
> 
> v6: Add string.h #include for issue reported by kernel test robot.
> v5: Fix asan issue in parse_hwmon_filename caught by a TMA metric.
> v4: Drop merged patches 1 to 10. Separate adding the hwmon_pmu from
>     the update to perf_pmu to use it. Try to make source of literal
>     strings clearer via named #defines. Fix a number of GCC warnings.
> v3: Rebase, add Namhyung's acked-by to patches 1 to 10.
> v2: Address Namhyung's review feedback. Rebase dropping 4 patches
>     applied by Arnaldo, fix build breakage reported by Arnaldo.
> 
> Ian Rogers (7):
>   tools api io: Ensure line_len_out is always initialized
>   perf hwmon_pmu: Add hwmon filename parser
>   perf test: Add hwmon filename parser test
>   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
>   perf pmu: Add calls enabling the hwmon_pmu
>   perf test: Add hwmon "PMU" test
>   perf docs: Document tool and hwmon events
> 
>  tools/lib/api/io.h                     |   1 +
>  tools/perf/Documentation/perf-list.txt |  15 +
>  tools/perf/tests/Build                 |   1 +
>  tools/perf/tests/builtin-test.c        |   1 +
>  tools/perf/tests/hwmon_pmu.c           | 340 ++++++++++
>  tools/perf/tests/tests.h               |   1 +
>  tools/perf/util/Build                  |   1 +
>  tools/perf/util/evsel.c                |   9 +
>  tools/perf/util/hwmon_pmu.c            | 825 +++++++++++++++++++++++++
>  tools/perf/util/hwmon_pmu.h            | 156 +++++
>  tools/perf/util/pmu.c                  |  20 +
>  tools/perf/util/pmu.h                  |   2 +
>  tools/perf/util/pmus.c                 |   9 +
>  tools/perf/util/pmus.h                 |   3 +
>  14 files changed, 1384 insertions(+)
>  create mode 100644 tools/perf/tests/hwmon_pmu.c
>  create mode 100644 tools/perf/util/hwmon_pmu.c
>  create mode 100644 tools/perf/util/hwmon_pmu.h
> 
> -- 
> 2.47.0.277.g8800431eea-goog
> 
