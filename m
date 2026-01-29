Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F6228C009
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699679; cv=none; b=cps65qJup/9jOflpA5ooWFdh8tv2qx0+HzR84oP5TYa/r2/aqDwvgtuLIBDmFCyviIeRSjPLNoQHbizLoheXenZ6U8lDD1SNOL0JbKXFHoAUGX30SEHxyVAHkaEjEvIl3HuQ+i7DGIcZFUT959jyUt/pWG6yuJBijOG8XWHLeZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699679; c=relaxed/simple;
	bh=GPJsN96ppC8OsyAJljdYl9ZtEVIQoS5fXCQGYnrRMVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T/eN+ZQ30mQ3kYYjTejPjp4cpcKJGri1w0HwF+9OFCdN6xK9v7MYGfHCZaaOFGLosQ64FtW7laHQWSGJ5zk6ylhpHB/ylUkH4aMCqnEvn80Jwgn7eh7aj20RE5UDFpM7K8lKrj353MQ3agKFs5sz8Xl0qG+78mCsTux/3wQJsKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6qNLvXTY; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6qNLvXTY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vKKA1nQHqCw0k0MhBE7VTAQT2s0IHwNBxOs15aoD4n4=;
	b=6qNLvXTYjyl47cF1R/5H2TLWRv0Z8sR5zm/KHiGow+URG36WTvWhdRntE0X439BnK4f/QiDAf
	65NZhudQ2WfQMX3pUFZRxdfrTyy+hWG6zKwgoOHlOZPv7xYjNgNCJHEt4JkLYY5qt1g0Om1Iwa3
	WwuT76od4SeV6A0RkOa1o3Q=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4f22dz5fk8zLlXt;
	Thu, 29 Jan 2026 23:11:03 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id D83F840565;
	Thu, 29 Jan 2026 23:14:31 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Jan 2026 23:14:31 +0800
Received: from [10.67.120.139] (10.67.120.139) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 29 Jan 2026 23:14:30 +0800
Message-ID: <b62090ee-1761-4cbb-8d7d-1a91169d187f@huawei.com>
Date: Thu, 29 Jan 2026 23:14:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH 5/7] perf-iostat: Support wilder wildcard-match for
 pmus
To: Ian Rogers <irogers@google.com>
CC: <mike.leach@linaro.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <peterz@infradead.org>, <john.g.garry@oracle.com>,
	<Jonathan.Cameron@huawei.com>, <shiju.jose@huawei.com>, <will@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <liuyonglong@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <wangzhou1@hisilicon.com>, Yushan Wang
	<wangyushan12@huawei.com>
References: <20260126123514.3238425-1-wangyushan12@huawei.com>
 <20260126123514.3238425-6-wangyushan12@huawei.com>
 <CAP-5=fXJSPbZkSvcLMEM7rdaGqYJGzrh+8qmZodrWy=ZGVRp_Q@mail.gmail.com>
Content-Language: en-US
From: wangyushan <wangyushan12@huawei.com>
In-Reply-To: <CAP-5=fXJSPbZkSvcLMEM7rdaGqYJGzrh+8qmZodrWy=ZGVRp_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100008.china.huawei.com (7.202.194.111)



On 1/27/2026 12:44 AM, Ian Rogers wrote:
> On Mon, Jan 26, 2026 at 4:35 AM Yushan Wang <wangyushan12@huawei.com> wrote:
>> Current wildcard matching of pmu names only support the form of
>> "<pmu_name>%d", which may not be sufficient for pmus with other forms of
>> name (e.g. HiSilicon PCIe PMU has the name of "hisi_pcie%d_pmu%d").
>>
>> To address that, change the wildcard matching function into a callback,
>> and add a new version of wildcard-matching function using the callback
>> to support more flexible pmu names.
> There's some discussion around PMU name matching here (and the replies):
> https://lore.kernel.org/lkml/20251231224233.113839-12-zide.chen@intel.com/
> that I think is relevant.
The complexity of name matching is sad. Do you think it's a good idea to add a callback for specific use? Maybe the wildcard matching needs more complete split, that extracts the match logic of core and uncore pmus into individual functions?
>> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
>> ---
>>  tools/perf/util/pmus.c | 12 +++++++++---
>>  tools/perf/util/pmus.h |  3 +++
>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>> index 98be2eb8f1f0..35184d477d07 100644
>> --- a/tools/perf/util/pmus.c
>> +++ b/tools/perf/util/pmus.c
>> @@ -402,7 +402,8 @@ struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *eve
>>         return NULL;
>>  }
>>
>> -struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard)
>> +struct perf_pmu *perf_pmus__scan_matching(struct perf_pmu *pmu, const char *wildcard,
>> +                                         perf_pmus_match_t match)
>>  {
>>         bool use_core_pmus = !pmu || pmu->is_core;
>>
>> @@ -436,19 +437,24 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const c
>>         }
>>         if (use_core_pmus) {
>>                 list_for_each_entry_continue(pmu, &core_pmus, list) {
>> -                       if (perf_pmu__wildcard_match(pmu, wildcard))
>> +                       if (match(pmu, wildcard))
>>                                 return pmu;
>>                 }
>>                 pmu = NULL;
>>                 pmu = list_prepare_entry(pmu, &other_pmus, list);
>>         }
>>         list_for_each_entry_continue(pmu, &other_pmus, list) {
>> -               if (perf_pmu__wildcard_match(pmu, wildcard))
>> +               if (match(pmu, wildcard))
>>                         return pmu;
>>         }
>>         return NULL;
>>  }
>>
>> +struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard)
>> +{
>> +       return perf_pmus__scan_matching(pmu, wildcard, perf_pmu__wildcard_match);
>> +}
>> +
>>  static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
>>  {
>>         bool use_core_pmus = !pmu || pmu->is_core;
>> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
>> index 7cb36863711a..9308afb5a7b8 100644
>> --- a/tools/perf/util/pmus.h
>> +++ b/tools/perf/util/pmus.h
>> @@ -9,6 +9,8 @@ struct perf_event_attr;
>>  struct perf_pmu;
>>  struct print_callbacks;
>>
>> +typedef _Bool (*perf_pmus_match_t)(const struct perf_pmu *, const char *);
> nit: can we use stdbool.h and make this return a bool?
> nit: in general Linux style is to avoid typedefs:
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#typedefs

Yes, thanks for pointing out, I will fix them.

>
> Thanks,
> Ian

Thanks, 
Yushan
>
>> +
>>  size_t pmu_name_len_no_suffix(const char *str);
>>  /* Exposed for testing only. */
>>  int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
>> @@ -22,6 +24,7 @@ struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr);
>>  struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
>>  struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
>>  struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event);
>> +struct perf_pmu *perf_pmus__scan_matching(struct perf_pmu *pmu, const char *wildcard, perf_pmus_match_t match);
>>  struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard);
>>
>>  const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
>> --
>> 2.33.0
>>

