Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9DF286A7;
	Thu, 23 Jul 2026 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784770355; cv=none; b=fAY2ZM9xtW9lWYK0i4MDVLFjJX0zarVFJwY6qrDJKZDr9PIk6myedJP9f48caewDrX0hq8badQ1I9jUXR3X/K2pOUbx07CDHQY/gHxsxD9AIkqC6l7AbEehqGL5lSEMpILQPZDATn7w6GgDiCA27bEZramsTgMudlO3sTIM5Vpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784770355; c=relaxed/simple;
	bh=cyNydO2VqSvszUm4EjQWwLVzTcbah6H1Fw01t9ZSyjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=msDeFkzT8cyqrxryXjdBr8JzgdpJ70wMn9DBxlLgXo3mvCDu8AwCQCVopvdNNdXu8NYI2US09KO3xj66X2dkkmxSezpH4497oIb3cTMyAPL1h+CQx4jN5+GGHW2c/wi/eieKnPhzIxw4SU39DX1OAfGJiZtJc7PPkSWw55Myrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jEmyjhJm; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jEmyjhJm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784770349; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ffb8HuUn7oxunFjlvB6SA3X4fMM99E5+jBR0sfFb7F0=;
	b=jEmyjhJmRcnYGsJX5TwIahNLyjjcKXdvTSO4LQA7p2PLiDheMvoh1J2wmzO4uuUULDEcUp9XSBx20KE27oTem6lmGOG9ynr4U2dcgKMVkwEZZSMkdtdzYFw6s4Oop7Af7IMvKay7ZUFfJUVm01qzK7IPzR5pqvCsHQMFbB3LBCk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X7eTJH5_1784770346;
Received: from 30.246.177.242(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X7eTJH5_1784770346 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Jul 2026 09:32:27 +0800
Message-ID: <31bebd39-8534-417c-866d-6d6e3468473c@linux.alibaba.com>
Date: Thu, 23 Jul 2026 09:32:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf: Remove redundant dev_err()/dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Frank Li <Frank.li@nxp.com>,
 Xu Yang <xu.yang_2@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
 Khuong Dinh <khuong@os.amperecomputing.com>,
 "moderated list:ARM PMU PROFILING AND DEBUGGING"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM PMU PROFILING AND DEBUGGING"
 <linux-perf-users@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>
References: <20260717103123.34887-1-panchuang@vivo.com>
 <20260717103123.34887-2-panchuang@vivo.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260717103123.34887-2-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/17/26 6:31 PM, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() and dev_err_probe() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>   drivers/perf/alibaba_uncore_drw_pmu.c | 5 +----
>   drivers/perf/fsl_imx8_ddr_perf.c      | 4 +---
>   drivers/perf/fsl_imx9_ddr_perf.c      | 4 +---
>   drivers/perf/fujitsu_uncore_pmu.c     | 2 +-
>   drivers/perf/qcom_l2_pmu.c            | 5 +----
>   drivers/perf/qcom_l3_pmu.c            | 5 +----
>   drivers/perf/starfive_starlink_pmu.c  | 2 +-
>   drivers/perf/xgene_pmu.c              | 4 +---
>   8 files changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> index 74786a5dd6a2..fc934bccf4a6 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -449,11 +449,8 @@ static struct ali_drw_pmu_irq *__ali_drw_pmu_init_irq(struct platform_device
>   	 */
>   	ret = devm_request_irq(&pdev->dev, irq_num, ali_drw_pmu_isr,
>   			       IRQF_SHARED, dev_name(&pdev->dev), irq);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev,
> -			"Fail to request IRQ:%d ret:%d\n", irq_num, ret);
> +	if (ret < 0)
>   		goto out_free;
> -	}
>   
>   	ret = irq_set_affinity_hint(irq_num, cpumask_of(irq->cpu));
>   	if (ret)
For Alibaba PMU part,

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks,
Shuai
