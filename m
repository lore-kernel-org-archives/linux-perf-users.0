Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D217A5BE;
	Fri,  8 Nov 2024 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094758; cv=none; b=U6zR5DyyP2UW1e+O3zPaTFCHYmcYUJMbMt5RperJ9B+F5YVAEzqRP6HZvDSnC4aQQw62zeGZa7iz3nLYUjHbuUxIRqJE/C0Wyu8nyHi/7vOXRCDYiLaklkFZlbmC+NXFT5XLBPwHN6T0xJ5OE1NFO83F511z/lTtPl7Lp3RoqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094758; c=relaxed/simple;
	bh=pThPIJsXUkpUPpCrFnyjx5/M3JHZPqeVFG47Df9l0Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeTxYPXvTbNwOvVEu7g+XvotQ6tnEShAYvu1L0S7iGGGFYH1NZVxhek3atDWuUMArW9hj+7jdATxs8Z6JpGfmRZK0hXGpe5Ua7Etz1yC/GwMehyCqtGVe6ThmOhjuLT9bH2tuzD1DJjv1THWw1R056WXss7rB7X55mvUSucrBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7EwJ6gi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7EwJ6gi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2373DC4CECD;
	Fri,  8 Nov 2024 19:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731094757;
	bh=pThPIJsXUkpUPpCrFnyjx5/M3JHZPqeVFG47Df9l0Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7EwJ6gijZ52AwltGj31xyMprNMdIgPp/rV+wIjF1RUSJyWHc2m6BJalslbkNMJ2p
	 qR0ZwBJup/p7OxywmZRpPgCuV0VmkVBE6s0MlcZXMx6kHJ9PKk4yqcujI/7G3uoeHh
	 L3qhwUZB2kyrxGT3ZqpMymFOSkM/nNkhRsV1LHF7mJrS+vfX9cLTTNLsGmDQeHtYMX
	 3e4yVbO73lkLL8Jr9fD4DYAu4o2JYrEpBnrq6gd8kLC6LQGQg3pNKPameLmlQdiLlJ
	 GDSMElJrarBtMxSok1TCRlol8XCKx+iWMiumbKvow+rjrVy/fmUAnI20XuTHo+xwYH
	 Gz1tv7JkAF6vA==
Date: Fri, 8 Nov 2024 11:39:15 -0800
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
Subject: Re: [PATCH v7 4/7] perf hwmon_pmu: Add a tool PMU exposing events
 from hwmon in sysfs
Message-ID: <Zy5o46RIEZSvX3uw@google.com>
References: <20241108174936.262704-1-irogers@google.com>
 <20241108174936.262704-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108174936.262704-5-irogers@google.com>

On Fri, Nov 08, 2024 at 09:49:33AM -0800, Ian Rogers wrote:
> Add a tool PMU for hwmon events but don't enable.
> 
> The hwmon sysfs ABI is defined in
> Documentation/hwmon/sysfs-interface.rst. Create a PMU that reads the
> hwmon input and can be used in `perf stat` and metrics much as an
> uncore PMU can.
> 
> For example, when enabled by a later patch, the following shows
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
> The PMUs are named from /sys/class/hwmon/hwmon<num>/name and have an
> alias of hwmon<num>.
> 
> Hwmon data is presented in multiple <type><number>_<item> files. The
> <type><number> is used to identify the event as is the <type> followed
> by the contents of the <type>_label file if it exists. The
> <type><number>_input file gives the data read by perf.
> 
> When enabled by a later patch, in `perf list` the other hwmon <item>
> files are used to give a richer description, for example:
> ```
> hwmon:
>   temp1
>        [Temperature in unit acpitz named temp1. Unit: hwmon_acpitz]
>   in0
>        [Voltage in unit bat0 named in0. Unit: hwmon_bat0]
>   temp_core_0 OR temp2
>        [Temperature in unit coretemp named Core 0. crit=100'C,max=100'C crit_alarm=0'C. Unit:
>         hwmon_coretemp]
>   temp_core_1 OR temp3
>        [Temperature in unit coretemp named Core 1. crit=100'C,max=100'C crit_alarm=0'C. Unit:
>         hwmon_coretemp]
> ...
>   temp_package_id_0 OR temp1
>        [Temperature in unit coretemp named Package id 0. crit=100'C,max=100'C crit_alarm=0'C.
>         Unit: hwmon_coretemp]
>   temp1
>        [Temperature in unit iwlwifi_1 named temp1. Unit: hwmon_iwlwifi_1]
>   temp_composite OR temp1
>        [Temperature in unit nvme named Composite. alarm=0'C,crit=86.85'C,max=75.85'C,
>         min=-273.15'C. Unit: hwmon_nvme]
>   temp_sensor_1 OR temp2
>        [Temperature in unit nvme named Sensor 1. max=65261.8'C,min=-273.15'C. Unit: hwmon_nvme]
>   temp_sensor_2 OR temp3
>        [Temperature in unit nvme named Sensor 2. max=65261.8'C,min=-273.15'C. Unit: hwmon_nvme]
>   fan1
>        [Fan in unit thinkpad named fan1. Unit: hwmon_thinkpad]
>   fan2
>        [Fan in unit thinkpad named fan2. Unit: hwmon_thinkpad]
> ...
>   temp_cpu OR temp1
>        [Temperature in unit thinkpad named CPU. Unit: hwmon_thinkpad]
>   temp_gpu OR temp2
>        [Temperature in unit thinkpad named GPU. Unit: hwmon_thinkpad]
>   curr1
>        [Current in unit ucsi_source_psy_usbc000_0 named curr1. max=1.5A. Unit:
>         hwmon_ucsi_source_psy_usbc000_0]
>   in0
>        [Voltage in unit ucsi_source_psy_usbc000_0 named in0. max=5V,min=5V. Unit:
>         hwmon_ucsi_source_psy_usbc000_0]
> ```
> 
> As there may be multiple hwmon devices a range of PMU types are
> reserved for their use and to identify the PMU as belonging to the
> hwmon types.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/hwmon_pmu.c | 683 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/hwmon_pmu.h |  45 +++
>  tools/perf/util/pmu.h       |   2 +
>  3 files changed, 730 insertions(+)
> 
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index f4b7b3b6a052..3f1bf9a9cfdf 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
[SNIP]
> +struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir, const char *sysfs_name, const char *name)
> +{
> +	char buf[32];
> +	struct hwmon_pmu *hwm;
> +
> +	hwm = zalloc(sizeof(*hwm));
> +	if (!hwm)
> +		return NULL;
> +
> +

Two blank lines.


> +	hwm->hwmon_dir_fd = hwmon_dir;
> +	hwm->pmu.type = PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name + 5, NULL, 10);
> +	if (hwm->pmu.type > PERF_PMU_TYPE_HWMON_END) {
> +		pr_err("Unable to encode hwmon type from %s in valid PMU type\n", sysfs_name);
> +		goto err_out;
> +	}
> +	snprintf(buf, sizeof(buf), "hwmon_%s", name);
> +	fix_name(buf + 6);
> +	hwm->pmu.name = strdup(buf);
> +	if (!hwm->pmu.name)
> +		goto err_out;
> +	hwm->pmu.alias_name = strdup(sysfs_name);
> +	if (!hwm->pmu.alias_name)
> +		goto err_out;
> +	hwm->pmu.cpus = perf_cpu_map__new("0");
> +	if (!hwm->pmu.cpus)
> +		goto err_out;
> +	INIT_LIST_HEAD(&hwm->pmu.format);
> +	INIT_LIST_HEAD(&hwm->pmu.aliases);
> +	INIT_LIST_HEAD(&hwm->pmu.caps);
> +	hashmap__init(&hwm->events, hwmon_pmu__event_hashmap_hash,
> +		      hwmon_pmu__event_hashmap_equal, /*ctx=*/NULL);
> +
> +	list_add_tail(&hwm->pmu.list, pmus);
> +	return &hwm->pmu;
> +err_out:
> +	free((char *)hwm->pmu.name);
> +	free(hwm->pmu.alias_name);
> +	free(hwm);
> +	close(hwmon_dir);
> +	return NULL;
> +}

[...]
> diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
> index df0ab5ff7534..ebfdfe3b295a 100644
> --- a/tools/perf/util/hwmon_pmu.h
> +++ b/tools/perf/util/hwmon_pmu.h
> @@ -2,8 +2,12 @@
>  #ifndef __HWMON_PMU_H
>  #define __HWMON_PMU_H
>  
> +#include "pmu.h"
>  #include <stdbool.h>
>  
> +struct list_head;
> +struct perf_thread_map;
> +
>  /**
>   * enum hwmon_type:
>   *
> @@ -87,6 +91,14 @@ enum hwmon_item {
>  	HWMON_ITEM__MAX,
>  };
>  
> +/** Strings that correspond to enum hwmon_type. */
> +extern const char * const hwmon_type_strs[HWMON_TYPE_MAX];
> +/** Strings that correspond to enum hwmon_item. */
> +extern const char * const hwmon_item_strs[HWMON_ITEM__MAX];

Belongs to the patch2?  But it'd be nice if we can remove them.

Thanks,
Namhyung

> +
> +bool perf_pmu__is_hwmon(const struct perf_pmu *pmu);
> +bool evsel__is_hwmon(const struct evsel *evsel);
> +
>  /**
>   * parse_hwmon_filename() - Parse filename into constituent parts.
>   *
> @@ -108,4 +120,37 @@ bool parse_hwmon_filename(const char *filename,
>  			  enum hwmon_item *item,
>  			  bool *alarm);
>  
> +/**
> + * hwmon_pmu__new() - Allocate and construct a hwmon PMU.
> + *
> + * @pmus: The list of PMUs to be added to.
> + * @hwmon_dir: An O_DIRECTORY file descriptor for a hwmon directory.
> + * @sysfs_name: Name of the hwmon sysfs directory like hwmon0.
> + * @name: The contents of the "name" file in the hwmon directory.
> + *
> + * Exposed for testing. Regular construction should happen via
> + * perf_pmus__read_hwmon_pmus.
> + */
> +struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir,
> +				const char *sysfs_name, const char *name);
> +void hwmon_pmu__exit(struct perf_pmu *pmu);
> +
> +int hwmon_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
> +size_t hwmon_pmu__num_events(struct perf_pmu *pmu);
> +bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name);
> +int hwmon_pmu__config_terms(const struct perf_pmu *pmu,
> +			    struct perf_event_attr *attr,
> +			    struct parse_events_terms *terms,
> +			    struct parse_events_error *err);
> +int hwmon_pmu__check_alias(struct parse_events_terms *terms, struct perf_pmu_info *info,
> +			   struct parse_events_error *err);
> +
> +int perf_pmus__read_hwmon_pmus(struct list_head *pmus);
> +
> +
> +int evsel__hwmon_pmu_open(struct evsel *evsel,
> +			 struct perf_thread_map *threads,
> +			 int start_cpu_map_idx, int end_cpu_map_idx);
> +int evsel__hwmon_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread);
> +
>  #endif /* __HWMON_PMU_H */
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index b86b3c3685a2..d511bf7cc9d0 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -37,6 +37,8 @@ struct perf_pmu_caps {
>  };
>  
>  enum {
> +	PERF_PMU_TYPE_HWMON_START = 0xFFFF0000,
> +	PERF_PMU_TYPE_HWMON_END   = 0xFFFFFFFD,
>  	PERF_PMU_TYPE_TOOL = 0xFFFFFFFE,
>  	PERF_PMU_TYPE_FAKE = 0xFFFFFFFF,
>  };
> -- 
> 2.47.0.277.g8800431eea-goog
> 
