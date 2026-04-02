Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B5233704
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775092469; cv=none; b=IG3Ts+wO8HRJvjRrshIuvZGN/d54caxwA+y0/mD4FqokGtExKffHM+EWlMxxxqAoz0A/twEuI/uSJ5CODdnUKYEzxIsLNUj159ym0BD8ZzxTjoft5Tu00qhcrLPCLyV/34cs8ASfuJ1NWylUxWG9lVI7qFY7hKDkrgZdXfyY/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775092469; c=relaxed/simple;
	bh=fpyuoqRhsa0MPUQAkvVYGReI2eoxdl7dtl+Yyx3fY5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K5LI2AVbOoG3LlmrzlojLI3JJM2LZTDEAsx/larnWTfCsnYAoTxbxsnLf9YZvVruprGhLGGHIogWxAF8kLexDK8DhaTeFlT7BUyFPkpEjGTDfGgQbsyRuwBPnIpj5X6F6Lo7OS8FzE7lwL9jqOFbrfNYC0Fj/wBYNnAPQHr84t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nHeyRAEp; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nHeyRAEp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fpyuoqRhsa0MPUQAkvVYGReI2eoxdl7dtl+Yyx3fY5M=;
	b=nHeyRAEpxmymeQfk79R/agfVsRwUElVVqQrQKRGzpLdLej/PiQf1y+nC4iIh4YH4HKWFJ/f/r
	H/SEadxRo9wPd3OqnDjLIX8HKhpZQjGm3/QMLSEp4vGTiDLdlq23bZUrE6kd+mVuphD7UD2+38e
	VPsg7F5Kjq9b3IcTlfahN8I=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fmNyL5m6Lz1prL9;
	Thu,  2 Apr 2026 09:08:10 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id D0C4040575;
	Thu,  2 Apr 2026 09:14:23 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Apr 2026 09:14:23 +0800
Received: from [10.67.120.139] (10.67.120.139) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 09:14:22 +0800
Message-ID: <4b262856-16e3-4273-bdc2-ab2282866afc@huawei.com>
Date: Thu, 2 Apr 2026 09:14:19 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH 0/7] perf tool: Support iostat for multiple platforms
To: Ian Rogers <irogers@google.com>
CC: <mike.leach@linaro.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <peterz@infradead.org>, <john.g.garry@oracle.com>,
	<Jonathan.Cameron@huawei.com>, <shiju.jose@huawei.com>, <will@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <liuyonglong@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <wangzhou1@hisilicon.com>
References: <20260126123514.3238425-1-wangyushan12@huawei.com>
 <CAP-5=fWkBjJy2i=e+zn1Ou5g3J8rapGKi8O7ryQ-ic2vXFEOoQ@mail.gmail.com>
 <d8639ed9-63d9-4a61-8cce-72f4b7fcb872@huawei.com>
 <CAP-5=fUmozPRDgms0QxHS5G3O8csrhyak9TWGGXeYE+QwiSHQA@mail.gmail.com>
Content-Language: en-US
From: Yushan Wang <wangyushan12@huawei.com>
In-Reply-To: <CAP-5=fUmozPRDgms0QxHS5G3O8csrhyak9TWGGXeYE+QwiSHQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100008.china.huawei.com (7.202.194.111)


On 4/2/2026 4:52 AM, Ian Rogers wrote:
>
> Hi Yushan, thanks for your effort on iostat! Did you have chance to
> work on follow up?
>
> Thanks,
> Ian
>

Yes, I am still working on it.

The next version will be posted in merge window or early 7.1 cycle.

Thanks for your attention!
Yuashan
>


