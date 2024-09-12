Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64652C80;
	Thu, 12 Sep 2024 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181418; cv=none; b=eKWFLZOMEbJa5fYd8ONuXJf0nDJzGNawO+uxn0FyhCeTzS3qFdtzboRhBKHtl3OfHqVdjjMVnWaWZh32of/k9m2OZO4k/9L+Us1bu2Rm8ZpG2hfOm6aaQj2M5bwoHAk+6k5V1wL1XFViii9DIcFp/MfMW5LVtNEb0om8H1Hb0VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181418; c=relaxed/simple;
	bh=NY0p3xR2vEqci09C9/o+Zh+pGhrvoPtl3r1LixLt0+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcGTEL0Gyerp5WNwZYl76bgUqdrEJtwT2vPfdEYBL8wwfKy0Ec2BDl2uZ2UopnIC4ue3TDZs5M9K8CBDAyGd/yG/60u/oAHL/iRkw48FClNR4XHMqXfevlHp1SSBm2vMaWJHfQQGMrntzyC96l6U5Q4piJ04KD2h4tf5qtmkLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpwbQFaG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpwbQFaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD71C4CEC3;
	Thu, 12 Sep 2024 22:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726181418;
	bh=NY0p3xR2vEqci09C9/o+Zh+pGhrvoPtl3r1LixLt0+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpwbQFaGHbg2UI+G/qAHCWRm+sNr/rWbLx2IK9LMBh9SJeCW1Owp2r7rLIFqeJeoI
	 jWWOTz88t1wi3ruIqyPlMNebCiA4VPhql0ri4OSPXjGcCCBR0vQJKLeurJaY7/cC/V
	 1KqnwDL8SF90mwedUndHxNTQ1sl6+PZB9Y8Gz6CEaln7PukVYp5352k7Kih2fZsetH
	 tXZz0q5l1fmhNk0IrNrY3BbBjIrVUA5LlYikSoVhHtY0tpdCIOkBhsJsUVsWWkjupC
	 KosHEtiBO/ycMBN1b3Ysb4wKz1axY5Dip+a7Srj3/lfWQZoTDTt1VUs9BuTHnUm7gX
	 TpiAdLj7DhwOg==
Date: Thu, 12 Sep 2024 15:50:15 -0700
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
Subject: Re: [PATCH v2 00/13] Tool and hwmon PMUs
Message-ID: <ZuNwJ07GyMVIT0Qi@google.com>
References: <20240912190341.919229-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912190341.919229-1-irogers@google.com>

On Thu, Sep 12, 2024 at 12:03:27PM -0700, Ian Rogers wrote:
> Rather than have fake and tool PMUs being special flags in an evsel,
> create special PMUs. This allows, for example, duration_time to also
> be tool/duration_time/. Once adding events to the tools PMU is just
> adding to an array, add events for nearly all the expr literals like
> num_cpus_online. Rather than create custom logic for finding and
> describing the tool events use json and add a notion of common json
> for the tool events.
> 
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
> v2: Address Namhyung's review feedback. Rebase dropping 4 patches
>     applied by Arnaldo, fix build breakage reported by Arnaldo.
> 
> Ian Rogers (13):
>   perf pmu: Simplify an asprintf error message
>   perf pmu: Allow hardcoded terms to be applied to attributes
>   perf parse-events: Expose/rename config_term_name
>   perf tool_pmu: Factor tool events into their own PMU
>   perf tool_pmu: Rename enum perf_tool_event to tool_pmu_event
>   perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
>   perf tool_pmu: Move expr literals to tool_pmu
>   perf jevents: Add tool event json under a common architecture
>   perf tool_pmu: Switch to standard pmu functions and json descriptions
>   perf tests: Add tool PMU test
>   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
>   perf test: Add hwmon "PMU" test
>   perf docs: Document tool and hwmon events

For patch 1-10,

Acked-by: Namhyung Kim <namhyung@kernel.org>

I'll take a look at hwmon patches later, but I think it'd be nice if you
could split the change into pieces.

Thanks,
Namhyung

> 
>  tools/perf/Documentation/perf-list.txt        |  15 +
>  tools/perf/arch/arm64/util/pmu.c              |   5 +-
>  tools/perf/arch/x86/util/intel-pt.c           |   3 +-
>  tools/perf/arch/x86/util/tsc.c                |  18 +-
>  tools/perf/builtin-list.c                     |  13 +-
>  tools/perf/builtin-stat.c                     |   7 +-
>  .../pmu-events/arch/common/common/tool.json   |  74 ++
>  tools/perf/pmu-events/empty-pmu-events.c      | 208 +++--
>  tools/perf/pmu-events/jevents.py              |  16 +-
>  tools/perf/tests/Build                        |   2 +
>  tools/perf/tests/builtin-test.c               |   2 +
>  tools/perf/tests/hwmon_pmu.c                  | 243 ++++++
>  tools/perf/tests/pmu.c                        |   3 +-
>  tools/perf/tests/tests.h                      |   2 +
>  tools/perf/tests/tool_pmu.c                   | 111 +++
>  tools/perf/util/Build                         |   2 +
>  tools/perf/util/evsel.c                       | 287 +-----
>  tools/perf/util/evsel.h                       |  28 +-
>  tools/perf/util/expr.c                        |  93 +-
>  tools/perf/util/hwmon_pmu.c                   | 818 ++++++++++++++++++
>  tools/perf/util/hwmon_pmu.h                   | 154 ++++
>  tools/perf/util/metricgroup.c                 |  35 +-
>  tools/perf/util/parse-events.c                |  62 +-
>  tools/perf/util/parse-events.h                |   5 +-
>  tools/perf/util/parse-events.l                |  11 -
>  tools/perf/util/parse-events.y                |  16 -
>  tools/perf/util/pmu.c                         | 104 ++-
>  tools/perf/util/pmu.h                         |   9 +-
>  tools/perf/util/pmus.c                        |  16 +
>  tools/perf/util/pmus.h                        |   3 +
>  tools/perf/util/print-events.c                |  36 +-
>  tools/perf/util/print-events.h                |   1 -
>  tools/perf/util/stat-display.c                |  14 +-
>  tools/perf/util/stat-shadow.c                 |  22 +-
>  tools/perf/util/tool_pmu.c                    | 508 +++++++++++
>  tools/perf/util/tool_pmu.h                    |  56 ++
>  tools/perf/util/tsc.h                         |   2 +-
>  37 files changed, 2376 insertions(+), 628 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/common/common/tool.json
>  create mode 100644 tools/perf/tests/hwmon_pmu.c
>  create mode 100644 tools/perf/tests/tool_pmu.c
>  create mode 100644 tools/perf/util/hwmon_pmu.c
>  create mode 100644 tools/perf/util/hwmon_pmu.h
>  create mode 100644 tools/perf/util/tool_pmu.c
>  create mode 100644 tools/perf/util/tool_pmu.h
> 
> -- 
> 2.46.0.662.g92d0881bb0-goog
> 
