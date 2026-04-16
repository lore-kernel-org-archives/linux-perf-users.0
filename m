Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFCF396596
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338399; cv=none; b=j8Iud1Zad1WKVa4DHgHtX3uIgxgkccT2ZSSKR0QORrO8CHdod+TYWJJGG6yNFsWBgCehsLHBFvRDiJUdWsmF7oWyJfreEOKBRfX/+1CvSJT98weLavD/6gMRV47x9JVYSrRNIqqHG1Z2NiSf8PcTaj4YHtuqUXYxuikGfFs58+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338399; c=relaxed/simple;
	bh=rP66Ft4gymdcUorodAbaQj5kSAXgdPwjKV+3kWVuHqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K7XCOrZ6Dm00vPRTBmr3j/1YzGLcQLFeuXOlJnM1A9ZOfwiTQpbASaKMHSz3w8ppomYS6GJ6Mfzag7nAJfZK+M4g70Q75Q5XK1Sc2NgtBUoPU4SRB1AmQj/ZbpvhI2tIAgedaA2ximWV8jnPkr5kagdF4HkMbaFvy4iRA83v8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fxFk56N8YzcZyN;
	Thu, 16 Apr 2026 19:13:17 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id E7D3740561;
	Thu, 16 Apr 2026 19:19:49 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Apr
 2026 19:19:49 +0800
Message-ID: <8be7bda5-56da-4c1d-9fde-6b81ea10ac19@hisilicon.com>
Date: Thu, 16 Apr 2026 19:19:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PMU driver maintainer to
 Yushan Wang
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Will Deacon <will@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>
CC: <linuxarm@huawei.com>, <jic23@kernel.org>
References: <20260416095110.25612-1-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260416095110.25612-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 4/16/2026 5:51 PM, Jonathan Cameron wrote:
> Replace myself with Yushan Wang who is very familiar with the HiSilicon PMU
> drivers.
Really appreciate all your guidance during the upstreaming work!

Acked-by: Jie Zhan <zhanjie9@hisilicon.com>
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cc0e12fe1f..8b95a43527fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11563,7 +11563,7 @@ F:	Documentation/devicetree/bindings/net/hisilicon*.txt
>  F:	drivers/net/ethernet/hisilicon/
>  
>  HISILICON PMU DRIVER
> -M:	Jonathan Cameron <jonathan.cameron@huawei.com>
> +M:	Yushan Wang <wangyushan12@huawei.com>
>  S:	Supported
>  W:	http://www.hisilicon.com
>  F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst
