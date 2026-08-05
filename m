Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6130DEA3;
	Wed,  5 Aug 2026 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896953; cv=none; b=bIvmuBmDJ2w9dGtN9ARuJLrjHqeIIWgcnRqzdz4cI5YzKOrFEuTcKReqwR9KdOUCrteX9yNCuSUzUg9Ev7zKTf7SSRelJsPFrP63fOjvK/az4LvChB0Ap5AK/2Y7/f5Aw1QKuPaZXGBV5mHgV01oUPc2jjBJxZ1AUyLWmNyP77s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896953; c=relaxed/simple;
	bh=XMzdKprmN5Bux9FcUQ1TuFRBY0A8WNnJDFUwFqk2gTI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CpyflbPE4KiT4c9OPZ2z6+43ybrNePini60aenNFu0Bom6tvlkC9n6EpG1A6PAif23WjuIH8QDojQwrMMmAKJ4HkJL3DzkDrVxgRV9fxzwKQrkUWxaH2LtMI0MMb5OHFWBdSqqhcM1ZfNXS5c3zRTjtRcXu/WCg+b2949O8MVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMey92wV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMey92wV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC29B1F000E9;
	Wed,  5 Aug 2026 02:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896950;
	bh=eXGrDXUMERcIvp1Z9BtH2ihtIAx1DTdV1LqUVFhCdDU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=OMey92wVAFWJDRdxuGtdxxSZ9Gbvj8mpbfEAjjHol97vV6hB/SJULbHslo7ivUi3c
	 W4vVc0J1a+VKT+8v/f+ghm0WYhz7tsDkY+ViGZkXG0nW6EB7iyusNZ8GAXj9+FaeTi
	 N8FOI80/emvyY/LgvI6HTVbwrGVPIxSWFR0/mCE7NYAVFYvpBN18ZMuVPWGMjy6idA
	 C41dXipPxn8EsNg0Fe1FEx7DxiKhZ95U7dW2h7WcN83Re8QjbvocTKYwWJV8mOIBP7
	 jgYJR3vmXs4r8wv1V6M76Rq4ckR4uarob/yForIyrOJw+MJE+P+yij4ulmKfR75IvI
	 b3xn9q+ivaFPg==
Date: Tue, 4 Aug 2026 20:29:08 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Atish Patra <atish.patra@linux.dev>
cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
    Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>, 
    Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
    linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v8 11/22] RISC-V: perf: Restructure the SBI PMU code
In-Reply-To: <20260701-counter_delegation-v8-11-7909f863a645@meta.com>
Message-ID: <150f3f8e-9a94-ecbc-4e1c-e1d1c476f5e9@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-11-7909f863a645@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Atish,

On Wed, 1 Jul 2026, Atish Patra wrote:

> From: Atish Patra <atishp@rivosinc.com>
> 
> With Ssccfg/Smcdeleg, supervisor mode can program and access the
> hpmcounters and events directly, without the SBI PMU extension. The SBI
> PMU extension is still required for firmware counters. Restructure the
> existing SBI PMU code so the hpmcounter/event helpers can be shared
> between the SBI and the counter delegation paths that follow.
> 
> The driver, file, module and Kconfig names are intentionally kept
> unchanged to avoid backport churn and userspace breakage (module listings,
> udev rules, cmdline options).
> 
> No functional change intended.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Could you write a little bit more about the specific motivation 
behind these changes?  I see three major themes:

1. adding _sbi_ to some variable names

2. changing "pmu" to "rvpmu" in some function names

3. removing _sbi_ from some function names

I'm assuming, maybe incorrectly, that the intent for #1 and #3 is to note 
that the variables in #1 are specific to SBI interactions, and that the 
functions in #3 don't use SBI, so shouldn't have SBI in their names.  But 
not sure what's going on with #2.  Is this just a cosmetic change to 
disambiguate the generic "pmu" abbreviation?  I see we have a bunch of 
references to "riscv_pmu", still, that aren't being changed by those 
patches - should we just use that instead so we don't have a jumble of 
different prefixes here?  Or is there supposed to be some semantic 
difference between the two?  In the past, it seems we only used "rvpmu" 
when struct riscv_pmu was involved; but seems that distinction is no 
longer applicable after this series.


thanks, 

- Paul

> ---
>  drivers/perf/Kconfig         |  14 ++-
>  drivers/perf/riscv_pmu_sbi.c | 238 +++++++++++++++++++++++++------------------
>  2 files changed, 150 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index ab90932fc2d0..3245bb2969e1 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -97,13 +97,17 @@ config RISCV_PMU_LEGACY
>  
>  config RISCV_PMU_SBI
>  	depends on RISCV_PMU && RISCV_SBI
> -	bool "RISC-V PMU based on SBI PMU extension"
> +	bool "RISC-V PMU based on SBI PMU extension and/or counter delegation"
>  	default y
>  	help
> -	  Say y if you want to use the CPU performance monitor
> -	  using SBI PMU extension on RISC-V based systems. This option provides
> -	  full perf feature support i.e. counter overflow, privilege mode
> -	  filtering, counter configuration.
> +	  Say y if you want to use the CPU performance monitor on RISC-V based
> +	  systems. This single driver supports both hardware counter access
> +	  mechanisms: it uses the counter delegation (Smcdeleg/Ssccfg) ISA
> +	  extension to program and read the hpmcounters directly in supervisor
> +	  mode when available, and uses the SBI PMU extension for firmware
> +	  counters and when counter delegation is not present. This option
> +	  provides full perf feature support i.e. counter overflow, privilege
> +	  mode filtering, counter configuration.
>  
>  config STARFIVE_STARLINK_PMU
>  	depends on ARCH_STARFIVE || COMPILE_TEST
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 5c8924ce1f38..74d934238821 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -88,6 +88,8 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
>  static int sysctl_perf_user_access __read_mostly = SYSCTL_USER_ACCESS;
>  
>  /*
> + * This structure is SBI specific but counter delegation also require counter
> + * width, csr mapping. Reuse it for now.
>   * RISC-V doesn't have heterogeneous harts yet. This need to be part of
>   * per_cpu in case of harts with different pmu counters
>   */
> @@ -100,7 +102,7 @@ static unsigned int riscv_pmu_irq;
>  /* Cache the available counters in a bitmask */
>  static unsigned long cmask;
>  
> -static int pmu_event_find_cache(u64 config);
> +static int sbi_pmu_event_find_cache(u64 config);
>  struct sbi_pmu_event_data {
>  	union {
>  		union {
> @@ -121,7 +123,7 @@ struct sbi_pmu_event_data {
>  	};
>  };
>  
> -static struct sbi_pmu_event_data pmu_hw_event_map[] = {
> +static struct sbi_pmu_event_data pmu_hw_event_sbi_map[] = {
>  	[PERF_COUNT_HW_CPU_CYCLES]		= {.hw_gen_event = {
>  							SBI_PMU_HW_CPU_CYCLES,
>  							SBI_PMU_EVENT_TYPE_HW, 0}},
> @@ -155,7 +157,7 @@ static struct sbi_pmu_event_data pmu_hw_event_map[] = {
>  };
>  
>  #define C(x) PERF_COUNT_HW_CACHE_##x
> -static struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
> +static struct sbi_pmu_event_data pmu_cache_event_sbi_map[PERF_COUNT_HW_CACHE_MAX]
>  [PERF_COUNT_HW_CACHE_OP_MAX]
>  [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
>  	[C(L1D)] = {
> @@ -302,7 +304,7 @@ static struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
>  
>  static int pmu_sbi_check_event_info(void)
>  {
> -	int num_events = ARRAY_SIZE(pmu_hw_event_map) + PERF_COUNT_HW_CACHE_MAX *
> +	int num_events = ARRAY_SIZE(pmu_hw_event_sbi_map) + PERF_COUNT_HW_CACHE_MAX *
>  			 PERF_COUNT_HW_CACHE_OP_MAX * PERF_COUNT_HW_CACHE_RESULT_MAX;
>  	struct riscv_pmu_event_info *event_info_shmem;
>  	phys_addr_t base_addr;
> @@ -313,14 +315,14 @@ static int pmu_sbi_check_event_info(void)
>  	if (!event_info_shmem)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
> -		event_info_shmem[count++].event_idx = pmu_hw_event_map[i].event_idx;
> +	for (i = 0; i < ARRAY_SIZE(pmu_hw_event_sbi_map); i++)
> +		event_info_shmem[count++].event_idx = pmu_hw_event_sbi_map[i].event_idx;
>  
> -	for (i = 0; i < ARRAY_SIZE(pmu_cache_event_map); i++) {
> -		for (j = 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++) {
> -			for (k = 0; k < ARRAY_SIZE(pmu_cache_event_map[i][j]); k++)
> +	for (i = 0; i < ARRAY_SIZE(pmu_cache_event_sbi_map); i++) {
> +		for (j = 0; j < ARRAY_SIZE(pmu_cache_event_sbi_map[i]); j++) {
> +			for (k = 0; k < ARRAY_SIZE(pmu_cache_event_sbi_map[i][j]); k++)
>  				event_info_shmem[count++].event_idx =
> -							pmu_cache_event_map[i][j][k].event_idx;
> +							pmu_cache_event_sbi_map[i][j][k].event_idx;
>  		}
>  	}
>  
> @@ -336,19 +338,19 @@ static int pmu_sbi_check_event_info(void)
>  		goto free_mem;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++) {
> +	for (i = 0; i < ARRAY_SIZE(pmu_hw_event_sbi_map); i++) {
>  		if (!(event_info_shmem[i].output & RISCV_PMU_EVENT_INFO_OUTPUT_MASK))
> -			pmu_hw_event_map[i].event_idx = -ENOENT;
> +			pmu_hw_event_sbi_map[i].event_idx = -ENOENT;
>  	}
>  
> -	count = ARRAY_SIZE(pmu_hw_event_map);
> +	count = ARRAY_SIZE(pmu_hw_event_sbi_map);
>  
> -	for (i = 0; i < ARRAY_SIZE(pmu_cache_event_map); i++) {
> -		for (j = 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++) {
> -			for (k = 0; k < ARRAY_SIZE(pmu_cache_event_map[i][j]); k++) {
> +	for (i = 0; i < ARRAY_SIZE(pmu_cache_event_sbi_map); i++) {
> +		for (j = 0; j < ARRAY_SIZE(pmu_cache_event_sbi_map[i]); j++) {
> +			for (k = 0; k < ARRAY_SIZE(pmu_cache_event_sbi_map[i][j]); k++) {
>  				if (!(event_info_shmem[count].output &
>  				      RISCV_PMU_EVENT_INFO_OUTPUT_MASK))
> -					pmu_cache_event_map[i][j][k].event_idx = -ENOENT;
> +					pmu_cache_event_sbi_map[i][j][k].event_idx = -ENOENT;
>  				count++;
>  			}
>  		}
> @@ -360,7 +362,7 @@ static int pmu_sbi_check_event_info(void)
>  	return result;
>  }
>  
> -static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
> +static void rvpmu_sbi_check_event(struct sbi_pmu_event_data *edata)
>  {
>  	struct sbiret ret;
>  
> @@ -375,7 +377,7 @@ static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
>  	}
>  }
>  
> -static void pmu_sbi_check_std_events(struct work_struct *work)
> +static void rvpmu_sbi_check_std_events(struct work_struct *work)
>  {
>  	int ret;
>  
> @@ -386,23 +388,23 @@ static void pmu_sbi_check_std_events(struct work_struct *work)
>  		return;
>  	}
>  
> -	for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
> -		pmu_sbi_check_event(&pmu_hw_event_map[i]);
> +	for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_sbi_map); i++)
> +		rvpmu_sbi_check_event(&pmu_hw_event_sbi_map[i]);
>  
> -	for (int i = 0; i < ARRAY_SIZE(pmu_cache_event_map); i++)
> -		for (int j = 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++)
> -			for (int k = 0; k < ARRAY_SIZE(pmu_cache_event_map[i][j]); k++)
> -				pmu_sbi_check_event(&pmu_cache_event_map[i][j][k]);
> +	for (int i = 0; i < ARRAY_SIZE(pmu_cache_event_sbi_map); i++)
> +		for (int j = 0; j < ARRAY_SIZE(pmu_cache_event_sbi_map[i]); j++)
> +			for (int k = 0; k < ARRAY_SIZE(pmu_cache_event_sbi_map[i][j]); k++)
> +				rvpmu_sbi_check_event(&pmu_cache_event_sbi_map[i][j][k]);
>  }
>  
> -static DECLARE_WORK(check_std_events_work, pmu_sbi_check_std_events);
> +static DECLARE_WORK(check_std_events_work, rvpmu_sbi_check_std_events);
>  
> -static int pmu_sbi_ctr_get_width(int idx)
> +static int rvpmu_ctr_get_width(int idx)
>  {
>  	return pmu_ctr_list[idx].width;
>  }
>  
> -static bool pmu_sbi_ctr_is_fw(int cidx)
> +static bool rvpmu_ctr_is_fw(int cidx)
>  {
>  	union sbi_pmu_ctr_info *info;
>  
> @@ -421,10 +423,10 @@ int riscv_pmu_get_event_info(u32 type, u64 config, u64 *econfig)
>  	case PERF_TYPE_HARDWARE:
>  		if (config >= PERF_COUNT_HW_MAX)
>  			return -EINVAL;
> -		ret = pmu_hw_event_map[config].event_idx;
> +		ret = pmu_hw_event_sbi_map[config].event_idx;
>  		break;
>  	case PERF_TYPE_HW_CACHE:
> -		ret = pmu_event_find_cache(config);
> +		ret = sbi_pmu_event_find_cache(config);
>  		break;
>  	case PERF_TYPE_RAW:
>  		/*
> @@ -509,12 +511,12 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr)
>  }
>  EXPORT_SYMBOL_GPL(riscv_pmu_get_hpm_info);
>  
> -static uint8_t pmu_sbi_csr_index(struct perf_event *event)
> +static uint8_t rvpmu_csr_index(struct perf_event *event)
>  {
>  	return pmu_ctr_list[event->hw.idx].csr - CSR_CYCLE;
>  }
>  
> -static unsigned long pmu_sbi_get_filter_flags(struct perf_event *event)
> +static unsigned long rvpmu_sbi_get_filter_flags(struct perf_event *event)
>  {
>  	unsigned long cflags = 0;
>  	bool guest_events = false;
> @@ -535,7 +537,7 @@ static unsigned long pmu_sbi_get_filter_flags(struct perf_event *event)
>  	return cflags;
>  }
>  
> -static int pmu_sbi_ctr_get_idx(struct perf_event *event)
> +static int rvpmu_sbi_ctr_get_idx(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> @@ -545,7 +547,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
>  	uint64_t cbase = 0, cmask = rvpmu->cmask;
>  	unsigned long cflags = 0;
>  
> -	cflags = pmu_sbi_get_filter_flags(event);
> +	cflags = rvpmu_sbi_get_filter_flags(event);
>  
>  	/*
>  	 * In legacy mode, we have to force the fixed counters for those events
> @@ -582,7 +584,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
>  		return -ENOENT;
>  
>  	/* Additional sanity check for the counter id */
> -	if (pmu_sbi_ctr_is_fw(idx)) {
> +	if (rvpmu_ctr_is_fw(idx)) {
>  		if (!test_and_set_bit(idx, cpuc->used_fw_ctrs))
>  			return idx;
>  	} else {
> @@ -593,7 +595,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
>  	return -ENOENT;
>  }
>  
> -static void pmu_sbi_ctr_clear_idx(struct perf_event *event)
> +static void rvpmu_ctr_clear_idx(struct perf_event *event)
>  {
>  
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -601,13 +603,13 @@ static void pmu_sbi_ctr_clear_idx(struct perf_event *event)
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
>  	int idx = hwc->idx;
>  
> -	if (pmu_sbi_ctr_is_fw(idx))
> +	if (rvpmu_ctr_is_fw(idx))
>  		clear_bit(idx, cpuc->used_fw_ctrs);
>  	else
>  		clear_bit(idx, cpuc->used_hw_ctrs);
>  }
>  
> -static int pmu_event_find_cache(u64 config)
> +static int sbi_pmu_event_find_cache(u64 config)
>  {
>  	unsigned int cache_type, cache_op, cache_result, ret;
>  
> @@ -623,7 +625,7 @@ static int pmu_event_find_cache(u64 config)
>  	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
>  		return -EINVAL;
>  
> -	ret = pmu_cache_event_map[cache_type][cache_op][cache_result].event_idx;
> +	ret = pmu_cache_event_sbi_map[cache_type][cache_op][cache_result].event_idx;
>  
>  	return ret;
>  }
> @@ -639,7 +641,7 @@ static bool pmu_sbi_is_fw_event(struct perf_event *event)
>  		return false;
>  }
>  
> -static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
> +static int rvpmu_sbi_event_map(struct perf_event *event, u64 *econfig)
>  {
>  	u32 type = event->attr.type;
>  	u64 config = event->attr.config;
> @@ -736,7 +738,7 @@ static int pmu_sbi_snapshot_setup(struct riscv_pmu *pmu, int cpu)
>  	return 0;
>  }
>  
> -static u64 pmu_sbi_ctr_read(struct perf_event *event)
> +static u64 rvpmu_sbi_ctr_read(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx = hwc->idx;
> @@ -778,25 +780,25 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
>  	return val;
>  }
>  
> -static void pmu_sbi_set_scounteren(void *arg)
> +static void rvpmu_set_scounteren(void *arg)
>  {
>  	struct perf_event *event = (struct perf_event *)arg;
>  
>  	if (event->hw.idx != -1)
>  		csr_write(CSR_SCOUNTEREN,
> -			  csr_read(CSR_SCOUNTEREN) | BIT(pmu_sbi_csr_index(event)));
> +			  csr_read(CSR_SCOUNTEREN) | BIT(rvpmu_csr_index(event)));
>  }
>  
> -static void pmu_sbi_reset_scounteren(void *arg)
> +static void rvpmu_reset_scounteren(void *arg)
>  {
>  	struct perf_event *event = (struct perf_event *)arg;
>  
>  	if (event->hw.idx != -1)
>  		csr_write(CSR_SCOUNTEREN,
> -			  csr_read(CSR_SCOUNTEREN) & ~BIT(pmu_sbi_csr_index(event)));
> +			  csr_read(CSR_SCOUNTEREN) & ~BIT(rvpmu_csr_index(event)));
>  }
>  
> -static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
> +static void rvpmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>  {
>  	struct sbiret ret;
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -816,10 +818,10 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>  
>  	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
>  	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> -		pmu_sbi_set_scounteren((void *)event);
> +		rvpmu_set_scounteren((void *)event);
>  }
>  
> -static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
> +static void rvpmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
>  {
>  	struct sbiret ret;
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -829,7 +831,7 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
>  
>  	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
>  	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> -		pmu_sbi_reset_scounteren((void *)event);
> +		rvpmu_reset_scounteren((void *)event);
>  
>  	if (sbi_pmu_snapshot_available())
>  		flag |= SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
> @@ -855,7 +857,7 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
>  	}
>  }
>  
> -static int pmu_sbi_find_num_ctrs(void)
> +static int rvpmu_sbi_find_num_ctrs(void)
>  {
>  	struct sbiret ret;
>  
> @@ -866,7 +868,7 @@ static int pmu_sbi_find_num_ctrs(void)
>  		return sbi_err_map_linux_errno(ret.error);
>  }
>  
> -static int pmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
> +static int rvpmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
>  {
>  	struct sbiret ret;
>  	int i, num_hw_ctr = 0, num_fw_ctr = 0;
> @@ -897,7 +899,7 @@ static int pmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
>  	return 0;
>  }
>  
> -static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
> +static inline void rvpmu_sbi_stop_all(struct riscv_pmu *pmu)
>  {
>  	/*
>  	 * No need to check the error because we are disabling all the counters
> @@ -907,7 +909,7 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
>  		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
>  }
>  
> -static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
> +static inline void rvpmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  {
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>  	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
> @@ -951,8 +953,8 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>   * while the overflowed counters need to be started with updated initialization
>   * value.
>   */
> -static inline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
> -					      u64 ctr_ovf_mask)
> +static inline void rvpmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
> +						u64 ctr_ovf_mask)
>  {
>  	int idx = 0, i;
>  	struct perf_event *event;
> @@ -992,8 +994,8 @@ static inline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
>  	}
>  }
>  
> -static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_evt,
> -						   u64 ctr_ovf_mask)
> +static inline void rvpmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_evt,
> +						     u64 ctr_ovf_mask)
>  {
>  	int i, idx = 0;
>  	struct perf_event *event;
> @@ -1027,18 +1029,18 @@ static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_
>  	}
>  }
>  
> -static void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> -					u64 ctr_ovf_mask)
> +static void rvpmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> +					  u64 ctr_ovf_mask)
>  {
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>  
>  	if (sbi_pmu_snapshot_available())
> -		pmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask);
> +		rvpmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask);
>  	else
> -		pmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
> +		rvpmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
>  }
>  
> -static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
> +static irqreturn_t rvpmu_ovf_handler(int irq, void *dev)
>  {
>  	struct perf_sample_data data;
>  	struct pt_regs *regs;
> @@ -1070,7 +1072,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	}
>  
>  	pmu = to_riscv_pmu(event->pmu);
> -	pmu_sbi_stop_hw_ctrs(pmu);
> +	rvpmu_sbi_stop_hw_ctrs(pmu);
>  
>  	/* Overflow status register should only be read after counter are stopped */
>  	if (sbi_pmu_snapshot_available())
> @@ -1139,13 +1141,55 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  		hw_evt->state = 0;
>  	}
>  
> -	pmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);
> +	rvpmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);
>  	perf_sample_event_took(sched_clock() - start_clock);
>  
>  	return IRQ_HANDLED;
>  }
>  
> -static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
> +static void rvpmu_ctr_start(struct perf_event *event, u64 ival)
> +{
> +	rvpmu_sbi_ctr_start(event, ival);
> +	/* TODO: Counter delegation implementation */
> +}
> +
> +static void rvpmu_ctr_stop(struct perf_event *event, unsigned long flag)
> +{
> +	rvpmu_sbi_ctr_stop(event, flag);
> +	/* TODO: Counter delegation implementation */
> +}
> +
> +static int rvpmu_find_num_ctrs(void)
> +{
> +	return rvpmu_sbi_find_num_ctrs();
> +	/* TODO: Counter delegation implementation */
> +}
> +
> +static int rvpmu_get_ctrinfo(int nctr, unsigned long *mask)
> +{
> +	return rvpmu_sbi_get_ctrinfo(nctr, mask);
> +	/* TODO: Counter delegation implementation */
> +}
> +
> +static int rvpmu_event_map(struct perf_event *event, u64 *econfig)
> +{
> +	return rvpmu_sbi_event_map(event, econfig);
> +	/* TODO: Counter delegation implementation */
> +}
> +
> +static int rvpmu_ctr_get_idx(struct perf_event *event)
> +{
> +	return rvpmu_sbi_ctr_get_idx(event);
> +	/* TODO: Counter delegation implementation */
> +}
> +
> +static u64 rvpmu_ctr_read(struct perf_event *event)
> +{
> +	return rvpmu_sbi_ctr_read(event);
> +	/* TODO: Counter delegation implementation */
> +}
> +
> +static int rvpmu_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
> @@ -1160,7 +1204,7 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  		csr_write(CSR_SCOUNTEREN, 0x2);
>  
>  	/* Stop all the counters so that they can be enabled from perf */
> -	pmu_sbi_stop_all(pmu);
> +	rvpmu_sbi_stop_all(pmu);
>  
>  	if (riscv_pmu_use_irq) {
>  		cpu_hw_evt->irq = riscv_pmu_irq;
> @@ -1174,7 +1218,7 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  	return 0;
>  }
>  
> -static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
> +static int rvpmu_dying_cpu(unsigned int cpu, struct hlist_node *node)
>  {
>  	if (riscv_pmu_use_irq) {
>  		disable_percpu_irq(riscv_pmu_irq);
> @@ -1189,7 +1233,7 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
>  	return 0;
>  }
>  
> -static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pdev)
> +static int rvpmu_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pdev)
>  {
>  	int ret;
>  	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
> @@ -1231,7 +1275,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
>  		goto err;
>  	}
>  
> -	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_handler, "riscv-pmu", hw_events);
> +	ret = request_percpu_irq(riscv_pmu_irq, rvpmu_ovf_handler, "riscv-pmu", hw_events);
>  	if (ret) {
>  		pr_err("registering percpu irq failed [%d]\n", ret);
>  		irq_dispose_mapping(riscv_pmu_irq);
> @@ -1313,7 +1357,7 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>  		cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>  }
>  
> -static void pmu_sbi_event_init(struct perf_event *event)
> +static void rvpmu_event_init(struct perf_event *event)
>  {
>  	/*
>  	 * The permissions are set at event_init so that we do not depend
> @@ -1327,7 +1371,7 @@ static void pmu_sbi_event_init(struct perf_event *event)
>  		event->hw.flags |= PERF_EVENT_FLAG_LEGACY;
>  }
>  
> -static void pmu_sbi_event_mapped(struct perf_event *event, struct mm_struct *mm)
> +static void rvpmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
>  {
>  	if (event->hw.flags & PERF_EVENT_FLAG_NO_USER_ACCESS)
>  		return;
> @@ -1355,14 +1399,14 @@ static void pmu_sbi_event_mapped(struct perf_event *event, struct mm_struct *mm)
>  	 * that it is possible to do so to avoid any race.
>  	 * And we must notify all cpus here because threads that currently run
>  	 * on other cpus will try to directly access the counter too without
> -	 * calling pmu_sbi_ctr_start.
> +	 * calling rvpmu_sbi_ctr_start.
>  	 */
>  	if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
>  		on_each_cpu_mask(mm_cpumask(mm),
> -				 pmu_sbi_set_scounteren, (void *)event, 1);
> +				 rvpmu_set_scounteren, (void *)event, 1);
>  }
>  
> -static void pmu_sbi_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> +static void rvpmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
>  {
>  	if (event->hw.flags & PERF_EVENT_FLAG_NO_USER_ACCESS)
>  		return;
> @@ -1384,7 +1428,7 @@ static void pmu_sbi_event_unmapped(struct perf_event *event, struct mm_struct *m
>  
>  	if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
>  		on_each_cpu_mask(mm_cpumask(mm),
> -				 pmu_sbi_reset_scounteren, (void *)event, 1);
> +				 rvpmu_reset_scounteren, (void *)event, 1);
>  }
>  
>  static void riscv_pmu_update_counter_access(void *info)
> @@ -1427,7 +1471,7 @@ static const struct ctl_table sbi_pmu_sysctl_table[] = {
>  	},
>  };
>  
> -static int pmu_sbi_device_probe(struct platform_device *pdev)
> +static int rvpmu_device_probe(struct platform_device *pdev)
>  {
>  	struct riscv_pmu *pmu = NULL;
>  	int ret = -ENODEV;
> @@ -1439,7 +1483,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	if (!pmu)
>  		return -ENOMEM;
>  
> -	num_counters = pmu_sbi_find_num_ctrs();
> +	num_counters = rvpmu_find_num_ctrs();
>  	if (num_counters < 0) {
>  		pr_err("SBI PMU extension doesn't provide any counters\n");
>  		goto out_free;
> @@ -1452,10 +1496,10 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	}
>  
>  	/* cache all the information about counters now */
> -	if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
> +	if (rvpmu_get_ctrinfo(num_counters, &cmask))
>  		goto out_free;
>  
> -	ret = pmu_sbi_setup_irqs(pmu, pdev);
> +	ret = rvpmu_setup_irqs(pmu, pdev);
>  	if (ret < 0) {
>  		pr_info("Perf sampling/filtering is not supported as sscof extension is not available\n");
>  		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
> @@ -1466,17 +1510,17 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	pmu->pmu.attr_groups = riscv_pmu_attr_groups;
>  	pmu->pmu.parent = &pdev->dev;
>  	pmu->cmask = cmask;
> -	pmu->ctr_start = pmu_sbi_ctr_start;
> -	pmu->ctr_stop = pmu_sbi_ctr_stop;
> -	pmu->event_map = pmu_sbi_event_map;
> -	pmu->ctr_get_idx = pmu_sbi_ctr_get_idx;
> -	pmu->ctr_get_width = pmu_sbi_ctr_get_width;
> -	pmu->ctr_clear_idx = pmu_sbi_ctr_clear_idx;
> -	pmu->ctr_read = pmu_sbi_ctr_read;
> -	pmu->event_init = pmu_sbi_event_init;
> -	pmu->event_mapped = pmu_sbi_event_mapped;
> -	pmu->event_unmapped = pmu_sbi_event_unmapped;
> -	pmu->csr_index = pmu_sbi_csr_index;
> +	pmu->ctr_start = rvpmu_ctr_start;
> +	pmu->ctr_stop = rvpmu_ctr_stop;
> +	pmu->event_map = rvpmu_event_map;
> +	pmu->ctr_get_idx = rvpmu_ctr_get_idx;
> +	pmu->ctr_get_width = rvpmu_ctr_get_width;
> +	pmu->ctr_clear_idx = rvpmu_ctr_clear_idx;
> +	pmu->ctr_read = rvpmu_ctr_read;
> +	pmu->event_init = rvpmu_event_init;
> +	pmu->event_mapped = rvpmu_event_mapped;
> +	pmu->event_unmapped = rvpmu_event_unmapped;
> +	pmu->csr_index = rvpmu_csr_index;
>  
>  	ret = riscv_pm_pmu_register(pmu);
>  	if (ret)
> @@ -1543,14 +1587,14 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static struct platform_driver pmu_sbi_driver = {
> -	.probe		= pmu_sbi_device_probe,
> +static struct platform_driver rvpmu_driver = {
> +	.probe		= rvpmu_device_probe,
>  	.driver		= {
>  		.name	= RISCV_PMU_SBI_PDEV_NAME,
>  	},
>  };
>  
> -static int __init pmu_sbi_devinit(void)
> +static int __init rvpmu_devinit(void)
>  {
>  	int ret;
>  	struct platform_device *pdev;
> @@ -1568,20 +1612,20 @@ static int __init pmu_sbi_devinit(void)
>  
>  	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
>  				      "perf/riscv/pmu:starting",
> -				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);
> +				      rvpmu_starting_cpu, rvpmu_dying_cpu);
>  	if (ret) {
>  		pr_err("CPU hotplug notifier could not be registered: %d\n",
>  		       ret);
>  		return ret;
>  	}
>  
> -	ret = platform_driver_register(&pmu_sbi_driver);
> +	ret = platform_driver_register(&rvpmu_driver);
>  	if (ret)
>  		return ret;
>  
>  	pdev = platform_device_register_simple(RISCV_PMU_SBI_PDEV_NAME, -1, NULL, 0);
>  	if (IS_ERR(pdev)) {
> -		platform_driver_unregister(&pmu_sbi_driver);
> +		platform_driver_unregister(&rvpmu_driver);
>  		return PTR_ERR(pdev);
>  	}
>  
> @@ -1590,4 +1634,4 @@ static int __init pmu_sbi_devinit(void)
>  
>  	return ret;
>  }
> -device_initcall(pmu_sbi_devinit)
> +device_initcall(rvpmu_devinit)
> 
> -- 
> 2.53.0-Meta
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
