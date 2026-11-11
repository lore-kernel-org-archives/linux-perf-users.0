Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418466;
	b=qMJdnt4AFzVDLa69kRNwB5ccog/UN1uty89xSQbHTilpQ8Peptk9trzBHScm/LMA3VvX
	 YGjd1Oz9tNZu4plZFp8B+blPvWChkh4kSuEL7IEkGQKtGFMOaQylS/xmlpWFzo/T66/H8
	 lAXbegzycbowBiaJhamquuF6yRzwsBPAxtt5ei/hC7r2jhzOn4qcJy1VIoWJj8xAF2crC
	 n9SW3b0aeTIfXAwoJIQfSNOYy7MPEEMeH+MelC6Ik6rJTjPzO7/lVkeu8synKJZ47BAsY
	 5RbnqiiKXWMmP+yffHx9OlNuPQW8f11E+zM3yfOfifIt57WSfilrfPL+EllMrPsGvdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418466;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uPqiu+ElU4cIICKoPtEjFRF5YoXaI3QeZNsern0wcRA=;
	b=qjxS3OwGpyzapVCZEl4PPmuz4P4M53dwoO/yixL/pGUkfvI91yYEpF5/AilT5ptWt9Da
	 8zRAEKZvUFeFeiijmuJFIcCHOVNZy4uiB5z0GiBTwu8DTF90hmDBdmzXtJOb7ntBEFwEY
	 5B+C1VG9dUKeUR6VhT1Np70FzFc2Nv8QdLKCl+Bv7xfZjx4hgUhdWCKr4e89RPbiNebkw
	 SK3Al9mn54Lwlr2rT7SL4cjoOGhjhRWlp+/0171O9mT1XwGwGxU9yXcqJr6VCdKs39X05
	 xCgZpnJhGHuormcHtsdP9Akyq9xgPB8on4ZBblEHXo+Fk6wnrGC+ACofXpirT/1gkwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VmalHv2M;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60976606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60976606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VmalHv2M
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E4A31576;
	Wed, 11 Nov 2026 09:34:22 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC43B3F632;
	Wed, 11 Nov 2026 09:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794418465; bh=frQdcUhueWWzIbR9Oz8s0QL9CPkNt6BylYNzxsYqnHM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=VmalHv2MEFAlvYotxBWyNb5nWPMltG0c0GKC+tKy8FxcJmRcihihtvBMUEwHt3Pj5
	 QSzlax2bALWVO5jYfq0t8ibvDrGUqeqJo7e8wDqY7EJA2QS0+54NesiijJK8a1AdwV
	 vQYJzqAFypYR0QyYjxn69GYfWDBRsM7rfcnQ4m7g=
Message-ID: <dee315cb-9218-4da6-913e-8eb946ed2d68@arm.com>
Date: Wed, 11 Nov 2026 17:34:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: Process subdirectory Makefiles unconditionally
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <4b2e518499270b2a6cab3e04a1123458d82d2759.1793990977.git.robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <4b2e518499270b2a6cab3e04a1123458d82d2759.1793990977.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2026 6:49 pm, Robin Murphy wrote:
> Our subdirectories here are purely for file-level organisation rather
> than any particular build structure, and everything in the Makefiles
> is already conditional on the appropriate config options. Plus they're
> not exactly big and complex, so for simplicity let's just drop the
> top-level conditions.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/perf/Makefile | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index eb8a022dad9a..8c3146c604ce 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> +obj-y += amlogic/ arm_cspmu/ hisilicon/
>   obj-$(CONFIG_ARM_CCI_PMU) += arm-cci.o
>   obj-$(CONFIG_ARM_CCN) += arm-ccn.o
>   obj-$(CONFIG_ARM_CMN) += arm-cmn.o
> @@ -14,7 +15,6 @@ obj-$(CONFIG_ARM_SMMU_V3_PMU) += arm_smmuv3_pmu.o
>   obj-$(CONFIG_FSL_IMX8_DDR_PMU) += fsl_imx8_ddr_perf.o
>   obj-$(CONFIG_FSL_IMX9_DDR_PMU) += fsl_imx9_ddr_perf.o
>   obj-$(CONFIG_FUJITSU_UNCORE_PMU) += fujitsu_uncore_pmu.o
> -obj-$(CONFIG_HISI_PMU) += hisilicon/

Ha, in fact this might technically fix a bug already, since Sashiko's 
hilarious internal monologue inadvertently highlights that HNS3_PMU can 
be selected without HISI_PMU, but currently wouldn't be built if so.

Robin.

>   obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
>   obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
>   obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
> @@ -32,8 +32,6 @@ obj-$(CONFIG_MARVELL_PEM_PMU) += marvell_pem_pmu.o
>   obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
>   obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
>   obj-$(CONFIG_DWC_PCIE_PMU) += dwc_pcie_pmu.o
> -obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
> -obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
>   obj-$(CONFIG_CXL_PMU) += cxl_pmu.o
>   obj-$(CONFIG_NVIDIA_TEGRA410_CMEM_LATENCY_PMU) += nvidia_t410_cmem_latency_pmu.o
>   obj-$(CONFIG_NVIDIA_TEGRA410_C2C_PMU) += nvidia_t410_c2c_pmu.o

