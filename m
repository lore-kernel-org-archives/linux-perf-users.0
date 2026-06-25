Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7031AAAA;
	Thu, 25 Jun 2026 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395623; cv=none; b=ZVuS8fxURHIZA1+5n7IYgoTFRxasO6vF7Ie8MAuXEYl/tLUuik4IQbU1tSCDku8a3+3oMBv8ASPI4/bqeP8GV4eB/YzZEYX1xIGwZP/EvAIzhA3pSm+14S2mVqiHXTNvmYy1P6UaL6Oj+mQho+IfZ3cQOGqv/0FtcaDxJu4V8Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395623; c=relaxed/simple;
	bh=0T8HEEzPv+gUEW5s2qzSLuWTsnHb5dkZyaIvFCWyMXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4gbnmPhoHmAHhytzUzkaSKAEKX/HtUzc9HkOE+cUKr8calQJ55+67wfY6aMgr1P/eb2V0edk4m37ThZOZ3Z4tQ/8Vxo4a97P9p6abx8zMVpcxoMsz+Hq8iZqT0VhudkqGs2qV39aKLWYSG3fo/gOmP4nnR0O5lWl5W2EMqY0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q1CSj4hF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q1CSj4hF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A728F165C;
	Thu, 25 Jun 2026 06:53:35 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A1613F632;
	Thu, 25 Jun 2026 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782395620; bh=0T8HEEzPv+gUEW5s2qzSLuWTsnHb5dkZyaIvFCWyMXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q1CSj4hFSq7JHrFz+hoJICKSlnsaWN1cT0Jnh5o0RsFvU9Wmej6xuj7AiXF2KLYRB
	 BnqXUFLWXGYaHJSopJBx2QCZY9mQlgM7gZwwy9SEzdlEuFM2m/KcMzLR0PvDKsO3M4
	 IrX9Vrb/azfIsq9+PjPZRjbqikqaMbWB0Tbp44pU=
Message-ID: <6b15d3fc-4b4e-4c6c-a96d-5817d7114d02@arm.com>
Date: Thu, 25 Jun 2026 14:53:24 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v4 1/3] perf: marvell: Add MPAM partid filtering to CN10K
 TAD PMU
To: Geetha sowjanya <gakula@marvell.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, will@kernel.org, krzk+dt@kernel.org,
 james.morse@arm.com
References: <20260618153610.13649-1-gakula@marvell.com>
 <20260618153610.13649-2-gakula@marvell.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260618153610.13649-2-gakula@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geetha,

+CC James

On 6/18/26 16:36, Geetha sowjanya wrote:
> From: Tanmay Jagdale <tanmay@marvell.com>
> 
> The TAD PMU exposes counters that can be filtered by MPAM partition id
> for a subset of allocation and hit events.
> 
> Add a 9-bit partid format attribute (config1) and route counter programming
> through variant-specific ops so CN10K keeps MPAM-capable programming while
> Odyssey keeps the reduced event set without advertising partid in sysfs.
> 
> Probe no longer mutates the platform_device MMIO resource (walk a local
> map_start), rejects tad-cnt / page sizes of zero, validates the memory
> window against tad-cnt, and registers the perf PMU before hotplug with
> correct unwind.
> 
> Example:
>   perf stat -e tad/tad_alloc_any,partid=0x12,partid_en=1/ -- <program>

Where is the user expected to get the PARTID from? The MPAM driver
considers the PARTID as an internal only value.

resctrl does support a 'debug' mount option which will show the CLOSID
associated with a control group. Whilst the CLOSID is often the PARTID,
it is really a set of PARTIDs. When the cdp mount option is used, CLOSID
maps to 2 PARTIDs and if we use PARTID narrowing to give us more
monitors, as in proposed in [1], then the set of PARTIDs may be bigger.
Furthermore, if the PARTID narrowing scheme is made dynamic the size of
the PARTID set may change when control or monitoring groups are created
or deleted.

It seems that a way to map from a resctrl control group to the set of
PARTIDs is required and a mechanism to tie this to lifetime of the
resctrl mount.

Perhaps some helpers along the lines of:

int resctrl_mount_generation(void)
int mpam_rdtgrp_to_partid_is_static(int mount_gen)
int resctrl_rdtgrp_generation(char *name)
int mpam_rdtgrp_to_partid_count(char *name, int rdt_gen)
int mpam_rdtgrp_to_partid_array(char *name, int rdt_gen, int* partids)

The rdtgrp generation is to an attempt to avoid having to use a debug
interface in anger and cope with renaming of control groups in resctrl.
This does seem a bit unwieldly so hopefully there is better way to do this.

Sorry to throw a spanner in the works.

Thanks,

Ben

> 
> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
> 
> Changelog (since v3)
> --------------------
> - Restore cpuhp_state_add_instance_nocalls before perf_pmu_register in probe
>   so users cannot attach events before the hotplug instance exists; unwind
>   removes the hotplug instance if perf registration fails.
> - Add perf_ready: tad_pmu_offline_cpu skips perf_pmu_migrate_context until after
>   successful perf_pmu_register, so a CPU offline between hotplug add and perf
>   register does not touch perf core state for an unregistered PMU.
> 
> Changelog (since v2)
> --------------------
> - Validate the eventId using an appropriate mask to ensure
>   it is restricted to 8 bits.
> 
> Changelog (since v1)
> --------------------
> - Fix config1 filter enable to use bit 9 consistently with the PMU format
>   string (partid_en) and reject reserved bits with GENMASK(9, 0).
> - Register perf_pmu_register before cpuhp_state_add_instance_nocalls and
>   unregister on hotplug failure.
> 
>  drivers/perf/marvell_cn10k_tad_pmu.c | 220 +++++++++++++++++++++------
>  1 file changed, 171 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
> index 51ccb0befa05..340be3776fe7 100644
> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
> @@ -7,6 +7,8 @@
>  #define pr_fmt(fmt) "tad_pmu: " fmt
>  
>  #include <linux/io.h>
> +#include <linux/bits.h>
> +#include <linux/compiler.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/cpuhotplug.h>
> @@ -14,12 +16,20 @@
>  #include <linux/platform_device.h>
>  #include <linux/acpi.h>
>  
> -#define TAD_PFC_OFFSET		0x800
> -#define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
>  #define TAD_PRF_OFFSET		0x900
> -#define TAD_PRF(counter)	(TAD_PRF_OFFSET | (counter << 3))
> +#define TAD_PFC_OFFSET		0x800
> +#define TAD_PFC(base, counter)	((base) | ((u64)(counter) << 3))
> +#define TAD_PRF(base, counter)	((base) | ((u64)(counter) << 3))
>  #define TAD_PRF_CNTSEL_MASK	0xFF
> +#define TAD_PRF_MATCH_PARTID	BIT(8)
> +#define TAD_PRF_PARTID_NS	BIT(10)
> +/*
> + * config1: bits 0..8 MPAM partition id (including 0); bit 9 requests
> + * filtering for MPAM-capable events. All-zero config1 means no filter.
> + */
> +#define TAD_PARTID_FILTER_EN	BIT(9)
>  #define TAD_MAX_COUNTERS	8
> +#define TAD_EVENT_SEL_MASK	GENMASK(7, 0)
>  
>  #define to_tad_pmu(p) (container_of(p, struct tad_pmu, pmu))
>  
> @@ -27,30 +37,94 @@ struct tad_region {
>  	void __iomem	*base;
>  };
>  
> +enum mrvl_tad_pmu_version {
> +	TAD_PMU_V1 = 1,
> +	TAD_PMU_V2,
> +};
> +
> +struct tad_pmu_data {
> +	int id;
> +	u64 tad_prf_offset;
> +	u64 tad_pfc_offset;
> +};
> +
>  struct tad_pmu {
>  	struct pmu pmu;
>  	struct tad_region *regions;
>  	u32 region_cnt;
>  	unsigned int cpu;
> +	/* Set after successful perf_pmu_register(); gates offline migration. */
> +	bool perf_ready;
> +	const struct tad_pmu_ops *ops;
> +	const struct tad_pmu_data *pdata;
>  	struct hlist_node node;
>  	struct perf_event *events[TAD_MAX_COUNTERS];
>  	DECLARE_BITMAP(counters_map, TAD_MAX_COUNTERS);
>  };
>  
> -enum mrvl_tad_pmu_version {
> -	TAD_PMU_V1 = 1,
> -	TAD_PMU_V2,
> -};
> -
> -struct tad_pmu_data {
> -	int id;
> +struct tad_pmu_ops {
> +	void (*start_counter)(struct tad_pmu *pmu, struct perf_event *event);
>  };
>  
>  static int tad_pmu_cpuhp_state;
>  
> +static void tad_pmu_start_counter(struct tad_pmu *pmu,
> +				  struct perf_event *event)
> +{
> +	const struct tad_pmu_data *pdata = pmu->pdata;
> +	struct hw_perf_event *hwc = &event->hw;
> +	u32 event_idx = (u32)(event->attr.config & TAD_EVENT_SEL_MASK);
> +	u32 counter_idx = hwc->idx;
> +	u64 partid_filter = 0;
> +	u64 reg_val;
> +	u64 cfg1 = event->attr.config1;
> +	bool use_mpam = cfg1 & TAD_PARTID_FILTER_EN;
> +	u32 partid = (u32)(cfg1 & GENMASK(8, 0));
> +	int i;
> +
> +	for (i = 0; i < pmu->region_cnt; i++)
> +		writeq_relaxed(0, pmu->regions[i].base +
> +			       TAD_PFC(pdata->tad_pfc_offset, counter_idx));
> +
> +	if (use_mpam && event_idx > 0x19 && event_idx < 0x21) {
> +		partid_filter = TAD_PRF_MATCH_PARTID | TAD_PRF_PARTID_NS |
> +				((u64)partid << 11);
> +	}
> +
> +
> +	for (i = 0; i < pmu->region_cnt; i++) {
> +		reg_val = event_idx & 0xFF;
> +		reg_val |= partid_filter;
> +		writeq_relaxed(reg_val, pmu->regions[i].base +
> +			       TAD_PRF(pdata->tad_prf_offset, counter_idx));
> +	}
> +}
> +
> +static void tad_pmu_v2_start_counter(struct tad_pmu *pmu,
> +				     struct perf_event *event)
> +{
> +	const struct tad_pmu_data *pdata = pmu->pdata;
> +	struct hw_perf_event *hwc = &event->hw;
> +	u32 event_idx = (u32)(event->attr.config & TAD_EVENT_SEL_MASK);
> +	u32 counter_idx = hwc->idx;
> +	u64 reg_val;
> +	int i;
> +
> +	for (i = 0; i < pmu->region_cnt; i++)
> +		writeq_relaxed(0, pmu->regions[i].base +
> +			       TAD_PFC(pdata->tad_pfc_offset, counter_idx));
> +
> +	for (i = 0; i < pmu->region_cnt; i++) {
> +		reg_val = event_idx & 0xFF;
> +		writeq_relaxed(reg_val, pmu->regions[i].base +
> +			       TAD_PRF(pdata->tad_prf_offset, counter_idx));
> +	}
> +}
> +
>  static void tad_pmu_event_counter_read(struct perf_event *event)
>  {
>  	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
> +	const struct tad_pmu_data *pdata = tad_pmu->pdata;
>  	struct hw_perf_event *hwc = &event->hw;
>  	u32 counter_idx = hwc->idx;
>  	u64 prev, new;
> @@ -60,7 +134,7 @@ static void tad_pmu_event_counter_read(struct perf_event *event)
>  		prev = local64_read(&hwc->prev_count);
>  		for (i = 0, new = 0; i < tad_pmu->region_cnt; i++)
>  			new += readq(tad_pmu->regions[i].base +
> -				     TAD_PFC(counter_idx));
> +				     TAD_PFC(pdata->tad_pfc_offset, counter_idx));
>  	} while (local64_cmpxchg(&hwc->prev_count, prev, new) != prev);
>  
>  	local64_add(new - prev, &event->count);
> @@ -69,16 +143,14 @@ static void tad_pmu_event_counter_read(struct perf_event *event)
>  static void tad_pmu_event_counter_stop(struct perf_event *event, int flags)
>  {
>  	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
> +	const struct tad_pmu_data *pdata = tad_pmu->pdata;
>  	struct hw_perf_event *hwc = &event->hw;
>  	u32 counter_idx = hwc->idx;
>  	int i;
>  
> -	/* TAD()_PFC() stop counting on the write
> -	 * which sets TAD()_PRF()[CNTSEL] == 0
> -	 */
>  	for (i = 0; i < tad_pmu->region_cnt; i++) {
>  		writeq_relaxed(0, tad_pmu->regions[i].base +
> -			       TAD_PRF(counter_idx));
> +			       TAD_PRF(pdata->tad_prf_offset, counter_idx));
>  	}
>  
>  	tad_pmu_event_counter_read(event);
> @@ -89,26 +161,10 @@ static void tad_pmu_event_counter_start(struct perf_event *event, int flags)
>  {
>  	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> -	u32 event_idx = event->attr.config;
> -	u32 counter_idx = hwc->idx;
> -	u64 reg_val;
> -	int i;
>  
>  	hwc->state = 0;
>  
> -	/* Typically TAD_PFC() are zeroed to start counting */
> -	for (i = 0; i < tad_pmu->region_cnt; i++)
> -		writeq_relaxed(0, tad_pmu->regions[i].base +
> -			       TAD_PFC(counter_idx));
> -
> -	/* TAD()_PFC() start counting on the write
> -	 * which sets TAD()_PRF()[CNTSEL] != 0
> -	 */
> -	for (i = 0; i < tad_pmu->region_cnt; i++) {
> -		reg_val = event_idx & 0xFF;
> -		writeq_relaxed(reg_val,	tad_pmu->regions[i].base +
> -			       TAD_PRF(counter_idx));
> -	}
> +	tad_pmu->ops->start_counter(tad_pmu, event);
>  }
>  
>  static void tad_pmu_event_counter_del(struct perf_event *event, int flags)
> @@ -128,7 +184,6 @@ static int tad_pmu_event_counter_add(struct perf_event *event, int flags)
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx;
>  
> -	/* Get a free counter for this event */
>  	idx = find_first_zero_bit(tad_pmu->counters_map, TAD_MAX_COUNTERS);
>  	if (idx == TAD_MAX_COUNTERS)
>  		return -EAGAIN;
> @@ -148,6 +203,9 @@ static int tad_pmu_event_counter_add(struct perf_event *event, int flags)
>  static int tad_pmu_event_init(struct perf_event *event)
>  {
>  	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
> +	const struct tad_pmu_data *pdata = tad_pmu->pdata;
> +	u32 event_idx = (u32)(event->attr.config & TAD_EVENT_SEL_MASK);
> +	u64 cfg1 = event->attr.config1;
>  
>  	if (event->attr.type != event->pmu->type)
>  		return -ENOENT;
> @@ -158,6 +216,23 @@ static int tad_pmu_event_init(struct perf_event *event)
>  	if (event->state != PERF_EVENT_STATE_OFF)
>  		return -EINVAL;
>  
> +	if (event->attr.config & ~TAD_EVENT_SEL_MASK)
> +		return -EINVAL;
> +
> +	if (pdata->id == TAD_PMU_V2) {
> +		if (cfg1)
> +			return -EINVAL;
> +	} else {
> +		if ((cfg1 & GENMASK(8, 0)) && !(cfg1 & TAD_PARTID_FILTER_EN))
> +			return -EINVAL;
> +		if (cfg1 & TAD_PARTID_FILTER_EN) {
> +			if (event_idx <= 0x19 || event_idx >= 0x21)
> +				return -EINVAL;
> +		}
> +		if (cfg1 & ~GENMASK(9, 0))
> +			return -EINVAL;
> +	}
> +
>  	event->cpu = tad_pmu->cpu;
>  	event->hw.idx = -1;
>  	event->hw.config_base = event->attr.config;
> @@ -232,7 +307,7 @@ static struct attribute *ody_tad_pmu_event_attrs[] = {
>  	TAD_PMU_EVENT_ATTR(tad_hit_ltg, 0x1e),
>  	TAD_PMU_EVENT_ATTR(tad_hit_any, 0x1f),
>  	TAD_PMU_EVENT_ATTR(tad_tag_rd, 0x20),
> -	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xFF),
> +	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xff),
>  	NULL
>  };
>  
> @@ -242,9 +317,13 @@ static const struct attribute_group ody_tad_pmu_events_attr_group = {
>  };
>  
>  PMU_FORMAT_ATTR(event, "config:0-7");
> +PMU_FORMAT_ATTR(partid, "config1:0-8");
> +PMU_FORMAT_ATTR(partid_en, "config1:9-9");
>  
>  static struct attribute *tad_pmu_format_attrs[] = {
>  	&format_attr_event.attr,
> +	&format_attr_partid.attr,
> +	&format_attr_partid_en.attr,
>  	NULL
>  };
>  
> @@ -253,6 +332,16 @@ static struct attribute_group tad_pmu_format_attr_group = {
>  	.attrs = tad_pmu_format_attrs,
>  };
>  
> +static struct attribute *ody_tad_pmu_format_attrs[] = {
> +	&format_attr_event.attr,
> +	NULL
> +};
> +
> +static struct attribute_group ody_tad_pmu_format_attr_group = {
> +	.name = "format",
> +	.attrs = ody_tad_pmu_format_attrs,
> +};
> +
>  static ssize_t tad_pmu_cpumask_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -281,16 +370,25 @@ static const struct attribute_group *tad_pmu_attr_groups[] = {
>  
>  static const struct attribute_group *ody_tad_pmu_attr_groups[] = {
>  	&ody_tad_pmu_events_attr_group,
> -	&tad_pmu_format_attr_group,
> +	&ody_tad_pmu_format_attr_group,
>  	&tad_pmu_cpumask_attr_group,
>  	NULL
>  };
>  
> +static const struct tad_pmu_ops tad_pmu_ops = {
> +	.start_counter = tad_pmu_start_counter,
> +};
> +
> +static const struct tad_pmu_ops tad_pmu_v2_ops = {
> +	.start_counter = tad_pmu_v2_start_counter,
> +};
> +
>  static int tad_pmu_probe(struct platform_device *pdev)
>  {
>  	const struct tad_pmu_data *dev_data;
>  	struct device *dev = &pdev->dev;
>  	struct tad_region *regions;
> +	resource_size_t map_start;
>  	struct tad_pmu *tad_pmu;
>  	struct resource *res;
>  	u32 tad_pmu_page_size;
> @@ -298,7 +396,6 @@ static int tad_pmu_probe(struct platform_device *pdev)
>  	u32 tad_cnt;
>  	int version;
>  	int i, ret;
> -	char *name;
>  
>  	tad_pmu = devm_kzalloc(&pdev->dev, sizeof(*tad_pmu), GFP_KERNEL);
>  	if (!tad_pmu)
> @@ -312,6 +409,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  	version = dev_data->id;
> +	tad_pmu->pdata = dev_data;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
> @@ -338,22 +436,31 @@ static int tad_pmu_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Can't find tad-cnt property\n");
>  		return ret;
>  	}
> +	if (!tad_cnt || !tad_page_size || !tad_pmu_page_size) {
> +		dev_err(&pdev->dev, "Invalid tad-cnt or page size\n");
> +		return -EINVAL;
> +	}
>  
>  	regions = devm_kcalloc(&pdev->dev, tad_cnt,
>  			       sizeof(*regions), GFP_KERNEL);
>  	if (!regions)
>  		return -ENOMEM;
>  
> -	/* ioremap the distributed TAD pmu regions */
> -	for (i = 0; i < tad_cnt && res->start < res->end; i++) {
> -		regions[i].base = devm_ioremap(&pdev->dev,
> -					       res->start,
> +	map_start = res->start;
> +	for (i = 0; i < tad_cnt; i++) {
> +		if (map_start > res->end ||
> +		    tad_pmu_page_size > (resource_size_t)(res->end - map_start + 1)) {
> +			dev_err(&pdev->dev, "TAD PMU mem window too small for tad-cnt=%u\n",
> +				tad_cnt);
> +			return -EINVAL;
> +		}
> +		regions[i].base = devm_ioremap(&pdev->dev, map_start,
>  					       tad_pmu_page_size);
>  		if (!regions[i].base) {
>  			dev_err(&pdev->dev, "TAD%d ioremap fail\n", i);
>  			return -ENOMEM;
>  		}
> -		res->start += tad_page_size;
> +		map_start += tad_page_size;
>  	}
>  
>  	tad_pmu->regions = regions;
> @@ -374,14 +481,16 @@ static int tad_pmu_probe(struct platform_device *pdev)
>  		.read		= tad_pmu_event_counter_read,
>  	};
>  
> -	if (version == TAD_PMU_V1)
> +	if (version == TAD_PMU_V1) {
>  		tad_pmu->pmu.attr_groups = tad_pmu_attr_groups;
> -	else
> +		tad_pmu->ops		 = &tad_pmu_ops;
> +	} else {
>  		tad_pmu->pmu.attr_groups = ody_tad_pmu_attr_groups;
> +		tad_pmu->ops		 = &tad_pmu_v2_ops;
> +	}
>  
>  	tad_pmu->cpu = raw_smp_processor_id();
>  
> -	/* Register pmu instance for cpu hotplug */
>  	ret = cpuhp_state_add_instance_nocalls(tad_pmu_cpuhp_state,
>  					       &tad_pmu->node);
>  	if (ret) {
> @@ -389,19 +498,24 @@ static int tad_pmu_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	name = "tad";
> -	ret = perf_pmu_register(&tad_pmu->pmu, name, -1);
> -	if (ret)
> +	ret = perf_pmu_register(&tad_pmu->pmu, "tad", -1);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error %d registering perf PMU\n", ret);
>  		cpuhp_state_remove_instance_nocalls(tad_pmu_cpuhp_state,
>  						    &tad_pmu->node);
> +		return ret;
> +	}
>  
> -	return ret;
> +	WRITE_ONCE(tad_pmu->perf_ready, true);
> +
> +	return 0;
>  }
>  
>  static void tad_pmu_remove(struct platform_device *pdev)
>  {
>  	struct tad_pmu *pmu = platform_get_drvdata(pdev);
>  
> +	WRITE_ONCE(pmu->perf_ready, false);
>  	cpuhp_state_remove_instance_nocalls(tad_pmu_cpuhp_state,
>  						&pmu->node);
>  	perf_pmu_unregister(&pmu->pmu);
> @@ -410,12 +524,17 @@ static void tad_pmu_remove(struct platform_device *pdev)
>  #if defined(CONFIG_OF) || defined(CONFIG_ACPI)
>  static const struct tad_pmu_data tad_pmu_data = {
>  	.id   = TAD_PMU_V1,
> +	.tad_prf_offset = TAD_PRF_OFFSET,
> +	.tad_pfc_offset = TAD_PFC_OFFSET,
>  };
> +
>  #endif
>  
>  #ifdef CONFIG_ACPI
>  static const struct tad_pmu_data tad_pmu_v2_data = {
>  	.id   = TAD_PMU_V2,
> +	.tad_prf_offset = TAD_PRF_OFFSET,
> +	.tad_pfc_offset = TAD_PFC_OFFSET,
>  };
>  #endif
>  
> @@ -451,6 +570,9 @@ static int tad_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  	struct tad_pmu *pmu = hlist_entry_safe(node, struct tad_pmu, node);
>  	unsigned int target;
>  
> +	if (!READ_ONCE(pmu->perf_ready))
> +		return 0;
> +
>  	if (cpu != pmu->cpu)
>  		return 0;
>  
> @@ -491,6 +613,6 @@ static void __exit tad_pmu_exit(void)
>  module_init(tad_pmu_init);
>  module_exit(tad_pmu_exit);
>  
> -MODULE_DESCRIPTION("Marvell CN10K LLC-TAD Perf driver");
> +MODULE_DESCRIPTION("Marvell CN10K LLC-TAD perf driver");
>  MODULE_AUTHOR("Bhaskara Budiredla <bbudiredla@marvell.com>");
>  MODULE_LICENSE("GPL v2");

