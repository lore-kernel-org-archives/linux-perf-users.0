Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7706E38B;
	Tue, 22 Oct 2024 04:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729571505; cv=none; b=BDkdFEMXmreGOrTHwvCZyKPNcrAgpPTf1imwAqcfMX+03DkHJlHyg9WQkd44P6nmtzkH0sToaw8sR9T4Hk4Y604DqpIj+7YbtduyajkxK3qmla6PnMpgDbzlLhSoHw2GbBtli+u2ttHFTyu1fcEa3CX78DBhRIKLRJi+p6+2VMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729571505; c=relaxed/simple;
	bh=JMmllV14RxvZYGSLvcuoLFa+QPWXIA4n1DSytG3zbNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC9TPoGSKz6zFdMFR4X80z9wKQKpf0vT+AmygYP2QX+FrJIK4J8eLvs400d0ub9Z3ZfUnTUHr2lzMxWMLRKb5Pw49luZWEQxPSleDNgApU02jTLm5D5g6fHPuok9AcTXIKVzfSKShb07ej2s6EKnMBhsFLJJ2Qeh1doFgtB7cdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARS4QCzq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARS4QCzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D800C4CEC3;
	Tue, 22 Oct 2024 04:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729571505;
	bh=JMmllV14RxvZYGSLvcuoLFa+QPWXIA4n1DSytG3zbNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARS4QCzqVeAuPpPAOMnoV+wMs5UzgiExWTl4F2GVzYPeL28mg2DNp7GtMDYzeIulE
	 bU0kkDAC3roa2u9omxWrN381IwkPoxibb/hGR4frA1kTvtYWuJHuyKluroQRIGDVUE
	 zbqtGobhOsIX3U+RIUut3yOFHx81Bq8PBzZyNKJj04kX2Iw1tpKKIjJlGdXinpMqif
	 x/Qck7q66ssC/Nr+ZeulTZOPELehBH15VBIOeXjeihd9m+GV0VNWMBfLMDu0+nAMU4
	 1BCZ12Ewk3LXfoJIr0veDpWH9njMw8KWlKBQHVatNDtPnbFMCBCuqJem+yL99E/TSc
	 Y2VSYMLUEzXRA==
Date: Mon, 21 Oct 2024 21:31:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Junhao He <hejunhao3@huawei.com>, irogers@google.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
	yangyicong@huawei.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com
Subject: Re: [PATCH v2] perf metrics: Support parsing metrics if platforms
 only have json table of system PMU
Message-ID: <Zxcqr85riwxaHwQG@google.com>
References: <20241010074430.16685-1-hejunhao3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010074430.16685-1-hejunhao3@huawei.com>

Hello,

On Thu, Oct 10, 2024 at 03:44:30PM +0800, Junhao He wrote:
> The system PMUs don't depend on the certain CPUs and we don't need a CPUID
> to metric table mapping to match the json event for generating the metric
> table. For example HiSilicon HIP09 only have json events table of system
> PMUs in the "sys/" subdirectory.
> 
> Currently for this case the struct of system metric table
> "pmu_metrics__hisilicon_hip09_sys" generating works fine and metrics
> display as expected by using `perf list`. But `perf stat` doesn't work
> for such metrics.
> 
>   $ perf list metric
>   Metrics:
>     cpa_p0_avg_bw
>          [Average bandwidth of CPA Port 0]
>     cpa_p1_avg_bw
>          [Average bandwidth of CPA Port 1]
>   $ perf stat -M cpa_p0_avg_bw --timeout 1000 --> No error messages output
>   $ echo $?
>   234
> 
> The metricgroup__parse_groups() expects to find an cpu metric table, but
> the hisilicon/hip09 doesn't uses CPUID to map json events and metrics, so
> pmu_metrics_table__find() will return NULL, than the cmd run failed.
> 
> But in metricgroup__add_metric(), the function parse for each sys metric
> and add it to metric_list, which also will get an valid sys metric table.
> So, we can ignore the NULL result of pmu_metrics_table__find() and to use
> the sys metric table.
> 
> metricgroup__parse_groups
>  -> parse_groups
>      -> metricgroup__add_metric_list
>          -> metricgroup__add_metric
> 	     -> pmu_for_each_sys_metric   --> parse for each sys metric
> 
> Testing:
>   $ perf stat -M cpa_p0_avg_bw --timeout 1000
> 
>  Performance counter stats for 'system wide':
> 
>      4,004,863,602      cpa_cycles                #     0.00 cpa_p0_avg_bw
>                  0      cpa_p0_wr_dat
>                  0      cpa_p0_rd_dat_64b
>                  0      cpa_p0_rd_dat_32b
> 
>        1.001306160 seconds time elapsed

Ian, can you please review this?

Thanks,
Namhyung

> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> v1 --> v2:
>  -Add some comments to explain the table is null.
>  -Modify the patch commit.
>  -Add Yicong Test-by.
> v1:https://lore.kernel.org/all/20240807040002.47119-1-hejunhao3@huawei.com/
> ---
>  tools/perf/util/metricgroup.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 69f6a46402c3..cb428eabd485 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1123,7 +1123,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_metric *pm,
>  
>  	ret = add_metric(d->metric_list, pm, d->modifier, d->metric_no_group,
>  			 d->metric_no_threshold, d->user_requested_cpu_list,
> -			 d->system_wide, d->root_metric, d->visited, d->table);
> +			 d->system_wide, d->root_metric, d->visited, d->table ?: table);
>  	if (ret)
>  		goto out;
>  
> @@ -1226,7 +1226,8 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
>   * @system_wide: Are events for all processes recorded.
>   * @metric_list: The list that the metric or metric group are added to.
>   * @table: The table that is searched for metrics, most commonly the table for the
> - *       architecture perf is running upon.
> + *       architecture perf is running upon. This value could be NULL if no core
> + *       metrics matches the architecture and we'll try to use the table of system PMUs.
>   */
>  static int metricgroup__add_metric(const char *pmu, const char *metric_name, const char *modifier,
>  				   bool metric_no_group, bool metric_no_threshold,
> @@ -1239,7 +1240,8 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
>  	int ret;
>  	bool has_match = false;
>  
> -	{
> +	/* Add core metrics to the metric list */
> +	if (table) {
>  		struct metricgroup__add_metric_data data = {
>  			.list = &list,
>  			.pmu = pmu,
> @@ -1263,6 +1265,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
>  		has_match = data.has_match;
>  	}
>  	{
> +		/* Parse metrics table of system PMUs */
>  		struct metricgroup_iter_data data = {
>  			.fn = metricgroup__add_metric_sys_event_iter,
>  			.data = (void *) &(struct metricgroup_add_iter_data) {
> @@ -1697,7 +1700,8 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
>  	const struct pmu_metrics_table *table = pmu_metrics_table__find();
>  
>  	if (!table)
> -		return -EINVAL;
> +		pr_debug("The core metric table not found, continue to parse system metric table\n");
> +
>  	if (hardware_aware_grouping)
>  		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
>  
> -- 
> 2.33.0
> 
