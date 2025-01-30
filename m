Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA11946C8;
	Thu, 30 Jan 2025 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265088; cv=none; b=SQ6317ecmylSxzQ0PaD/cIkn2CHmXy4EiKZ7s+RyoEZFFzWYMBqq6IXQsE0DD00CNzHN4rRfpYejyUa3NDicPF3j8AHbugp8UYAgCswiwLobjagfDOw7foEA5Xmh/yCoga43YuRbjYshumXpPnn5yva3JDBXVfwYO5HRuSn5OCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265088; c=relaxed/simple;
	bh=jTgur9og+joCJ81jYqmm1nze96v2l/w4wxOjW4Q9ZYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bLYbhLIIkfiP36UxDOECCmVJLOgf8ICnSaf/LYRq5I7Wa5nd7RZ//PQSvE+g0u/NL2EovCVBxJuGPPS0tUB9t3FNYi8cOzeKtl/yapqfA2dH9RnG/3PYM9pmDQabklSLLaKDizYhyna7OR5yU8dzL2K8njYPPXbPCxmkshaOgfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JW5wZcrd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JW5wZcrd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738265086; x=1769801086;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=jTgur9og+joCJ81jYqmm1nze96v2l/w4wxOjW4Q9ZYo=;
  b=JW5wZcrdijaEYTvpzXaulKY50fHlgndsSOqvk9vfkJq8t0B7Og4Q4FoX
   R8siEuSZO1k5FUhlriFD1Y9vxDpDHCPL+9Qwpm4f1wk6zrjuFL60Rvr2j
   qZY0fDcz5WDLjZ3j0sNHIBl0zWlOrWW9nUUWtq8piLnsCL3Gx5E0EKkVT
   y68Nv5PbnwJbRwA/cBOUYc9nOf2TihY4dPGiWQ7IyLWKOE4sJvqsZ4Zqu
   hXMmUmCdtJYm+ftb3I+gEPiv1PnvCahPi1SjsBMGe+Pd4WHI0vc7Ezd8V
   sgpjOR0z5sT4tOtvGeSlwjFb4STDepoAITEkbCSeJQv1oS4AiIwko4cJY
   Q==;
X-CSE-ConnectionGUID: QEZ4irslSCebcWlR3Z52cg==
X-CSE-MsgGUID: O3Y5SvCFSWC8LVEdp+N3Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38989778"
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="38989778"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 11:24:45 -0800
X-CSE-ConnectionGUID: TtIzahfBQ9+MOT5eZlT9Xg==
X-CSE-MsgGUID: OzvCvh4LTyOtA2ddGe5vGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="140312922"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 11:24:45 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 69CDE20B5713;
	Thu, 30 Jan 2025 11:24:43 -0800 (PST)
Message-ID: <2763b783-c316-46e8-b4db-469d1ba55ac4@linux.intel.com>
Date: Thu, 30 Jan 2025 14:24:42 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] perf pmus: Restructure pmu_read_sysfs to scan
 fewer PMUs
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
 Weilin Wang <weilin.wang@intel.com>,
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
 Junhao He <hejunhao3@huawei.com>, Yicong Yang <yangyicong@hisilicon.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250123074659.698123-1-irogers@google.com>
 <20250123074659.698123-3-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250123074659.698123-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-23 2:46 a.m., Ian Rogers wrote:
> Rather than scanning core or all PMUs, allow pmu_read_sysfs to read
> some combination of core, other, hwmon and tool PMUs. The PMUs that
> should be read and are already read are held as bitmaps. It is known
> that a "hwmon_" prefix is necessary for a hwmon PMU's name, similarly
> with "tool", so only scan those PMUs in situations the PMU name or the
> PMU's type number make sense to.
> 
> The number of openat system calls reduces from 276 to 98 for a hwmon
> event. The number of openats for regular perf events isn't changed.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.h  |   2 +
>  tools/perf/util/pmus.c | 144 ++++++++++++++++++++++++++---------------
>  2 files changed, 95 insertions(+), 51 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index dbed6c243a5e..edd36c20aedc 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -37,6 +37,8 @@ struct perf_pmu_caps {
>  };
>  
>  enum {
> +	PERF_PMU_TYPE_PE_START    = 0,
> +	PERF_PMU_TYPE_PE_END      = 0xFFFEFFFF,
>  	PERF_PMU_TYPE_HWMON_START = 0xFFFF0000,
>  	PERF_PMU_TYPE_HWMON_END   = 0xFFFFFFFD,
>  	PERF_PMU_TYPE_TOOL = 0xFFFFFFFE,
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index b493da0d22ef..3e3ffafcad71 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -37,10 +37,23 @@
>   */
>  static LIST_HEAD(core_pmus);
>  static LIST_HEAD(other_pmus);
> -static bool read_sysfs_core_pmus;
> -static bool read_sysfs_all_pmus;
> +enum perf_tool_pmu_type {
> +	PERF_TOOL_PMU_TYPE_PE_CORE,
> +#define PERF_TOOL_PMU_TYPE_PE_CORE_MASK (1 << PERF_TOOL_PMU_TYPE_PE_CORE)
> +	PERF_TOOL_PMU_TYPE_PE_OTHER,

What is the PE short for?

The terminology "other" confused me at first glance.

I think the PE_OTHER means the PMUs not core, hwmon or tool.
There is a "other_pmus" nearby, which means the PMUs not core, but
include hwmon and tool.

Please add some comments to explain the scope of the TYPE_PE_OTHER.

> +#define PERF_TOOL_PMU_TYPE_PE_OTHER_MASK (1 << PERF_TOOL_PMU_TYPE_PE_OTHER)
> +	PERF_TOOL_PMU_TYPE_TOOL,
> +#define PERF_TOOL_PMU_TYPE_TOOL_MASK (1 << PERF_TOOL_PMU_TYPE_TOOL)
> +	PERF_TOOL_PMU_TYPE_HWMON,
> +#define PERF_TOOL_PMU_TYPE_HWMON_MASK (1 << PERF_TOOL_PMU_TYPE_HWMON)
> +#define PERF_TOOL_PMU_TYPE_ALL_MASK (PERF_TOOL_PMU_TYPE_PE_CORE_MASK |	\
> +					PERF_TOOL_PMU_TYPE_PE_OTHER_MASK | \
> +					PERF_TOOL_PMU_TYPE_TOOL_MASK |	\
> +					PERF_TOOL_PMU_TYPE_HWMON_MASK)
> +};

Nit: Maybe it's better to split the enum perf_tool_pmu_type and #define.
It's a little bit hard for me to locate how many types there are at
first glance.

> +static unsigned int read_pmu_types;
>  
> -static void pmu_read_sysfs(bool core_only);
> +static void pmu_read_sysfs(unsigned int to_read_pmus);
>  
>  size_t pmu_name_len_no_suffix(const char *str)
>  {
> @@ -102,8 +115,7 @@ void perf_pmus__destroy(void)
>  
>  		perf_pmu__delete(pmu);
>  	}
> -	read_sysfs_core_pmus = false;
> -	read_sysfs_all_pmus = false;
> +	read_pmu_types = 0;
>  }
>  
>  static struct perf_pmu *pmu_find(const char *name)
> @@ -129,6 +141,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
>  	struct perf_pmu *pmu;
>  	int dirfd;
>  	bool core_pmu;
> +	unsigned int to_read_pmus = 0;
>  
>  	/*
>  	 * Once PMU is loaded it stays in the list,
> @@ -139,11 +152,11 @@ struct perf_pmu *perf_pmus__find(const char *name)
>  	if (pmu)
>  		return pmu;
>  
> -	if (read_sysfs_all_pmus)
> +	if (read_pmu_types == PERF_TOOL_PMU_TYPE_ALL_MASK)
>  		return NULL;
>  
>  	core_pmu = is_pmu_core(name);
> -	if (core_pmu && read_sysfs_core_pmus)
> +	if (core_pmu && (read_pmu_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK))
>  		return NULL;
>  
>  	dirfd = perf_pmu__event_source_devices_fd();
> @@ -151,15 +164,27 @@ struct perf_pmu *perf_pmus__find(const char *name)
>  			       /*eager_load=*/false);
>  	close(dirfd);
>  
> -	if (!pmu) {
> -		/*
> -		 * Looking up an inidividual PMU failed. This may mean name is
> -		 * an alias, so read the PMUs from sysfs and try to find again.
> -		 */
> -		pmu_read_sysfs(core_pmu);
> +	if (pmu)
> +		return pmu;
> +
> +	/* Looking up an individual perf event PMU failed, check if a tool PMU should be read. */
> +	if (!strncmp(name, "hwmon_", 6))
> +		to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK;
> +	else if (!strcmp(name, "tool"))
> +		to_read_pmus |= PERF_TOOL_PMU_TYPE_TOOL_MASK;
> +
> +	if (to_read_pmus) {
> +		pmu_read_sysfs(to_read_pmus);
>  		pmu = pmu_find(name);
> +		if (pmu)
> +			return pmu;
>  	}
> -	return pmu;
> +	/* Read all necessary PMUs from sysfs and see if the PMU is found. */
> +	to_read_pmus = PERF_TOOL_PMU_TYPE_PE_CORE_MASK;
> +	if (!core_pmu)
> +		to_read_pmus |= PERF_TOOL_PMU_TYPE_PE_OTHER_MASK;
> +	pmu_read_sysfs(to_read_pmus);
> +	return pmu_find(name);
>  }
>  
>  static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
> @@ -176,11 +201,11 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
>  	if (pmu)
>  		return pmu;
>  
> -	if (read_sysfs_all_pmus)
> +	if (read_pmu_types == PERF_TOOL_PMU_TYPE_ALL_MASK)
>  		return NULL;
>  
>  	core_pmu = is_pmu_core(name);
> -	if (core_pmu && read_sysfs_core_pmus)
> +	if (core_pmu && (read_pmu_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK))
>  		return NULL;
>  
>  	return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name,
> @@ -197,52 +222,60 @@ static int pmus_cmp(void *priv __maybe_unused,
>  }
>  
>  /* Add all pmus in sysfs to pmu list: */
> -static void pmu_read_sysfs(bool core_only)
> +static void pmu_read_sysfs(unsigned int to_read_types)
>  {
> -	int fd;
> -	DIR *dir;
> -	struct dirent *dent;
>  	struct perf_pmu *tool_pmu;
>  
> -	if (read_sysfs_all_pmus || (core_only && read_sysfs_core_pmus))
> +	if ((read_pmu_types & to_read_types) == to_read_types) {
> +		/* All requested PMU types have been read. */
>  		return;
> +	}
>  
> -	fd = perf_pmu__event_source_devices_fd();
> -	if (fd < 0)
> -		return;
> +	if (to_read_types & (PERF_TOOL_PMU_TYPE_PE_CORE_MASK | PERF_TOOL_PMU_TYPE_PE_OTHER_MASK)) {
> +		int fd = perf_pmu__event_source_devices_fd();
> +		DIR *dir;
> +		struct dirent *dent;
> +		bool core_only = (to_read_types & PERF_TOOL_PMU_TYPE_PE_OTHER_MASK) == 0;
>  
> -	dir = fdopendir(fd);
> -	if (!dir) {
> -		close(fd);
> -		return;
> -	}
> +		if (fd < 0)
> +			goto skip_pe_pmus;
>  
> -	while ((dent = readdir(dir))) {
> -		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
> -			continue;
> -		if (core_only && !is_pmu_core(dent->d_name))
> -			continue;
> -		/* add to static LIST_HEAD(core_pmus) or LIST_HEAD(other_pmus): */
> -		perf_pmu__find2(fd, dent->d_name);
> -	}
> +		dir = fdopendir(fd);
> +		if (!dir) {
> +			close(fd);
> +			goto skip_pe_pmus;
> +		}
>  
> -	closedir(dir);
> -	if (list_empty(&core_pmus)) {
> +		while ((dent = readdir(dir))) {
> +			if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
> +				continue;
> +			if (core_only && !is_pmu_core(dent->d_name))
> +				continue;
> +			/* add to static LIST_HEAD(core_pmus) or LIST_HEAD(other_pmus): */
> +			perf_pmu__find2(fd, dent->d_name);
> +		}
> +
> +		closedir(dir);
> +	}
> +skip_pe_pmus:
> +	if ((to_read_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK) && list_empty(&core_pmus)) {
>  		if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
>  			pr_err("Failure to set up any core PMUs\n");
>  	}
>  	list_sort(NULL, &core_pmus, pmus_cmp);
> -	if (!core_only) {
> +
> +	if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) != 0 &&
> +	    (read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) == 0) {

Nit: Maybe

	if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) &&
	    !(read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK))

>  		tool_pmu = perf_pmus__tool_pmu();
>  		list_add_tail(&tool_pmu->list, &other_pmus);
> -		perf_pmus__read_hwmon_pmus(&other_pmus);
>  	}
> +	if ((to_read_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) != 0 &&
> +	    (read_pmu_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) == 0)

ditto

Thanks,
Kan
> +		perf_pmus__read_hwmon_pmus(&other_pmus);
> +
>  	list_sort(NULL, &other_pmus, pmus_cmp);
> -	if (!list_empty(&core_pmus)) {
> -		read_sysfs_core_pmus = true;
> -		if (!core_only)
> -			read_sysfs_all_pmus = true;
> -	}
> +
> +	read_pmu_types |= to_read_types;
>  }
>  
>  static struct perf_pmu *__perf_pmus__find_by_type(unsigned int type)
> @@ -263,12 +296,21 @@ static struct perf_pmu *__perf_pmus__find_by_type(unsigned int type)
>  
>  struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
>  {
> +	unsigned int to_read_pmus;
>  	struct perf_pmu *pmu = __perf_pmus__find_by_type(type);
>  
> -	if (pmu || read_sysfs_all_pmus)
> +	if (pmu || (read_pmu_types == PERF_TOOL_PMU_TYPE_ALL_MASK))
>  		return pmu;
>  
> -	pmu_read_sysfs(/*core_only=*/false);
> +	if (type >= PERF_PMU_TYPE_PE_START && type <= PERF_PMU_TYPE_PE_END) {
> +		to_read_pmus = PERF_TOOL_PMU_TYPE_PE_CORE_MASK |
> +			PERF_TOOL_PMU_TYPE_PE_OTHER_MASK;
> +	} else if (type >= PERF_PMU_TYPE_HWMON_START && type <= PERF_PMU_TYPE_HWMON_END) {
> +		to_read_pmus = PERF_TOOL_PMU_TYPE_HWMON_MASK;
> +	} else {
> +		to_read_pmus = PERF_TOOL_PMU_TYPE_TOOL_MASK;
> +	}
> +	pmu_read_sysfs(to_read_pmus);
>  	pmu = __perf_pmus__find_by_type(type);
>  	return pmu;
>  }
> @@ -282,7 +324,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
>  	bool use_core_pmus = !pmu || pmu->is_core;
>  
>  	if (!pmu) {
> -		pmu_read_sysfs(/*core_only=*/false);
> +		pmu_read_sysfs(PERF_TOOL_PMU_TYPE_ALL_MASK);
>  		pmu = list_prepare_entry(pmu, &core_pmus, list);
>  	}
>  	if (use_core_pmus) {
> @@ -300,7 +342,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
>  struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
>  {
>  	if (!pmu) {
> -		pmu_read_sysfs(/*core_only=*/true);
> +		pmu_read_sysfs(PERF_TOOL_PMU_TYPE_PE_CORE_MASK);
>  		return list_first_entry_or_null(&core_pmus, typeof(*pmu), list);
>  	}
>  	list_for_each_entry_continue(pmu, &core_pmus, list)
> @@ -316,7 +358,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
>  	const char *last_pmu_name = (pmu && pmu->name) ? pmu->name : "";
>  
>  	if (!pmu) {
> -		pmu_read_sysfs(/*core_only=*/false);
> +		pmu_read_sysfs(PERF_TOOL_PMU_TYPE_ALL_MASK);
>  		pmu = list_prepare_entry(pmu, &core_pmus, list);
>  	} else
>  		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");

