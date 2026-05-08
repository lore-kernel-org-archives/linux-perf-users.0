Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55173D0901;
	Fri,  8 May 2026 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236593; cv=none; b=MjT7crWYkxqOJEKJ7Ug+yEnRmqMDjIiFZDMZb2PvQZ1kknna1Izvg2bXx4d3rs1Hza5PqV7S4czIMDe3QTu9U8yTbwJQV6LWZVlBDuXKHl5laY6clcMcHq4Tahcilbu8pAcPliDYc9fftXtv64m4ci8+bTiYxKIEoB0GEWZ3YhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236593; c=relaxed/simple;
	bh=xlsoaH6+s33yDtojmUKNfhTfqJon+lLn5/GAmxf7QuI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ZPWy/6zQQvbOwm9ctSPP7iPxjxNjQstc2ZZTHc3Z0P4qyfqLwXO3sF+qBg/jL0dPgt9sFen68SOXnd/vvXC2YV/HNLUWhtWaq/HsRJPZIcQG5hMzPcsEg0wRBAhnJygJBYhzGg3nshDmZBbDWUQGrwApTosImTRiYsIqLftNdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=H+aBSlKO; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="H+aBSlKO"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xlsoaH6+s33yDtojmUKNfhTfqJon+lLn5/GAmxf7QuI=;
	b=H+aBSlKOqOQlrWGMkYZ3TZ3CsT+bQE1WIQSvMGnuTwiMEA0zp3pNRtpOlRG97Qfy8cnvQL1M1
	jeQBSsf+lPNuqOMKiks66wnvuDZh2wktwFvRQtNifhNRbeel+zAurXGllsB8Xqbp/dyWRPGUiVH
	DUYrwr5CirMVXHILmgGCGgw=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gBlhj4kzTz1T4M2;
	Fri,  8 May 2026 18:28:53 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 08B3A40569;
	Fri,  8 May 2026 18:36:28 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 May 2026 18:36:27 +0800
Received: from [10.67.120.139] (10.67.120.139) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 8 May 2026 18:36:26 +0800
Message-ID: <6d4a668d-b659-460b-89f9-c9ae39120646@huawei.com>
Date: Fri, 8 May 2026 18:36:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yushan Wang <wangyushan12@huawei.com>
Subject: Re: [RFT PATCH v2 6/7] perf-iostat: Make x86 iostat compatible with
 new iostat framework
To: Ian Rogers <irogers@google.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <james.clark@arm.com>, <john.g.garry@oracle.com>,
	<will@kernel.org>, <mike.leach@arm.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<jic23@kernel.org>, <leo.yan@linux.dev>, <robin.murphy@arm.com>,
	<linuxarm@huawei.com>, <hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <wangzhou1@hisilicon.com>
References: <20260507063737.3542950-1-wangyushan12@huawei.com>
 <20260507063737.3542950-7-wangyushan12@huawei.com>
 <CAP-5=fX1ECS9ECh0WYXDr6DHSwSvqwZBKkAETxQGtwAWcpphfg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP-5=fX1ECS9ECh0WYXDr6DHSwSvqwZBKkAETxQGtwAWcpphfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100008.china.huawei.com (7.202.194.111)

On 5/8/2026 12:17 AM, Ian Rogers wrote:
> On Wed, May 6, 2026 at 11:37 PM Yushan Wang <wangyushan12@huawei.com> wrote:
>>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Change the original x86 iio iostat supporter to be compatible with the
>> set of iostat frameworks.
>>
>> The matching function of x86 iio may not be correct.
>>
>> Signed-off-by: Shiju Jose  <shiju.jose@huawei.com>
>> Co-developed-by: Yushan Wang <wangyushan12@huawei.com>
>> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
>> ---
>>  tools/perf/util/iostat.c     | 26 +++++++--------
>>  tools/perf/util/x86-iostat.c | 62 ++++++++++++++++++++++++++----------
>>  2 files changed, 59 insertions(+), 29 deletions(-)
>>
>> diff --git a/tools/perf/util/x86-iostat.c b/tools/perf/util/x86-iostat.c
>> index f8d4c9718594..778655cbc2a0 100644
>> --- a/tools/perf/util/x86-iostat.c
>> +++ b/tools/perf/util/x86-iostat.c
>> @@ -332,9 +332,9 @@ static int iostat_event_group(struct evlist *evl,
>>         return ret;
>>  }
>>

[...]

>> +
>> +/*
>> + * FIXME: pmu name prefix match might not work for x86 iio.
>> + */
>> +static bool iio_iostat_probe(struct iostat_pmu *iostat_pmu)
>> +{
>> +       return perf_pmus__scan_matching_wildcard(NULL, iostat_pmu->pmu_name_wildcard);
>
> It feels more readable to me as:
> ```
>   return perf_pmus__scan_matching_wildcard(NULL, "uncore_iio") != NULL;
> ```

Yes, I can do that refactor.

>
>
>> +}
>> +
>> +static struct iostat_pmu x86_iio_iostat_pmu_list[]  = {
>> +       {
>> +               .pmu_name_wildcard = "uncore_iio*",
>> +               .match = iio_iostat_probe,
>> +               .prepare = iio_iostat_prepare,
>> +               .parse = iio_iostat_parse,
>> +               .list = iio_iostat_list,
>> +               .print_header_prefix = iio_iostat_print_header_prefix,
>> +               .print_metric = iio_iostat_print_metric,
>
> Is there scope to push the metric printing into json? For example, you
> can have PMUs with json:
> tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> ```
>     {
>        "BriefDescription": "Uncore frequency per die [GHZ]",
>        "MetricExpr": "tma_info_system_socket_clks / #num_dies /
> duration_time / 1e9",
>        "MetricGroup": "SoC",
>        "MetricName": "UNCORE_FREQ",
>        "Unit": "cpu_core"
>    },
> ```
> and do uncore type things:
> tools/perf/pmu-events/arch/x86/amdzen6/recommended.json
> ```
>   {
>    "MetricName": "umc_activate_cmd_rate",
>    "BriefDescription": "Memory controller ACTIVATE command rate.",
>    "MetricExpr": "d_ratio(umc_act_cmd.all * 1000, umc_mem_clk)",
>    "MetricGroup": "memory_controller",
>    "PerPkg": "1",
>    "ScaleUnit": "1per_memclk"
>  },
> ```

Currently it's a bit far to reach json configurable PMU iostat structural
display, since the PMUs are vendor specific and may have different meaningful
combinations of events, and they may be hard to be handled with generalized
handler.

Taking currently availble uncore_iio* and hisi_pcie* pmu as example, they have
different sets of events to display, different ways of calculation, and
different PMU to PCIe root port mapping topology, which requires dedicated
handler.

But admittedly there are a lot of redundant code that can be optimized, I can
see if those iostat_* callbacks can be merged or generalized so that variated
functions can be minimized.

Thanks,
Yushan

>
>> +               .print_counters = iio_iostat_print_counters,
>> +               .release = iio_iostat_release,
>> +       },
>> +};
>> +
>> +static void __attribute__((constructor)) x86_iio_iostat_pmu_init(void)
>
> I don't believe these attributes are what we normally do.
>
> Thanks,
> Ian
>
>
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(x86_iio_iostat_pmu_list); i++)
>> +               register_iostat_pmu(&x86_iio_iostat_pmu_list[i]);
>> +}
>> --
>> 2.33.0
>>

