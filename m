Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBCF20C48A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699889; cv=none; b=gnorYqBOMQ5IhaCDlVycaqROAZ8FS7tZXfJHiNMOjZqioJvYNDTL+uxfop1HvWJkrV5QHVdACEXwZhgwo0nSCEeHGhQvo5PH7Dc9+V4gLRg7pc2K7kRjjLGQghhijkviKRP84niYDLf2u8ISIWK81/c3O9VJvzLXvgbhROdHJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699889; c=relaxed/simple;
	bh=4yjbWrx1m4lq4an4maTGB/jGzcPlJnNDeubdKIquNLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AUOmXH6OCJNHSErpEXiPZiV+8AE2f396Au7cQ0SHlX7QFSw6Nm3/aGguH6ZBN7nFlv+9BWQWYOx0UjNTatjOpchJ4pvG/JN+kYCQ9z+S2eIyWKfopvDjqTIRDCQC8L6H5XPS9+Y1cfcN3IK/SYKo1EHXMB6c8g2HjrIXoRU8C5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5/8OjsDa; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5/8OjsDa"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EXNz48ErS4VkHSIsHgHCczlXRgDQbWuwWUUMeOs+Q0E=;
	b=5/8OjsDa/M2L06sMM0NM/ms1B4k90W2Y8xdF/yWwV8jMdl9NQew+aL9eGNxedEDJJ75mwTcvs
	Vz2Yh+T4i3z1G2X3Ne7qZyWepVKG8mkWrRWNT/3Au9x4WmOjiXCJMBEsn9AmEz/DJLCuPddtytE
	dXfGyGAUHPkVeqOMpEt1i3w=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f22jT3Kp0znTVy;
	Thu, 29 Jan 2026 23:14:05 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id A25F240539;
	Thu, 29 Jan 2026 23:17:58 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Jan 2026 23:17:58 +0800
Received: from [10.67.120.139] (10.67.120.139) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 29 Jan 2026 23:17:47 +0800
Message-ID: <734d6c88-1065-473a-80bb-31b0a2defd7f@huawei.com>
Date: Thu, 29 Jan 2026 23:17:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH 2/7] perf stat: Save unnecessary print_metric() call
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <mike.leach@linaro.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <peterz@infradead.org>,
	<john.g.garry@oracle.com>, <shiju.jose@huawei.com>, <will@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <liuyonglong@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <wangzhou1@hisilicon.com>, Yushan Wang
	<wangyushan12@huawei.com>
References: <20260126123514.3238425-1-wangyushan12@huawei.com>
 <20260126123514.3238425-3-wangyushan12@huawei.com>
 <20260127160118.00001692@huawei.com>
Content-Language: en-US
From: wangyushan <wangyushan12@huawei.com>
In-Reply-To: <20260127160118.00001692@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100008.china.huawei.com (7.202.194.111)



On 1/28/2026 12:01 AM, Jonathan Cameron wrote:
> On Mon, 26 Jan 2026 20:35:09 +0800
> Yushan Wang <wangyushan12@huawei.com> wrote:
>
>> Patch [1] removed the second branch of iostat_run, and changed num to 0
>> since it is the default behavior. But during iostat_run, default value 1
>> of num is required to avoid print_metric() call later.
>>
>> Set num as 1 to avoid redundant print_metric() call that causes
>> unaligned blank printed.
>>
>> Fixes: b71f46a6a708 ("perf stat: Remove hard coded shadow metrics")
>>
>> [1]: https://lore.kernel.org/all/20251111212206.631711-8-irogers@google.com/
> Use a Link tag for links, but don't add them when they just point to the patch
> you already have as a fixes tag.  Just refer to it as "The patch listed under
> Fixes".

Yes, I will fix that in the next version, thanks for pointing out.

Yushan

>> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
>> ---
>>  tools/perf/util/stat-shadow.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
>> index 9c83f7d96caa..9439baf8002f 100644
>> --- a/tools/perf/util/stat-shadow.c
>> +++ b/tools/perf/util/stat-shadow.c
>> @@ -319,8 +319,10 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>>  	void *ctxp = out->ctx;
>>  	int num = 0;
>>  
>> -	if (config->iostat_run)
>> +	if (config->iostat_run) {
>>  		iostat_print_metric(config, evsel, out);
>> +		num = 1;
>> +	}
>>  
>>  	perf_stat__print_shadow_stats_metricgroup(config, evsel, aggr_idx,
>>  						  &num, NULL, out);

