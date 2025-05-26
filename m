Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F47A1EB5C2
	for <linux-perf-users@vger.kernel.org>; Mon, 26 May 2025 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748257610; cv=none; b=mIfUu6zJn/aZHUJdudIZL3AU1PeLvAKFibpcBjrejY6VMxddD3Sfn5JMt6v7ZS/pWWkQhDHbPZs5gn3REsxLf4Xxm/v1uv3H+p/BRgwdBObfFFkbsXYNzoFSR4kPnl7RxyizO5xdxnNXKetkUvD0ycGfOgUo48RKB4eeOA47Gd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748257610; c=relaxed/simple;
	bh=bZVrbFtLLb6xWMkxlIOLz4L0KQi2gJoiftZUhISdV0Q=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DmUJ70IY7rwE+r3OJHM868LZ4wXV0kuyGrjMOtJqGWNOjaDU3VmH9SVYdD4gnbiBr3Xc7CsNgaaV4lsQAplc/He29ehy0IAOTx+id/BNIyBnNuBcd1ruQM0ZyPnQLMbZn3S/sWnc5XAknMPtdlUio4kGxVswta6zNyLvQix8l2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4b5XwS6RyWz13KdP;
	Mon, 26 May 2025 19:04:56 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B8E2A1402EA;
	Mon, 26 May 2025 19:06:38 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 19:06:38 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 19:06:37 +0800
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
Message-ID: <f5afc098-def8-fa83-db9e-32837eadec0c@huawei.com>
Date: Mon, 26 May 2025 19:06:37 +0800
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200018.china.huawei.com (7.202.195.108)

Hi Arnaldo,

On 2025/5/21 22:49, Arnaldo Carvalho de Melo wrote:
> On Wed, May 14, 2025 at 11:38:42AM +0800, Yicong Yang wrote:
>> a gentle ping on this..
> 
> So this involves both kernel and tooling, as soon as someone merges the
> kernel part, I can try and get to the user part,

is it still possible to catch up with this cycle? Kernel part has been picked up [1].

thanks.

[1] https://lore.kernel.org/linux-arm-kernel/174790933967.1291842.14160046478134585349.b4-ty@kernel.org/

> 
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
