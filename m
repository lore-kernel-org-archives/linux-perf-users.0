Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881424;
	b=m5MRIX4mG8agzTlL1TrxKAsw+TjegURJP3f7XLCROO/PidhJtWV5n+Ui3+8MR8d+5oLx
	 Ln+Ic2Tz32piM7f/bzS+l0miMRqB6S2pbFNawdyH7JmNss4OUAKA6xmNbEBwO2PLMRNBm
	 /oWNk617PbZ+rcX7aXGor5zOsxTDoaSAZq4aG0AGNAWY7UGmee0M/MamTHwuHp7YZS52R
	 yR9PTIZ+dgt7HHl9GkrUpQn+P5Aw8K7QX8ri/0sRdQzqPqMgmAmliBWHD2emuH4CinCY2
	 Oh6/8frYUEY8S39Ifq6LTFEtn//sUvt8ePpixiyfQQMDwKYqo0V3UpCZFK5XB+pwBJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881424;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=fJDT0cxFozi2qKfsub911Wuy7oft4DKJw9vVKniaDDA=;
	b=y+DmWcv2eBSH23khl3rv03diFds6mBJVKSw2J8U4laWyv4FCTUIdiPgXU1XuoF/cIQ1D
	 5ikfZ1OdmPKAUP5hNgh9mOiLin4rNC5Mfo0o+CmenWIdQBO20ITJt4LB3DMCGi99mmUWB
	 fT4joRQ0Zh8gnHu2VXfVh2Csb0U/LOTVfyLUKZykohxCf7xougsAgLQr7Fd7c6p5v7oqd
	 WzBCiIgP4dnLfnBNbA4+EpXfNFFz01ks1x9BiBe/dHyKYbHbNrvfAXA19vpshogBx4sMI
	 rMtgkS5gSAlklDAG8MMUCv0XV+DCBvJ38mlKXuHKgwT348dahyw6s2Jq/McHpm7Z5DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hY2sl8JL;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433E7606A329;
	Thu,  5 Nov 2026 12:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 433E7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hY2sl8JL
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84BA51E8D;
	Thu,  5 Nov 2026 04:23:39 -0800 (PST)
Received: from [10.2.197.99] (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C51E3F673;
	Thu,  5 Nov 2026 04:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793881422; bh=7ObBKmqG+icuZPmjyc4qH8N7xSCMrgwpI3l9c/5Rzhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hY2sl8JL1Curp89U6geW4bLaZvzJBrkCyaOrSFFWbtGeJ5li+1PizU2SzB1gV8Dyv
	 WpdGz1qFYpJJX9YROSmUJi3s+uAZqNRsyd3F4PLsRrP6+fMmHTt9MEzX22Xxqw0yF2
	 f+oxFog0lIao2vAzIzZkvOyhlQBhNIZWOT92byhs=
Message-ID: <38d01cef-4fb9-4b98-8187-80c4214f7931@arm.com>
Date: Thu, 5 Nov 2026 12:23:38 +0000
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
Subject: Re: [PATCH v4 6/7] coresight: etm4x: Report whether the PMU counts
 the external outputs
To: Amir Ayupov <aaupov@fb.com>, James Clark <james.clark@linaro.org>,
 Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Daniel Pereira <danielmaraboo@gmail.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <a433810b85a9b768489d7b7b3ceb50324a2cd336.1792989860.git.aaupov@fb.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <a433810b85a9b768489d7b7b3ceb50324a2cd336.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/10/2026 05:48, Amir Ayupov wrote:
> Some CPUs count the trace unit's external outputs as the PMU common
> events TRCEXTOUT0-3 (0x4010-0x4013), which lets a configuration drive a
> PMU event from trace unit events. Other CPUs, Neoverse N1 for example,
> have no such events, and a feature relying on them would silently do
> nothing there.
> 
> Detect at probe, on the trace unit's CPU, whether the PMU counts every
> external output: the trace unit has an external output for each of its
> events (caps.nr_event), and pmuv3_event_implemented() reports whether
> the PMU implements TRCEXTOUTn. Only check ETE: per its specification, an
> implemented TRCEXTOUTn event counts external output n, while whether that
> output is also an external input is IMPLEMENTATION DEFINED.
> 
> Add a CS_CFG_MATCH_CAP_TRCEXTOUT capability match flag, set it on those
> trace units, and show it in the feature's configfs 'matches' attribute.
> With capabilities matched separately from the device class, a feature
> that requires it only loads on those trace units.
> 
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> ---
>   .../hwtracing/coresight/coresight-config.h    |  2 ++
>   .../hwtracing/coresight/coresight-etm4x-cfg.c |  6 ++++-
>   .../coresight/coresight-etm4x-core.c          | 26 +++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-etm4x.h |  3 +++
>   .../coresight/coresight-syscfg-configfs.c     |  3 +++
>   5 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index 220bc54f8e5e1..4cf53230854d0 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -38,6 +38,8 @@
>    * a device that matches one of its classes and has all of its capabilities.
>    */
>   #define CS_CFG_MATCH_CAP_MASK		GENMASK_U32(15, 8)
> +/* the PMU counts the trace unit's external outputs as TRCEXTOUTn */
> +#define CS_CFG_MATCH_CAP_TRCEXTOUT	BIT(8)
>   

Please could we rename this to :

CS_CFG_MATCH_CAP_ETE_TRCEXTOUT

as this is only applicable for ETEs ?

>   /*
>    * Limit number of presets in a configuration
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> index 52cb036bb04b9..9e4dc5950c13d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> @@ -176,9 +176,13 @@ static int etm4_cfg_load_feature(struct coresight_device *csdev,
>   
>   int etm4_cscfg_register(struct coresight_device *csdev)
>   {
> +	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>   	struct cscfg_csdev_feat_ops ops;
> +	u32 match_flags = CS_CFG_ETM4_MATCH_FLAGS;
>   
>   	ops.load_feat = &etm4_cfg_load_feature;
> +	if (drvdata->caps.trcextout)
> +		match_flags |= CS_CFG_MATCH_CAP_TRCEXTOUT;
>   
> -	return cscfg_register_csdev(csdev, CS_CFG_ETM4_MATCH_FLAGS, &ops);
> +	return cscfg_register_csdev(csdev, match_flags, &ops);
>   }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index af017bd8a5477..cb5fbb0279b88 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -30,6 +30,7 @@
>   #include <linux/uaccess.h>
>   #include <linux/perf_event.h>
>   #include <linux/perf/arm_pmu.h>
> +#include <linux/perf/arm_pmuv3.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/property.h>
> @@ -1399,6 +1400,29 @@ static void etm4_fixup_wrong_ccitmin(struct etmv4_caps *caps)
>   	}
>   }
>   
> +/*
> + * Whether the PMU counts each external output of this trace unit as
> + * TRCEXTOUTn. The trace unit has an external output for each of its events.
> + * Only ETE is checked: per its specification, an implemented TRCEXTOUTn event
> + * counts external output n.
> + *
> + * Must run on the CPU that owns the trace unit.
> + */
> +static bool etm4_pmu_counts_extout(struct etmv4_drvdata *drvdata)
> +{
> +	int n;
> +
> +	if (!etm4x_is_ete(drvdata) || !drvdata->caps.nr_event)
> +		return false;
> +
> +	for (n = 0; n < drvdata->caps.nr_event; n++) {
> +		if (!pmuv3_event_implemented(ARMV8_PMUV3_PERFCTR_TRCEXTOUT0 + n))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>   static void etm4_init_arch_data(void *info)
>   {
>   	u32 etmidr0;
> @@ -1562,6 +1586,8 @@ static void etm4_init_arch_data(void *info)
>   	/* NUMCNTR, bits[30:28] number of counters available for tracing */
>   	caps->nr_cntr = FIELD_GET(TRCIDR5_NUMCNTR_MASK, etmidr5);
>   
> +	caps->trcextout = etm4_pmu_counts_extout(drvdata);
> +
>   	coresight_clear_self_claim_tag_unlocked(csa);
>   	etm4_cs_lock(drvdata, csa);
>   	cpu_detect_trace_filtering(drvdata);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 5417280cdb274..33994ad4b2641 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -868,6 +868,8 @@ enum etm_impdef_type {
>    * @lpoverride:	If the implementation can support low-power state over.
>    * @skip_power_up: Indicates if an implementation can skip powering up
>    *		   the trace unit.
> + * @trcextout:	The trace unit is an ETE whose PMU counts its external
> + *		outputs as TRCEXTOUTn.

We don't seem to be using this after the CSFG flag initialisation, in 
which case could we directly call etm4_pmu_counts_extout() from
etm4_cscfg_register() ?


Suzuki

>    */
>   struct etmv4_caps {
>   	u8	nr_pe;
> @@ -907,6 +909,7 @@ struct etmv4_caps {
>   	bool	atbtrig : 1;
>   	bool	lpoverride : 1;
>   	bool	skip_power_up : 1;
> +	bool	trcextout : 1;
>   };
>   
>   /**
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
> index 2b40e556be872..7b3800138f625 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
> @@ -250,6 +250,9 @@ static ssize_t cscfg_feat_matches_show(struct config_item *item, char *page)
>   	if (match_flags & CS_CFG_MATCH_CLASS_SRC_ETM4)
>   		used += scnprintf(page + used, PAGE_SIZE - used, "SRC_ETMV4 ");
>   
> +	if (match_flags & CS_CFG_MATCH_CAP_TRCEXTOUT)
> +		used += scnprintf(page + used, PAGE_SIZE - used, "TRCEXTOUT ");
> +
>   	used += scnprintf(page + used, PAGE_SIZE - used, "\n");
>   	return used;
>   }

