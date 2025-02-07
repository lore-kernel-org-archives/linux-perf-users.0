Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA937E0FF;
	Fri,  7 Feb 2025 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738896083; cv=none; b=nguNz315rPBYaE9QTfmo6HqFNeDT91X4kaHETOaLJ16OL6sMdRKAtgV/u1JqzbR/VDlql9cEiihfDsoHW0CvCDxK8ZsOAPMV4XiJFDxc6P79BULt3JLiDhjcdJycHdz7Can/Q9vqfW/8akVgODb2qi/AiL3YN5RjC2SQTDz1sM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738896083; c=relaxed/simple;
	bh=usW+bz6oKgsv1kDpCKBbEVSEOKdp156abvluOOct4us=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eOM652tuYikcsUWHBGAixYu9YfFGX0ehR4KobnpUwM6kOAgerD0vjRgC2/gOZSCE3ECR5GIQ/SvdHRVtwH0yVhBNxJ4sz0SPJsYIMtG/4AkvpiPfd9/LDrl8N1TH5KqD+grqhypcOwL0bWPNqbojOLNmgZDHjUASqQuqOvxcA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fSoTASgr; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fSoTASgr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738896077; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/zEhfB3CHplqCB7IjBn91aPxxiAsdOK81yimcuizNvU=;
	b=fSoTASgrAlyHJgl9XIlBAmqOX0LrcD7QfOK2Cm+GYbqBOl9P8Vm0OMXExRtJBL1jWKtk5I0EB0BWlAynVsXad4zwGbYoJhtGK2uN0I5fWpV8cBruPklPq/EBAtx8GbSztxA4l0eb7SCKxyLlbowVfREJlvuj+RhpwCypv781zw8=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WOxlwo8_1738895757 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Feb 2025 10:35:57 +0800
Message-ID: <0961be9f-87be-4ecc-9e60-faa78119affc@linux.alibaba.com>
Date: Fri, 7 Feb 2025 10:35:56 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf/dwc_pcie: fix duplicate pci_dev devices
To: Yunhui Cui <cuiyunhui@bytedance.com>, renyu.zj@linux.alibaba.com,
 will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250205031425.67265-1-cuiyunhui@bytedance.com>
 <20250205031425.67265-3-cuiyunhui@bytedance.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250205031425.67265-3-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/5 11:14, Yunhui Cui 写道:
> During platform_device_register, wrongly using struct device
> pci_dev as platform_data caused a kmemdup copy of pci_dev. Worse
> still, accessing the duplicated device leads to list corruption as its
> mutex content (e.g., list, magic) remains the same as the original.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 4ac53167d7ab..fd9d87b4f201 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -566,9 +566,7 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
>   	u32 sbdf;
>   
>   	sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
> -	plat_dev = platform_device_register_data(NULL, "dwc_pcie_pmu", sbdf,
> -						 pdev, sizeof(*pdev));
> -
> +	plat_dev = platform_device_register_simple("platform_dwc_pcie", sbdf, NULL, 0);
>   	if (IS_ERR(plat_dev))
>   		return PTR_ERR(plat_dev);
>   
> @@ -620,18 +618,26 @@ static struct notifier_block dwc_pcie_pmu_nb = {
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
> +		pr_err("No pdev found for the sbdf");

How about also adding the sbdf to print?

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
> @@ -646,7 +652,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>   	pcie_pmu->on_cpu = -1;
>   	pcie_pmu->pmu = (struct pmu){
>   		.name		= name,
> -		.parent		= &pdev->dev,
> +		.parent		= &plat_dev->dev,
>   		.module		= THIS_MODULE,
>   		.attr_groups	= dwc_pcie_attr_groups,
>   		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> @@ -733,7 +739,7 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_n
>   
>   static struct platform_driver dwc_pcie_pmu_driver = {
>   	.probe = dwc_pcie_pmu_probe,
> -	.driver = {.name = "dwc_pcie_pmu",},
> +	.driver = {.name = "platform_dwc_pcie",},
>   };
>   
>   static void dwc_pcie_cleanup_devices(void)

