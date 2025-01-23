Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA8620CCFF;
	Thu, 23 Jan 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737625805; cv=none; b=tg7EaYpFn4J25IXT9PL3bJ/kK1616bMuLpbxjOCm0T0XuELB0YQSevf544+AWMYRU8Crn1gGQtzq6JMQFTeSY1hbRUn1Z84q+1VSqnK1feizBJszftsFBswlhW7gt3gGLlM5it4tMTV/qj6sej/+wY3yqClDjc1vcLidg/hTO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737625805; c=relaxed/simple;
	bh=xzt4URNabIKkONjmNRY0fm3fVF5z84E/xJdyzIh3FA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K1cwMs96A9iM8tHoWeGCzxPjBNGvr0d7K2SK7oiQyWbMa+7DuHFv51HYfS6RhehdTwbNuUuGq6Vg4cHXj4zXuJ3VgjzZ/5J7W5CJBf898pGEikmcDoT2Lt8fT9k+XVSiPo75IpHH+rCqF5gvLj48MJI7+MTPiXt0j/nY/ryx4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Kv8nTySE; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Kv8nTySE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737625792; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Q1Ts7XE8Xr5IE3ZwrGLXx/LOXkXGx3YbnOYf+1AJwHU=;
	b=Kv8nTySEbX9tqHYFdDeev3mTZfJQwC86rh9A5uH9WVeWE18ICtyQt2TbrfUyEOiEIR48m/+Iue41WeQCv7ttaeLO4cfrxaHhjtqEnHxPTCBjocd4U5aaUA8GjQwmvfAYTBiB1tvK6N8N/OitgLxeJ0kNesmytbRUyrRYvpsxwaM=
Received: from 30.246.161.230(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WOBFs9N_1737625791 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Jan 2025 17:49:52 +0800
Message-ID: <344c53cd-d856-4c03-9deb-743b65acd8aa@linux.alibaba.com>
Date: Thu, 23 Jan 2025 17:49:50 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/dwc_pcie: fix duplicate pci_dev devices
To: Yunhui Cui <cuiyunhui@bytedance.com>, renyu.zj@linux.alibaba.com,
 will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250123074830.90923-1-cuiyunhui@bytedance.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250123074830.90923-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/23 15:48, Yunhui Cui 写道:
> During platform_device_register, wrongly using struct device
> pci_dev as platform_data caused a kmemdup copy of pci_dev. Worse
> still, accessing the duplicated device leads to list corruption as its
> mutex content (e.g., list, magic) remains the same as the original.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index cccecae9823f..8b208f287a1f 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -565,9 +565,7 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
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
> @@ -614,19 +612,32 @@ static struct notifier_block dwc_pcie_pmu_nb = {
>   
>   static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>   {
> -	struct pci_dev *pdev = plat_dev->dev.platform_data;
> +	struct pci_dev *pdev = NULL;
>   	struct dwc_pcie_pmu *pcie_pmu;
> +	bool found = false;
>   	char *name;
>   	u32 sbdf;
>   	u16 vsec;
>   	int ret;
>   
> +	for_each_pci_dev(pdev) {
> +		sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
> +		if (sbdf == plat_dev->id) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	if (!found) {
> +		pr_err("The plat_dev->id does not match the sbdf");
> +		return -ENODEV;
> +	}
> +

How about using pci_get_domain_bus_and_slot() to find pci_dev?

>   	vsec = dwc_pcie_des_cap(pdev);
>   	if (!vsec)
>   		return -ENODEV;
>   
>   	sbdf = plat_dev->id;
> -	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
> +	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%d_pmu", sbdf);

A new name will break previous user tools.

>   	if (!name)
>   		return -ENOMEM;
>   
> @@ -640,7 +651,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>   	pcie_pmu->on_cpu = -1;
>   	pcie_pmu->pmu = (struct pmu){
>   		.name		= name,
> -		.parent		= &pdev->dev,
> +		.parent		= &plat_dev->dev,
>   		.module		= THIS_MODULE,
>   		.attr_groups	= dwc_pcie_attr_groups,
>   		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> @@ -727,7 +738,7 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_n
>   
>   static struct platform_driver dwc_pcie_pmu_driver = {
>   	.probe = dwc_pcie_pmu_probe,
> -	.driver = {.name = "dwc_pcie_pmu",},
> +	.driver = {.name = "platform_dwc_pcie",},
>   };
>   
>   static int __init dwc_pcie_pmu_init(void)

Thanks.

Best Regards,
Shuai

