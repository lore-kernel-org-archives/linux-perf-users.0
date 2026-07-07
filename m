Received: from va-2-27.ptr.blmpb.com (va-2-27.ptr.blmpb.com [209.127.231.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7BB2045AD
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412713; cv=none; b=I730wyV5uyxP/uBR0JbSQPT8Z400qU2Ubp/iUCvp7N3erQO7pjRwHf71ncQWPdjIMngzPVh66FocQCCsjKdHp5lblEsk6mtN9oh7nqfaEmkQLLVarMFgNtFy9/IWdxSRT2OegDiAH0NuS2Z+L9gWQ5wAjb2HPpGVOm8s9IQgGFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412713; c=relaxed/simple;
	bh=hvF/4DMqJFE0A5PWHWmtvX9lOBtVSwbgiDjmtabJOmw=;
	h=To:Cc:Subject:Mime-Version:In-Reply-To:Date:References:From:
	 Message-Id:Content-Type; b=cItORE4kzJTmYtf/+TLo+hCqzDrMEs4FPLSbhMs386MP/uqUOczPc292+wKkAw+/FPQeTwFNZExV2UiBFs8jKlViJ31Q8xGuChglzqAq3hIxC2Ynn5yUufUm8mXtmtNL9VDW52E0v07saLMms68h5fz1XpVJ4hweYe+UbIf7rjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=QyvKidgC; arc=none smtp.client-ip=209.127.231.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="QyvKidgC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1783412701; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cw19VphC2mP7ckJXdDxnF8cbRI55kv2xFSetp7MLX3c=;
 b=QyvKidgCluIYr+MJzGvQQRboOzswlNKWxU7xCtdylKyvkhcD8DivVMdqqc1LywdUwMOArp
 PH87ufmF+Un/fIS62stZkXubuYASWgo3RO7PNsH4zS2DkribafG3XRL/572DL4I8YCW8VU
 bXG1cDkUJw5D4PHscbxR/YHXOkOINtLBl9wdhmlmFPmbnCcgbryIhDgTUlZAFfmsccqqiO
 uKdFItLf2rF5nG1YrJiQ+pCyWj7qAN44Vl8v8hgibyLU3P1ii4aUinML2v8VxkDsad2pyf
 6SLR1uwlhpJjKnhL6BwrIBu017yoV8RmYaYyflooIWUTKCYBEpxmsOvx2DLzjA==
To: "Atish Patra" <atish.patra@linux.dev>
Cc: "Jiri Olsa" <jolsa@kernel.org>, "Paul Walmsley" <pjw@kernel.org>, 
	"Mark Rutland" <mark.rutland@arm.com>, "Rob Herring" <robh@kernel.org>, 
	"Anup Patel" <anup@brainfault.org>, "Namhyung Kim" <namhyung@kernel.org>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Ian Rogers" <irogers@google.com>, "Will Deacon" <will@kernel.org>, 
	"James Clark" <james.clark@linaro.org>, <yang.yicong@picoheart.com>, 
	<linux-arm-kernel@lists.infradead.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<devicetree@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, 
	"Conor Dooley" <conor@kernel.org>
Subject: Re: [PATCH v8 14/22] RISC-V: perf: Implement supervisor counter delegation support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260701-counter_delegation-v8-14-7909f863a645@meta.com>
X-Lms-Return-Path: <lba+26a4cb7db+16e24b+vger.kernel.org+yang.yicong@picoheart.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Date: Tue, 7 Jul 2026 16:24:55 +0800
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-14-7909f863a645@meta.com>
Received: from [100.86.219.172] ([61.141.241.105]) by smtp.feishu.cn with ESMTPS; Tue, 07 Jul 2026 16:24:58 +0800
Content-Language: en-US
From: "Yicong Yang" <yang.yicong@picoheart.com>
Message-Id: <46cc0a87-a6cf-44d0-87d0-187ae8f6791e@picoheart.com>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird

On 7/1/26 4:47 PM, Atish Patra wrote:
> From: Atish Patra <atishp@rivosinc.com>
> 
> There are few new RISC-V ISA exensions (ssccfg, sscsrind, smcntrpmf) which
> allows the hpmcounter/hpmevents to be programmed directly from S-mode. The
> implementation detects the ISA extension at runtime and uses them if
> available instead of SBI PMU extension. SBI PMU extension will still be
> used for firmware counters if the user requests it.
> 
> The current linux driver relies on event encoding defined by SBI PMU
> specification for standard perf events. However, there are no standard
> event encoding available in the ISA. In the future, we may want to
> decouple the counter delegation and SBI PMU completely. In that case,
> counter delegation supported platforms must rely on the event encoding
> defined in the perf json file or in the pmu driver.
> 
> For firmware events, it will continue to use the SBI PMU encoding as
> one can not support firmware event without SBI PMU.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr.h   |   1 +
>  drivers/perf/riscv_pmu_sbi.c   | 578 +++++++++++++++++++++++++++++++++--------
>  include/linux/perf/riscv_pmu.h |   3 +
>  3 files changed, 478 insertions(+), 104 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index a3b24b88e401..cd22b5168689 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -258,6 +258,7 @@
>  #endif
>  
>  #define SISELECT_SSCCFG_BASE		0x40
> +#define HPMEVENT_MASK			GENMASK_ULL(63, 56)
>  
>  /* mseccfg bits */
>  #define MSECCFG_PMM			ENVCFG_PMM
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 2568c6808f5d..7995da4a98a1 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -28,6 +28,8 @@
>  #include <asm/cpufeature.h>
>  #include <asm/vendor_extensions.h>
>  #include <asm/vendor_extensions/andes.h>
> +#include <asm/hwcap.h>
> +#include <asm/csr_ind.h>
>  
>  #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
>  asm volatile(ALTERNATIVE_2(						\
> @@ -60,7 +62,20 @@ asm volatile(ALTERNATIVE(						\
>  #define PERF_EVENT_FLAG_USER_ACCESS	BIT(SYSCTL_USER_ACCESS)
>  #define PERF_EVENT_FLAG_LEGACY		BIT(SYSCTL_LEGACY)
>  
> -PMU_FORMAT_ATTR(event, "config:0-55");
> +#define RVPMU_SBI_PMU_FORMAT_ATTR	"config:0-47"
> +#define RVPMU_CDELEG_PMU_FORMAT_ATTR	"config:0-55"
> +
> +static ssize_t __maybe_unused rvpmu_format_show(struct device *dev, struct device_attribute *attr,
> +						char *buf);
> +
> +#define RVPMU_ATTR_ENTRY(_name, _func, _config)	(			\
> +	&((struct dev_ext_attribute[]) {				\
> +		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }	\
> +	})[0].attr.attr)
> +
> +#define RVPMU_FORMAT_ATTR_ENTRY(_name, _config) \
> +	RVPMU_ATTR_ENTRY(_name, rvpmu_format_show, (char *)_config)
> +
>  PMU_FORMAT_ATTR(firmware, "config:62-63");
>  
>  static bool sbi_v2_available;
> @@ -68,7 +83,11 @@ static bool sbi_v3_available;
>  static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
>  #define sbi_pmu_snapshot_available() \
>  	static_branch_unlikely(&sbi_pmu_snapshot_available)
> +
>  static DEFINE_STATIC_KEY_FALSE(riscv_pmu_sbi_available);
> +#define riscv_pmu_sbi_available() \
> +		static_branch_likely(&riscv_pmu_sbi_available)
> +
>  static DEFINE_STATIC_KEY_FALSE(riscv_pmu_cdeleg_available);
>  
>  /* Avoid unnecessary code patching in the one time booting path*/
> @@ -83,19 +102,35 @@ static DEFINE_STATIC_KEY_FALSE(riscv_pmu_cdeleg_available);
>  #define riscv_pmu_sbi_available() \
>  		static_branch_likely(&riscv_pmu_sbi_available)
>  
> -static struct attribute *riscv_arch_formats_attr[] = {
> -	&format_attr_event.attr,
> +static struct attribute *riscv_sbi_pmu_formats_attr[] = {
> +	RVPMU_FORMAT_ATTR_ENTRY(event, RVPMU_SBI_PMU_FORMAT_ATTR),
>  	&format_attr_firmware.attr,
>  	NULL,
>  };
>  
> -static struct attribute_group riscv_pmu_format_group = {
> +static struct attribute_group riscv_sbi_pmu_format_group = {
>  	.name = "format",
> -	.attrs = riscv_arch_formats_attr,
> +	.attrs = riscv_sbi_pmu_formats_attr,
>  };
>  
> -static const struct attribute_group *riscv_pmu_attr_groups[] = {
> -	&riscv_pmu_format_group,
> +static const struct attribute_group *riscv_sbi_pmu_attr_groups[] = {
> +	&riscv_sbi_pmu_format_group,
> +	NULL,
> +};
> +
> +static struct attribute *riscv_cdeleg_pmu_formats_attr[] = {
> +	RVPMU_FORMAT_ATTR_ENTRY(event, RVPMU_CDELEG_PMU_FORMAT_ATTR),
> +	&format_attr_firmware.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group riscv_cdeleg_pmu_format_group = {
> +	.name = "format",
> +	.attrs = riscv_cdeleg_pmu_formats_attr,
> +};
> +
> +static const struct attribute_group *riscv_cdeleg_pmu_attr_groups[] = {
> +	&riscv_cdeleg_pmu_format_group,
>  	NULL,
>  };
>  
> @@ -482,6 +517,14 @@ static void rvpmu_sbi_check_std_events(struct work_struct *work)
>  
>  static DECLARE_WORK(check_std_events_work, rvpmu_sbi_check_std_events);
>  
> +static ssize_t rvpmu_format_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr = container_of(attr,
> +				struct dev_ext_attribute, attr);
> +	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
> +}
> +
>  static int rvpmu_ctr_get_width(int idx)
>  {
>  	return pmu_ctr_list[idx].width;
> @@ -599,6 +642,38 @@ static uint8_t rvpmu_csr_index(struct perf_event *event)
>  	return pmu_ctr_list[event->hw.idx].csr - CSR_CYCLE;
>  }
>  
> +static uint64_t get_deleg_priv_filter_bits(struct perf_event *event)
> +{
> +	u64 priv_filter_bits = 0;

could we explicitly initialize the priv_filter_bits to MINH? though this bit
is S-mode read-only and won't have any effects, but considering the semantic
is to inhibit counting at certain privilege mode, initialize it to MINH will
make it clear.

> +	bool guest_events = false;
> +
> +	if (event->attr.config1 & RISCV_PMU_CONFIG1_GUEST_EVENTS)
> +		guest_events = true;

use attr::config1 to distinguish the KVM events looks incorrect. it's a user
visible interface and could be set explicitly by the user and break the
logic here.. e.g. perf stat -e cycles/config1=0x1/

> +	if (event->attr.exclude_kernel)
> +		priv_filter_bits |= guest_events ? HPMEVENT_VSINH : HPMEVENT_SINH;
> +	if (event->attr.exclude_user)
> +		priv_filter_bits |= guest_events ? HPMEVENT_VUINH : HPMEVENT_UINH;
> +	if (guest_events && event->attr.exclude_hv)
> +		priv_filter_bits |= HPMEVENT_SINH;
> +	if (event->attr.exclude_host)
> +		priv_filter_bits |= HPMEVENT_UINH | HPMEVENT_SINH;
> +	if (event->attr.exclude_guest)
> +		priv_filter_bits |= HPMEVENT_VSINH | HPMEVENT_VUINH;
> +
> +	return priv_filter_bits;
> +}
> +
> +static bool pmu_sbi_is_fw_event(struct perf_event *event)
> +{
> +	u32 type = event->attr.type;
> +	u64 config = event->attr.config;
> +
> +	if (type == PERF_TYPE_RAW && ((config >> 63) == 1))
> +		return true;
> +	else
> +		return false;
> +}
> +
>  static unsigned long rvpmu_sbi_get_filter_flags(struct perf_event *event)
>  {
>  	unsigned long cflags = 0;
> @@ -627,7 +702,8 @@ static int rvpmu_sbi_ctr_get_idx(struct perf_event *event)
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
>  	struct sbiret ret;
>  	int idx;
> -	uint64_t cbase = 0, cmask = rvpmu->cmask;
> +	u64 cbase = 0;
> +	unsigned long ctr_mask = rvpmu->cmask;
>  	unsigned long cflags = 0;
>  
>  	cflags = rvpmu_sbi_get_filter_flags(event);
> @@ -640,21 +716,23 @@ static int rvpmu_sbi_ctr_get_idx(struct perf_event *event)
>  	if ((hwc->flags & PERF_EVENT_FLAG_LEGACY) && (event->attr.type == PERF_TYPE_HARDWARE)) {
>  		if (event->attr.config == PERF_COUNT_HW_CPU_CYCLES) {
>  			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
> -			cmask = 1;
> +			ctr_mask = 1;
>  		} else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS) {
>  			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
> -			cmask = BIT(CSR_INSTRET - CSR_CYCLE);
> +			ctr_mask = BIT(CSR_INSTRET - CSR_CYCLE);
>  		}
> +	} else if (pmu_sbi_is_fw_event(event)) {
> +		ctr_mask = firmware_cmask;
>  	}
>  
>  	/* retrieve the available counter index */
>  #if defined(CONFIG_32BIT)
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
> -			cmask, cflags, hwc->event_base, hwc->config,
> +			ctr_mask, cflags, hwc->event_base, hwc->config,
>  			hwc->config >> 32);
>  #else
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
> -			cmask, cflags, hwc->event_base, hwc->config, 0);
> +			ctr_mask, cflags, hwc->event_base, hwc->config, 0);
>  #endif
>  	if (ret.error) {
>  		pr_debug("Not able to find a counter for event %lx config %llx\n",
> @@ -663,7 +741,7 @@ static int rvpmu_sbi_ctr_get_idx(struct perf_event *event)
>  	}
>  
>  	idx = ret.value;
> -	if (!test_bit(idx, &rvpmu->cmask) || !pmu_ctr_list[idx].value)
> +	if (!test_bit(idx, &ctr_mask) || !pmu_ctr_list[idx].value)
>  		return -ENOENT;
>  
>  	/* Additional sanity check for the counter id */
> @@ -713,29 +791,98 @@ static int sbi_pmu_event_find_cache(u64 config)
>  	return ret;
>  }
>  
> -static bool pmu_sbi_is_fw_event(struct perf_event *event)
> +static int rvpmu_sbi_event_map(struct perf_event *event, u64 *econfig)
>  {
>  	u32 type = event->attr.type;
>  	u64 config = event->attr.config;
>  
> -	if ((type == PERF_TYPE_RAW) && ((config >> 63) == 1))
> -		return true;
> -	else
> -		return false;
> +	/*
> +	 * Ensure we are finished checking standard hardware events for
> +	 * validity before allowing userspace to configure any events.
> +	 */
> +	flush_work(&check_std_events_work);
> +
> +	return riscv_pmu_get_event_info(type, config, econfig);
>  }
>  
> -static int rvpmu_sbi_event_map(struct perf_event *event, u64 *econfig)
> +static int cdeleg_pmu_event_find_cache(u64 config, u64 *eventid, uint32_t *counter_mask)
> +{
> +	unsigned int cache_type, cache_op, cache_result;
> +
> +	if (!current_pmu_cache_event_map)
> +		return -ENOENT;
> +
> +	cache_type = (config >>  0) & 0xff;
> +	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
> +		return -EINVAL;
> +
> +	cache_op = (config >>  8) & 0xff;
> +	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
> +		return -EINVAL;
> +
> +	cache_result = (config >> 16) & 0xff;
> +	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
> +		return -EINVAL;
> +
> +	if (eventid)
> +		*eventid = current_pmu_cache_event_map[cache_type][cache_op]
> +						      [cache_result].event_id;
> +	if (counter_mask)
> +		*counter_mask = current_pmu_cache_event_map[cache_type][cache_op]
> +							   [cache_result].counter_mask;
> +
> +	return 0;
> +}
> +
> +static int rvpmu_cdeleg_event_map(struct perf_event *event, u64 *econfig)
>  {
>  	u32 type = event->attr.type;
>  	u64 config = event->attr.config;
> +	int ret = 0;
>  
>  	/*
> -	 * Ensure we are finished checking standard hardware events for
> -	 * validity before allowing userspace to configure any events.
> +	 * There are two ways standard perf events can be mapped to platform specific
> +	 * encoding.
> +	 * 1. The vendor may specify the encodings in the driver.
> +	 * 2. The Perf tool for RISC-V may remap the standard perf event to platform
> +	 * specific encoding.
> +	 *
> +	 * As RISC-V ISA doesn't define any standard event encoding. Thus, perf tool allows
> +	 * vendor to define it via json file. The encoding defined in the json will override
> +	 * the perf legacy encoding. However, some user may want to run performance
> +	 * monitoring without perf tool as well. That's why, vendors may specify the event
> +	 * encoding in the driver as well if they want to support that use case too.
> +	 * If an encoding is defined in the json, it will be encoded as a raw event.
>  	 */
> -	flush_work(&check_std_events_work);
>  
> -	return riscv_pmu_get_event_info(type, config, econfig);
> +	switch (type) {
> +	case PERF_TYPE_HARDWARE:
> +		if (config >= PERF_COUNT_HW_MAX)
> +			return -EINVAL;
> +		if (!current_pmu_hw_event_map)
> +			return -ENOENT;
> +
> +		*econfig = current_pmu_hw_event_map[config].event_id;
> +		if (*econfig == HW_OP_UNSUPPORTED)
> +			ret = -ENOENT;
> +		break;
> +	case PERF_TYPE_HW_CACHE:
> +		ret = cdeleg_pmu_event_find_cache(config, econfig, NULL);
> +		if (ret)
> +			break;
> +		if (*econfig == CACHE_OP_UNSUPPORTED)
> +			ret = -ENOENT;
> +		break;
> +	case PERF_TYPE_RAW:
> +		*econfig = config & RISCV_PMU_DELEG_RAW_EVENT_MASK;
> +		break;
> +	default:
> +		ret = -ENOENT;
> +		break;
> +	}
> +
> +	/* event_base is not used for counter delegation */
> +	return ret;
>  }
>  
>  static void pmu_sbi_snapshot_free(struct riscv_pmu *pmu)
> @@ -821,7 +968,7 @@ static int pmu_sbi_snapshot_setup(struct riscv_pmu *pmu, int cpu)
>  	return 0;
>  }
>  
> -static u64 rvpmu_sbi_ctr_read(struct perf_event *event)
> +static u64 rvpmu_ctr_read(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx = hwc->idx;

the counter read logic need to coordinate the counter delegation
and SBI PMU snapshot, since the diff here doesn't show the logic,
so I paste the final applied code below:

static u64 rvpmu_ctr_read(struct perf_event *event)
{
	struct hw_perf_event *hwc = &event->hw;
	int idx = hwc->idx;
	[...variables declarations and initilizations]

	/* Read the value from the shared memory directly only if counter is stopped */
	if (sbi_pmu_snapshot_available() && (hwc->state & PERF_HES_STOPPED)) {
		val = sdata->ctr_values[idx];
		return val;
	}

seems we shouldn't read from the SBI PMU snapshot memory for delegated
counter, but here we always read from the snapshot memory if available.

> @@ -898,10 +1045,6 @@ static void rvpmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>  	if (ret.error && (ret.error != SBI_ERR_ALREADY_STARTED))
>  		pr_err("Starting counter idx %d failed with error %d\n",
>  			hwc->idx, sbi_err_map_linux_errno(ret.error));
> -
> -	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
> -	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> -		rvpmu_set_scounteren((void *)event);
>  }
>  
>  static void rvpmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
> @@ -912,10 +1055,6 @@ static void rvpmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>  	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>  
> -	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
> -	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> -		rvpmu_reset_scounteren((void *)event);
> -
>  	if (sbi_pmu_snapshot_available())
>  		flag |= SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
>  
> @@ -951,12 +1090,6 @@ static int rvpmu_sbi_find_num_ctrs(void)
>  		return sbi_err_map_linux_errno(ret.error);
>  }
>  
> -static u32 rvpmu_deleg_find_ctrs(void)
> -{
> -	/* TODO */
> -	return 0;
> -}
> -
>  static int rvpmu_sbi_get_ctrinfo(u32 nsbi_ctr, u32 *num_fw_ctr, u32 *num_hw_ctr)
>  {
>  	struct sbiret ret;
> @@ -1034,55 +1167,75 @@ static inline void rvpmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  	}
>  }
>  
> -/*
> - * This function starts all the used counters in two step approach.
> - * Any counter that did not overflow can be start in a single step
> - * while the overflowed counters need to be started with updated initialization
> - * value.
> - */
> -static inline void rvpmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
> -						u64 ctr_ovf_mask)
> +static void rvpmu_deleg_ctr_start_mask(unsigned long mask)
>  {
> -	int idx = 0, i;
> -	struct perf_event *event;
> -	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
> -	unsigned long ctr_start_mask = 0;
> -	uint64_t max_period;
> -	struct hw_perf_event *hwc;
> -	u64 init_val = 0;
> +	unsigned long scountinhibit_val = 0;
>  
> -	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
> -		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
> -		/* Start all the counters that did not overflow in a single shot */
> -		if (ctr_start_mask) {
> -			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG,
> -				  ctr_start_mask, 0, 0, 0, 0);
> -		}
> -	}
> +	scountinhibit_val = csr_read(CSR_SCOUNTINHIBIT);
> +	scountinhibit_val &= ~mask;
> +
> +	csr_write(CSR_SCOUNTINHIBIT, scountinhibit_val);
> +}
> +
> +static void rvpmu_deleg_ctr_enable_irq(struct perf_event *event)
> +{
> +	unsigned long hpmevent_curr;
> +	unsigned long of_mask;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int counter_idx = hwc->idx;
> +	unsigned long sip_val = csr_read(CSR_SIP);
> +
> +	if (!is_sampling_event(event) || (sip_val & SIP_LCOFIP))

we should also consider overflow for counters of non-sampling events..

> +		return;
>  
> -	/* Reinitialize and start all the counter that overflowed */
> -	while (ctr_ovf_mask) {
> -		if (ctr_ovf_mask & 0x01) {
> -			event = cpu_hw_evt->events[idx];
> -			hwc = &event->hw;
> -			max_period = riscv_pmu_ctr_get_width_mask(event);
> -			init_val = local64_read(&hwc->prev_count) & max_period;
>  #if defined(CONFIG_32BIT)
> -			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
> -				  flag, init_val, init_val >> 32, 0);
> +	hpmevent_curr = csr_ind_read(CSR_SIREG5, SISELECT_SSCCFG_BASE, counter_idx);
> +	of_mask = (u32)~HPMEVENTH_OF;
>  #else
> -			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
> -				  flag, init_val, 0, 0);
> +	hpmevent_curr = csr_ind_read(CSR_SIREG2, SISELECT_SSCCFG_BASE, counter_idx);
> +	of_mask = ~HPMEVENT_OF;
>  #endif
> -			perf_event_update_userpage(event);
> -		}
> -		ctr_ovf_mask = ctr_ovf_mask >> 1;
> -		idx++;
> -	}
> +
> +	hpmevent_curr &= of_mask;
> +#if defined(CONFIG_32BIT)
> +	csr_ind_write(CSR_SIREG5, SISELECT_SSCCFG_BASE, counter_idx, hpmevent_curr);
> +#else
> +	csr_ind_write(CSR_SIREG2, SISELECT_SSCCFG_BASE, counter_idx, hpmevent_curr);
> +#endif
> +}
> +
> +static void rvpmu_deleg_ctr_start(struct perf_event *event, u64 ival)
> +{
> +	unsigned long scountinhibit_val = 0;
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +#if defined(CONFIG_32BIT)
> +	csr_ind_write(CSR_SIREG, SISELECT_SSCCFG_BASE, hwc->idx, ival & 0xFFFFFFFF);
> +	csr_ind_write(CSR_SIREG4, SISELECT_SSCCFG_BASE, hwc->idx, ival >> BITS_PER_LONG);
> +#else
> +	csr_ind_write(CSR_SIREG, SISELECT_SSCCFG_BASE, hwc->idx, ival);
> +#endif
> +
> +	rvpmu_deleg_ctr_enable_irq(event);
> +
> +	scountinhibit_val = csr_read(CSR_SCOUNTINHIBIT);
> +	scountinhibit_val &= ~BIT(hwc->idx);
> +
> +	csr_write(CSR_SCOUNTINHIBIT, scountinhibit_val);
> +}
> +
> +static void rvpmu_deleg_ctr_stop_mask(unsigned long mask)
> +{
> +	unsigned long scountinhibit_val = 0;
> +
> +	scountinhibit_val = csr_read(CSR_SCOUNTINHIBIT);
> +	scountinhibit_val |= mask;
> +
> +	csr_write(CSR_SCOUNTINHIBIT, scountinhibit_val);
>  }
>  
> -static inline void rvpmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_evt,
> -						     u64 ctr_ovf_mask)
> +static void rvpmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_evt,
> +					      u64 ctr_ovf_mask)
>  {
>  	int i, idx = 0;
>  	struct perf_event *event;
> @@ -1116,15 +1269,53 @@ static inline void rvpmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_h
>  	}
>  }
>  
> -static void rvpmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> -					  u64 ctr_ovf_mask)
> +/*
> + * This function starts all the used counters in two step approach.
> + * Any counter that did not overflow can be start in a single step
> + * while the overflowed counters need to be started with updated initialization
> + * value.
> + */
> +static void rvpmu_start_overflow_mask(struct riscv_pmu *pmu, u64 ctr_ovf_mask)
>  {
> +	int idx = 0, i;
> +	struct perf_event *event;
> +	unsigned long ctr_start_mask = 0;
> +	u64 max_period, init_val = 0;
> +	struct hw_perf_event *hwc;
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>  
>  	if (sbi_pmu_snapshot_available())
> -		rvpmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask);
> -	else
> -		rvpmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
> +		return rvpmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask);
> +
> +	/* Start all the counters that did not overflow */
> +	if (riscv_pmu_cdeleg_available()) {
> +		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[0] & ~ctr_ovf_mask;
> +		rvpmu_deleg_ctr_start_mask(ctr_start_mask);
> +	} else {
> +		for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
> +			ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
> +			/* Start all the counters that did not overflow in a single shot */
> +			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG,
> +				  ctr_start_mask, 0, 0, 0, 0);
> +		}
> +	}
> +
> +	/* Reinitialize and start all the counter that overflowed */
> +	while (ctr_ovf_mask) {
> +		if (ctr_ovf_mask & 0x01) {
> +			event = cpu_hw_evt->events[idx];
> +			hwc = &event->hw;
> +			max_period = riscv_pmu_ctr_get_width_mask(event);
> +			init_val = local64_read(&hwc->prev_count) & max_period;
> +			if (riscv_pmu_cdeleg_available())
> +				rvpmu_deleg_ctr_start(event, init_val);
> +			else
> +				rvpmu_sbi_ctr_start(event, init_val);
> +			perf_event_update_userpage(event);
> +		}
> +		ctr_ovf_mask = ctr_ovf_mask >> 1;
> +		idx++;
> +	}
>  }
>  
>  static irqreturn_t rvpmu_ovf_handler(int irq, void *dev)
> @@ -1159,10 +1350,18 @@ static irqreturn_t rvpmu_ovf_handler(int irq, void *dev)
>  	}
>  
>  	pmu = to_riscv_pmu(event->pmu);
> -	rvpmu_sbi_stop_hw_ctrs(pmu);
> +	if (riscv_pmu_cdeleg_available())
> +		rvpmu_deleg_ctr_stop_mask(cpu_hw_evt->used_hw_ctrs[0]);
> +	else
> +		rvpmu_sbi_stop_hw_ctrs(pmu);
>  
> -	/* Overflow status register should only be read after counter are stopped */
> -	if (sbi_pmu_snapshot_available())
> +	/*
> +	 * Overflow status register should only be read after counter are stopped.
> +	 * In counter delegation mode the overflows are reported in scountovf, not
> +	 * in the SBI snapshot area, so read the CSR directly even when an SBI PMU
> +	 * snapshot is also available.
> +	 */
> +	if (sbi_pmu_snapshot_available() && !riscv_pmu_cdeleg_available())
>  		overflow = sdata->ctr_overflow_mask;
>  	else
>  		ALT_SBI_PMU_OVERFLOW(overflow);
> @@ -1228,22 +1427,183 @@ static irqreturn_t rvpmu_ovf_handler(int irq, void *dev)
>  		hw_evt->state = 0;
>  	}
>  
> -	rvpmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);
> +	rvpmu_start_overflow_mask(pmu, overflowed_ctrs);
>  	perf_sample_event_took(sched_clock() - start_clock);
>  
>  	return IRQ_HANDLED;
>  }
>  
> +static int get_deleg_hw_ctr_width(int counter_offset)
> +{
> +	unsigned long hpm_warl;
> +	int num_bits;
> +
> +	if (counter_offset < 3 || counter_offset > 31)
> +		return 0;
> +
> +	hpm_warl = csr_ind_warl(CSR_SIREG, SISELECT_SSCCFG_BASE, counter_offset, -1);
> +	if (!hpm_warl)
> +		return 0;
> +	num_bits = __fls(hpm_warl);
> +
> +#if defined(CONFIG_32BIT)
> +	/*
> +	 * The low half contributes a full BITS_PER_LONG bits when the counter is
> +	 * wider than 32 bits; the high half's __fls() gives the remaining width.
> +	 */
> +	hpm_warl = csr_ind_warl(CSR_SIREG4, SISELECT_SSCCFG_BASE, counter_offset, -1);
> +	if (hpm_warl)
> +		num_bits = BITS_PER_LONG + __fls(hpm_warl);
> +#endif
> +	return num_bits;
> +}
> +
> +static int rvpmu_deleg_find_ctrs(void)
> +{
> +	int i, num_hw_ctr = 0;
> +	union sbi_pmu_ctr_info cinfo;
> +	unsigned long scountinhibit_old = 0;
> +
> +	/* Do a WARL write/read to detect which hpmcounters have been delegated */
> +	scountinhibit_old = csr_read(CSR_SCOUNTINHIBIT);
> +	csr_write(CSR_SCOUNTINHIBIT, -1);
> +	cmask = csr_read(CSR_SCOUNTINHIBIT);
> +
> +	csr_write(CSR_SCOUNTINHIBIT, scountinhibit_old);
> +
> +	for_each_set_bit(i, &cmask, RISCV_MAX_HW_COUNTERS) {
> +		if (unlikely(i == 1))
> +			continue; /* This should never happen as TM is read only */
> +		cinfo.value = 0;
> +		cinfo.type = SBI_PMU_CTR_TYPE_HW;
> +		/*
> +		 * If counter delegation is enabled, the csr stored to the cinfo will
> +		 * be a virtual counter that the delegation attempts to read.
> +		 */
> +		cinfo.csr = CSR_CYCLE + i;
> +		if (i == 0 || i == 2)
> +			cinfo.width = 63;
> +		else
> +			cinfo.width = get_deleg_hw_ctr_width(i);
> +
> +		num_hw_ctr++;
> +		pmu_ctr_list[i].value = cinfo.value;
> +	}
> +
> +	return num_hw_ctr;
> +}
> +
> +static int get_deleg_fixed_hw_idx(struct cpu_hw_events *cpuc, struct perf_event *event)
> +{
> +	return -EINVAL;
> +}
> +
> +static int get_deleg_next_hpm_hw_idx(struct cpu_hw_events *cpuc, struct perf_event *event)
> +{
> +	unsigned long hw_ctr_mask = 0;
> +
> +	/*
> +	 * TODO: Treat every hpmcounter can monitor every event for now.
> +	 * The event to counter mapping should come from the json file.
> +	 * The mapping should also tell if sampling is supported or not.
> +	 */
> +
> +	/* Select only hpmcounters */
> +	hw_ctr_mask = cmask & (~0x7);
> +	hw_ctr_mask &= ~(cpuc->used_hw_ctrs[0]);
> +	return __ffs(hw_ctr_mask);
> +}
> +
> +static void update_deleg_hpmevent(int counter_idx, uint64_t event_value, uint64_t filter_bits)
> +{
> +	u64 hpmevent_value = 0;
> +
> +	/* OF bit should be enable during the start if sampling is requested */
> +	hpmevent_value = (event_value & ~HPMEVENT_MASK) | filter_bits | HPMEVENT_OF;
> +#if defined(CONFIG_32BIT)
> +	csr_ind_write(CSR_SIREG2, SISELECT_SSCCFG_BASE, counter_idx, hpmevent_value & 0xFFFFFFFF);
> +	if (riscv_isa_extension_available(NULL, SSCOFPMF))
> +		csr_ind_write(CSR_SIREG5, SISELECT_SSCCFG_BASE, counter_idx,
> +			      hpmevent_value >> BITS_PER_LONG);
> +#else
> +	csr_ind_write(CSR_SIREG2, SISELECT_SSCCFG_BASE, counter_idx, hpmevent_value);
> +#endif
> +}
> +
> +static int rvpmu_deleg_ctr_get_idx(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
> +	unsigned long hw_ctr_max_id;
> +	u64 priv_filter;
> +	int idx;
> +
> +	/*
> +	 * TODO: We should not rely on SBI Perf encoding to check if the event
> +	 * is a fixed one or not.
> +	 */
> +	if (!is_sampling_event(event)) {
> +		idx = get_deleg_fixed_hw_idx(cpuc, event);
> +		if (idx == 0 || idx == 2) {
> +			/* Priv mode filter bits are only available if smcntrpmf is present */
> +			if (riscv_isa_extension_available(NULL, SMCNTRPMF))
> +				goto found_idx;
> +			else
> +				goto skip_update;
> +		}
> +	}
> +
> +	if (!cmask)
> +		goto out_err;> +	hw_ctr_max_id = __fls(cmask);
> +	idx = get_deleg_next_hpm_hw_idx(cpuc, event);
> +	if (idx < 3 || idx > hw_ctr_max_id)
> +		goto out_err;
> +found_idx:
> +	priv_filter = get_deleg_priv_filter_bits(event);
> +	update_deleg_hpmevent(idx, hwc->config, priv_filter);
> +skip_update:
> +	if (!test_and_set_bit(idx, cpuc->used_hw_ctrs))

test is redundant, get_*_idx() above already gives a free idx

> +		return idx;
> +out_err:
> +	return -ENOENT;
> +}
> +
>  static void rvpmu_ctr_start(struct perf_event *event, u64 ival)
>  {
> -	rvpmu_sbi_ctr_start(event, ival);
> -	/* TODO: Counter delegation implementation */
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (riscv_pmu_cdeleg_available() && !pmu_sbi_is_fw_event(event))
> +		rvpmu_deleg_ctr_start(event, ival);
> +	else
> +		rvpmu_sbi_ctr_start(event, ival);
> +
> +	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
> +	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> +		rvpmu_set_scounteren((void *)event);
>  }
>  
>  static void rvpmu_ctr_stop(struct perf_event *event, unsigned long flag)
>  {
> -	rvpmu_sbi_ctr_stop(event, flag);
> -	/* TODO: Counter delegation implementation */
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
> +	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> +		rvpmu_reset_scounteren((void *)event);
> +
> +	if (riscv_pmu_cdeleg_available() && !pmu_sbi_is_fw_event(event)) {
> +		/*
> +		 * The counter is already stopped. No need to stop again. Counter
> +		 * mapping will be reset in clear_idx function.
> +		 */
> +		if (flag != RISCV_PMU_STOP_FLAG_RESET)
> +			rvpmu_deleg_ctr_stop_mask(BIT(hwc->idx));
> +		else
> +			update_deleg_hpmevent(hwc->idx, 0, 0);

will crash here if idx=0x1 (CY counter) and !SMCNTRPMF.

thanks.

> +	} else {
> +		rvpmu_sbi_ctr_stop(event, flag);
> +	}
>  }
>  
>  static int rvpmu_find_ctrs(void)
> @@ -1292,20 +1652,18 @@ static int rvpmu_find_ctrs(void)
>  
>  static int rvpmu_event_map(struct perf_event *event, u64 *econfig)
>  {
> -	return rvpmu_sbi_event_map(event, econfig);
> -	/* TODO: Counter delegation implementation */
> +	if (riscv_pmu_cdeleg_available() && !pmu_sbi_is_fw_event(event))
> +		return rvpmu_cdeleg_event_map(event, econfig);
> +	else
> +		return rvpmu_sbi_event_map(event, econfig);
>  }
>  
>  static int rvpmu_ctr_get_idx(struct perf_event *event)
>  {
> -	return rvpmu_sbi_ctr_get_idx(event);
> -	/* TODO: Counter delegation implementation */
> -}
> -
> -static u64 rvpmu_ctr_read(struct perf_event *event)
> -{
> -	return rvpmu_sbi_ctr_read(event);
> -	/* TODO: Counter delegation implementation */
> +	if (riscv_pmu_cdeleg_available() && !pmu_sbi_is_fw_event(event))
> +		return rvpmu_deleg_ctr_get_idx(event);
> +	else
> +		return rvpmu_sbi_ctr_get_idx(event);
>  }
>  
>  static int rvpmu_starting_cpu(unsigned int cpu, struct hlist_node *node)
> @@ -1323,7 +1681,16 @@ static int rvpmu_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  		csr_write(CSR_SCOUNTEREN, 0x2);
>  
>  	/* Stop all the counters so that they can be enabled from perf */
> -	rvpmu_sbi_stop_all(pmu);
> +	if (riscv_pmu_cdeleg_available()) {
> +		rvpmu_deleg_ctr_stop_mask(cmask);
> +		if (riscv_pmu_sbi_available()) {
> +			/* Stop the firmware counters as well */
> +			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0, firmware_cmask,
> +				  0, 0, 0, 0);
> +		}
> +	} else {
> +		rvpmu_sbi_stop_all(pmu);
> +	}
>  
>  	if (riscv_pmu_use_irq) {
>  		cpu_hw_evt->irq = riscv_pmu_irq;
> @@ -1632,8 +1999,11 @@ static int rvpmu_device_probe(struct platform_device *pdev)
>  	}
>  	irq_requested = (ret == 0);
>  
> -	pmu->pmu.attr_groups = riscv_pmu_attr_groups;
>  	pmu->pmu.parent = &pdev->dev;
> +	if (riscv_pmu_cdeleg_available_boot())
> +		pmu->pmu.attr_groups = riscv_cdeleg_pmu_attr_groups;
> +	else
> +		pmu->pmu.attr_groups = riscv_sbi_pmu_attr_groups;
>  	pmu->cmask = cmask;
>  	pmu->ctr_start = rvpmu_ctr_start;
>  	pmu->ctr_stop = rvpmu_ctr_stop;
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
> index f82a28040594..3c64151cb038 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -20,6 +20,7 @@
>   */
>  
>  #define RISCV_MAX_COUNTERS	64
> +#define RISCV_MAX_HW_COUNTERS	32
>  #define RISCV_OP_UNSUPP		(-EOPNOTSUPP)
>  #define RISCV_PMU_SBI_PDEV_NAME	"riscv-pmu-sbi"
>  #define RISCV_PMU_LEGACY_PDEV_NAME	"riscv-pmu-legacy"
> @@ -28,6 +29,8 @@
>  
>  #define RISCV_PMU_CONFIG1_GUEST_EVENTS 0x1
>  
> +#define RISCV_PMU_DELEG_RAW_EVENT_MASK GENMASK_ULL(55, 0)
> +
>  struct cpu_hw_events {
>  	/* currently enabled events */
>  	int			n_events;
