Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C328249B;
	Mon, 10 Jun 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026202; cv=none; b=qKwaDqByk1TPAk3qsjXJDk4zVDwDf3UDpXFLgNANm6jlR/qoVSDg6qmlRejjmXwY8JiJjlnfy/G4Ydkx4IMhdBEGTiJpqYopnvVBFNd0svVr95Keav4MQD1tS8w5VdzfjQkZPUYCJfBNsS4cnUgdPGZCJWu2GsMYoMbrEz3jUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026202; c=relaxed/simple;
	bh=pJs6mwstDQaHQs2FVF03s7TQ7W6Rw3QLFBtu7GmPXVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FuOIcf9+bBp8R40U0UBfX8HV561DP8Ow0NdKSXIIRg4ZlgS7DIkgi7aFyJ8EFwmYkjSCwP3s5ejFcnt2IZRw6lFKGmYbQ6V60O4oJP35vP82St8hnAmpcjcODA33rgy6ZXQ6KecXcAwyEalJwF8OvWOvAy1SmIxGDmPssc8GElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C15011FB;
	Mon, 10 Jun 2024 06:30:24 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5603F58B;
	Mon, 10 Jun 2024 06:29:57 -0700 (PDT)
Message-ID: <23ee1734-7e65-4f11-aede-fea44ada3cc4@arm.com>
Date: Mon, 10 Jun 2024 14:29:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf arm: Workaround ARM PMUs cpu maps having offline
 cpus
To: Ian Rogers <irogers@google.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yicong Yang <yangyicong@huawei.com>
References: <20240607065343.695369-1-irogers@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240607065343.695369-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Ian,

On 6/7/24 07:53, Ian Rogers wrote:

[...]

> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index 8b7cb68ba1a8..6b544edbd3f6 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -11,12 +11,15 @@
> 
>   #include "arm-spe.h"
>   #include "hisi-ptt.h"
> +#include "../../../util/cpumap.h"
>   #include "../../../util/pmu.h"
>   #include "../../../util/cs-etm.h"
>   #include "../../arm64/util/mem-events.h"
> 
> -void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> +void perf_pmu__arch_init(struct perf_pmu *pmu)
>   {
> +       struct perf_cpu_map *intersect;
> +
>   #ifdef HAVE_AUXTRACE_SUPPORT
>          if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
>                  /* add ETM default config here */
> @@ -33,6 +36,9 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>                  pmu->selectable = true;
>   #endif
>          }
> -
>   #endif
> +       /* Workaround some ARM PMU's failing to correctly set CPU maps for online processors. */
> +       intersect = perf_cpu_map__intersect(cpu_map__online(), pmu->cpus);
> +       perf_cpu_map__put(pmu->cpus);
> +       pmu->cpus = intersect;

I did a test for this patch, it works well for me.

Tested-by: Leo Yan <leo.yan@arm.com>

Just a nitpick and I think it is not an issue caused by this patch.
After hotplug off one CPU and then if specify the CPU with option '-C',
the 'perf stat' command still continues to run. This is inconsistent
with the 'perf record' which exits with failures immediately.

Maybe consider to send an extra patch to address this issue?

The test steps are:

   # echo 0 > /sys/devices/system/cpu0/online
   # perf stat -C 0 -e armv9_cortex_a520/cycles/ -- sleep 1
     WARNING: A requested CPU in '0' is not supported by PMU 
'armv9_cortex_a520' (CPUs 5) for event 'armv9_cortex_a520/cycles/'

     Performance counter stats for 'CPU(s) 0':

       <not supported>      armv9_cortex_a520/cycles/

           1.001223060 seconds time elapsed

Thanks,
Leo

>   }
> --
> 2.45.2.505.gda0bf45e8d-goog
> 
> 
