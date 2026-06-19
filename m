Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E844A38CFE8;
	Fri, 19 Jun 2026 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885168; cv=none; b=rIsmaL9xgcu8+yabhe160egfRxMJ/opB3j2HU82M6ikpmBGRGJDtmg/Jpa2gbojQVv73zIOU6PV1Mh9i2u0AWb+jdeEtM/hKGqepKxzx+Vr0M0ttK9AQfZA5dMrdP5CPxpMALu4F9QMRYVvzWEwn/HuBF1owh9ijCnmz2BGXrEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885168; c=relaxed/simple;
	bh=owUbC3NqokjsRp0DsNk4Yj7gPkr3ROamMdSUq9Ovs1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aiq3UxEF1o7MardQQzjNaefQe87hkVRR2XvDnwkfv2GevLDOqMz7s96yvsCCwlZIMuwD+kFFfYypZXVL6fgvvsR47NPLFEmH7fi5euGaQUXQU6G3K8t5DERYZ+SfHamifjMMUXx0Jlmi6r2+EUylfxZC7YR+pN7n0hUOHBb8E0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfVf/r6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfVf/r6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43221F00A3A;
	Fri, 19 Jun 2026 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781885166;
	bh=DEGh5iV5dIARgxSi3rH+BC9tT08sN9phT2LdvTATjBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CfVf/r6D5S+1ew/rB8pwmgyKUzM0fI1G/KmEVATb6MSlyV8ygGvmLHJCIqiYMUOxB
	 Jm21Noq8EtdRgMeo98LGNtYV62KQnBIuf+V4h3sm3YT8I9/RT0Pe+FMdKfUjeTgTs+
	 BVIG3dYFGuWuQZKMp+r1VOmOFh4ex5zFvmQRzbnA0F/lPrEOIkSIHcNNEg1f3iso1J
	 zf8AcHFFLNNfUSqHhYn1pOrtBrVvhPK57ScHrXRAn66vy8i4M3V4zIJbE2iyVL7c6u
	 BMF7BdrAxZOTfNKo1hiKol5zUIdh5voo0gCeHLT0+x0NktI7BVy1o6w0SEXfqJh8Hp
	 +AnZfwDtsUlcA==
Date: Fri, 19 Jun 2026 12:05:51 -0400
From: Guo Ren <guoren@kernel.org>
To: Zong Li <zong.li@sifive.com>,
	David Laight <david.laight.linux@gmail.com>
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, robh@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	mark.rutland@arm.com, conor+dt@kernel.org, krzk@kernel.org,
	guoyaxing@bosc.ac.cn, luxu.kernel@bytedance.com,
	lv.zheng@linux.spacemit.com, andrew.jones@oss.qualcomm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Message-ID: <ajVo34aTfZFBZpoe@gmail.com>
References: <20260208063848.3547817-1-zong.li@sifive.com>
 <20260208063848.3547817-2-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260208063848.3547817-2-zong.li@sifive.com>

On Sat, Feb 07, 2026 at 10:38:35PM -0800, Zong Li wrote:
> Add a new driver to support the RISC-V IOMMU PMU. This is an auxiliary
> device driver created by the parent RISC-V IOMMU driver.
> 
> The RISC-V IOMMU PMU separates the cycle counter from the event counters.
> The cycle counter is not associated with iohpmevt0, so a software-defined
> cycle event is required for the perf subsystem.
> 
> The number and width of the counters are hardware-implemented and must
> be detected at runtime.
> 
> The performance monitor provides counters with filtering support to
> collect events for specific device ID/process ID, or GSCID/PSCID.
> 
> PMU-related definitions are moved into the perf driver, where they are
> used exclusively.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/iommu/riscv/iommu-bits.h |  61 ---
>  drivers/perf/Kconfig             |  12 +
>  drivers/perf/Makefile            |   1 +
>  drivers/perf/riscv_iommu_pmu.c   | 661 +++++++++++++++++++++++++++++++
>  4 files changed, 674 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/perf/riscv_iommu_pmu.c
> 
> diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
> index 98daf0e1a306..746cd11f4938 100644
> --- a/drivers/iommu/riscv/iommu-bits.h
> +++ b/drivers/iommu/riscv/iommu-bits.h
> @@ -189,67 +189,6 @@ enum riscv_iommu_ddtp_modes {
>  #define RISCV_IOMMU_IPSR_PMIP		BIT(RISCV_IOMMU_INTR_PM)
>  #define RISCV_IOMMU_IPSR_PIP		BIT(RISCV_IOMMU_INTR_PQ)
>  
> -/* 5.19 Performance monitoring counter overflow status (32bits) */
> -#define RISCV_IOMMU_REG_IOCOUNTOVF	0x0058
> -#define RISCV_IOMMU_IOCOUNTOVF_CY	BIT(0)
> -#define RISCV_IOMMU_IOCOUNTOVF_HPM	GENMASK_ULL(31, 1)
> -
> -/* 5.20 Performance monitoring counter inhibits (32bits) */
> -#define RISCV_IOMMU_REG_IOCOUNTINH	0x005C
> -#define RISCV_IOMMU_IOCOUNTINH_CY	BIT(0)
> -#define RISCV_IOMMU_IOCOUNTINH_HPM	GENMASK(31, 1)
> -
> -/* 5.21 Performance monitoring cycles counter (64bits) */
> -#define RISCV_IOMMU_REG_IOHPMCYCLES     0x0060
> -#define RISCV_IOMMU_IOHPMCYCLES_COUNTER	GENMASK_ULL(62, 0)
> -#define RISCV_IOMMU_IOHPMCYCLES_OF	BIT_ULL(63)
> -
> -/* 5.22 Performance monitoring event counters (31 * 64bits) */
> -#define RISCV_IOMMU_REG_IOHPMCTR_BASE	0x0068
> -#define RISCV_IOMMU_REG_IOHPMCTR(_n)	(RISCV_IOMMU_REG_IOHPMCTR_BASE + ((_n) * 0x8))
> -
> -/* 5.23 Performance monitoring event selectors (31 * 64bits) */
> -#define RISCV_IOMMU_REG_IOHPMEVT_BASE	0x0160
> -#define RISCV_IOMMU_REG_IOHPMEVT(_n)	(RISCV_IOMMU_REG_IOHPMEVT_BASE + ((_n) * 0x8))
> -#define RISCV_IOMMU_IOHPMEVT_EVENTID	GENMASK_ULL(14, 0)
> -#define RISCV_IOMMU_IOHPMEVT_DMASK	BIT_ULL(15)
> -#define RISCV_IOMMU_IOHPMEVT_PID_PSCID	GENMASK_ULL(35, 16)
> -#define RISCV_IOMMU_IOHPMEVT_DID_GSCID	GENMASK_ULL(59, 36)
> -#define RISCV_IOMMU_IOHPMEVT_PV_PSCV	BIT_ULL(60)
> -#define RISCV_IOMMU_IOHPMEVT_DV_GSCV	BIT_ULL(61)
> -#define RISCV_IOMMU_IOHPMEVT_IDT	BIT_ULL(62)
> -#define RISCV_IOMMU_IOHPMEVT_OF		BIT_ULL(63)
> -
> -/* Number of defined performance-monitoring event selectors */
> -#define RISCV_IOMMU_IOHPMEVT_CNT	31
> -
> -/**
> - * enum riscv_iommu_hpmevent_id - Performance-monitoring event identifier
> - *
> - * @RISCV_IOMMU_HPMEVENT_INVALID: Invalid event, do not count
> - * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
> - * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
> - * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
> - * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
> - * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
> - * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
> - * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: First-stage page table walks
> - * @RISCV_IOMMU_HPMEVENT_G_WALKS: Second-stage page table walks
> - * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event IDs
> - */
> -enum riscv_iommu_hpmevent_id {
> -	RISCV_IOMMU_HPMEVENT_INVALID    = 0,
> -	RISCV_IOMMU_HPMEVENT_URQ        = 1,
> -	RISCV_IOMMU_HPMEVENT_TRQ        = 2,
> -	RISCV_IOMMU_HPMEVENT_ATS_RQ     = 3,
> -	RISCV_IOMMU_HPMEVENT_TLB_MISS   = 4,
> -	RISCV_IOMMU_HPMEVENT_DD_WALK    = 5,
> -	RISCV_IOMMU_HPMEVENT_PD_WALK    = 6,
> -	RISCV_IOMMU_HPMEVENT_S_VS_WALKS = 7,
> -	RISCV_IOMMU_HPMEVENT_G_WALKS    = 8,
> -	RISCV_IOMMU_HPMEVENT_MAX        = 9
> -};
> -
>  /* 5.24 Translation request IOVA (64bits) */
>  #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
>  #define RISCV_IOMMU_TR_REQ_IOVA_VPN	GENMASK_ULL(63, 12)
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 638321fc9800..6d0ece827501 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -105,6 +105,18 @@ config RISCV_PMU_SBI
>  	  full perf feature support i.e. counter overflow, privilege mode
>  	  filtering, counter configuration.
>  
> +config RISCV_IOMMU_PMU
> +	depends on RISCV || COMPILE_TEST
> +	depends on RISCV_IOMMU
> +	bool "RISC-V IOMMU Hardware Performance Monitor"
> +	default y
> +	help
> +	  Say Y if you want to use the RISC-V IOMMU performance monitor
> +	  implementation. The performance monitor is an optional hardware
> +	  feature, and whether it is actually enabled depends on IOMMU
> +	  hardware support. If the underlying hardware does not implement
> +	  the PMU, this option will have no effect.
> +
>  config STARFIVE_STARLINK_PMU
>  	depends on ARCH_STARFIVE || COMPILE_TEST
>  	depends on 64BIT
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index ea52711a87e3..f64f7dc046f1 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
>  obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
>  obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
>  obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
> +obj-$(CONFIG_RISCV_IOMMU_PMU) += riscv_iommu_pmu.o
>  obj-$(CONFIG_STARFIVE_STARLINK_PMU) += starfive_starlink_pmu.o
>  obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>  obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pmu.c
> new file mode 100644
> index 000000000000..72fc4341b165
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c
> @@ -0,0 +1,661 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 SiFive
> + *
> + * Authors
> + *	Zong Li <zong.li@sifive.com>
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/io-64-nonatomic-hi-lo.h>
> +#include <linux/perf_event.h>
> +
> +#include "../iommu/riscv/iommu.h"
> +
> +/* 5.19 Performance monitoring counter overflow status (32bits) */
> +#define RISCV_IOMMU_REG_IOCOUNTOVF	0x0058
> +#define RISCV_IOMMU_IOCOUNTOVF_CY	BIT(0)
> +#define RISCV_IOMMU_IOCOUNTOVF_HPM	GENMASK_ULL(31, 1)
> +
> +/* 5.20 Performance monitoring counter inhibits (32bits) */
> +#define RISCV_IOMMU_REG_IOCOUNTINH	0x005C
> +#define RISCV_IOMMU_IOCOUNTINH_CY	BIT(0)
> +#define RISCV_IOMMU_IOCOUNTINH_HPM	GENMASK(31, 0)
> +
> +/* 5.21 Performance monitoring cycles counter (64bits) */
> +#define RISCV_IOMMU_REG_IOHPMCYCLES	0x0060
> +#define RISCV_IOMMU_IOHPMCYCLES_COUNTER	GENMASK_ULL(62, 0)
> +#define RISCV_IOMMU_IOHPMCYCLES_OF	BIT_ULL(63)
> +#define RISCV_IOMMU_REG_IOHPMCTR(_n)	(RISCV_IOMMU_REG_IOHPMCYCLES + ((_n) * 0x8))
> +
> +/* 5.22 Performance monitoring event counters (31 * 64bits) */
> +#define RISCV_IOMMU_REG_IOHPMCTR_BASE	0x0068
> +#define RISCV_IOMMU_IOHPMCTR_COUNTER	GENMASK_ULL(63, 0)
> +
> +/* 5.23 Performance monitoring event selectors (31 * 64bits) */
> +#define RISCV_IOMMU_REG_IOHPMEVT_BASE	0x0160
> +#define RISCV_IOMMU_REG_IOHPMEVT(_n)	(RISCV_IOMMU_REG_IOHPMEVT_BASE + ((_n) * 0x8))
> +#define RISCV_IOMMU_IOHPMEVT_EVENTID	GENMASK_ULL(14, 0)
> +#define RISCV_IOMMU_IOHPMEVT_DMASK	BIT_ULL(15)
> +#define RISCV_IOMMU_IOHPMEVT_PID_PSCID	GENMASK_ULL(35, 16)
> +#define RISCV_IOMMU_IOHPMEVT_DID_GSCID	GENMASK_ULL(59, 36)
> +#define RISCV_IOMMU_IOHPMEVT_PV_PSCV	BIT_ULL(60)
> +#define RISCV_IOMMU_IOHPMEVT_DV_GSCV	BIT_ULL(61)
> +#define RISCV_IOMMU_IOHPMEVT_IDT	BIT_ULL(62)
> +#define RISCV_IOMMU_IOHPMEVT_OF		BIT_ULL(63)
> +#define RISCV_IOMMU_IOHPMEVT_EVENT	GENMASK_ULL(62, 0)
> +
> +/* The total number of counters is 31 event counters plus 1 cycle counter */
> +#define RISCV_IOMMU_HPM_COUNTER_NUM	32
> +
> +static int cpuhp_state;
> +
> +/**
> + * enum riscv_iommu_hpmevent_id - Performance-monitoring event identifier
> + *
> + * @RISCV_IOMMU_HPMEVENT_CYCLE: Clock cycle counter
> + * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
> + * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
> + * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
> + * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
> + * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
> + * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
> + * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: First-stage page table walks
> + * @RISCV_IOMMU_HPMEVENT_G_WALKS: Second-stage page table walks
> + * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event IDs
> + *
> + * The specification does not define an event ID for counting the
> + * number of clock cycles, meaning there is no associated 'iohpmevt0'.
> + * Event ID 0 is an invalid event and does not overlap with any valid
> + * event ID. Let's repurpose ID 0 as the cycle for perf, the cycle
> + * event is not actually written into any register, it serves solely
> + * as an identifier.
> + */
> +enum riscv_iommu_hpmevent_id {
> +	RISCV_IOMMU_HPMEVENT_CYCLE	= 0,
> +	RISCV_IOMMU_HPMEVENT_URQ        = 1,
> +	RISCV_IOMMU_HPMEVENT_TRQ        = 2,
> +	RISCV_IOMMU_HPMEVENT_ATS_RQ     = 3,
> +	RISCV_IOMMU_HPMEVENT_TLB_MISS   = 4,
> +	RISCV_IOMMU_HPMEVENT_DD_WALK    = 5,
> +	RISCV_IOMMU_HPMEVENT_PD_WALK    = 6,
> +	RISCV_IOMMU_HPMEVENT_S_VS_WALKS = 7,
> +	RISCV_IOMMU_HPMEVENT_G_WALKS    = 8,
> +	RISCV_IOMMU_HPMEVENT_MAX        = 9
> +};
> +
> +struct riscv_iommu_pmu {
> +	struct pmu pmu;
> +	struct hlist_node node;
> +	void __iomem *reg;
> +	unsigned int on_cpu;
> +	int num_counters;
> +	u64 cycle_cntr_mask;
> +	u64 event_cntr_mask;
> +	struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
> +	DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_NUM);
> +};
> +
> +#define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu, pmu))
> +
> +#define RISCV_IOMMU_PMU_ATTR_EXTRACTOR(_name, _mask)			\
> +	static inline u32 get_##_name(struct perf_event *event)		\
> +	{								\
> +		return FIELD_GET(_mask, event->attr.config);		\
> +	}								\
> +
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(event, RISCV_IOMMU_IOHPMEVT_EVENTID);
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(partial_matching, RISCV_IOMMU_IOHPMEVT_DMASK);
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(pid_pscid, RISCV_IOMMU_IOHPMEVT_PID_PSCID);
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(did_gscid, RISCV_IOMMU_IOHPMEVT_DID_GSCID);
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_pid_pscid, RISCV_IOMMU_IOHPMEVT_PV_PSCV);
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_did_gscid, RISCV_IOMMU_IOHPMEVT_DV_GSCV);
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_id_type, RISCV_IOMMU_IOHPMEVT_IDT);
> +
> +/* Formats */
> +PMU_FORMAT_ATTR(event,            "config:0-14");
> +PMU_FORMAT_ATTR(partial_matching, "config:15");
> +PMU_FORMAT_ATTR(pid_pscid,        "config:16-35");
> +PMU_FORMAT_ATTR(did_gscid,        "config:36-59");
> +PMU_FORMAT_ATTR(filter_pid_pscid, "config:60");
> +PMU_FORMAT_ATTR(filter_did_gscid, "config:61");
> +PMU_FORMAT_ATTR(filter_id_type,   "config:62");
> +
> +static struct attribute *riscv_iommu_pmu_formats[] = {
> +	&format_attr_event.attr,
> +	&format_attr_partial_matching.attr,
> +	&format_attr_pid_pscid.attr,
> +	&format_attr_did_gscid.attr,
> +	&format_attr_filter_pid_pscid.attr,
> +	&format_attr_filter_did_gscid.attr,
> +	&format_attr_filter_id_type.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group riscv_iommu_pmu_format_group = {
> +	.name = "format",
> +	.attrs = riscv_iommu_pmu_formats,
> +};
> +
> +/* Events */
> +static ssize_t riscv_iommu_pmu_event_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
> +}
> +
> +#define RISCV_IOMMU_PMU_EVENT_ATTR(name, id)			\
> +	PMU_EVENT_ATTR_ID(name, riscv_iommu_pmu_event_show, id)
> +
> +static struct attribute *riscv_iommu_pmu_events[] = {
> +	RISCV_IOMMU_PMU_EVENT_ATTR(cycle, RISCV_IOMMU_HPMEVENT_CYCLE),
> +	RISCV_IOMMU_PMU_EVENT_ATTR(untranslated_req, RISCV_IOMMU_HPMEVENT_URQ),
> +	RISCV_IOMMU_PMU_EVENT_ATTR(translated_req, RISCV_IOMMU_HPMEVENT_TRQ),
> +	RISCV_IOMMU_PMU_EVENT_ATTR(ats_trans_req, RISCV_IOMMU_HPMEVENT_ATS_RQ),
> +	RISCV_IOMMU_PMU_EVENT_ATTR(tlb_miss, RISCV_IOMMU_HPMEVENT_TLB_MISS),
> +	RISCV_IOMMU_PMU_EVENT_ATTR(ddt_walks, RISCV_IOMMU_HPMEVENT_DD_WALK),
> +	RISCV_IOMMU_PMU_EVENT_ATTR(pdt_walks, RISCV_IOMMU_HPMEVENT_PD_WALK),
> +	RISCV_IOMMU_PMU_EVENT_ATTR(s_vs_pt_walks, RISCV_IOMMU_HPMEVENT_S_VS_WALKS),
> +	RISCV_IOMMU_PMU_EVENT_ATTR(g_pt_walks, RISCV_IOMMU_HPMEVENT_G_WALKS),
> +	NULL,
> +};
> +
> +static const struct attribute_group riscv_iommu_pmu_events_group = {
> +	.name = "events",
> +	.attrs = riscv_iommu_pmu_events,
> +};
> +
> +/* cpumask */
> +static ssize_t riscv_iommu_cpumask_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(dev_get_drvdata(dev));
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->on_cpu));
> +}
> +
> +static struct device_attribute riscv_iommu_cpumask_attr =
> +	__ATTR(cpumask, 0444, riscv_iommu_cpumask_show, NULL);
> +
> +static struct attribute *riscv_iommu_cpumask_attrs[] = {
> +	&riscv_iommu_cpumask_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group riscv_iommu_pmu_cpumask_group = {
> +	.attrs = riscv_iommu_cpumask_attrs,
> +};
> +
> +static const struct attribute_group *riscv_iommu_pmu_attr_grps[] = {
> +	&riscv_iommu_pmu_cpumask_group,
> +	&riscv_iommu_pmu_format_group,
> +	&riscv_iommu_pmu_events_group,
> +	NULL,
> +};
> +
> +/* PMU Operations */
> +static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu *pmu, u32 idx,
> +					u64 value)
> +{
> +	u64 counter_mask = idx ? pmu->event_cntr_mask : pmu->cycle_cntr_mask;
> +
> +	writeq(value & counter_mask, pmu->reg + RISCV_IOMMU_REG_IOHPMCTR(idx));
> +}
> +
> +static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, u32 idx)
> +{
> +	u64 value, counter_mask = idx ? pmu->event_cntr_mask : pmu->cycle_cntr_mask;
> +
> +	/* Use readq to read counter would be imprecise on 32-bits system */
> +	value = readq(pmu->reg + RISCV_IOMMU_REG_IOHPMCTR(idx)) & counter_mask;
As stated in the RISC-V IOMMU Specification, Chapter 6:
  Whether an 8-byte access to an IOMMU register is single-copy atomic is
  UNSPECIFIED, and such an access may appear, internally to the IOMMU,
  as if two separate 4-byte accesses — first to the high half and second
  to the low half — were performed.

Therefore, the atomicity of 64-bit MMIO accesses is UNSPECIFIED and
not clearly defined in the current ratified RISC-V IOMMU
specification. To handle this correctly, the Linux RISC-V IOMMU driver
should fall back to 32-bit MMIO accesses when reading 64-bit HPM counter
register.

Additionally, David Laight has proposed an optimization using the
hi-lo-hi read pattern with multiple 32-bit MMIO accesses [1], no retry
loop.

[1]: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> +
> +	/* The bit 63 of cycle counter (i.e., idx == 0) is OF bit */
> +	return idx ? value : (value & ~RISCV_IOMMU_IOHPMCYCLES_OF);
> +}
> +
> +static bool is_cycle_event(u64 event)
> +{
> +	return event == RISCV_IOMMU_HPMEVENT_CYCLE;
> +}
> +
> +static void riscv_iommu_pmu_set_event(struct riscv_iommu_pmu *pmu, u32 idx,
> +				      u64 value)
> +{
> +	/* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
> +	if (is_cycle_event(value))
> +		return;
> +
> +	/* Event counter start from idx 1 */
> +	writeq(FIELD_GET(RISCV_IOMMU_IOHPMEVT_EVENT, value),
> +	       pmu->reg + RISCV_IOMMU_REG_IOHPMEVT(idx - 1));
> +}
> +
> +static void riscv_iommu_pmu_enable_counter(struct riscv_iommu_pmu *pmu, u32 idx)
> +{
> +	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> +	u32 value = readl(addr);
> +
> +	writel(value & ~BIT(idx), addr);
> +}
> +
> +static void riscv_iommu_pmu_disable_counter(struct riscv_iommu_pmu *pmu, u32 idx)
> +{
> +	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> +	u32 value = readl(addr);
> +
> +	writel(value | BIT(idx), addr);
> +}
> +
> +static void riscv_iommu_pmu_start_all(struct riscv_iommu_pmu *pmu)
> +{
> +	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> +	u32 used_cntr = 0;
> +
> +	/* The performance-monitoring counter inhibits is a 32-bit WARL register */
> +	bitmap_to_arr32(&used_cntr, pmu->used_counters, pmu->num_counters);
> +
> +	writel(~used_cntr, addr);
> +}
> +
> +static void riscv_iommu_pmu_stop_all(struct riscv_iommu_pmu *pmu)
> +{
> +	writel(GENMASK_ULL(pmu->num_counters - 1, 0),
> +	       pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH);
> +}
> +
> +/* PMU APIs */
> +static void riscv_iommu_pmu_set_period(struct perf_event *event)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 counter_mask = hwc->idx ? pmu->event_cntr_mask : pmu->cycle_cntr_mask;
> +	u64 period;
> +
> +	/*
> +	 * Limit the maximum period to prevent the counter value
> +	 * from overtaking the one we are about to program.
> +	 * In effect we are reducing max_period to account for
> +	 * interrupt latency (and we are being very conservative).
> +	 */
> +	period = counter_mask >> 1;
> +	riscv_iommu_pmu_set_counter(pmu, hwc->idx, period);
> +	local64_set(&hwc->prev_count, period);
> +}
> +
> +static int riscv_iommu_pmu_event_init(struct perf_event *event)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct perf_event *sibling;
> +	int total_event_counters = pmu->num_counters - 1;
> +	int counters = 0;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (hwc->sample_period)
> +		return -EOPNOTSUPP;
> +
> +	if (event->cpu < 0)
> +		return -EOPNOTSUPP;
> +
> +	event->cpu = pmu->on_cpu;
> +
> +	hwc->idx = -1;
> +	hwc->config = event->attr.config;
> +
> +	if (event->group_leader == event)
> +		return 0;
> +
> +	if (is_cycle_event(get_event(event->group_leader)))
> +		if (++counters > total_event_counters)
> +			return -EINVAL;
> +
> +	for_each_sibling_event(sibling, event->group_leader) {
> +		if (is_cycle_event(get_event(sibling)))
> +			continue;
> +
> +		if (sibling->pmu != event->pmu && !is_software_event(sibling))
> +			return -EINVAL;
> +
> +		if (++counters > total_event_counters)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void riscv_iommu_pmu_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	u64 delta, prev, now;
> +	u32 idx = hwc->idx;
> +	u64 counter_mask = idx ? pmu->event_cntr_mask : pmu->cycle_cntr_mask;
> +
> +	do {
> +		prev = local64_read(&hwc->prev_count);
> +		now = riscv_iommu_pmu_get_counter(pmu, idx);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
> +
> +	delta = (now - prev) & counter_mask;
> +	local64_add(delta, &event->count);
> +}
> +
> +static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
> +		return;
> +
> +	if (flags & PERF_EF_RELOAD)
> +		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
> +
> +	hwc->state = 0;
> +	riscv_iommu_pmu_set_period(event);
> +	riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
> +	riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
> +
> +	perf_event_update_userpage(event);
> +}
> +
> +static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +	if (hwc->state & PERF_HES_STOPPED)
> +		return;
> +
> +	riscv_iommu_pmu_disable_counter(pmu, idx);
> +
> +	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE))
> +		riscv_iommu_pmu_update(event);
> +
> +	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +}
> +
> +static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	unsigned int num_counters = pmu->num_counters;
> +	int idx;
> +
> +	/* Reserve index zero for iohpmcycles */
> +	if (is_cycle_event(get_event(event)))
> +		idx = 0;
> +	else
> +		idx = find_next_zero_bit(pmu->used_counters, num_counters, 1);
> +
> +	/* All event counters or cycle counter are in use */
> +	if (idx == num_counters || pmu->events[idx])
> +		return -EAGAIN;
> +
> +	set_bit(idx, pmu->used_counters);
> +
> +	pmu->events[idx] = event;
> +	hwc->idx = idx;
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	local64_set(&hwc->prev_count, 0);
> +
> +	if (flags & PERF_EF_START)
> +		riscv_iommu_pmu_start(event, flags);
> +
> +	/* Propagate changes to the userspace mapping. */
> +	perf_event_update_userpage(event);
> +
> +	return 0;
> +}
> +
> +static void riscv_iommu_pmu_read(struct perf_event *event)
> +{
> +	riscv_iommu_pmu_update(event);
> +}
> +
> +static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +	riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> +	pmu->events[idx] = NULL;
> +	clear_bit(idx, pmu->used_counters);
> +
> +	perf_event_update_userpage(event);
> +}
> +
> +static int riscv_iommu_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct riscv_iommu_pmu *iommu_pmu;
> +
> +	iommu_pmu = hlist_entry_safe(node, struct riscv_iommu_pmu, node);
> +
> +	if (iommu_pmu->on_cpu == -1)
> +		iommu_pmu->on_cpu = cpu;
> +
> +	return 0;
> +}
> +
> +static int riscv_iommu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct riscv_iommu_pmu *iommu_pmu;
> +	unsigned int target_cpu;
> +
> +	iommu_pmu = hlist_entry_safe(node, struct riscv_iommu_pmu, node);
> +
> +	if (cpu != iommu_pmu->on_cpu)
> +		return 0;
> +
> +	iommu_pmu->on_cpu = -1;
> +
> +	target_cpu = cpumask_any_but(cpu_online_mask, cpu);
> +	if (target_cpu >= nr_cpu_ids)
> +		return 0;
> +
> +	perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target_cpu);
> +	iommu_pmu->on_cpu = target_cpu;
> +
> +	return 0;
> +}
> +
> +static irqreturn_t riscv_iommu_pmu_handle_irq(struct riscv_iommu_pmu *pmu)
> +{
> +	u32 ovf = readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
> +	int idx;
> +
> +	if (!ovf)
> +		return IRQ_NONE;
> +
> +	riscv_iommu_pmu_stop_all(pmu);
> +
> +	for_each_set_bit(idx, (unsigned long *)&ovf, pmu->num_counters) {
> +		struct perf_event *event = pmu->events[idx];
> +
> +		if (WARN_ON_ONCE(!event))
> +			continue;
> +
> +		riscv_iommu_pmu_update(event);
> +		riscv_iommu_pmu_set_period(event);
> +	}
> +
> +	riscv_iommu_pmu_start_all(pmu);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
> +{
> +	struct riscv_iommu_pmu *pmu = (struct riscv_iommu_pmu *)dev_id;
> +	irqreturn_t ret;
> +
> +	/* Check whether this interrupt is for PMU */
> +	if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IOMMU_IPSR_PMIP))
> +		return IRQ_NONE;
> +
> +	/* Process PMU IRQ */
> +	ret = riscv_iommu_pmu_handle_irq(pmu);
> +
> +	/* Clear performance monitoring interrupt pending bit */
> +	writel_relaxed(RISCV_IOMMU_IPSR_PMIP, pmu->reg + RISCV_IOMMU_REG_IPSR);
> +
> +	return ret;
> +}
> +
> +static unsigned int riscv_iommu_pmu_get_irq_num(struct riscv_iommu_device *iommu)
> +{
> +	/* Reuse ICVEC.CIV mask for all interrupt vectors mapping */
> +	int vec = (iommu->icvec >> (RISCV_IOMMU_IPSR_PMIP * 4)) & RISCV_IOMMU_ICVEC_CIV;
> +
> +	return iommu->irqs[vec];
> +}
> +
> +static int riscv_iommu_pmu_request_irq(struct riscv_iommu_device *iommu,
> +				       struct riscv_iommu_pmu *pmu)
> +{
> +	unsigned int irq = riscv_iommu_pmu_get_irq_num(iommu);
> +
> +	/*
> +	 * Set the IRQF_ONESHOT flag because this IRQ can be shared with
> +	 * other threaded IRQs by other queues.
> +	 */
> +	return devm_request_irq(iommu->dev, irq, riscv_iommu_pmu_irq_handler,
> +				IRQF_ONESHOT | IRQF_SHARED, dev_name(iommu->dev), pmu);
> +}
> +
> +static void riscv_iommu_pmu_free_irq(struct riscv_iommu_device *iommu,
> +				     struct riscv_iommu_pmu *pmu)
> +{
> +	unsigned int irq = riscv_iommu_pmu_get_irq_num(iommu);
> +
> +	free_irq(irq, pmu);
> +}
> +
> +static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
> +				 const struct auxiliary_device_id *id)
> +{
> +	struct  riscv_iommu_device *iommu_dev = dev_get_platdata(&auxdev->dev);
> +	struct riscv_iommu_pmu *iommu_pmu;
> +	void __iomem *addr;
> +	char *name;
> +	int ret;
> +
> +	iommu_pmu = devm_kzalloc(&auxdev->dev, sizeof(*iommu_pmu), GFP_KERNEL);
> +	if (!iommu_pmu)
> +		return -ENOMEM;
> +
> +	iommu_pmu->reg = iommu_dev->reg;
> +
> +	/* Counter number and width are hardware-implemented. Detect them by write 1s */
> +	addr = iommu_pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> +	writel(RISCV_IOMMU_IOCOUNTINH_HPM, addr);
> +	iommu_pmu->num_counters = hweight32(readl(addr));
> +
> +	addr = iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
> +	writeq(RISCV_IOMMU_IOHPMCYCLES_COUNTER, addr);
> +	iommu_pmu->cycle_cntr_mask = readq(addr);
> +
> +	/* Assume the width of all event counters are the same */
> +	addr = iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCTR_BASE;
> +	writeq(RISCV_IOMMU_IOHPMCTR_COUNTER, addr);
> +	iommu_pmu->event_cntr_mask = readq(addr);
> +
> +	iommu_pmu->pmu = (struct pmu) {
> +		.module		= THIS_MODULE,
> +		.parent		= &auxdev->dev,
> +		.task_ctx_nr	= perf_invalid_context,
> +		.event_init	= riscv_iommu_pmu_event_init,
> +		.add		= riscv_iommu_pmu_add,
> +		.del		= riscv_iommu_pmu_del,
> +		.start		= riscv_iommu_pmu_start,
> +		.stop		= riscv_iommu_pmu_stop,
> +		.read		= riscv_iommu_pmu_read,
> +		.attr_groups	= riscv_iommu_pmu_attr_grps,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +	};
> +
> +	auxiliary_set_drvdata(auxdev, iommu_pmu);
> +
> +	name = devm_kasprintf(&auxdev->dev, GFP_KERNEL,
> +			      "riscv_iommu_pmu_%s", dev_name(iommu_dev->dev));
> +	if (!name) {
> +		dev_err(&auxdev->dev, "Failed to create name riscv_iommu_pmu_%s\n",
> +			dev_name(iommu_dev->dev));
> +		return -ENOMEM;
> +	}
> +
> +	/* Bind all events to the same cpu context to avoid race enabling */
> +	iommu_pmu->on_cpu = raw_smp_processor_id();
> +
> +	ret = cpuhp_state_add_instance_nocalls(cpuhp_state, &iommu_pmu->node);
> +	if (ret) {
> +		dev_err(&auxdev->dev, "Failed to register hotplug %s: %d\n", name, ret);
> +		return ret;
> +	}
> +
> +	ret = riscv_iommu_pmu_request_irq(iommu_dev, iommu_pmu);
> +	if (ret) {
> +		dev_err(&auxdev->dev, "Failed to request irq %s: %d\n", name, ret);
> +		goto err_cpuhp_remove;
> +	}
> +
> +	ret = perf_pmu_register(&iommu_pmu->pmu, name, -1);
> +	if (ret) {
> +		dev_err(&auxdev->dev, "Failed to registe %s: %d\n", name, ret);
> +		goto err_free_irq;
> +	}
> +
> +	dev_info(&auxdev->dev, "%s: Registered with %d counters\n",
> +		 name, iommu_pmu->num_counters);
> +
> +	return 0;
> +
> +err_free_irq:
> +	riscv_iommu_pmu_free_irq(iommu_dev, iommu_pmu);
> +err_cpuhp_remove:
> +	cpuhp_state_remove_instance_nocalls(cpuhp_state, &iommu_pmu->node);
> +	return ret;
> +}
> +
> +static const struct auxiliary_device_id riscv_iommu_pmu_id_table[] = {
> +	{ .name = "iommu.pmu" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, riscv_iommu_pmu_id_table);
> +
> +static struct auxiliary_driver iommu_pmu_driver = {
> +	.probe		= riscv_iommu_pmu_probe,
> +	.id_table	= riscv_iommu_pmu_id_table,
> +};
> +
> +static int __init riscv_iommu_pmu_init(void)
> +{
> +	int ret;
> +
> +	cpuhp_state = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +					      "perf/riscv/iommu:online",
> +					      riscv_iommu_pmu_online_cpu,
> +					      riscv_iommu_pmu_offline_cpu);
> +	if (cpuhp_state < 0)
> +		return cpuhp_state;
> +
> +	ret = auxiliary_driver_register(&iommu_pmu_driver);
> +	if (ret)
> +		cpuhp_remove_multi_state(cpuhp_state);
> +
> +	return ret;
> +}
> +module_init(riscv_iommu_pmu_init);
> +
> +MODULE_DESCRIPTION("RISC-V IOMMU PMU");
> +MODULE_LICENSE("GPL");
> -- 
> 2.43.7
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
