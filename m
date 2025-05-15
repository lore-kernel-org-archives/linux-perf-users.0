Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A005183098;
	Thu, 15 May 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747325217; cv=none; b=Md6xhroATdt83UePXeRQrXriKZmiWYZpsLhyGMb8jIT9HUqqQSsLAbtmlR2xgpWFa0lm51R1SX6I1XSVFEsmPuvjKANUT8yifuurXVVQAFrKMc+L1SFv6REspavdZ3X5taSbSxyx7O+gztHrG7198zAGfM+45RCSlLP6BpfgplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747325217; c=relaxed/simple;
	bh=mVOJxR9jh8qBUgfhL8DL2yKIBYy1OWgSMqw7m5awS+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mFb9waNF5JQSKup6HfdqGa8IjtbiRoXn6oqeoHBr285YCbyIlnMPWEVG/cjGnc17fCWuhCFOTlwa+EyHDzL3BbkyZb2m3DnfIMYxG/1WdL/lRIlZka9G5TMMB17h6eh3cF8mvI3ICexaHf6h8+3ybSAJCevdUfYo4xK1GesMs6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REM9fjKF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REM9fjKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747325215; x=1778861215;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=mVOJxR9jh8qBUgfhL8DL2yKIBYy1OWgSMqw7m5awS+0=;
  b=REM9fjKFkkkatxzIj423A1xnng2rm2uIvOFb8vxwy6QCojccKMuyuV4z
   u3Uf+Zhl4yIiEK7kIFpRoTSTZ11AcuC02Tqs4Bq7rv8rb3kH0+mlnEq5t
   FKRR4uWLsO6SSEJLuRrivFr9/PkGYrzlJKsnz8Y26Zw+puizzJRzLkUET
   sjIRevC6HTmKdsFX1VjmHHQXbH9Xynj9KnVHTB1bqj7g+FVJxOnz5okj1
   0IQK9PWkjh33kfzZ7Q+De3ECO1CEmUVCsBBBV0TPmfyLLu70ENl5i+cxr
   O8OXkF4S9KO67eHwIClm3Pb7IOLFMWCKNtpEwhK9FUxIq7qdWZDmFaXxy
   w==;
X-CSE-ConnectionGUID: XgA5W68OSkKEbl3u8Pefmw==
X-CSE-MsgGUID: Cut/D4g7T/aYxAoBzaHzMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36890217"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="36890217"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 09:06:54 -0700
X-CSE-ConnectionGUID: b7phbyMvTemxrxhCMaTthA==
X-CSE-MsgGUID: j+40rhg9T/6p7FvTH5Y8WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="143532136"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 09:06:54 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 1F42220B5736;
	Thu, 15 May 2025 09:09:33 -0700 (PDT)
Message-ID: <909e988c-6e7c-4de1-b5b3-d5de119e4f35@linux.intel.com>
Date: Thu, 15 May 2025 12:06:52 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on graniterapids
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250515043818.236807-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250515043818.236807-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-15 12:38 a.m., Ian Rogers wrote:
> On graniterapids the cache home agent (CHA) and memory controller
> (IMC) PMUs all have their cpumask set to per-socket information. In
> order for per NUMA node aggregation to work correctly the PMUs cpumask
> needs to be set to CPUs for the relevant sub-NUMA grouping.
> 
> For example, on a 2 socket graniterapids machine with sub NUMA
> clustering of 3, for uncore_cha and uncore_imc PMUs the cpumask is
> "0,120" leading to aggregation only on NUMA nodes 0 and 3:
> ```
> $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
> N0        1    277,835,681,344      UNC_CHA_CLOCKTICKS
> N0        1     19,242,894,228      UNC_M_CLOCKTICKS
> N3        1    277,803,448,124      UNC_CHA_CLOCKTICKS
> N3        1     19,240,741,498      UNC_M_CLOCKTICKS
> 
>        1.002113847 seconds time elapsed
> ```
> 
> By updating the PMUs cpumasks to "0,120", "40,160" and "80,200" then
> the correctly 6 NUMA node aggregations are achieved:
> ```
> $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
> N0        1     92,748,667,796      UNC_CHA_CLOCKTICKS
> N0        0      6,424,021,142      UNC_M_CLOCKTICKS
> N1        0     92,753,504,424      UNC_CHA_CLOCKTICKS
> N1        1      6,424,308,338      UNC_M_CLOCKTICKS
> N2        0     92,751,170,084      UNC_CHA_CLOCKTICKS
> N2        0      6,424,227,402      UNC_M_CLOCKTICKS
> N3        1     92,745,944,144      UNC_CHA_CLOCKTICKS
> N3        0      6,423,752,086      UNC_M_CLOCKTICKS
> N4        0     92,725,793,788      UNC_CHA_CLOCKTICKS
> N4        1      6,422,393,266      UNC_M_CLOCKTICKS
> N5        0     92,717,504,388      UNC_CHA_CLOCKTICKS
> N5        0      6,421,842,618      UNC_M_CLOCKTICKS
> 
>        1.003406645 seconds time elapsed
> ```
> 
> In general, having the perf tool adjust cpumasks isn't desirable as
> ideally the PMU driver would be advertising the correct cpumask.
>

Strictly speaking, the information used here is the CHA and IMC topology
information, not a cpumask.

The cpumask in the uncore driver implies the scope of the PMU. Usually,
it's the first CPU of each socket/die.

The topology information discloses how the uncore units connect to the
HW components, e.g., die, node...
There should be another interface for it. An example is the UPI topology
information.
https://lore.kernel.org/lkml/20221117122833.3103580-7-alexander.antonov@linux.intel.com/

But I think utilizing the cpumask to imply the topology as this patch
does should be a good idea.

But I still incline not to add it to the kernel at least for now. Because,
- The current method is based on some assumptions, e.g., the hardware id
and logical id of Notes and CHAs follow the ascending order. It should
work for the vast majority of cases. But it's not reliable compared to
retrieving from a register.
- Perf tool is more flexible. It can be easily deployed on an old
environment without the need to update the kernel.
- The cpumask codes are shared among uncore PMUs in the uncore driver.
It requires a big refactor to support per uncore PMU specific cpumask.
It may not be worth doing it only for GNR.

Let's support it in the perf tool x86 code for now. We may move it to
the uncore driver later once the above items have changed.


> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/pmu.c | 259 ++++++++++++++++++++++++++++++++-
>  1 file changed, 254 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 8712cbbbc712..38c800c6e9c8 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -8,6 +8,8 @@
>  #include <linux/perf_event.h>
>  #include <linux/zalloc.h>
>  #include <api/fs/fs.h>
> +#include <api/io_dir.h>
> +#include <internal/cpumap.h>
>  #include <errno.h>
>  
>  #include "../../../util/intel-pt.h"
> @@ -16,7 +18,247 @@
>  #include "../../../util/fncache.h"
>  #include "../../../util/pmus.h"
>  #include "mem-events.h"
> +#include "util/debug.h"
>  #include "util/env.h"
> +#include "util/header.h"
> +
> +static bool x86__is_intel_graniterapids(void)
> +{
> +	static bool checked_if_graniterapids;
> +	static bool is_graniterapids;
> +
> +	if (!checked_if_graniterapids) {
> +		const char *graniterapids_cpuid = "GenuineIntel-6-A[DE]";
> +		char *cpuid = get_cpuid_str((struct perf_cpu){0});
> +
> +		is_graniterapids = cpuid && strcmp_cpuid_str(graniterapids_cpuid, cpuid) == 0;
> +		free(cpuid);
> +		checked_if_graniterapids = true;
> +	}
> +	return is_graniterapids;
> +}
> +
> +static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
> +{
> +	struct perf_cpu_map *cpus;
> +	char *buf = NULL;
> +	size_t buf_len;
> +
> +	if (sysfs__read_str(sysfs_path, &buf, &buf_len) < 0)
> +		return NULL;
> +
> +	cpus = perf_cpu_map__new(buf);
> +	free(buf);
> +	return cpus;
> +}
> +
> +static int snc_nodes_per_l3_cache(void)
> +{
> +	static bool checked_snc;
> +	static int snc_nodes;
> +
> +	if (!checked_snc) {
> +		struct perf_cpu_map *node_cpus =
> +			read_sysfs_cpu_map("devices/system/node/node0/cpulist");
> +		struct perf_cpu_map *cache_cpus =
> +			read_sysfs_cpu_map("devices/system/cpu/cpu0/cache/index3/shared_cpu_list");
> +
> +		snc_nodes = perf_cpu_map__nr(cache_cpus) / perf_cpu_map__nr(node_cpus);
> +		perf_cpu_map__put(cache_cpus);
> +		perf_cpu_map__put(node_cpus);
> +		checked_snc = true;
> +	}
> +	return snc_nodes;
> +}
> +
> +static bool starts_with(const char *str, const char *prefix)
> +{
> +	return !strncmp(prefix, str, strlen(prefix));
> +}
> +
> +static int num_chas(void)
> +{
> +	static bool checked_chas;
> +	static int num_chas;
> +
> +	if (!checked_chas) {
> +		int fd = perf_pmu__event_source_devices_fd();
> +		struct io_dir dir;
> +		struct io_dirent64 *dent;
> +
> +		if (fd < 0)
> +			return -1;
> +
> +		io_dir__init(&dir, fd);
> +
> +		while ((dent = io_dir__readdir(&dir)) != NULL) {
> +			/* Note, dent->d_type will be DT_LNK and so isn't a useful filter. */
> +			if (starts_with(dent->d_name, "uncore_cha_"))
> +				num_chas++;
> +		}
> +		close(fd);
> +		checked_chas = true;
> +	}
> +	return num_chas;
> +}
> +
> +#define MAX_SNCS 6
> +
> +static int uncore_cha_snc(struct perf_pmu *pmu)
> +{
> +	// CHA SNC numbers are ordered correspond to the CHAs number.
> +	unsigned int cha_num;
> +	int num_cha, chas_per_node, cha_snc;
> +	int snc_nodes = snc_nodes_per_l3_cache();
> +
> +	if (snc_nodes <= 1)
> +		return 0;
> +
> +	num_cha = num_chas();
> +	if (num_cha <= 0) {
> +		pr_warning("Unexpected: no CHAs found\n");
> +		return 0;
> +	}
> +
> +	/* Compute SNC for PMU. */
> +	if (sscanf(pmu->name, "uncore_cha_%u", &cha_num) != 1) {
> +		pr_warning("Unexpected: unable to compute CHA number '%s'\n", pmu->name);
> +		return 0;
> +	}
> +	chas_per_node = num_cha / snc_nodes;
> +	cha_snc = cha_num / chas_per_node;
> +
> +	/* Range check cha_snc. for unexpected out of bounds. */
> +	return cha_snc >= MAX_SNCS ? 0 : cha_snc;
> +}
> +
> +static int uncore_imc_snc(struct perf_pmu *pmu)
> +{
> +	// Compute the IMC SNC using lookup tables.
> +	unsigned int imc_num;
> +	int snc_nodes = snc_nodes_per_l3_cache();
> +	const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
> +	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
> +	const u8 *snc_map;
> +	size_t snc_map_len;
> +
> +	switch (snc_nodes) {
> +	case 2:
> +		snc_map = snc2_map;
> +		snc_map_len = ARRAY_SIZE(snc2_map);
> +		break;
> +	case 3:
> +		snc_map = snc3_map;
> +		snc_map_len = ARRAY_SIZE(snc3_map);
> +		break;
> +	default:
> +		/* Error or no lookup support for SNC with >3 nodes. */
> +		return 0;
> +	}
> +
> +	/* Compute SNC for PMU. */
> +	if (sscanf(pmu->name, "uncore_imc_%u", &imc_num) != 1) {
> +		pr_warning("Unexpected: unable to compute IMC number '%s'\n", pmu->name);
> +		return 0;
> +	}
> +	if (imc_num >= snc_map_len) {
> +		pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_num, snc_nodes);
> +		return 0;
> +	}
> +	return snc_map[imc_num];
> +}
> +
> +static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
> +{
> +	static bool checked_cpu_adjust[MAX_SNCS];
> +	static int cpu_adjust[MAX_SNCS];
> +	struct perf_cpu_map *node_cpus;
> +	char node_path[] = "devices/system/node/node0/cpulist";
> +
> +	/* Was adjust already computed? */
> +	if (checked_cpu_adjust[pmu_snc])
> +		return cpu_adjust[pmu_snc];
> +
> +	/* SNC0 doesn't need an adjust. */
> +	if (pmu_snc == 0) {
> +		cpu_adjust[0] = 0;
> +		checked_cpu_adjust[0] = true;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Use NUMA topology to compute first CPU of the NUMA node, we want to
> +	 * adjust CPU 0 to be this and similarly for other CPUs if there is >1
> +	 * socket.
> +	 */
> +	node_path[24] = pmu_snc; // Shift node0 to be node<pmu_snc>.

I think scnprintf should be a prefer way to update the idx. E.g.,

#define NODE_PATH	"devices/system/node/node%d/cpulist"

scnprintf(node_path, MAX_PATH, NODE_PATH, pmu_snc);


> +	node_cpus = read_sysfs_cpu_map(node_path);
> +	cpu_adjust[pmu_snc] = perf_cpu_map__cpu(node_cpus, 0).cpu;
> +	checked_cpu_adjust[pmu_snc] = true;
> +	perf_cpu_map__put(node_cpus);
> +	return cpu_adjust[pmu_snc];
> +}
> +
> +static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
> +{
> +	// With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
> +	// topology. For example, a two socket graniterapids machine may be set
> +	// up with 3-way SNC meaning there are 6 NUMA nodes that should be
> +	// displayed with --per-node. The cpumask of the CHA and IMC PMUs
> +	// reflects per-socket information meaning, for example, uncore_cha_60
> +	// on a two socket graniterapids machine with 120 cores per socket will
> +	// have a cpumask of "0,120". This cpumask needs adjusting to "40,160"
> +	// to reflect that uncore_cha_60 is used for the 2nd SNC of each
> +	// socket. Without the adjustment events on uncore_cha_60 will appear in
> +	// node 0 and node 3 (in our example 2 socket 3-way set up), but with
> +	// the adjustment they will appear in node 1 and node 4. The number of
> +	// CHAs is typically larger than the number of cores. The CHA numbers
> +	// are assumed to split evenly and inorder wrt core numbers. There are
> +	// fewer memory IMC PMUs than cores and mapping is handled using lookup
> +	// tables.
> +	static struct perf_cpu_map *cha_adjusted[MAX_SNCS];
> +	static struct perf_cpu_map *imc_adjusted[MAX_SNCS];
> +	struct perf_cpu_map **adjusted = cha ? cha_adjusted : imc_adjusted;
> +	int idx, pmu_snc, cpu_adjust;
> +	struct perf_cpu cpu;
> +	bool alloc;
> +
> +	// Cpus from the kernel holds first CPU of each socket. e.g. 0,120
> +	assert(perf_cpu_map__cpu(pmu->cpus, 0).cpu == 0);

Can it just simply return if a non-0 is detected?
In case, the uncore driver is updated later. This can be treated as a
fallback solution.

Thanks,
Kan> +
> +	pmu_snc = cha ? uncore_cha_snc(pmu) : uncore_imc_snc(pmu);
> +	if (pmu_snc == 0) {
> +		// No adjustment necessary for the first SNC.
> +		return;
> +	}
> +
> +	alloc = adjusted[pmu_snc] == NULL;
> +	if (alloc) {
> +		// Hold onto the perf_cpu_map globally to avoid recomputation.
> +		cpu_adjust = uncore_cha_imc_compute_cpu_adjust(pmu_snc);
> +		adjusted[pmu_snc] = perf_cpu_map__empty_new(perf_cpu_map__nr(pmu->cpus));
> +		if (!adjusted[pmu_snc])
> +			return;
> +	}
> +
> +	perf_cpu_map__for_each_cpu(cpu, idx, pmu->cpus) {
> +		// Compute the new cpu map values or if not allocating, assert
> +		// that they match expectations. asserts will be removed to
> +		// avoid overhead in NDEBUG builds.
> +		if (alloc) {
> +			adjusted[pmu_snc]->map[idx].cpu = cpu.cpu + cpu_adjust;
> +		} else if (idx == 0) {
> +			cpu_adjust = perf_cpu_map__cpu(adjusted[pmu_snc], idx).cpu - cpu.cpu;
> +			assert(uncore_cha_imc_compute_cpu_adjust(pmu_snc) == cpu_adjust);
> +		} else {
> +			assert(perf_cpu_map__cpu(adjusted[pmu_snc], idx).cpu ==
> +			       cpu.cpu + cpu_adjust);
> +		}
> +	}
> +
> +	perf_cpu_map__put(pmu->cpus);
> +	pmu->cpus = perf_cpu_map__get(adjusted[pmu_snc]);
> +}
>  
>  void perf_pmu__arch_init(struct perf_pmu *pmu)
>  {
> @@ -49,10 +291,17 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>  
>  		perf_mem_events__loads_ldlat = 0;
>  		pmu->mem_events = perf_mem_events_amd_ldlat;
> -	} else if (pmu->is_core) {
> -		if (perf_pmu__have_event(pmu, "mem-loads-aux"))
> -			pmu->mem_events = perf_mem_events_intel_aux;
> -		else
> -			pmu->mem_events = perf_mem_events_intel;
> +	} else {
> +		if (pmu->is_core) {
> +			if (perf_pmu__have_event(pmu, "mem-loads-aux"))
> +				pmu->mem_events = perf_mem_events_intel_aux;
> +			else
> +				pmu->mem_events = perf_mem_events_intel;
> +		} else if (x86__is_intel_graniterapids()) {
> +			if (starts_with(pmu->name, "uncore_cha_"))
> +				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
> +			else if (starts_with(pmu->name, "uncore_imc_"))
> +				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
> +		}
>  	}
>  }

