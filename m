Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C7732AAA8;
	Thu, 28 May 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953314; cv=none; b=YiXNpb6iidbAshhba/FI8i+ZxZqdwZbVuntDhL/I06eDXB2nhDeeunmYotDJPfqmXNSyk3K3t4j0TRJtwyMpQ1ehe2WPGnnOz6nmsyxliwzgUGstt5Qf7502MdxWmZMXTNSH5f7e5uwcZk7lajMn6BxT9aL9yXsbaLgGEss+zZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953314; c=relaxed/simple;
	bh=bTpkOgWsu469H7oaGBOSi88Y7S9zXSuEy6WKbvBX4jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbo2edDWjS/esxropmzS7BeQtLOFIQtSs2scVXWqI53Wyv5XRy57nhlgIepg06+fzkSW1wDkGJ2z7NkiJTJTwJe7lBJS+Ttz3t8DFUYdWxHLoefvMHiU4ADi/ZLa7zQQFd1DZC/uFEbUs+yJWuWH2QtChFOb9Mg48B2FdkzY4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc5001a5b4667a2accba1.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:1a5b:4667:a2ac:cba1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A802B1C59BB;
	Thu, 28 May 2026 09:28:31 +0200 (CEST)
Date: Thu, 28 May 2026 09:28:30 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, x86@kernel.org, 
	dave.hansen@linux.intel.com, tglx@kernel.org, bp@alien8.de, hpa@zytor.com, 
	iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, sandipan.das@amd.com
Subject: Re: [PATCH] x86/events/amd/iommu: Fix cpumask of IOMMU events
Message-ID: <ahfujybXeL-GHNmr@8bytes.org>
References: <20260517114026.6817-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517114026.6817-1-vasant.hegde@amd.com>

On Sun, May 17, 2026 at 11:40:26AM +0000, Vasant Hegde wrote:
> IOMMU performance counters are accessed via MMIO space. Currently IOMMU
> PMUs uses a single global cpumask (iommu_cpumask) shared across all AMD
> IOMMU PMU instances. This prevents collecting per-socket numbers
> (ex: perf stat --per-socket).
> 
> Fix this by adjusting cpumask based on IOMMUs NUMA node.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Acked-by: Joerg Roedel <joerg.roedel@amd.com>

> ---
>  arch/x86/events/amd/iommu.c | 29 +++++++++++++++++++++++------
>  drivers/iommu/amd/init.c    |  7 +++++++
>  include/linux/amd-iommu.h   |  1 +
>  3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index 07b110e8418a..b1848300028d 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -10,6 +10,7 @@
>  
>  #define pr_fmt(fmt)	"perf/amd_iommu: " fmt
>  
> +#include <linux/device.h>
>  #include <linux/perf_event.h>
>  #include <linux/init.h>
>  #include <linux/cpumask.h>
> @@ -43,6 +44,7 @@ struct perf_amd_iommu {
>  	u8 max_counters;
>  	u64 cntr_assign_mask;
>  	raw_spinlock_t lock;
> +	cpumask_t cpumask;
>  };
>  
>  static LIST_HEAD(perf_amd_iommu_list);
> @@ -131,13 +133,15 @@ static struct amd_iommu_event_desc amd_iommu_v2_event_descs[] = {
>  /*---------------------------------------------
>   * sysfs cpumask attributes
>   *---------------------------------------------*/
> -static cpumask_t iommu_cpumask;
> -
>  static ssize_t _iommu_cpumask_show(struct device *dev,
>  				   struct device_attribute *attr,
>  				   char *buf)
>  {
> -	return cpumap_print_to_pagebuf(true, buf, &iommu_cpumask);
> +	struct pmu *pmu = dev_get_drvdata(dev);
> +	struct perf_amd_iommu *perf_iommu =
> +			container_of(pmu, struct perf_amd_iommu, pmu);
> +
> +	return cpumap_print_to_pagebuf(true, buf, &perf_iommu->cpumask);
>  }
>  static DEVICE_ATTR(cpumask, S_IRUGO, _iommu_cpumask_show, NULL);
>  
> @@ -420,7 +424,8 @@ static const struct pmu iommu_pmu __initconst = {
>  static __init int init_one_iommu(unsigned int idx)
>  {
>  	struct perf_amd_iommu *perf_iommu;
> -	int ret;
> +	struct device *dev;
> +	int node, cpu, ret;
>  
>  	perf_iommu = kzalloc_obj(struct perf_amd_iommu);
>  	if (!perf_iommu)
> @@ -440,6 +445,20 @@ static __init int init_one_iommu(unsigned int idx)
>  		return -EINVAL;
>  	}
>  
> +	dev = amd_iommu_idx_to_dev(idx);
> +	node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
> +	if (node != NUMA_NO_NODE)
> +		cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
> +	else
> +		cpu = cpumask_any(cpu_online_mask);
> +
> +	if (cpu >= nr_cpu_ids) {
> +		pr_warn("Failed to find online CPU for IOMMU %d.\n", idx);
> +		kfree(perf_iommu);
> +		return -ENODEV;
> +	}
> +	cpumask_set_cpu(cpu, &perf_iommu->cpumask);
> +
>  	snprintf(perf_iommu->name, IOMMU_NAME_SIZE, "amd_iommu_%u", idx);
>  
>  	ret = perf_pmu_register(&perf_iommu->pmu, perf_iommu->name, -1);
> @@ -483,8 +502,6 @@ static __init int amd_iommu_pc_init(void)
>  		return -ENODEV;
>  	}
>  
> -	/* Init cpumask attributes to only core 0 */
> -	cpumask_set_cpu(0, &iommu_cpumask);
>  	return 0;
>  }
>  
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 3bdb380d23e9..2c35d171b5ae 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3939,6 +3939,13 @@ struct amd_iommu *get_amd_iommu(unsigned int idx)
>  	return NULL;
>  }
>  
> +struct device *amd_iommu_idx_to_dev(unsigned int idx)
> +{
> +	struct amd_iommu *iommu = get_amd_iommu(idx);
> +
> +	return iommu ? &iommu->dev->dev : NULL;
> +}
> +
>  /****************************************************************************
>   *
>   * IOMMU EFR Performance Counter support functionality. This code allows
> diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
> index edcee9f5335a..6b8d6b53b4e9 100644
> --- a/include/linux/amd-iommu.h
> +++ b/include/linux/amd-iommu.h
> @@ -67,6 +67,7 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
>  int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
>  		u64 *value);
>  struct amd_iommu *get_amd_iommu(unsigned int idx);
> +struct device *amd_iommu_idx_to_dev(unsigned int idx);
>  
>  #ifdef CONFIG_KVM_AMD_SEV
>  int amd_iommu_snp_disable(void);
> -- 
> 2.31.1
> 
