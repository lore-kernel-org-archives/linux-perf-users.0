Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CA6174EF0;
	Fri,  7 Feb 2025 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894807; cv=none; b=EjwTlzHUIyXgE9AfqFo+e6Ap2e6Q3IYE85NKAmqOK8AsWVfBCw9NFvL0uTd5MoDVEjxrM3Wx60GXHuuqOrpF67MbCEcxmlB3TS94+i3xM4OO4l/1kRZhL8EJRHqOdwy8XwvKAjTrnshLPv6SgXiGC0EcXmtKGnV7HOf5YaFV2R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894807; c=relaxed/simple;
	bh=Ggtl3+tapFujgU4WanDZRKGcgAgXmjbWlHKoycU8AtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=unLPLSyUcrhpiToFsdZIhsjxO4UzIw7DKNYRtFuEduegtvYx+gxE3t5O49dRPBY6rltRkDwDilDufNKZJnUtRqG7uBZbPcxlNjJVzxZxtXWDPgSzGKikzfyeTaPDtVDWnhjfVcLC3idJ0zNlycTnW4zpzkXzJ6vVyTvG+5SkdmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nCaOzaF1; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nCaOzaF1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738894801; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MIJQd8/xiO8zk0JzBELYAOXAcVPyFlMXoXFFjOZkwuA=;
	b=nCaOzaF1M0QqssoLW21Q1c5trNnfcLnre3qhJ4BLdlLuOCpetcM7xd2VXhTSw8G4O4ss2oDyze53XuJp9caPTOw12Z5iuqtkhwEfeVlFNjIfYz21GW5gD+Yz0ryzWxXggkqry6QnDp0S7rlC67quEKyOpRByDYVKRp3ZOwxqWAI=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WOxloU6_1738894800 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Feb 2025 10:20:00 +0800
Message-ID: <76dad20a-0180-46a0-9840-6d8444d1749a@linux.alibaba.com>
Date: Fri, 7 Feb 2025 10:19:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf/dwc_pcie: fix the incorrect reference count
To: Yunhui Cui <cuiyunhui@bytedance.com>, renyu.zj@linux.alibaba.com,
 will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250205031425.67265-1-cuiyunhui@bytedance.com>
 <20250205031425.67265-2-cuiyunhui@bytedance.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250205031425.67265-2-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/5 11:14, Yunhui Cui 写道:
> for_each_pci_dev increments pdev refcount. Call pci_dev_put after access
> to decrement it.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 42 ++++++++++++++++++++++++++-----------
>   1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index cccecae9823f..4ac53167d7ab 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -553,6 +553,7 @@ static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
>   
>   static void dwc_pcie_unregister_dev(struct dwc_pcie_dev_info *dev_info)
>   {
> +	pci_dev_put(dev_info->pdev);
>   	platform_device_unregister(dev_info->plat_dev);
>   	list_del(&dev_info->dev_node);
>   	kfree(dev_info);
> @@ -572,8 +573,10 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
>   		return PTR_ERR(plat_dev);
>   
>   	dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
> -	if (!dev_info)
> +	if (!dev_info) {
> +		platform_device_unregister(plat_dev);
>   		return -ENOMEM;
> +	}
>   
>   	/* Cache platform device to handle pci device hotplug */
>   	dev_info->plat_dev = plat_dev;
> @@ -594,8 +597,11 @@ static int dwc_pcie_pmu_notifier(struct notifier_block *nb,
>   	case BUS_NOTIFY_ADD_DEVICE:
>   		if (!dwc_pcie_des_cap(pdev))
>   			return NOTIFY_DONE;
> -		if (dwc_pcie_register_dev(pdev))
> +		pci_dev_get(pdev);
> +		if (dwc_pcie_register_dev(pdev)) {
> +			pci_dev_put(pdev);
>   			return NOTIFY_BAD;
> +		}
>   		break;
>   	case BUS_NOTIFY_DEL_DEVICE:
>   		dev_info = dwc_pcie_find_dev_info(pdev);
> @@ -730,20 +736,29 @@ static struct platform_driver dwc_pcie_pmu_driver = {
>   	.driver = {.name = "dwc_pcie_pmu",},
>   };
>   
> +static void dwc_pcie_cleanup_devices(void)
> +{
> +	struct dwc_pcie_dev_info *dev_info, *tmp;
> +
> +	list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, dev_node) {
> +		dwc_pcie_unregister_dev(dev_info);
> +	}
> +}
> +
>   static int __init dwc_pcie_pmu_init(void)
>   {
>   	struct pci_dev *pdev = NULL;
>   	int ret;
>   
>   	for_each_pci_dev(pdev) {
> -		if (!dwc_pcie_des_cap(pdev))
> +		if (!dwc_pcie_des_cap(pdev)) {
> +			pci_dev_put(pdev);

If the pdev has no RAS cap, we do not need to put the device.

> The reference count for @from is
> always decremented if it is not %NULL.

Please see comments from pci_get_device() for more details.

Shuai

