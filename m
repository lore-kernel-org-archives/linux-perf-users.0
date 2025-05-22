Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF96ADD
	for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904846; cv=none; b=r34q6DYqtavKSfgURh1e5l3PlmtdHOrYVVHoyb2cE00+ScQasIjobyggfNJfriVn73949QA6iEcHb4sY/9X2HDIqojS/yeQfToSoS3ADYkT49PCjSlU4KNIgT2SFCXvaYqFUS0ubDVrnVr45Hgyr6s77/0PCC8Zeswy8A+afPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904846; c=relaxed/simple;
	bh=oOSr6yQ3F4t5E2VsAyJH+EGgYLkAHEetf3Q/t5I0/ZQ=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XPhOhQR9wjnzlfPyOPeFyrtaRABGfQru9F6r0MA9LrazBw866hzGVJbKy1VNOrIgnEyRr029Vn295qN5R02l+6/Ee6dBzALy76jTpwQCnAW27iRBl6sZ4vrSzCTxfOMYClb3mg2hGzc4EeZGiQQcgt05tuvxOaq8XQYaGR9TEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4b32T830LxzVmcC;
	Thu, 22 May 2025 17:06:04 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D0E20140134;
	Thu, 22 May 2025 17:07:19 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 May 2025 17:07:19 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 May 2025 17:07:18 +0800
CC: <yangyicong@hisilicon.com>, <namhyung@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <mark.rutland@arm.com>, <jolsa@kernel.org>,
	<john.g.garry@oracle.com>, <james.clark@linaro.org>, <leo.yan@linux.dev>,
	<irogers@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <jonathan.cameron@huawei.com>,
	<hejunhao3@huawei.com>, <linuxarm@huawei.com>, <wangyushan12@huawei.com>,
	<caijingtao@huawei.com>, <xueshan2@huawei.com>, <prime.zeng@hisilicon.com>,
	Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v2 0/3] Add support for SPE Data Source packet on
 HiSilicon HIP12
To: Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20250425033845.57671-1-yangyicong@huawei.com>
 <d06b1e86-b6b8-3909-65bb-45b7cd70d263@huawei.com> <aC3oFxuEbVEHd3Pb@x1>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <b567709c-2e5b-8000-d856-ae92cba22816@huawei.com>
Date: Thu, 22 May 2025 17:07:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aC3oFxuEbVEHd3Pb@x1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/5/21 22:49, Arnaldo Carvalho de Melo wrote:
> On Wed, May 14, 2025 at 11:38:42AM +0800, Yicong Yang wrote:
>> a gentle ping on this..
> 
> So this involves both kernel and tooling, as soon as someone merges the
> kernel part, I can try and get to the user part,
> 

the kernel part only add the cputype definition, then the definition update is synchronized in
both userspace/kernel headers. So the changes in the userspace actually have no dependency on
the kernel one.

Thanks.

> - Arnaldo
>  
>> Thanks.
>>
>> On 2025/4/25 11:38, Yicong Yang wrote:
>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>
>>> Add support for Data Source packet on HIP12. Support counting L2 HITM for c2c
>>> statistic since it was missing.
>>>
>>> Change since v2:
>>> - split the kernel/userspace changes into different patch
>>> - revise some mem_snoop decoding according to the discussion
>>> - count missing L2 HITM for c2c statistic
>>> Link: https://lore.kernel.org/linux-perf-users/20250408122809.37884-1-yangyicong@huawei.com/
>>>
>>> Yicong Yang (3):
>>>   arm64: cputype: Add cputype definition for HIP12
>>>   perf arm-spe: Add support for SPE Data Source packet on HiSilicon
>>>     HIP12
>>>   perf mem: Count L2 HITM for c2c statistic
>>>
>>>  arch/arm64/include/asm/cputype.h              |  2 +
>>>  tools/arch/arm64/include/asm/cputype.h        |  2 +
>>>  .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 ++++
>>>  tools/perf/util/arm-spe.c                     | 96 +++++++++++++++++++
>>>  tools/perf/util/mem-events.c                  |  5 +-
>>>  5 files changed, 121 insertions(+), 1 deletion(-)
>>>
> 
> .
> 
