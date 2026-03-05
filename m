Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD61F0995;
	Thu,  5 Mar 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691259; cv=none; b=NT1wVPXO5Hip1TPstmlrnSIFWYylbnpB1tYdmaazOH3gWHnEq03eq6WCksiSI45g/DU3qV3RNU9BB39kSlKNbIvyOshvh38upb9V5WQA8sAfaqncl4c/yMQjzvKvShi177EkVxj/1L8Qv3y3A1hk6bGhC7PlZK9zQ+Oo6hykwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691259; c=relaxed/simple;
	bh=U6CRz9ZFaosPCbXMYNCP++vpUui/e9wHOD/+bweJnuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SLNcHwTEKZB4DYrF1xv5t+AZdXS4oCzJc5FdxLfT1drZefK4DLl4OHpqtNGJv5f6N9stdvLyVX1otYLRDXqrsX+Uynh6O8yvW7s6i0RvUa3fM3MSuDaJhK/TIHuJFUW3aLu0zY/6iqt1DZJXJFUqfreehxlT3LnPT6b1GbcIiTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4jut2Qjl; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4jut2Qjl"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jJzj1BkLnhAoNL5+WKUdYx8gNtt4tVeCO7DclpuXOLA=;
	b=4jut2QjlLchD5uTWnD+EdcR5A0t4PvV3cY806o7+Gy8z4SwT8xGqzC8FDv2/wh8tlxOSbSlIu
	BUziKuGZvdzszC0H9HJ2hNSwXd3uunvAGMHknsapv+EXdF4MGHcdIfjhdzvbMcKgylA5aLnZ1ra
	+1tH5oNyCVt7om8ec0GxU4s=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fRJz53QbqznTVx;
	Thu,  5 Mar 2026 14:09:37 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DA1440565;
	Thu,  5 Mar 2026 14:14:13 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Mar 2026 14:14:12 +0800
Message-ID: <116e9d60-8031-4897-acd5-457c1fafedf8@huawei.com>
Date: Thu, 5 Mar 2026 14:14:12 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf: Add --pmu-filter option for filtering PMUs
To: Namhyung Kim <namhyung@kernel.org>
CC: <irogers@google.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <wangyushan12@huawei.com>, <hejunhao3@h-partners.com>,
	<jonathan.cameron@huawei.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>
References: <20260225034125.2157622-1-xiaqinxin@huawei.com>
 <20260225034125.2157622-2-xiaqinxin@huawei.com> <aaeItD2RYk0DZU0x@google.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <aaeItD2RYk0DZU0x@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/3/4 09:19:48, Namhyung Kim <namhyung@kernel.org> wrote:
> On Wed, Feb 25, 2026 at 11:41:25AM +0800, Qinxin Xia wrote:
>> This patch adds a new --pmu-filter option to perf-stat command to allow
>> filtering events on specific PMUs. This is useful when there are
>> multiple PMUs with same type (e.g. hisi_sicl2_cpa0 and hisi_sicl0_cpa0).
>>
>> perf event:
>> [root@localhost tmp]# perf stat -e cpa_cycles
>>   Performance counter stats for 'system wide':
>>
>>       3,005,509,659      hisi_sicl0_cpa0/cpa_cycles/
>>       3,005,502,319      hisi_sicl2_cpa0/cpa_cycles/
>>
>>         3.005460970 seconds time elapsed
>>
>> [root@localhost tmp]# perf stat --pmu-filter hisi_sicl0_cpa0 -e cpa_cycles
>>   Performance counter stats for 'system wide':
>>
>>       3,003,899,571      cpa_cycles
>>
>>         3.003864470 seconds time elapsed
> 
> In this case, you can just use -e /hisi_sicl0_cpa0/cpa_cycles/.
> 
Oh, I overlooked that, thanks for pointing it out. In the next version,
I'll delete this description in commit.
>>
>> perf metric:
>> [root@localhost tmp]# perf stat -M cpa_p0_avg_bw
>>   Performance counter stats for 'system wide':
>>
>>      19,417,779,115      hisi_sicl0_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
>>                   0      hisi_sicl0_cpa0/cpa_p0_wr_dat/
>>                   0      hisi_sicl0_cpa0/cpa_p0_rd_dat_64b/
>>                   0      hisi_sicl0_cpa0/cpa_p0_rd_dat_32b/
>>      19,417,751,103      hisi_sicl10_cpa0/cpa_cycles/     #     0.00 cpa_p0_avg_bw
>>                   0      hisi_sicl10_cpa0/cpa_p0_wr_dat/
>>                   0      hisi_sicl10_cpa0/cpa_p0_rd_dat_64b/
>>                   0      hisi_sicl10_cpa0/cpa_p0_rd_dat_32b/
>>      19,417,730,679      hisi_sicl2_cpa0/cpa_cycles/      #     0.31 cpa_p0_avg_bw
>>          75,635,749      hisi_sicl2_cpa0/cpa_p0_wr_dat/
>>          18,520,640      hisi_sicl2_cpa0/cpa_p0_rd_dat_64b/
>>                   0      hisi_sicl2_cpa0/cpa_p0_rd_dat_32b/
>>      19,417,674,227      hisi_sicl8_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
>>                   0      hisi_sicl8_cpa0/cpa_p0_wr_dat/
>>                   0      hisi_sicl8_cpa0/cpa_p0_rd_dat_64b/
>>                   0      hisi_sicl8_cpa0/cpa_p0_rd_dat_32b/
>>
>>        19.417734480 seconds time elapsed
>>
>> [root@localhost tmp]# perf stat --pmu-filter hisi_sicl2_cpa0 -M cpa_p0_avg_bw
>>   Performance counter stats for 'system wide':
>>
>>       6,234,093,559      cpa_cycles                       #     0.60 cpa_p0_avg_bw
>>          50,548,465      cpa_p0_wr_dat
>>           7,552,182      cpa_p0_rd_dat_64b
>>                   0      cpa_p0_rd_dat_32b
>>
>>         6.234139320 seconds time elapsed
> 
> But right, metrics seem to need this.  Does this support wildcard match
> for multiple PMUs?
> 
> Thanks,
> Namhyung
> 
This patch does not support wildcard match. I will try to support it in
the next version.
Thank you for your review.

>>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> ---
>>   tools/perf/Documentation/perf-stat.txt |  4 ++++
>>   tools/perf/builtin-stat.c              | 26 ++++++++++++++++++++++++++
>>   tools/perf/util/metricgroup.c          | 18 +++++++++++++-----
>>   3 files changed, 43 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>> index 7cccc3a847d1..b72a29c9223c 100644
>> --- a/tools/perf/Documentation/perf-stat.txt
>> +++ b/tools/perf/Documentation/perf-stat.txt
>> @@ -578,6 +578,10 @@ $ perf config stat.no-csv-summary=true
>>   Only enable events on applying cpu with this type for hybrid platform
>>   (e.g. core or atom)"
>>   
>> +--pmu-filter::
>> +Only enable events on applying pmu with specified for multiple
>> +pmus with same type (e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)
>> +
>>   EXAMPLES
>>   --------
>>   
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 73c2ba7e3076..67fb91816c0b 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -1214,6 +1214,28 @@ static int parse_cputype(const struct option *opt,
>>   	return 0;
>>   }
>>   
>> +static int parse_pmu_filter(const struct option *opt,
>> +			   const char *str,
>> +			   int unset __maybe_unused)
>> +{
>> +	const struct perf_pmu *pmu;
>> +	struct evlist *evlist = *(struct evlist **)opt->value;
>> +
>> +	if (!list_empty(&evlist->core.entries)) {
>> +		fprintf(stderr, "Must define pmu-filter before events/metrics\n");
>> +		return -1;
>> +	}
>> +
>> +	pmu = perf_pmus__pmu_for_pmu_filter(str);
>> +	if (!pmu) {
>> +		fprintf(stderr, "--pmu-filter %s is not supported!\n", str);
>> +		return -1;
>> +	}
>> +	parse_events_option_args.pmu_filter = pmu->name;
>> +
>> +	return 0;
>> +}
>> +
>>   static int parse_cache_level(const struct option *opt,
>>   			     const char *str,
>>   			     int unset __maybe_unused)
>> @@ -2561,6 +2583,10 @@ int cmd_stat(int argc, const char **argv)
>>   			"Only enable events on applying cpu with this type "
>>   			"for hybrid platform (e.g. core or atom)",
>>   			parse_cputype),
>> +		OPT_CALLBACK(0, "pmu-filter", &evsel_list, "pmu",
>> +			"Only enable events on applying pmu with specified "
>> +			"for multiple pmus with same type(e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)",
>> +			parse_pmu_filter),
>>   #ifdef HAVE_LIBPFM
>>   		OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
>>   			"libpfm4 event selector. use 'perf list' to list available events",
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 46bf4dfeebc8..89b83ca38483 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -387,8 +387,13 @@ static bool match_pm_metric_or_groups(const struct pmu_metric *pm, const char *p
>>   				      const char *metric_or_groups)
>>   {
>>   	const char *pm_pmu = pm->pmu ?: "cpu";
>> +	struct perf_pmu *perf_pmu = NULL;
>>   
>> -	if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu))
>> +	if (pm->pmu)
>> +		perf_pmu = perf_pmus__find(pm->pmu);
>> +
>> +	if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu) &&
>> +	   (perf_pmu && !perf_pmu__name_wildcard_match(perf_pmu, pmu)))
>>   		return false;
>>   
>>   	return match_metric_or_groups(pm->metric_group, metric_or_groups) ||
>> @@ -1259,7 +1264,8 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
>>   static int parse_ids(bool metric_no_merge, bool fake_pmu,
>>   		     struct expr_parse_ctx *ids, const char *modifier,
>>   		     bool group_events, const bool tool_events[TOOL_PMU__EVENT_MAX],
>> -		     struct evlist **out_evlist)
>> +		     struct evlist **out_evlist,
>> +		     const char *filter_pmu)
>>   {
>>   	struct parse_events_error parse_error;
>>   	struct evlist *parsed_evlist;
>> @@ -1313,7 +1319,7 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
>>   	}
>>   	pr_debug("Parsing metric events '%s'\n", events.buf);
>>   	parse_events_error__init(&parse_error);
>> -	ret = __parse_events(parsed_evlist, events.buf, /*pmu_filter=*/NULL,
>> +	ret = __parse_events(parsed_evlist, events.buf, filter_pmu,
>>   			     &parse_error, fake_pmu, /*warn_if_reordered=*/false,
>>   			     /*fake_tp=*/false);
>>   	if (ret) {
>> @@ -1416,7 +1422,8 @@ static int parse_groups(struct evlist *perf_evlist,
>>   					/*modifier=*/NULL,
>>   					/*group_events=*/false,
>>   					tool_events,
>> -					&combined_evlist);
>> +					&combined_evlist,
>> +					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
>>   		}
>>   		if (combined)
>>   			expr__ctx_free(combined);
>> @@ -1471,7 +1478,8 @@ static int parse_groups(struct evlist *perf_evlist,
>>   		}
>>   		if (!metric_evlist) {
>>   			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
>> -					m->group_events, tool_events, &m->evlist);
>> +					m->group_events, tool_events, &m->evlist,
>> +					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
>>   			if (ret)
>>   				goto out;
>>   
>> -- 
>> 2.33.0
>>
> 

-- 
Thanks,
Qinxin

