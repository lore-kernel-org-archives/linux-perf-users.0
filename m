Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93719BE40;
	Mon, 24 Feb 2025 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361989; cv=none; b=jDoxkFoj/9IyKEtPtOHe0M2bM0udZo/9LTN9GcDwNjX5LG87oMtxtDoSN6snrnBsl4tzGgKPzA1slbKQfYukRkOGm1TM6ukKd3LHDv8eZg8dPd9n3xYttMJldHWSvU05/0i4k0v/IR8Lm10jtKcvbpiq3JieTqAomN3VfOPlkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361989; c=relaxed/simple;
	bh=6ikVNs1Lm/B+JSWTCi9hCbgykU2ecAZBuRwQTpMt/GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dWIM7/vZyV5HJtJ1vdSn2a4kJwjwlvdQSFMxmmOQKxDY5adrueBzfMJb+8GRjU5Z0ndIY+GslC3ti22Zo0btPkeOw+j/2YUfrE4b2hd1dbSzKVHQuyHZxgeoXbaLjghe48hax+3KgdgCjyL0+VLVaSRGLoReA0XHz6TwmB5LA6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pBn8N8H/; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pBn8N8H/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740361977; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oEmpU6CxySYSJOx99iwbmfKn56SP3FGaigjsO4xV1Bw=;
	b=pBn8N8H/9CyllR+P5VLZRJO2wTSl9KOJLODMLBgqEH8JiGt6xF07DiOVFaXMBKeNv0VbdWv8KeIgaKDGoe8MLQkxptXykcvDjZpjxT1afCrX6F0xEssPCMMrPCRSc3ilai9ON70UaMCrxqR+BPrrF+OzdLdV+wx5gTHMFauGhRM=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQ1RZA4_1740361975 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 09:52:56 +0800
Message-ID: <f532b261-631f-41ac-813e-cb351eb1f8f3@linux.alibaba.com>
Date: Mon, 24 Feb 2025 09:52:55 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] perf/dwc_pcie: fix some unreleased resources
To: Yunhui Cui <cuiyunhui@bytedance.com>, renyu.zj@linux.alibaba.com,
 will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220121716.50324-1-cuiyunhui@bytedance.com>
 <20250220121716.50324-2-cuiyunhui@bytedance.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250220121716.50324-2-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/20 20:17, Yunhui Cui 写道:
> Release leaked resources, such as plat_dev and dev_info.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 33 ++++++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index cccecae9823f..19fa2ba8dd67 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -572,8 +572,10 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
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
> @@ -730,6 +732,15 @@ static struct platform_driver dwc_pcie_pmu_driver = {
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
> @@ -742,7 +753,7 @@ static int __init dwc_pcie_pmu_init(void)
>   		ret = dwc_pcie_register_dev(pdev);
>   		if (ret) {
>   			pci_dev_put(pdev);
> -			return ret;
> +			goto err_cleanup;
>   		}
>   	}
>   
> @@ -751,35 +762,35 @@ static int __init dwc_pcie_pmu_init(void)
>   				      dwc_pcie_pmu_online_cpu,
>   				      dwc_pcie_pmu_offline_cpu);
>   	if (ret < 0)
> -		return ret;
> +		goto err_cleanup;
>   
>   	dwc_pcie_pmu_hp_state = ret;
>   
>   	ret = platform_driver_register(&dwc_pcie_pmu_driver);
>   	if (ret)
> -		goto platform_driver_register_err;
> +		goto err_remove_cpuhp;
>   
>   	ret = bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
>   	if (ret)
> -		goto platform_driver_register_err;
> +		goto err_unregister_driver;
>   	notify = true;
>   
>   	return 0;
>   
> -platform_driver_register_err:
> +err_unregister_driver:
> +	platform_driver_unregister(&dwc_pcie_pmu_driver);
> +err_remove_cpuhp:
>   	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
> -
> +err_cleanup:
> +	dwc_pcie_cleanup_devices();
>   	return ret;
>   }
>   
>   static void __exit dwc_pcie_pmu_exit(void)
>   {
> -	struct dwc_pcie_dev_info *dev_info, *tmp;
> -
>   	if (notify)
>   		bus_unregister_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
> -	list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, dev_node)
> -		dwc_pcie_unregister_dev(dev_info);
> +	dwc_pcie_cleanup_devices();
>   	platform_driver_unregister(&dwc_pcie_pmu_driver);
>   	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
>   }


LGTM. Thanks.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Shuai
