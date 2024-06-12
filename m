Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3A3110A;
	Wed, 12 Jun 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187388; cv=none; b=RdXnVtFpxNEUG0O7x8oAeokWBcwhQvoUFr9bHPsmCdkK8zefPnf8Izu8GBhCfPBzVMio77Iy6U2xDWgxoIDSCH5sY8Ctu+n1vQayb+AnbPKpPQAPN34mZisCNye0xlLHNFABTntxCMw+tG1WHLEWP/nu4fIUJ5FtvFcC530kAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187388; c=relaxed/simple;
	bh=aObPsDD/jDTOxpxuQPyX8DttTAfm3t8fCC5A2NzoRNI=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RvHVOi8jNRcCBqjTIxpCIdafHK0eKFeqDcRSLUHz/ZA78e4j8vVcbM9sNmHd7CyYTU9LFoCk8F/Nx7pLh/KFhb5X6WP9GrRmSeqSu+gcTg3+HI6NLMo7MFs1W2xyKEJjNr0328e4oLQ82YTjznJyvEfq0YmeRHoObyisTVPvBmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VzhGj3HPMz1HDY6;
	Wed, 12 Jun 2024 18:14:21 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 72296180065;
	Wed, 12 Jun 2024 18:16:16 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 12 Jun 2024 18:16:15 +0800
CC: <yangyicong@hisilicon.com>
Subject: Re: [PATCH v1] perf arm: Workaround ARM PMUs cpu maps having offline
 cpus
To: Ian Rogers <irogers@google.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, James Clark
	<james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, Will Deacon
	<will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Adrian
 Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
	<coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240607065343.695369-1-irogers@google.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <cc4ac58b-6a0b-1d72-f881-a60b43d5c229@huawei.com>
Date: Wed, 12 Jun 2024 18:16:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240607065343.695369-1-irogers@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200014.china.huawei.com (7.221.188.8)

Hi Ian,

On 2024/6/7 14:53, Ian Rogers wrote:
> When PMUs have a cpu map in the 'cpus' or 'cpumask' file, perf will
> try to open events on those CPUs. ARM doesn't remove offline CPUs
> meaning taking a CPU offline will cause perf commands to fail unless a
> CPU map is passed on the command line.
> 
> More context in:
> https://lore.kernel.org/lkml/20240603092812.46616-1-yangyicong@huawei.com/
> 
> Reported-by: Yicong Yang <yangyicong@huawei.com>
> Closes: https://lore.kernel.org/lkml/20240603092812.46616-2-yangyicong@huawei.com/
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested worked for this case:

[root@localhost tmp]# echo 0 > /sys/devices/system/cpu/cpu1/online
[root@localhost tmp]# /home/yang/perf_static stat -e armv8_pmuv3_0/cpu_cycles/ --timeout 100
Error:
The sys_perf_event_open() syscall returned with 19 (No such device) for event (armv8_pmuv3_0/cpu_cycles/).
/bin/dmesg | grep -i perf may provide additional information.

[root@localhost tmp]# /tmp/perf_Ian stat -e armv8_pmuv3_0/cpu_cycles/ --timeout 100

 Performance counter stats for 'system wide':

          54994604      armv8_pmuv3_0/cpu_cycles/

       0.176079800 seconds time elapsed

So:
Tested-by: Yicong Yang <yangyicong@hisilicon.com>

But still wondering why isn't it better to move this into pmu_cpumask() as does in
the previous patch? Yes currently this is a arm specific issue, but we cannot handle
the case if later PMU doesn't update the cpus/cpumask either :)

> ---
>  tools/perf/arch/arm/util/pmu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index 8b7cb68ba1a8..6b544edbd3f6 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -11,12 +11,15 @@
>  
>  #include "arm-spe.h"
>  #include "hisi-ptt.h"
> +#include "../../../util/cpumap.h"
>  #include "../../../util/pmu.h"
>  #include "../../../util/cs-etm.h"
>  #include "../../arm64/util/mem-events.h"
>  
> -void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> +void perf_pmu__arch_init(struct perf_pmu *pmu)
>  {
> +	struct perf_cpu_map *intersect;
> +
>  #ifdef HAVE_AUXTRACE_SUPPORT
>  	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
>  		/* add ETM default config here */
> @@ -33,6 +36,9 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  		pmu->selectable = true;
>  #endif
>  	}
> -
>  #endif
> +	/* Workaround some ARM PMU's failing to correctly set CPU maps for online processors. */
> +	intersect = perf_cpu_map__intersect(cpu_map__online(), pmu->cpus);
> +	perf_cpu_map__put(pmu->cpus);
> +	pmu->cpus = intersect;
>  }
> 
