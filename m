Received: from sg-3-43.ptr.tlmpb.com (sg-3-43.ptr.tlmpb.com [101.45.255.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084003B8BB6
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Aug 2026 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733723; cv=none; b=VYWqCeQSkAyxjaJrRidxJTdYgp6Ir+nT699ay6ixmh+a96W+FsQmOFV7A4tGHeJ7Qdet4IV74L/3C7/sEtD6lpW5zCn9X82NoxfC5iqRUdblsU1kOdLjQr/n53nPb4bz8we9x/RBijZcOq8sb9CMfsPQjLsuQSB87zNhdSs5xvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733723; c=relaxed/simple;
	bh=9ShPCCNq5dQxHrM+wtim7pj2qMWPe/vNu0bW6s8wI00=;
	h=From:Message-Id:To:Cc:Date:Mime-Version:In-Reply-To:References:
	 Subject:Content-Type; b=i+SnLY7HtGTnPPWcyPQxi/XlrIkhPVvP9fxXDZsReg25TcaswzModmq1kDGDO3R+8m4VdMt2CHI9AOrcnFmD6td/ahOWRsxrxiV1lGHpQIBbPtZhJlqMsJLAmgJqHNwLndYPoC94dbc4FMIzH7NV8ZLtosKt91sjDqxp5ZvAv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=i/FoCy0U; arc=none smtp.client-ip=101.45.255.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="i/FoCy0U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1787732977; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=HzdH8nsqTysaIedViXV7Z9XxXF8cCq89j3KqpBDmv5o=;
 b=i/FoCy0UAYSWhTFfxs4N+tQYdKiEKIY7Q02+ElGjQpppoKorysZHuM/wZzTKvDGJlTwsQD
 gpcvWi9G03LE0c3fmAJ26EigOLdmXwIaJCjSwYxg9vnqM1KybIwSk0a7N4AL4nwS7LABIG
 HmCrh3zSADnjQIGMfetSrdcuub5/d99/6JJ34wMGeFksypuJ00j2mr3CvAcKPjuG/1fitV
 N55d4CjhOYxNg1FlfDsYCAwnk/KfGfbHXDDmZtJxyxHufXJUjWs/U1Pu6bOegDXe24Zlbs
 ITW32ET/zVsrRW+j6LWlveRC/+n0tnxiYhLbSyg6+tVtwOaHjZHhmCvFzRlkEg==
From: "Yicong Yang" <yang.yicong@picoheart.com>
Message-Id: <612d401c-2543-44aa-8b16-9f571432a788@picoheart.com>
To: "Zong Li" <zong.li@sifive.com>
Cc: <tomasz.jeznach@linux.dev>, <joro@8bytes.org>, <will@kernel.org>, 
	<robin.murphy@arm.com>, <pjw@kernel.org>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <mark.rutland@arm.com>, 
	<andrew.jones@oss.qualcomm.com>, <guoren@kernel.org>, 
	<david.laight.linux@gmail.com>, <zhangzhanpeng.jasper@bytedance.com>, 
	<iommu@lists.linux.dev>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, 
	<yang.yicong@picoheart.com>, "Chen Pei" <cp0613@linux.alibaba.com>, 
	"Fangyu Yu" <fangyu.yu@linux.alibaba.com>, 
	"Samuel Holland" <samuel.holland@sifive.com>
Date: Wed, 26 Aug 2026 16:29:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260824022034.3916570-3-zong.li@sifive.com>
User-Agent: Mozilla Thunderbird
References: <20260824022034.3916570-1-zong.li@sifive.com> <20260824022034.3916570-3-zong.li@sifive.com>
X-Lms-Return-Path: <lba+26a8ea3ef+03b42b+vger.kernel.org+yang.yicong@picoheart.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 2/2] iommu/riscv: create a auxiliary device for HPM
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Received: from [100.86.213.231] ([120.234.91.234]) by smtp.feishu.cn with ESMTPS; Wed, 26 Aug 2026 16:29:33 +0800

On 8/24/26 10:20 AM, Zong Li wrote:
> Create an auxiliary device for HPM when the IOMMU supports a
> hardware performance monitor.
> 
> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>

> ---
>  drivers/iommu/riscv/Kconfig |  1 +
>  drivers/iommu/riscv/iommu.c | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> index b86e5ab94183..8025bf0fb67f 100644
> --- a/drivers/iommu/riscv/Kconfig
> +++ b/drivers/iommu/riscv/Kconfig
> @@ -10,6 +10,7 @@ config RISCV_IOMMU
>  	select GENERIC_PT
>  	select IOMMU_PT
>  	select IOMMU_PT_RISCV64
> +	select AUXILIARY_BUS
>  	help
>  	  Support for implementations of the RISC-V IOMMU architecture that
>  	  complements the RISC-V MMU capabilities, providing similar address
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index cec3ddd7ab10..7f619971bb70 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -14,6 +14,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/acpi_rimt.h>
> +#include <linux/auxiliary_bus.h>
>  #include <linux/compiler.h>
>  #include <linux/crash_dump.h>
>  #include <linux/init.h>
> @@ -48,6 +49,9 @@
>  static DEFINE_IDA(riscv_iommu_pscids);
>  #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
>  
> +/* IOMMU PMU auxiliary device id allocation namespace. */
> +static DEFINE_IDA(riscv_iommu_pmu_ida);
> +
>  /* Device resource-managed allocations */
>  struct riscv_iommu_devres {
>  	void *addr;
> @@ -565,6 +569,36 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +/*
> + * IOMMU Hardware performance monitor
> + */
> +static void riscv_iommu_pmu_id_free(void *data)
> +{
> +	ida_free(&riscv_iommu_pmu_ida, (unsigned long)data);
> +}
> +
> +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> +{
> +	struct auxiliary_device *auxdev;
> +	int id, ret;
> +
> +	id = ida_alloc(&riscv_iommu_pmu_ida, GFP_KERNEL);
> +	if (id < 0)
> +		return id;
> +
> +	ret = devm_add_action_or_reset(iommu->dev, riscv_iommu_pmu_id_free,
> +				       (void *)(unsigned long)id);
> +	if (ret)
> +		return ret;
> +
> +	auxdev = __devm_auxiliary_device_create(iommu->dev, "riscv-iommu",
> +						"pmu", iommu, id);
> +	if (!auxdev)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
>  /* Lookup and initialize device context info structure. */
>  static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
>  						 unsigned int devid)
> @@ -1613,6 +1647,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>  		goto err_remove_sysfs;
>  	}
>  
> +	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
> +		riscv_iommu_hpm_enable(iommu);
> +
>  	return 0;
>  
>  err_remove_sysfs:
