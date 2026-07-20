Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D362F0673;
	Mon, 20 Jul 2026 04:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784520331; cv=none; b=NC93dpGKBCXVVuPMaD/41stnLI27zwyI3hvJL7B86jrTkmmNBpWYBGGp+TwOZcY8aUz48Gjkfj1fzymJLjifgKP6eTEtamdSAIc5y6zaTee8Z3GW7xPsuU22YGO8QAQwYwiOFSdOYO6J5N/PmjSNy05kshAu4hv0wBSVm1ILZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784520331; c=relaxed/simple;
	bh=anXf+3SPJMjuCand0Wq/k0cA5Ug97kPNZ0TQOoqk/5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=R43/ItKp4lH5GFdhw9XyTOMOBsmZ7AfgIDhymVPc4gH1s/XedXFPGWmVhvW4VNPlNJzTOnv7OJq/vCCii+sP3GDtosXbyNkGvw+HidsM+ML4VRlmXxf8HrM/VHrNsKeYZ7X1lMTc/0lsM+Iiy3Cxb02EpdQ4sed2fE5pNrcrVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fXsgjlbG; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fXsgjlbG"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Y5U9Z07azIKoS+HmD20XRidZIG20eJu/X9DH5Wl67jM=;
	b=fXsgjlbGQMsOIrt7wXHLHx6x7cEhxJYQpo59tiKU05P9aPmkvbgQ/Tmok1Wi+9YYB8OC7l75e
	bh4Nq29MHSF/Mtv1ZVUqumuxAJ9MXxZJvc3Cm3H+kMshHRdgP5PtI5dNzEMaAMGzJrvA3gwQSxQ
	byPwAb9ALRxIsolJKi0fXt4=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4h3RWl6cvFzmV8f;
	Mon, 20 Jul 2026 11:56:03 +0800 (CST)
Received: from whupemo500002.china.huawei.com (unknown [7.152.185.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 63D4E40572;
	Mon, 20 Jul 2026 12:05:25 +0800 (CST)
Received: from [10.67.120.139] (10.67.120.139) by
 whupemo500002.china.huawei.com (7.152.185.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Jul 2026 12:05:24 +0800
Message-ID: <e59ac457-8ee8-4a10-93a2-ae80c124ecf4@huawei.com>
Date: Mon, 20 Jul 2026 12:05:23 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drivers/perf: hisi: Remove redundant
 dev_err()/dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>
References: <20260717103123.34887-1-panchuang@vivo.com>
 <20260717103123.34887-4-panchuang@vivo.com>
Content-Language: en-US
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"moderated list:ARM PMU PROFILING AND DEBUGGING"
	<linux-arm-kernel@lists.infradead.org>, "open list:ARM PMU PROFILING AND
 DEBUGGING" <linux-perf-users@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
From: Yushan Wang <wangyushan12@huawei.com>
In-Reply-To: <20260717103123.34887-4-panchuang@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemo500002.china.huawei.com (7.152.185.250)



On 7/17/2026 6:31 PM, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() and dev_err_probe() calls.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 3 +--
>  drivers/perf/hisilicon/hisi_uncore_pmu.c     | 5 +----
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> index f963e4f9e552..56a88fb0d3c2 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> @@ -604,8 +604,7 @@ static int hisi_l3c_pmu_init_ext(struct hisi_pmu *l3c_pmu, struct platform_devic
>  				       IRQF_NOBALANCING | IRQF_NO_THREAD,
>  				       irqname, l3c_pmu);
>  		if (ret < 0)
> -			return dev_err_probe(&pdev->dev, ret,
> -				"Fail to request EXT IRQ: %d.\n", irq);
> +			return ret;
>  
>  		hisi_l3c_pmu->ext_irq[i] = irq;
>  	}
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index 0ff2fdf4b3e2..77390d033d08 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -192,11 +192,8 @@ int hisi_uncore_pmu_init_irq(struct hisi_pmu *hisi_pmu,
>  	ret = devm_request_irq(&pdev->dev, irq, hisi_uncore_pmu_isr,
>  			       IRQF_NOBALANCING | IRQF_NO_THREAD,
>  			       dev_name(&pdev->dev), hisi_pmu);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev,
> -			"Fail to request IRQ: %d ret: %d.\n", irq, ret);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	hisi_pmu->irq = irq;
>  
Acked-by: Yushan Wang <wangyushan12@huawei.com>

Thanks!
