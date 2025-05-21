Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8134725C71C
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823713; cv=none; b=sBklSGUJ9z4MQQXIvC/FY6WDNiaSdC+aHIxxuBra7IlGlU1+I/aMXszVxO758341LdhBgvrO/VAyE/RNXIbLc25c28Im53ENRxBVJxMC/Tt11lU3v/tNHX0YQgN5kLudEnpBmDwr2TCoogQR4UVEp7Pg6D3vH2uN0i91AmH2fc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823713; c=relaxed/simple;
	bh=GpHM5216gtHeopyfZEzQV2wEoq09UgcfrVqw31dY+Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ForDlHLPgbBGxazerb2YBYbBkrHTGRPAAwj/Yj72hyJPI4L+GXigH8JzIMsLNRH6ZLJ8bo0ZvcJgztegoy+dD/O7b/Jyk/zX852P/UcAJp/d3lKQ1jZdtJQLXqqvPeNbVIwD8+6zVlz8glrRMfHnuNOvmmJNoB946MkUAUpn7Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01C041515;
	Wed, 21 May 2025 03:34:57 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AE603F6A8;
	Wed, 21 May 2025 03:35:10 -0700 (PDT)
Date: Wed, 21 May 2025 11:35:08 +0100
From: Leo Yan <leo.yan@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: acme@kernel.org, namhyung@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, jolsa@kernel.org, john.g.garry@oracle.com,
	james.clark@linaro.org, leo.yan@linux.dev, irogers@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, jonathan.cameron@huawei.com,
	hejunhao3@huawei.com, linuxarm@huawei.com, wangyushan12@huawei.com,
	caijingtao@huawei.com, xueshan2@huawei.com,
	prime.zeng@hisilicon.com, yangyicong@hisilicon.com
Subject: Re: [PATCH v2 2/3] perf arm-spe: Add support for SPE Data Source
 packet on HiSilicon HIP12
Message-ID: <20250521103508.GA2565659@e132581.arm.com>
References: <20250425033845.57671-1-yangyicong@huawei.com>
 <20250425033845.57671-3-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425033845.57671-3-yangyicong@huawei.com>

On Fri, Apr 25, 2025 at 11:38:44AM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Add data source encoding for HiSilicon HIP12 and coresponding mapping
> to the perf's memory data source. This will help to synthesize the data
> and support upper layer tools like perf-mem and perf-c2c.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  tools/arch/arm64/include/asm/cputype.h        |  2 +
>  .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 ++++
>  tools/perf/util/arm-spe.c                     | 96 +++++++++++++++++++
>  3 files changed, 115 insertions(+)
> 
> diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
> index 488f8e751349..9a5d85cfd1fb 100644
> --- a/tools/arch/arm64/include/asm/cputype.h
> +++ b/tools/arch/arm64/include/asm/cputype.h
> @@ -129,6 +129,7 @@
>  #define FUJITSU_CPU_PART_A64FX		0x001
>  
>  #define HISI_CPU_PART_TSV110		0xD01
> +#define HISI_CPU_PART_HIP12		0xD06
>  
>  #define APPLE_CPU_PART_M1_ICESTORM	0x022
>  #define APPLE_CPU_PART_M1_FIRESTORM	0x023
> @@ -202,6 +203,7 @@
>  #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
>  #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
>  #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
> +#define MIDR_HISI_HIP12 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP12)
>  #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
>  #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
>  #define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 5d232188643b..881d9f29c138 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -82,6 +82,23 @@ enum arm_spe_ampereone_data_source {
>  	ARM_SPE_AMPEREONE_L2D                           = 0x9,
>  };
>  
> +enum arm_spe_hisi_hip_data_source {
> +	ARM_SPE_HISI_HIP_PEER_CPU		= 0,
> +	ARM_SPE_HISI_HIP_PEER_CPU_HITM		= 1,
> +	ARM_SPE_HISI_HIP_L3			= 2,
> +	ARM_SPE_HISI_HIP_L3_HITM		= 3,
> +	ARM_SPE_HISI_HIP_PEER_CLUSTER		= 4,
> +	ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM	= 5,
> +	ARM_SPE_HISI_HIP_REMOTE_SOCKET		= 6,
> +	ARM_SPE_HISI_HIP_REMOTE_SOCKET_HITM	= 7,
> +	ARM_SPE_HISI_HIP_LOCAL_MEM		= 8,
> +	ARM_SPE_HISI_HIP_REMOTE_MEM		= 9,
> +	ARM_SPE_HISI_HIP_NC_DEV			= 13,
> +	ARM_SPE_HISI_HIP_L2			= 16,
> +	ARM_SPE_HISI_HIP_L2_HITM		= 17,
> +	ARM_SPE_HISI_HIP_L1			= 18,
> +};
> +
>  struct arm_spe_record {
>  	enum arm_spe_sample_type type;
>  	int err;
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 2a9775649cc2..d46e0cccac99 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -571,6 +571,11 @@ static const struct midr_range ampereone_ds_encoding_cpus[] = {
>  	{},
>  };
>  
> +static const struct midr_range hisi_hip_ds_encoding_cpus[] = {
> +	MIDR_ALL_VERSIONS(MIDR_HISI_HIP12),
> +	{},
> +};
> +
>  static void arm_spe__sample_flags(struct arm_spe_queue *speq)
>  {
>  	const struct arm_spe_record *record = &speq->decoder->record;
> @@ -718,9 +723,100 @@ static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *re
>  	arm_spe__synth_data_source_common(&common_record, data_src);
>  }
>  
> +static void arm_spe__synth_data_source_hisi_hip(const struct arm_spe_record *record,
> +						union perf_mem_data_src *data_src)
> +{
> +	/* Use common synthesis method to handle store operations */
> +	if (record->op & ARM_SPE_OP_ST) {
> +		arm_spe__synth_data_source_common(record, data_src);
> +		return;
> +	}
> +
> +	switch (record->source) {
> +	case ARM_SPE_HISI_HIP_PEER_CPU:
> +		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		break;
> +	case ARM_SPE_HISI_HIP_PEER_CPU_HITM:
> +		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		break;
> +	case ARM_SPE_HISI_HIP_L3:
> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> +		break;
> +	case ARM_SPE_HISI_HIP_L3_HITM:
> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		break;
> +	case ARM_SPE_HISI_HIP_PEER_CLUSTER:
> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		break;
> +	case ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM:
> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		break;
> +	case ARM_SPE_HISI_HIP_REMOTE_SOCKET:
> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		break;
> +	case ARM_SPE_HISI_HIP_REMOTE_SOCKET_HITM:
> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		break;
> +	case ARM_SPE_HISI_HIP_LOCAL_MEM:
> +		data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		break;
> +	case ARM_SPE_HISI_HIP_REMOTE_MEM:
> +		data_src->mem_lvl = PERF_MEM_LVL_REM_RAM1 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> +		break;
> +	case ARM_SPE_HISI_HIP_NC_DEV:
> +		data_src->mem_lvl = PERF_MEM_LVL_IO | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_IO;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		break;
> +	case ARM_SPE_HISI_HIP_L2:
> +		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		break;
> +	case ARM_SPE_HISI_HIP_L2_HITM:
> +		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		break;
> +	case ARM_SPE_HISI_HIP_L1:
> +		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static const struct data_source_handle data_source_handles[] = {
>  	DS(common_ds_encoding_cpus, data_source_common),
>  	DS(ampereone_ds_encoding_cpus, data_source_ampereone),
> +	DS(hisi_hip_ds_encoding_cpus, data_source_hisi_hip),
>  };
>  
>  static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
> 
> -- 
> 2.24.0
> 
