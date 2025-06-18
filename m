Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D66827E7D8
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750236280; cv=none; b=knBAfw4QPZ2e5YRMTByDQmkBO3VRIIre+LEvL7e/kNhgGga0W5yiqIKhuPmZtK79gj0i2qGN8AoI6c27TDVocHd/tekx/UGs9oUfsEzVO55uDP4vN6OlIkcRV+zhw8fZBQf+0G1WgCXtN0OuMS66DwCE6J2AfSJLOiuNdauNvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750236280; c=relaxed/simple;
	bh=GgsOSjDucAOFL8g36UkI+SHwwPvztM8ecCt2Z2kD378=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glrFjXkHTT0WRAAR0jxq2tQsnufKOcQUqSlsdh9HGDofT3ewakTsn+9HUujcZo0MyksZdxoU9YITT+/iWWuLspAfefS5iBprQyCSTn04PjFc87p3JFFBXrpT30rIPT9kEwMpZh4PUWZcntugMciva069IWucORXTbKV7nieRSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A10A113E;
	Wed, 18 Jun 2025 01:44:17 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9B873F66E;
	Wed, 18 Jun 2025 01:44:34 -0700 (PDT)
Date: Wed, 18 Jun 2025 09:44:29 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: acme@kernel.org, leo.yan@linaro.org, james.clark@linaro.org,
	namhyung@kernel.org, shameerali.kolothum.thodi@huawei.com,
	will@kernel.org, catalin.marinas@arm.com, jolsa@kernel.org,
	irogers@google.com, peterz@infradead.org, mingo@redhat.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jonathan.cameron@huawei.com,
	linuxarm@huawei.com, prime.zeng@hisilicon.com,
	yangyicong@hisilicon.com
Subject: Re: [PATCH] tools/headers: Workaround the copy coherency issue of
 arm64's cputype.h
Message-ID: <aFJ8bQh_30JMzF_-@J2N7QTR9R3>
References: <20250618083017.62879-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618083017.62879-1-yangyicong@huawei.com>

On Wed, Jun 18, 2025 at 04:30:17PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> arch/arm64/include/asm/cputype.h is copied from arch/arm64 and used
> by perf to parsing vendor specific SPE packets according to the MIDR.
> The header diverge after errata management handling for VM live
> migration merged [1] so a direct copy will lead to the build failure
> of perf [2]: is_midr_in_range_list() is used but the implementation
> has been changed and moved out of the kernel header.

The build failure described above manifests *IF AND WHEN* we update the
userspace header with a copy of the kernel header, and there's no need
to do so.

> Workaround this issue by maintaining is_perf_midr_in_range_list()
> in the userspace. Temporarily include the kernel headers for the
> MIDR definitions, a later refactor will generate the MIDR header
> dynamically similar to how we handle the sysreg-defs.h in userspace.
> Remove cputype.h from check-headers.sh.

Sorry, but NAK to this. As-is, this means that any change to the
kernel-internal asm/cputype.h is liable to break the userspace tool, and
placing a burden on whoever modifies the kernel-internal headers.

The simple solution for now is to *NOT* update the userspace header, and
to stop warning that this has diverged from the kernel header. If we
want to improve matters, we should split things appropriately for
sharing.

Mark.

> [1] https://lore.kernel.org/all/20250221140229.12588-1-shameerali.kolothum.thodi@huawei.com/
> [2] https://lore.kernel.org/lkml/aEyGg98z-MkcClXY@x1/#t
> Suggested-by: Leo Yan <leo.yan@arm.com>
> [https://lore.kernel.org/linux-arm-kernel/20250617141810.GB794930@e132581.arm.com/]
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  tools/arch/arm64/include/asm/cputype.h | 316 +------------------------
>  tools/perf/check-headers.sh            |   1 -
>  tools/perf/util/arm-spe.c              |   4 +-
>  3 files changed, 14 insertions(+), 307 deletions(-)
> 
> diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
> index 9a5d85cfd1fb..7be07ba0ce7a 100644
> --- a/tools/arch/arm64/include/asm/cputype.h
> +++ b/tools/arch/arm64/include/asm/cputype.h
> @@ -2,314 +2,22 @@
>  /*
>   * Copyright (C) 2012 ARM Ltd.
>   */
> -#ifndef __ASM_CPUTYPE_H
> -#define __ASM_CPUTYPE_H
> +#ifndef __PERF_ASM_CPUTYPE_H
> +#define __PERF_ASM_CPUTYPE_H
>  
> -#define INVALID_HWID		ULONG_MAX
> +#include "../../../../../arch/arm64/include/asm/cputype.h"
>  
> -#define MPIDR_UP_BITMASK	(0x1 << 30)
> -#define MPIDR_MT_BITMASK	(0x1 << 24)
> -#define MPIDR_HWID_BITMASK	UL(0xff00ffffff)
> -
> -#define MPIDR_LEVEL_BITS_SHIFT	3
> -#define MPIDR_LEVEL_BITS	(1 << MPIDR_LEVEL_BITS_SHIFT)
> -#define MPIDR_LEVEL_MASK	((1 << MPIDR_LEVEL_BITS) - 1)
> -
> -#define MPIDR_LEVEL_SHIFT(level) \
> -	(((1 << level) >> 1) << MPIDR_LEVEL_BITS_SHIFT)
> -
> -#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
> -	((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)
> -
> -#define MIDR_REVISION_MASK	0xf
> -#define MIDR_REVISION(midr)	((midr) & MIDR_REVISION_MASK)
> -#define MIDR_PARTNUM_SHIFT	4
> -#define MIDR_PARTNUM_MASK	(0xfff << MIDR_PARTNUM_SHIFT)
> -#define MIDR_PARTNUM(midr)	\
> -	(((midr) & MIDR_PARTNUM_MASK) >> MIDR_PARTNUM_SHIFT)
> -#define MIDR_ARCHITECTURE_SHIFT	16
> -#define MIDR_ARCHITECTURE_MASK	(0xf << MIDR_ARCHITECTURE_SHIFT)
> -#define MIDR_ARCHITECTURE(midr)	\
> -	(((midr) & MIDR_ARCHITECTURE_MASK) >> MIDR_ARCHITECTURE_SHIFT)
> -#define MIDR_VARIANT_SHIFT	20
> -#define MIDR_VARIANT_MASK	(0xf << MIDR_VARIANT_SHIFT)
> -#define MIDR_VARIANT(midr)	\
> -	(((midr) & MIDR_VARIANT_MASK) >> MIDR_VARIANT_SHIFT)
> -#define MIDR_IMPLEMENTOR_SHIFT	24
> -#define MIDR_IMPLEMENTOR_MASK	(0xffU << MIDR_IMPLEMENTOR_SHIFT)
> -#define MIDR_IMPLEMENTOR(midr)	\
> -	(((midr) & MIDR_IMPLEMENTOR_MASK) >> MIDR_IMPLEMENTOR_SHIFT)
> -
> -#define MIDR_CPU_MODEL(imp, partnum) \
> -	((_AT(u32, imp)		<< MIDR_IMPLEMENTOR_SHIFT) | \
> -	(0xf			<< MIDR_ARCHITECTURE_SHIFT) | \
> -	((partnum)		<< MIDR_PARTNUM_SHIFT))
> -
> -#define MIDR_CPU_VAR_REV(var, rev) \
> -	(((var)	<< MIDR_VARIANT_SHIFT) | (rev))
> -
> -#define MIDR_CPU_MODEL_MASK (MIDR_IMPLEMENTOR_MASK | MIDR_PARTNUM_MASK | \
> -			     MIDR_ARCHITECTURE_MASK)
> -
> -#define ARM_CPU_IMP_ARM			0x41
> -#define ARM_CPU_IMP_APM			0x50
> -#define ARM_CPU_IMP_CAVIUM		0x43
> -#define ARM_CPU_IMP_BRCM		0x42
> -#define ARM_CPU_IMP_QCOM		0x51
> -#define ARM_CPU_IMP_NVIDIA		0x4E
> -#define ARM_CPU_IMP_FUJITSU		0x46
> -#define ARM_CPU_IMP_HISI		0x48
> -#define ARM_CPU_IMP_APPLE		0x61
> -#define ARM_CPU_IMP_AMPERE		0xC0
> -#define ARM_CPU_IMP_MICROSOFT		0x6D
> -
> -#define ARM_CPU_PART_AEM_V8		0xD0F
> -#define ARM_CPU_PART_FOUNDATION		0xD00
> -#define ARM_CPU_PART_CORTEX_A57		0xD07
> -#define ARM_CPU_PART_CORTEX_A72		0xD08
> -#define ARM_CPU_PART_CORTEX_A53		0xD03
> -#define ARM_CPU_PART_CORTEX_A73		0xD09
> -#define ARM_CPU_PART_CORTEX_A75		0xD0A
> -#define ARM_CPU_PART_CORTEX_A35		0xD04
> -#define ARM_CPU_PART_CORTEX_A55		0xD05
> -#define ARM_CPU_PART_CORTEX_A76		0xD0B
> -#define ARM_CPU_PART_NEOVERSE_N1	0xD0C
> -#define ARM_CPU_PART_CORTEX_A77		0xD0D
> -#define ARM_CPU_PART_NEOVERSE_V1	0xD40
> -#define ARM_CPU_PART_CORTEX_A78		0xD41
> -#define ARM_CPU_PART_CORTEX_A78AE	0xD42
> -#define ARM_CPU_PART_CORTEX_X1		0xD44
> -#define ARM_CPU_PART_CORTEX_A510	0xD46
> -#define ARM_CPU_PART_CORTEX_A520	0xD80
> -#define ARM_CPU_PART_CORTEX_A710	0xD47
> -#define ARM_CPU_PART_CORTEX_A715	0xD4D
> -#define ARM_CPU_PART_CORTEX_X2		0xD48
> -#define ARM_CPU_PART_NEOVERSE_N2	0xD49
> -#define ARM_CPU_PART_CORTEX_A78C	0xD4B
> -#define ARM_CPU_PART_CORTEX_X1C		0xD4C
> -#define ARM_CPU_PART_CORTEX_X3		0xD4E
> -#define ARM_CPU_PART_NEOVERSE_V2	0xD4F
> -#define ARM_CPU_PART_CORTEX_A720	0xD81
> -#define ARM_CPU_PART_CORTEX_X4		0xD82
> -#define ARM_CPU_PART_NEOVERSE_V3	0xD84
> -#define ARM_CPU_PART_CORTEX_X925	0xD85
> -#define ARM_CPU_PART_CORTEX_A725	0xD87
> -#define ARM_CPU_PART_NEOVERSE_N3	0xD8E
> -
> -#define APM_CPU_PART_XGENE		0x000
> -#define APM_CPU_VAR_POTENZA		0x00
> -
> -#define CAVIUM_CPU_PART_THUNDERX	0x0A1
> -#define CAVIUM_CPU_PART_THUNDERX_81XX	0x0A2
> -#define CAVIUM_CPU_PART_THUNDERX_83XX	0x0A3
> -#define CAVIUM_CPU_PART_THUNDERX2	0x0AF
> -/* OcteonTx2 series */
> -#define CAVIUM_CPU_PART_OCTX2_98XX	0x0B1
> -#define CAVIUM_CPU_PART_OCTX2_96XX	0x0B2
> -#define CAVIUM_CPU_PART_OCTX2_95XX	0x0B3
> -#define CAVIUM_CPU_PART_OCTX2_95XXN	0x0B4
> -#define CAVIUM_CPU_PART_OCTX2_95XXMM	0x0B5
> -#define CAVIUM_CPU_PART_OCTX2_95XXO	0x0B6
> -
> -#define BRCM_CPU_PART_BRAHMA_B53	0x100
> -#define BRCM_CPU_PART_VULCAN		0x516
> -
> -#define QCOM_CPU_PART_FALKOR_V1		0x800
> -#define QCOM_CPU_PART_FALKOR		0xC00
> -#define QCOM_CPU_PART_KRYO		0x200
> -#define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
> -#define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
> -#define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
> -#define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
> -#define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
> -
> -#define NVIDIA_CPU_PART_DENVER		0x003
> -#define NVIDIA_CPU_PART_CARMEL		0x004
> -
> -#define FUJITSU_CPU_PART_A64FX		0x001
> -
> -#define HISI_CPU_PART_TSV110		0xD01
> -#define HISI_CPU_PART_HIP12		0xD06
> -
> -#define APPLE_CPU_PART_M1_ICESTORM	0x022
> -#define APPLE_CPU_PART_M1_FIRESTORM	0x023
> -#define APPLE_CPU_PART_M1_ICESTORM_PRO	0x024
> -#define APPLE_CPU_PART_M1_FIRESTORM_PRO	0x025
> -#define APPLE_CPU_PART_M1_ICESTORM_MAX	0x028
> -#define APPLE_CPU_PART_M1_FIRESTORM_MAX	0x029
> -#define APPLE_CPU_PART_M2_BLIZZARD	0x032
> -#define APPLE_CPU_PART_M2_AVALANCHE	0x033
> -#define APPLE_CPU_PART_M2_BLIZZARD_PRO	0x034
> -#define APPLE_CPU_PART_M2_AVALANCHE_PRO	0x035
> -#define APPLE_CPU_PART_M2_BLIZZARD_MAX	0x038
> -#define APPLE_CPU_PART_M2_AVALANCHE_MAX	0x039
> -
> -#define AMPERE_CPU_PART_AMPERE1		0xAC3
> -#define AMPERE_CPU_PART_AMPERE1A	0xAC4
> -
> -#define MICROSOFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
> -
> -#define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
> -#define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
> -#define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
> -#define MIDR_CORTEX_A73 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A73)
> -#define MIDR_CORTEX_A75 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A75)
> -#define MIDR_CORTEX_A35 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A35)
> -#define MIDR_CORTEX_A55 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A55)
> -#define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
> -#define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
> -#define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
> -#define MIDR_NEOVERSE_V1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V1)
> -#define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
> -#define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
> -#define MIDR_CORTEX_X1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1)
> -#define MIDR_CORTEX_A510 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A510)
> -#define MIDR_CORTEX_A520 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A520)
> -#define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
> -#define MIDR_CORTEX_A715 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A715)
> -#define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
> -#define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
> -#define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
> -#define MIDR_CORTEX_X1C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1C)
> -#define MIDR_CORTEX_X3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X3)
> -#define MIDR_NEOVERSE_V2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V2)
> -#define MIDR_CORTEX_A720 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720)
> -#define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
> -#define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
> -#define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
> -#define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
> -#define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
> -#define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
> -#define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
> -#define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
> -#define MIDR_OCTX2_98XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_98XX)
> -#define MIDR_OCTX2_96XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_96XX)
> -#define MIDR_OCTX2_95XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XX)
> -#define MIDR_OCTX2_95XXN MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XXN)
> -#define MIDR_OCTX2_95XXMM MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XXMM)
> -#define MIDR_OCTX2_95XXO MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XXO)
> -#define MIDR_CAVIUM_THUNDERX2 MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX2)
> -#define MIDR_BRAHMA_B53 MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_BRAHMA_B53)
> -#define MIDR_BRCM_VULCAN MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_VULCAN)
> -#define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
> -#define MIDR_QCOM_FALKOR MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR)
> -#define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
> -#define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_GOLD)
> -#define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_SILVER)
> -#define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_SILVER)
> -#define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_GOLD)
> -#define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
> -#define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
> -#define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
> -#define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
> -#define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
> -#define MIDR_HISI_HIP12 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP12)
> -#define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
> -#define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
> -#define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
> -#define MIDR_APPLE_M1_FIRESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM_PRO)
> -#define MIDR_APPLE_M1_ICESTORM_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_MAX)
> -#define MIDR_APPLE_M1_FIRESTORM_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM_MAX)
> -#define MIDR_APPLE_M2_BLIZZARD MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD)
> -#define MIDR_APPLE_M2_AVALANCHE MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE)
> -#define MIDR_APPLE_M2_BLIZZARD_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_PRO)
> -#define MIDR_APPLE_M2_AVALANCHE_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_PRO)
> -#define MIDR_APPLE_M2_BLIZZARD_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_MAX)
> -#define MIDR_APPLE_M2_AVALANCHE_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_MAX)
> -#define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
> -#define MIDR_AMPERE1A MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1A)
> -#define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MICROSOFT_CPU_PART_AZURE_COBALT_100)
> -
> -/* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
> -#define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
> -#define MIDR_FUJITSU_ERRATUM_010001_MASK	(~MIDR_CPU_VAR_REV(1, 0))
> -#define TCR_CLEAR_FUJITSU_ERRATUM_010001	(TCR_NFD1 | TCR_NFD0)
> -
> -#ifndef __ASSEMBLY__
> -
> -#include <asm/sysreg.h>
> -
> -#define read_cpuid(reg)			read_sysreg_s(SYS_ ## reg)
> -
> -/*
> - * Represent a range of MIDR values for a given CPU model and a
> - * range of variant/revision values.
> - *
> - * @model	- CPU model as defined by MIDR_CPU_MODEL
> - * @rv_min	- Minimum value for the revision/variant as defined by
> - *		  MIDR_CPU_VAR_REV
> - * @rv_max	- Maximum value for the variant/revision for the range.
> - */
> -struct midr_range {
> -	u32 model;
> -	u32 rv_min;
> -	u32 rv_max;
> -};
> -
> -#define MIDR_RANGE(m, v_min, r_min, v_max, r_max)		\
> -	{							\
> -		.model = m,					\
> -		.rv_min = MIDR_CPU_VAR_REV(v_min, r_min),	\
> -		.rv_max = MIDR_CPU_VAR_REV(v_max, r_max),	\
> -	}
> -
> -#define MIDR_REV_RANGE(m, v, r_min, r_max) MIDR_RANGE(m, v, r_min, v, r_max)
> -#define MIDR_REV(m, v, r) MIDR_RANGE(m, v, r, v, r)
> -#define MIDR_ALL_VERSIONS(m) MIDR_RANGE(m, 0, 0, 0xf, 0xf)
> -
> -static inline bool midr_is_cpu_model_range(u32 midr, u32 model, u32 rv_min,
> -					   u32 rv_max)
> -{
> -	u32 _model = midr & MIDR_CPU_MODEL_MASK;
> -	u32 rv = midr & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);
> -
> -	return _model == model && rv >= rv_min && rv <= rv_max;
> -}
> -
> -static inline bool is_midr_in_range(u32 midr, struct midr_range const *range)
> -{
> -	return midr_is_cpu_model_range(midr, range->model,
> -				       range->rv_min, range->rv_max);
> -}
> -
> -static inline bool
> -is_midr_in_range_list(u32 midr, struct midr_range const *ranges)
> +static inline bool is_perf_midr_in_range_list(u32 midr,
> +					      struct midr_range const *ranges)
>  {
> -	while (ranges->model)
> -		if (is_midr_in_range(midr, ranges++))
> +	while (ranges->model) {
> +		if (midr_is_cpu_model_range(midr, ranges->model,
> +					    ranges->rv_min, ranges->rv_max))
>  			return true;
> -	return false;
> -}
> -
> -/*
> - * The CPU ID never changes at run time, so we might as well tell the
> - * compiler that it's constant.  Use this function to read the CPU ID
> - * rather than directly reading processor_id or read_cpuid() directly.
> - */
> -static inline u32 __attribute_const__ read_cpuid_id(void)
> -{
> -	return read_cpuid(MIDR_EL1);
> -}
> -
> -static inline u64 __attribute_const__ read_cpuid_mpidr(void)
> -{
> -	return read_cpuid(MPIDR_EL1);
> -}
> -
> -static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
> -{
> -	return MIDR_IMPLEMENTOR(read_cpuid_id());
> -}
> -
> -static inline unsigned int __attribute_const__ read_cpuid_part_number(void)
> -{
> -	return MIDR_PARTNUM(read_cpuid_id());
> -}
> +		ranges++;
> +	}
>  
> -static inline u32 __attribute_const__ read_cpuid_cachetype(void)
> -{
> -	return read_cpuid(CTR_EL0);
> +	return false;
>  }
> -#endif /* __ASSEMBLY__ */
>  
> -#endif
> +#endif /* __PERF_ASM_CPUTYPE_H */
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index e9fab20e9330..e47bd9940106 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -187,7 +187,6 @@ done
>  check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))" -I"^#include <linux/cfi_types.h>"'
>  check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
>  check arch/x86/include/asm/amd/ibs.h  '-I "^#include [<\"]\(asm/\)*msr-index.h"'
> -check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
>  check include/linux/unaligned.h '-I "^#include <linux/unaligned/packed_struct.h>" -I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnostic"'
>  check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
>  check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index d46e0cccac99..6b33d9ff055c 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -13,6 +13,7 @@
>  #include <linux/log2.h>
>  #include <linux/types.h>
>  #include <linux/zalloc.h>
> +#include <asm/cputype.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  
> @@ -34,7 +35,6 @@
>  #include "arm-spe-decoder/arm-spe-decoder.h"
>  #include "arm-spe-decoder/arm-spe-pkt-decoder.h"
>  
> -#include "../../arch/arm64/include/asm/cputype.h"
>  #define MAX_TIMESTAMP (~0ULL)
>  
>  #define is_ldst_op(op)		(!!((op) & ARM_SPE_OP_LDST))
> @@ -882,7 +882,7 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(data_source_handles); i++) {
> -		if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {
> +		if (is_perf_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {
>  			data_source_handles[i].ds_synth(record, data_src);
>  			return true;
>  		}
> -- 
> 2.24.0
> 
