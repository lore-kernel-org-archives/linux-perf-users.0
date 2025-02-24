Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07F19343B;
	Mon, 24 Feb 2025 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362063; cv=none; b=D4JWn3zRLJmRR6l2ZES/DQy5ZMu9j/rR5TfCdH4cqnsa9nIimNI7RtouJFE22uXjIFz0zYUh6o0FCq7QFYaP//gVt8n81o06rJmBA10ErCjuAzJqFPPtDz8age7Yw595cFxAT6QMJSYzWu0IMLz6JAutMuwCA1ST7QQO2Ox2FiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362063; c=relaxed/simple;
	bh=7BJnpcUtxMmzlgMD9aCGNNsKxWVHlZhzu0qVxox5Mis=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gn/kUbD0llPfvpiobUza1hoOFOsFVXWM2iFprAgc0VMiUGYInvHVAAZWdYeGggPCVgy38kjJbmeIDI0wUenvOKWeC5VgQMMEjst5Xtp+dlWD6IU8FPx/v4IhL+hceQlsriDq1aszVxddOosVNpRY0Zgqg+LhqV8XOAiisyFfdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f98j+d3z; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f98j+d3z"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740362051; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5Mgf5q6qhRBmuSgAe02ZdEG2nF1QbJDMGd3ly1/yKPM=;
	b=f98j+d3zAO1YP5XtijKJbGEULUCD16HAVIFrE6W4OzXimLZUGIw0oqqFKaJBJ7udXn5QCPe0NZMlTErIo7DZ1iTqlS3vWounyRIH39s5N+H3Lqo5Pqldxx3ot8+6lPE6JfmU7ve1f/EaxgCrBbixYCumPvypMYSVl3SNyPmGgQc=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQ1RZjo_1740362050 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 09:54:11 +0800
Message-ID: <5f25bb49-ce73-48ea-aa74-bd8972a3517d@linux.alibaba.com>
Date: Mon, 24 Feb 2025 09:54:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf/dwc_pcie: fix duplicate pci_dev devices
To: Yunhui Cui <cuiyunhui@bytedance.com>, renyu.zj@linux.alibaba.com,
 will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220121716.50324-1-cuiyunhui@bytedance.com>
 <20250220121716.50324-3-cuiyunhui@bytedance.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250220121716.50324-3-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/20 20:17, Yunhui Cui 写道:
> During platform_device_register, wrongly using struct device
> pci_dev as platform_data caused a kmemdup copy of pci_dev. Worse
> still, accessing the duplicated device leads to list corruption as its
> mutex content (e.g., list, magic) remains the same as the original.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 19fa2ba8dd67..f851e070760c 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -565,9 +565,7 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
>   	u32 sbdf;
>   
>   	sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
> -	plat_dev = platform_device_register_data(NULL, "dwc_pcie_pmu", sbdf,
> -						 pdev, sizeof(*pdev));
> -
> +	plat_dev = platform_device_register_simple("dwc_pcie_pmu", sbdf, NULL, 0);
>   	if (IS_ERR(plat_dev))
>   		return PTR_ERR(plat_dev);
>   
> @@ -616,18 +614,26 @@ static struct notifier_block dwc_pcie_pmu_nb = {
>   
>   static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>   {
> -	struct pci_dev *pdev = plat_dev->dev.platform_data;
> +	struct pci_dev *pdev;
>   	struct dwc_pcie_pmu *pcie_pmu;
>   	char *name;
>   	u32 sbdf;
>   	u16 vsec;
>   	int ret;
>   
> +	sbdf = plat_dev->id;
> +	pdev = pci_get_domain_bus_and_slot(sbdf >> 16, PCI_BUS_NUM(sbdf & 0xffff),
> +					   sbdf & 0xff);
> +	if (!pdev) {
> +		pr_err("No pdev found for the sbdf 0x%x\n", sbdf);
> +		return -ENODEV;
> +	}
> +
>   	vsec = dwc_pcie_des_cap(pdev);
>   	if (!vsec)
>   		return -ENODEV;
>   
> -	sbdf = plat_dev->id;
> +	pci_dev_put(pdev);
>   	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
>   	if (!name)
>   		return -ENOMEM;
> @@ -642,7 +648,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>   	pcie_pmu->on_cpu = -1;
>   	pcie_pmu->pmu = (struct pmu){
>   		.name		= name,
> -		.parent		= &pdev->dev,
> +		.parent		= &plat_dev->dev,
>   		.module		= THIS_MODULE,
>   		.attr_groups	= dwc_pcie_attr_groups,
>   		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,


LGTM. Thanks.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Shuai
