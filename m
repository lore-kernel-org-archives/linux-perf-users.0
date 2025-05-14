Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF84438B
	for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747193929; cv=none; b=p+EBFJlCqcvKB8D4gjbsrbP4CfgNXgvQ3SVU9V018Lrn5ULrLjNkY3590sv+OnNm3mK7xOPkedI9K5p0QeqRiqyarCwZYpfFJ/iLiGlqVp8YbUte3MqgVsNbjiswlhdFAuMCaEswe5xXQkHrInS5gLeuparIzRhkLTmj+eQcOBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747193929; c=relaxed/simple;
	bh=J0Dtq0z9coLPnYq9s1gwP1h4BIzAqvmxpGn/6U267oo=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y4IydDdIF4VcTAtfMmCl/MYhL+t5qNQRXbbl3U3KThbkknoWilqzX1TEf98UNJO5CX7fwtLzZzIRHT10Th8vgN8sxK3cZ7MrgoLN+F5xBE9WC+9a5hjF1z6sZzZWmzDm9CZBeI8XxxZpidRSvrBN0guSmGWnZwVxG3thHA383VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZxzYT67c1zxTSP;
	Wed, 14 May 2025 11:37:17 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B9A2D1402E0;
	Wed, 14 May 2025 11:38:43 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 May 2025 11:38:43 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 May 2025 11:38:42 +0800
CC: <yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<hejunhao3@huawei.com>, <linuxarm@huawei.com>, <wangyushan12@huawei.com>,
	<caijingtao@huawei.com>, <xueshan2@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v2 0/3] Add support for SPE Data Source packet on
 HiSilicon HIP12
To: <acme@kernel.org>, <namhyung@kernel.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<mark.rutland@arm.com>, <jolsa@kernel.org>, <john.g.garry@oracle.com>,
	<james.clark@linaro.org>, <leo.yan@linux.dev>, <irogers@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>
References: <20250425033845.57671-1-yangyicong@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <d06b1e86-b6b8-3909-65bb-45b7cd70d263@huawei.com>
Date: Wed, 14 May 2025 11:38:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250425033845.57671-1-yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemq200018.china.huawei.com (7.202.195.108)

a gentle ping on this..

Thanks.

On 2025/4/25 11:38, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Add support for Data Source packet on HIP12. Support counting L2 HITM for c2c
> statistic since it was missing.
> 
> Change since v2:
> - split the kernel/userspace changes into different patch
> - revise some mem_snoop decoding according to the discussion
> - count missing L2 HITM for c2c statistic
> Link: https://lore.kernel.org/linux-perf-users/20250408122809.37884-1-yangyicong@huawei.com/
> 
> Yicong Yang (3):
>   arm64: cputype: Add cputype definition for HIP12
>   perf arm-spe: Add support for SPE Data Source packet on HiSilicon
>     HIP12
>   perf mem: Count L2 HITM for c2c statistic
> 
>  arch/arm64/include/asm/cputype.h              |  2 +
>  tools/arch/arm64/include/asm/cputype.h        |  2 +
>  .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 ++++
>  tools/perf/util/arm-spe.c                     | 96 +++++++++++++++++++
>  tools/perf/util/mem-events.c                  |  5 +-
>  5 files changed, 121 insertions(+), 1 deletion(-)
> 
