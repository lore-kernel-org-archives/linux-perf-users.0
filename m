Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52820156887;
	Fri,  6 Sep 2024 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612252; cv=none; b=A+IzveJ3xMGH07tVww+QOcc1S5PpEn6tU81Znl5X1ZIDLgz7qxEWhcBShqw7wVWuB7rN5DIi+MlSzHBshTtnQ4RLxaLwqwtLKwuq7qoG9HD667B/CKjBgeaQqY9cXS3tpK1MiuY0dwjw/3duAyiJ9SICvIkKESQajrN7Lere3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612252; c=relaxed/simple;
	bh=y9dnPvC36xO+z9EToCzGrlnSVPtP/LEMuO1W8WGXtIo=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=N0fipSB3K187P8fqO5/hh7/nwxrfDNWiO3yV7RClUgmDoQCZTIA9ayky3Hc3ECRaGngRdobF4B/xI/6Fh/02/hD9FWCHL7wBKm2qRM0tkTsZ8HkuLstP8UAONM3qnwxIsCP2mOCX4f+G8SffVHjTcFtI8zzzc6wVDmRiaU5OPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X0V9k2ZGPzyR72;
	Fri,  6 Sep 2024 16:43:06 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (unknown [7.185.36.158])
	by mail.maildlp.com (Postfix) with ESMTPS id 8CC2F1800F2;
	Fri,  6 Sep 2024 16:44:06 +0800 (CST)
Received: from [10.67.120.218] (10.67.120.218) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Sep 2024 16:44:06 +0800
Subject: Re: [PATCH] perf metrics: Fixes stat cmd cannot parse sys metrics
 when cpus MIDR mismatch
To: Yicong Yang <yangyicong@huawei.com>, <irogers@google.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>
References: <20240807040002.47119-1-hejunhao3@huawei.com>
 <00b3d618-628f-3366-7195-2300468eb450@huawei.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>
From: hejunhao <hejunhao3@huawei.com>
Message-ID: <9a2dd2ea-c38d-ba3d-99b4-d377250060bd@huawei.com>
Date: Fri, 6 Sep 2024 16:44:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <00b3d618-628f-3366-7195-2300468eb450@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500002.china.huawei.com (7.185.36.158)

Hi, Yicong


Thanks for your comments.

On 2024/9/5 11:16, Yicong Yang wrote:
> On 2024/8/7 12:00, Junhao He wrote:
>> On some platforms that do not use cpu MIDR mapping, such as hisilicon
>> HIP09 platform. The list cmd can display the CPA metrics, but the stat
>> cmd cannot work well to parse of CPA metrics.
>>
>>    $ perf list metric
>>    Metrics:
>>      cpa_p0_avg_bw
>>           [Average bandwidth of CPA Port 0]
>>      cpa_p1_avg_bw
>>           [Average bandwidth of CPA Port 1]
>>    $ perf stat -M cpa_p0_avg_bw --timeout 1000 --> No error messages output
>>    $ echo $?
>>    234
>>
>> Currently, the metricgroup__parse_groups() expects to find an cpu metric
>> table, but the hisilicon/hip09 doesn't uses cpus MIDR to map json events
>> and metrics, so pmu_metrics_table__find() will return NULL, than the cmd
>> run failed.
>> But in metricgroup__add_metric(), the function parse for each sys metric
>> and add it to metric_list, which also will get an valid sys metric table.
>> So, we can ignore the NULL result of pmu_metrics_table__find() and to use
>> the sys metric table.
>>
>> metricgroup__parse_groups
>>   -> parse_groups
>>       -> metricgroup__add_metric_list
>>           -> metricgroup__add_metric
>>               -> pmu_for_each_sys_metric   --> We've got the sys metric
>>
>> Testing:
>>    [root@localhost ~]# perf stat -M cpa_p0_avg_bw --no-merge --timeout 1000
>>
>>     Performance counter stats for 'system wide':
>>
>>     CPU0        1,001,121,239      cpa_cycles [hisi_sicl0_cpa0]     #     0.00 cpa_p0_avg_bw
>>     CPU0                    0      cpa_p0_wr_dat [hisi_sicl0_cpa0]
>>     CPU0                    0      cpa_p0_rd_dat_64b [hisi_sicl0_cpa0]
>>     CPU0                    0      cpa_p0_rd_dat_32b [hisi_sicl0_cpa0]
>>     CPU0        1,001,094,851      cpa_cycles [hisi_sicl2_cpa0]     #     0.00 cpa_p0_avg_bw
>>     CPU0                    0      cpa_p0_wr_dat [hisi_sicl2_cpa0]
>>     CPU0                    0      cpa_p0_rd_dat_64b [hisi_sicl2_cpa0]
>>     CPU0                    0      cpa_p0_rd_dat_32b [hisi_sicl2_cpa0]
>>
>>         1.001306160 seconds time elapsed
>>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
>
> The changes looks fine to me, I'd prefer to add some documents for this. See below.
>
>> ---
>>   tools/perf/util/metricgroup.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 69f6a46402c3..fa62fb3418b6 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -1123,7 +1123,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_metric *pm,
>>   
>>   	ret = add_metric(d->metric_list, pm, d->modifier, d->metric_no_group,
>>   			 d->metric_no_threshold, d->user_requested_cpu_list,
>> -			 d->system_wide, d->root_metric, d->visited, d->table);
>> +			 d->system_wide, d->root_metric, d->visited, d->table ?: table);
>>   	if (ret)
>>   		goto out;
>>   
>> @@ -1239,7 +1239,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
>>   	int ret;
>>   	bool has_match = false;
>>   
>> -	{
>> +	if (table) {
> may add a comment here. If !table then the metrics may belong to a system PMU.

Yes, I will do that.

>>   		struct metricgroup__add_metric_data data = {
>>   			.list = &list,
>>   			.pmu = pmu,
>> @@ -1696,8 +1696,6 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
>>   {
>>   	const struct pmu_metrics_table *table = pmu_metrics_table__find();
>>   
>> -	if (!table)
>> -		return -EINVAL;
> may add a debug message to mention we're parsing metrics of system PMUs.
>
> Thanks.

Yes, I will do that.

Best regards,
Junhao.

>
>>   	if (hardware_aware_grouping)
>>   		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
>>   
>>
> .
>

