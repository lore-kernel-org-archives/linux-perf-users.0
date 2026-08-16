Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA81EB19B;
	Sun, 16 Aug 2026 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786844579; cv=none; b=AQGPitgjPNnrX8HWodyE8Lfv7Y7N2XiJFOIY9o9AwZozcgHYhkTegjdeZQYiK4G2xJOlKgMqv0d2X7qdXi/E++SqenjI0Cs1sEdcGQsdtpSndnjQIMXW8kDiozoFdwL6O14V9QQKOQuCX5u/AzhHiWh9HKzLvdWDXucHdh1MB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786844579; c=relaxed/simple;
	bh=tzMlVKDnnNIZ3PjsUydIbCEt5Zad93HvcVzkLXcR16I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVlusJNSrUFG17FPiV3gs8goWDjpq7fFDApzbklVsyNoU7XKj6Z48P/yZ2k5j4qnWCmHcGx5z6AR8pXKSLRGkcqEG/HKPc5ofVjw3j07wkUg9ckDR8i7znM/Wt8sVlpsrc3GJKxLSEv6/rijNrFx78CO/sIxdnCE7NvX/GxZ4yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DgWl2RNZ; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DgWl2RNZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786844567; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dVBzPFe0whP78lsDOkJAtpx+rXVWYaUG5slZsC0Fb64=;
	b=DgWl2RNZx6ty/p7bifOi6GHSQr53K97G142QSbwmSo+EX8O8n/xAPbCgDXCuU9cltYuVxbp3mWo4o6uuQRvHcZlyxK7pzyz5z7ov7tMeD+StBCnlVLudgm9WGkxSlVGC15ReIznQK1eVPWHtFIxRpcxO7cs/TdunOVRlfCGItwk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X9-u0h6_1786844565;
Received: from 30.28.192.31(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X9-u0h6_1786844565 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Aug 2026 09:42:46 +0800
Message-ID: <7321c855-08b7-4270-9d98-297a872ad47d@linux.alibaba.com>
Date: Sun, 16 Aug 2026 09:42:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/dwc_pcie: Fix PCI device reference leak in probe
To: Ruoyu Wang <ruoyuw560@gmail.com>, Jing Zhang
 <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Yunhui Cui <cuiyunhui@bytedance.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260814133925.1385687-1-ruoyuw560@gmail.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260814133925.1385687-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/26 9:39 PM, Ruoyu Wang wrote:
> pci_get_domain_bus_and_slot() returns a referenced PCI device. When the
> subsequent RAS DES capability lookup fails, dwc_pcie_pmu_probe() returns
> -ENODEV without releasing that reference. Repeated failed probes can
> therefore keep the PCI device allocated after removal.
> 
> Move the existing pci_dev_put() immediately after capability discovery
> so the temporary lookup reference is released on both success and
> failure paths.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.
> 
> Fixes: 7f35b429802a ("perf/dwc_pcie: fix duplicate pci_dev devices")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 5385401fa9cf6..baa736fd9a6ef 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -710,10 +710,10 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>   	}
>   
>   	vsec = dwc_pcie_des_cap(pdev);
> +	pci_dev_put(pdev);
>   	if (!vsec)
>   		return -ENODEV;
>   
> -	pci_dev_put(pdev);
>   	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
>   	if (!name)
>   		return -ENOMEM;


Good catch.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

