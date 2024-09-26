Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB31BC58;
	Thu, 26 Sep 2024 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727381589; cv=none; b=Vd8dEems5cz7p8IwzSX25jM6/QVUaHtV5ZGCfbARMq0l5XvDOUA0ToHZAtuVh1KwMjLixCqYMajRN+aKwXAetm17sbbt37K9YtK2OuarZycD2EVbbjkE4QDVMemDQvH3ULoNpF4S+iDjyl9wADLpsIoBY0AUsa11Eqvsny9JUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727381589; c=relaxed/simple;
	bh=DfUkjGWOlcvpaVhHWXCIGOf0Wy4ZOw6Knk8goDl7nUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ByjmH0hJwQvoPo6BYgqrq4YAOV9t+Vv7IxzR8ZErZJUVIpf5mDBvmQwxPiCKXACtt02oeYax9ljQCS7+SaKou/9si2bRYDJCz4TYLTvJGXOmCUTxW/Mo/25ImX4pr14A65S63XkigLxlMt8RhNCFjCaOts49x8VsxY3TDiSsRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB45314BF;
	Thu, 26 Sep 2024 13:13:35 -0700 (PDT)
Received: from [10.57.20.191] (unknown [10.57.20.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 599EB3F587;
	Thu, 26 Sep 2024 13:13:03 -0700 (PDT)
Message-ID: <e9c77ce7-0bfb-41cf-9034-2d96359a30a8@arm.com>
Date: Thu, 26 Sep 2024 21:12:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf jevents: Add cycles breakdown metric for
 arm64/AMD/Intel
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Jing Zhang <renyu.zj@linux.alibaba.com>,
 Thomas Richter <tmricht@linux.ibm.com>, James Clark <james.clark@arm.com>,
 Leo Yan <leo.yan@linux.dev>
References: <20240926175709.410022-1-irogers@google.com>
 <20240926175709.410022-3-irogers@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240926175709.410022-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/2024 6:57 PM, Ian Rogers wrote:
> 
> Breakdown cycles to user, kernel and guest. Add a common_metrics.py
> file for such metrics.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/Build             |  2 +-
>  tools/perf/pmu-events/amd_metrics.py    |  3 +++
>  tools/perf/pmu-events/arm64_metrics.py  |  2 ++
>  tools/perf/pmu-events/common_metrics.py | 18 ++++++++++++++++++
>  tools/perf/pmu-events/intel_metrics.py  |  2 ++
>  5 files changed, 26 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/pmu-events/common_metrics.py
> 
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index f3bc6c093360..91b6837e32c9 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -37,7 +37,7 @@ $(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
>         $(call rule_mkdir)
>         $(Q)$(call echo-cmd,gen)cp $< $@
> 
> -GEN_METRIC_DEPS := pmu-events/metric.py
> +GEN_METRIC_DEPS := pmu-events/metric.py pmu-events/common_metrics.py
> 
>  # Generate AMD Json
>  ZENS = $(shell ls -d pmu-events/arch/x86/amdzen*)
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index 422b119553ff..ccc8ebf13e08 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -4,6 +4,7 @@ from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
>                      JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
>                      Metric, MetricGroup, Select)
>  import argparse
> +from common_metrics import Cycles
>  import json
>  import math
>  import os
> @@ -571,6 +572,7 @@ def AmdUpc() -> Metric:
>    return Metric("upc", "Micro-ops retired per core cycle (higher is better)",
>                  upc, "uops/cycle")
> 
> +
>  def Idle() -> Metric:
>    cyc = Event("msr/mperf/")
>    tsc = Event("msr/tsc/")
> @@ -652,6 +654,7 @@ def main() -> None:
>        AmdHwpf(),
>        AmdSwpf(),
>        AmdUpc(),
> +      Cycles(),
>        Idle(),
>        Rapl(),
>        UncoreL3(),
> diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
> index bfac570600d9..5285a22ff0c8 100755
> --- a/tools/perf/pmu-events/arm64_metrics.py
> +++ b/tools/perf/pmu-events/arm64_metrics.py
> @@ -3,6 +3,7 @@
>  from metric import (d_ratio, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
>                      LoadEvents, Metric, MetricGroup)
>  import argparse
> +from common_metrics import Cycles
>  import json
>  import os
>  from typing import Optional
> @@ -171,6 +172,7 @@ def main() -> None:
> 
>    all_metrics = MetricGroup("",[
>        Arm64Topdown(),
> +      Cycles(),
>    ])
> 
>    if _args.metricgroups:
> diff --git a/tools/perf/pmu-events/common_metrics.py b/tools/perf/pmu-events/common_metrics.py
> new file mode 100644
> index 000000000000..74c58f9ab020
> --- /dev/null
> +++ b/tools/perf/pmu-events/common_metrics.py
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +from metric import (d_ratio, Event, Metric, MetricGroup)
> +
> +def Cycles() -> MetricGroup:
> +  cyc_k = Event("cycles:kHh")

I am confused that these modifiers should be OR operation or AND operation.

Seems to me, 'k' / 'H' modifiers are AND operation for tracing host and
kernel. But for 'h', it is OR operation with rest modifiers, as we want to
trace for both host kernel and hypervisor.

Sorry I might ask a duplicate question which has been discussed before.

The patch itself looks good to me.

Thanks for working on this.
Leo

> +  cyc_g = Event("cycles:G")
> +  cyc_u = Event("cycles:uH")
> +  cyc = cyc_k + cyc_g + cyc_u
> +
> +  return MetricGroup("cycles", [
> +      Metric("cycles_total", "Total number of cycles", cyc, "cycles"),
> +      Metric("cycles_user", "User cycles as a percentage of all cycles",
> +             d_ratio(cyc_u, cyc), "100%"),
> +      Metric("cycles_kernel", "Kernel cycles as a percentage of all cycles",
> +             d_ratio(cyc_k, cyc), "100%"),
> +      Metric("cycles_guest", "Hypervisor guest cycles as a percentage of all cycles",
> +             d_ratio(cyc_g, cyc), "100%"),
> +  ], description = "cycles breakdown per privilege level (users, kernel, guest)")
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index a3a317d13841..4b7668e25e54 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -5,6 +5,7 @@ from metric import (d_ratio, has_event, max, source_count, CheckPmu, Event,
>                      Literal, LoadEvents, Metric, MetricConstraint, MetricGroup,
>                      MetricRef, Select)
>  import argparse
> +from common_metrics import Cycles
>  import json
>  import math
>  import os
> @@ -1050,6 +1051,7 @@ def main() -> None:
>    LoadEvents(directory)
> 
>    all_metrics = MetricGroup("", [
> +      Cycles(),
>        Idle(),
>        Rapl(),
>        Smi(),
> --
> 2.46.1.824.gd892dcdcdd-goog
> 
> 
