Received: from sg-1-34.ptr.blmpb.com (sg-1-34.ptr.blmpb.com [118.26.132.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053A1D31B9
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Dec 2025 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764915289; cv=none; b=BuMj9FlNVZApl/o1Fp164cLM99ukz+fLGmRnx3TdPRLbZ2lbCze+hic0NUJy+lHs/Vq0NIYRTQd/nzoc06sPgTsCeksuQJCC0v6n4SPwJeKJE77QJnkbyXf1QLafjxhh9i94cJV6A88iCW3gstPPmG7yommkVHcvkuAfswmoTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764915289; c=relaxed/simple;
	bh=CvWhmtmvn7qNNSNds0KvCC2SLPReBQpsfdIG9lnMji0=;
	h=Subject:Message-Id:Mime-Version:Content-Type:References:
	 In-Reply-To:To:Date:Cc:From; b=c89apEXZM5XpsN+Du8f9UaAOMOLcXGtwM4U1OSKZhyG2j50J2LYjunl2W9LaGDROYeV0pRHsuBG9sZgJL0s++z1UZNlwrK0pFAg9byKtOxohzmuHezQ2sohDX/IWu5LX9yYCAwdkNnaomTT6/BsnNilReKfPQNLng6pO54iKsNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b=JBfuGE69; arc=none smtp.client-ip=118.26.132.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b="JBfuGE69"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=picoheart-com.20200927.dkim.feishu.cn; t=1764915159;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=CbbPQmGT66XgpcQTC/NHTJu3sZ6jTELyOqJLg0OipEM=;
 b=JBfuGE69Do+bFrVN6EcOnjae8w/VdKFoH5FAjG+LcfFoNkUBEwUEPq/HA499GvjxjqF0m2
 fIEgs56nbY3QIGXT0GIepUUM3kJiSh0722TMMb4aZWXR6Ylz5yOfcrkrMoK5pQTuSEmzKV
 kh60gDU+K2qn/GcMtTpzv+Calxl9PmmY9+gwMbgfc/cuSXdI8a8wq8SdGNLMMiiKCC1uBb
 mrjaE5wDsqGGf27ctDVJi96JBoj4rqErALrE5nFqb2/OIHFIH14sPvIAKiouxLyllN4zSi
 hRfyfyzTizO9B7AmdtBl8WEUZi3rmEkGnuZ4jD4SZWpQLR0uioTEAbMk2c64Zg==
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Lms-Return-Path: <lba+2693277d5+f048a0+vger.kernel.org+yang.yicong@picoheart.com>
Subject: Re: [PATCH v6 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
Received: from [100.86.226.133] ([58.250.106.109]) by smtp.feishu.cn with ESMTPS; Fri, 05 Dec 2025 14:12:36 +0800
Message-Id: <96fd2a69-baf4-4109-8341-0d4bb6c60393@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
References: <20251114033243.76509-1-cuiyunhui@bytedance.com> <20251114033243.76509-3-cuiyunhui@bytedance.com>
In-Reply-To: <20251114033243.76509-3-cuiyunhui@bytedance.com>
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Date: Fri, 5 Dec 2025 14:12:33 +0800
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Cc: <akpm@linux-foundation.org>, <alex@ghiti.fr>, <anup@brainfault.org>, 
	<aou@eecs.berkeley.edu>, <atish.patra@linux.dev>, 
	<catalin.marinas@arm.com>, <dianders@chromium.org>, 
	<johannes@sipsolutions.net>, <lihuafei1@huawei.com>, 
	<mark.rutland@arm.com>, <masahiroy@kernel.org>, <maz@kernel.org>, 
	<mingo@kernel.org>, <nicolas.schier@linux.dev>, <palmer@dabbelt.com>, 
	<paul.walmsley@sifive.com>, <suzuki.poulose@arm.com>, 
	<thorsten.blum@linux.dev>, <wangjinchao600@gmail.com>, <will@kernel.org>, 
	<yangyicong@hisilicon.com>, <zhanjie9@hisilicon.com>, 
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<linux-perf-users@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	"Paul Walmsley" <pjw@kernel.org>, <yang.yicong@picoheart.com>, 
	<geshijian@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>

Hi Yunhui,

this has conflicts on the mainline master. looks like you have a dependency
on the SSE PMU support patchset [1], need to mention it for the maintainer
to apply.

[1] https://lore.kernel.org/linux-riscv/20250908181717.1997461-5-cleger@rivosinc.com/

one comment below.

On 2025/11/14 11:32, Yunhui Cui wrote:
> Enable the HARDLOCKUP_DETECTOR_PERF function based on RISC-V SSE.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Paul Walmsley <pjw@kernel.org>
> ---
>  arch/riscv/Kconfig           |  3 +++
>  drivers/perf/riscv_pmu_sbi.c | 10 ++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fadec20b87a8e..46ccd33732fa8 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -186,6 +186,9 @@ config RISCV
>  	select HAVE_PAGE_SIZE_4KB
>  	select HAVE_PCI
>  	select HAVE_PERF_EVENTS
> +	select HAVE_PERF_EVENTS_NMI if RISCV_PMU_SBI_SSE
> +	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> +	select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index c852f64a50221..0c7c5924687c9 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -22,6 +22,7 @@
>  #include <linux/sched/clock.h>
>  #include <linux/soc/andes/irq.h>
>  #include <linux/workqueue.h>
> +#include <linux/nmi.h>
>  
>  #include <asm/errata_list.h>
>  #include <asm/sbi.h>
> @@ -1192,6 +1193,13 @@ static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
>  }
>  #endif
>  
> +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> +bool arch_perf_nmi_is_available(void)
> +{
> +	return IS_ENABLED(CONFIG_RISCV_PMU_SBI_SSE);

this looks incorrect per implementation in [1]. we'll fallback to the normal
interrupt if failed to register the SSE event, in which case NMI is not
available for the PMU. Check the kconfig is not sufficient.

you can check pmu->sse_evt instead for the NMI support here, or cached the
NMI status somewhere like how arm_pmu does.

Thanks.

> +}
> +#endif
> +
>  static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
> @@ -1618,6 +1626,8 @@ static int __init pmu_sbi_devinit(void)
>  	/* Notify legacy implementation that SBI pmu is available*/
>  	riscv_pmu_legacy_skip_init();
>  
> +	lockup_detector_retry_init();
> +
>  	return ret;
>  }
>  device_initcall(pmu_sbi_devinit)
