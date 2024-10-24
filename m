Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D0482EB;
	Thu, 24 Oct 2024 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729739206; cv=none; b=Hm7W1s43v3sdqiyPrIgdByzVqFUHcmFboqc/EPaVXhLZFmtzbPFSqJz5gu/dbiSqXmnewb32yrzmGUksJdWLtxIFg/T0TN+RYYe7CQJnKGjQaPBCRcQXT4iETRv6BlilH6K972V6upZ1JHhmR7GlpASriVMWIYrihZTIdYj+H8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729739206; c=relaxed/simple;
	bh=idlAGLwFHth059G6pQJOOqh6gCScQHa8vkEmecsBQLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sap7hBexI3JuuXSDB0QFo52K7S7BI0s+fUOjvmCXRz5pZ+t26RKiJPxKNFCqfSPFmIOosWY5EPuiAy+3Wmc104x9QjcP7+mG3d/o34zNL8q/be1JOIVrs+Nsxos6PpuV7o01NxDo83q0Esavy+/BdiJxz8M1AgkYJhQ/p8LQyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2oHIB1O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2oHIB1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4CBC4CEC6;
	Thu, 24 Oct 2024 03:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729739205;
	bh=idlAGLwFHth059G6pQJOOqh6gCScQHa8vkEmecsBQLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2oHIB1OVeN0kjMdZCOyV8quz5zRIv2RAF0/LszqlxEMpchNt3bnZcLZXujIYUttU
	 EwNcZ3VC7c1cL/kapD56Re0wcd7qN0uUKrY6TSxALfmguZJdhqXVIyOMFAiUhs2ICP
	 a1Kmpe/Sz7y1n+odpKbCYxvkaRM4tLKqpb1aIlpjZ+L73nnhK4rKdFJd4iJjbs2i1t
	 +xG4gE9sas1wEM9kFh3CTHLuHf00zWfV3hhHwg6ATkZ3cjJTA0wRfD5T1lfQKwQB9a
	 ASlaWuSOt+O+z5LYYFnjUL2h9AWJ9HhC0dwJyFY4gTfvKRrQgsdEhqlA3Agr6kK/kc
	 3BmGh2ZR1DBOQ==
Date: Wed, 23 Oct 2024 20:06:43 -0700
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
Subject: Re: [PATCH v6 0/5]  Hwmon PMUs
Message-ID: <Zxm5w6wXLxpbERZx@google.com>
References: <20241022180623.463131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022180623.463131-1-irogers@google.com>

Hi Ian,

On Tue, Oct 22, 2024 at 11:06:18AM -0700, Ian Rogers wrote:
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
> v6: Add string.h #include for issue reported by kernel test robot.
> v5: Fix asan issue in parse_hwmon_filename caught by a TMA metric.
> v4: Drop merged patches 1 to 10. Separate adding the hwmon_pmu from
>     the update to perf_pmu to use it. Try to make source of literal
>     strings clearer via named #defines. Fix a number of GCC warnings.
> v3: Rebase, add Namhyung's acked-by to patches 1 to 10.
> v2: Address Namhyung's review feedback. Rebase dropping 4 patches
>     applied by Arnaldo, fix build breakage reported by Arnaldo.
> 
> Ian Rogers (5):
>   tools api io: Ensure line_len_out is always initialized
>   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
>   perf pmu: Add calls enabling the hwmon_pmu
>   perf test: Add hwmon "PMU" test
>   perf docs: Document tool and hwmon events

I think the patch 2 can be easily splitted into core and other parts
like dealing with aliases and units.  I believe it'd be helpful for
others (like me) to understand how it works.

Please take a look at 'perf/hwmon-pmu' branch in:

  https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

> 
>  tools/lib/api/io.h                     |   1 +
>  tools/perf/Documentation/perf-list.txt |  15 +
>  tools/perf/tests/Build                 |   1 +
>  tools/perf/tests/builtin-test.c        |   1 +
>  tools/perf/tests/hwmon_pmu.c           | 243 ++++++++
>  tools/perf/tests/tests.h               |   1 +
>  tools/perf/util/Build                  |   1 +
>  tools/perf/util/evsel.c                |   9 +
>  tools/perf/util/hwmon_pmu.c            | 821 +++++++++++++++++++++++++
>  tools/perf/util/hwmon_pmu.h            | 154 +++++
>  tools/perf/util/pmu.c                  |  20 +
>  tools/perf/util/pmu.h                  |   2 +
>  tools/perf/util/pmus.c                 |   9 +
>  tools/perf/util/pmus.h                 |   3 +
>  14 files changed, 1281 insertions(+)
>  create mode 100644 tools/perf/tests/hwmon_pmu.c
>  create mode 100644 tools/perf/util/hwmon_pmu.c
>  create mode 100644 tools/perf/util/hwmon_pmu.h
> 
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
