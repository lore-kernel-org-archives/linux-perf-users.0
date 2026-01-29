Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D52C0F7F
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700005; cv=none; b=MdL4R4a691unSYVd4XNsgy9LXRgj9WQWmNyUJYcshOgrtg2tEZSVdEVzjHSzArIR4F1h8/tK/9ySX3vOar0xlkk6rchZLmaYghXepQdVTAxVtUki2mqsIMaYauwyo+TvQRBClzkPIHiKb6pBJca5yAlpfHCUZuRKFS7B1kp2sxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700005; c=relaxed/simple;
	bh=M4CEXFcfaZJnULvaBzBi0gSNB8qkVoAtMiZ4V8kiLA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b4GMGsrXdgbev/Mr7AdUKIcSt93OpJeROjXv06HkM24/9KjYykmZthmXf5JHgrQw8g9nfyPLYwYtnA/4ZGp/lX0e4GtDsjUgNgU9GMQCBKBXfVD386kS7WFXiVZwB2GJu/dy8MvQ1VVwBuiR6pSUOl/6wmKW1d3CspQFvKS5pEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CRxPawUI; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CRxPawUI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yPprun4aR90KqpUnWVsp2X14tMNGCdXErOUxb3GK7ZA=;
	b=CRxPawUIXau+eXwS1lVvSmkkxONUydluDE8cAS9KTPp2fg/cfjXzXiVs1hrTPxohj63az0jc5
	w145pGxHti+NWh4ypxhZ1JeocsyAVVFXOXAdixMsCD0uBhvO5xv/QcrdFt8NCw6LrsYcYW43x1f
	BhlrQ+ZeAp7wn+2qcwvaejg=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4f22mG0VMwzmV6b;
	Thu, 29 Jan 2026 23:16:30 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 714D74048B;
	Thu, 29 Jan 2026 23:19:59 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Jan 2026 23:19:59 +0800
Received: from [10.67.120.139] (10.67.120.139) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 29 Jan 2026 23:19:58 +0800
Message-ID: <e90f26f2-a966-46a1-a858-d1061a9e19c9@huawei.com>
Date: Thu, 29 Jan 2026 23:19:57 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH 1/7] perf stat: Check color's length instead of the
 pointer
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
 <20260126123514.3238425-2-wangyushan12@huawei.com>
 <20260127155835.000011c9@huawei.com>
Content-Language: en-US
From: wangyushan <wangyushan12@huawei.com>
In-Reply-To: <20260127155835.000011c9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100008.china.huawei.com (7.202.194.111)



On 1/27/2026 11:58 PM, Jonathan Cameron wrote:
> On Mon, 26 Jan 2026 20:35:08 +0800
> Yushan Wang <wangyushan12@huawei.com> wrote:
>
>> Color string returned by metric_threshold_classify__color() is never
>> NULL, check the presence of *color will always return true.
>>
>> Fix this by change the checks against length of *color.
>>
>> Fixes: 37b77ae95416 ("perf stat: Change color to threshold in print_metric")
>>
> No blank line between tags.
>
> Fixes: 37b77ae95416 ("perf stat: Change color to threshold in print_metric")
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
>
> Some of the scripting run against the kernel uses that lack of blank lines
> as a heuristic to identify what is a tag vs other similar looking text.

Thanks for reminding, will fix it in the next version.
> Thanks,
>
> Jonathan
>
>> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
>> ---
>>  tools/perf/builtin-script.c    | 2 +-
>>  tools/perf/util/stat-display.c | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
[...]

Thanks!
Yushan
