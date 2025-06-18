Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270728312D
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245759; cv=none; b=qvvG3OIg74DtTaKgnfWVA9kOQD8I1fF5iTpYIgXNj7Y3xJbmLc9uGDChxr9epPWTt7BsdKtK+r3a1WMXXBsGTjd2ZGsHhyH/+0KmKKtEQNxoVmObWscqiK+3q3UcXwH01TKZ7X9C0+Qux/jHHgeWB5d3sZdAyHQJ+Q4xjMBuOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245759; c=relaxed/simple;
	bh=+NhOfCJYKzzcpcQp/ArPOmEqieMTRfaR1m9mAqhuy8U=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=moS3bX9tFSvkZHWD3pJPeOs9jorhZzG+ZizocZol7lL3/gdVBr2J80xuWQvMkGo3JuNkmAOADY+dwPFt21TxmCQqS6SDxaiM/m/FZa3MHrK2uzfdxZOZrbvaojdz6A3KJxjHnwt0To0S9zHZ8jGFnl0bQ18Vawq3oMQxxoI//LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bMh9X54rFz1d1yR;
	Wed, 18 Jun 2025 19:20:16 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 408DD180B64;
	Wed, 18 Jun 2025 19:22:28 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Jun 2025 19:22:28 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Jun 2025 19:22:27 +0800
CC: Leo Yan <leo.yan@arm.com>, Leo Yan <leo.yan@linux.dev>,
	<yangyicong@hisilicon.com>, <acme@kernel.org>, <james.clark@linaro.org>,
	<namhyung@kernel.org>, <shameerali.kolothum.thodi@huawei.com>,
	<will@kernel.org>, <catalin.marinas@arm.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: Re: [PATCH] tools/headers: Workaround the copy coherency issue of
 arm64's cputype.h
To: Mark Rutland <mark.rutland@arm.com>
References: <20250618083017.62879-1-yangyicong@huawei.com>
 <aFJ8bQh_30JMzF_-@J2N7QTR9R3>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <2fe89c81-9613-eb01-2487-115b8ea27e8e@huawei.com>
Date: Wed, 18 Jun 2025 19:22:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aFJ8bQh_30JMzF_-@J2N7QTR9R3>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/6/18 16:44, Mark Rutland wrote:
> On Wed, Jun 18, 2025 at 04:30:17PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> arch/arm64/include/asm/cputype.h is copied from arch/arm64 and used
>> by perf to parsing vendor specific SPE packets according to the MIDR.
>> The header diverge after errata management handling for VM live
>> migration merged [1] so a direct copy will lead to the build failure
>> of perf [2]: is_midr_in_range_list() is used but the implementation
>> has been changed and moved out of the kernel header.
> 
> The build failure described above manifests *IF AND WHEN* we update the
> userspace header with a copy of the kernel header, and there's no need
> to do so.
> 
>> Workaround this issue by maintaining is_perf_midr_in_range_list()
>> in the userspace. Temporarily include the kernel headers for the
>> MIDR definitions, a later refactor will generate the MIDR header
>> dynamically similar to how we handle the sysreg-defs.h in userspace.
>> Remove cputype.h from check-headers.sh.
> 
> Sorry, but NAK to this. As-is, this means that any change to the
> kernel-internal asm/cputype.h is liable to break the userspace tool, and
> placing a burden on whoever modifies the kernel-internal headers.
> 
> The simple solution for now is to *NOT* update the userspace header, and
> to stop warning that this has diverged from the kernel header. If we
> want to improve matters, we should split things appropriately for
> sharing.
> 

ok then I think we just make it as is and wait for Leo's refactor.

thanks.
