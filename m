Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ABC1C3BFC;
	Mon, 19 Jan 2026 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808933; cv=none; b=Pl+IVH48qIEeAQszWVzTYZCJkLEEttitNIyZQD0pISk6Y2XZZsTiH+D+B9BfNg/wTsmkrK2FuiqbjinPtU0CgenJwh0mh5B/Z4qqKYJBxmD8J3jB4lHnBHBj2f/iEtAhpBytPEz5YoMQhk/RTbxi1ZrKy3xRC7ckn1Akg4PuPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808933; c=relaxed/simple;
	bh=iHrfcL3C1cOAn1xTPRfjRVF+JwBDrEg3qrN0QYHytS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TR9BvwuOmPyNzRASPNp9Vu6eLmDHil87X18nQzevzT+mx99dvAHRdSW+gacV0uCMaLSfQzt3BUbc2+y6/KQ4ANqBPdqe1JumEhg+ZC7eNVXe7aJxZh5kSkpBiQVjBAvzy78q8UFH5GU5ZO0iWyBGSiknGP0XOIAaTLPzO3z/3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4d2HlA+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4d2HlA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768808932; x=1800344932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iHrfcL3C1cOAn1xTPRfjRVF+JwBDrEg3qrN0QYHytS8=;
  b=Y4d2HlA+8lWiua4zE/URkhYEsvIpHsdggE6Ov1RCdcK4DLP1JCHy6spn
   HckCNeOP6Bj/8mNv2M+LAAVbxXOp/ckqNCnMZY4G9n4xG4s6QCklT1p79
   Eephli9mDLK+58clJCu9cX6PJTXCJk3rQuhF94TaV+KhZMVeF8ZiZIxkN
   PGJsO7cl8vkNgdzLZgTKHLjoAq/0J0IOKJhsiNwuep3TRV+qzhAclE+Uy
   6mdRHXjxlxlYEPfsQ0o+lLB1VzGWiB9GgCGPYJjktEi7ZmD5LGiHGuRdW
   GG1EcvlfIpeExrMtWLAqPPPgiVrs/NhlxdgVTViGi8HXh9J4SlJyCCmIU
   w==;
X-CSE-ConnectionGUID: I3cA2XI/RYOIj009mokZaQ==
X-CSE-MsgGUID: kwok6TD1S2+lhL87tJ5sAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69916743"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="69916743"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:48:51 -0800
X-CSE-ConnectionGUID: 0DwowYdDQkeip0HBiLabWQ==
X-CSE-MsgGUID: S09y7KrJQwihpq/R/KPRRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="209940236"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:48:47 -0800
Message-ID: <82e836e7-c0cc-4226-91cf-4b2275d99e73@linux.intel.com>
Date: Mon, 19 Jan 2026 15:48:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to
 eliminate RMW race
To: Ravi Bangoria <ravi.bangoria@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Manali Shukla <manali.shukla@amd.com>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
 <20260116033450.965-8-ravi.bangoria@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260116033450.965-8-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/16/2026 11:34 AM, Ravi Bangoria wrote:
> The existing IBS_{FETCH|OP}_CTL MSRs combine control and status bits
> which leads to RMW race between HW and SW:
>
>   HW                               SW
>   ------------------------         ------------------------------
>                                    config = rdmsr(IBS_OP_CTL);
>                                    config &= ~EN;
>   Set IBS_OP_CTL[Val] to 1
>   trigger NMI
>                                    wrmsr(IBS_OP_CTL, config);
>                                    // Val is accidentally cleared
>
> Future hardware adds a control-only MSR, IBS_{FETCH|OP}_CTL2, which
> provides a second-level "disable" bit (Dis). IBS is now:
>
>   Enabled:  IBS_{FETCH|OP}_CTL[En] = 1 && IBS_{FETCH|OP}_CTL2[Dis] = 0
>   Disabled: IBS_{FETCH|OP}_CTL[En] = 0 || IBS_{FETCH|OP}_CTL2[Dis] = 1
>
> The separate "Dis" bit lets software disable IBS without touching any
> status fields, eliminating the hardware/software race.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 45 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 02e7bffe1208..d8216048be84 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -86,9 +86,11 @@ struct cpu_perf_ibs {
>  struct perf_ibs {
>  	struct pmu			pmu;
>  	unsigned int			msr;
> +	unsigned int			msr2;
>  	u64				config_mask;
>  	u64				cnt_mask;
>  	u64				enable_mask;
> +	u64				disable_mask;
>  	u64				valid_mask;
>  	u16				min_period;
>  	u64				max_period;
> @@ -292,6 +294,8 @@ static int perf_ibs_init(struct perf_event *event)
>  		return -ENOENT;
>  
>  	config = event->attr.config;
> +	hwc->extra_reg.config = 0;
> +	hwc->extra_reg.reg = 0;
>  
>  	if (event->pmu != &perf_ibs->pmu)
>  		return -ENOENT;
> @@ -316,6 +320,11 @@ static int perf_ibs_init(struct perf_event *event)
>  	if (ret)
>  		return ret;
>  
> +	if (ibs_caps & IBS_CAPS_DIS) {
> +		hwc->extra_reg.config &= ~perf_ibs->disable_mask;
> +		hwc->extra_reg.reg = perf_ibs->msr2;
> +	}
> +
>  	if (hwc->sample_period) {
>  		if (config & perf_ibs->cnt_mask)
>  			/* raw max_cnt may not be set */
> @@ -445,6 +454,9 @@ static inline void perf_ibs_enable_event(struct perf_ibs *perf_ibs,
>  		wrmsrq(hwc->config_base, tmp & ~perf_ibs->enable_mask);
>  
>  	wrmsrq(hwc->config_base, tmp | perf_ibs->enable_mask);
> +
> +	if (hwc->extra_reg.reg)
> +		wrmsrq(hwc->extra_reg.reg, hwc->extra_reg.config);
>  }
>  
>  /*
> @@ -457,6 +469,11 @@ static inline void perf_ibs_enable_event(struct perf_ibs *perf_ibs,
>  static inline void perf_ibs_disable_event(struct perf_ibs *perf_ibs,
>  					  struct hw_perf_event *hwc, u64 config)
>  {
> +	if (ibs_caps & IBS_CAPS_DIS) {
> +		wrmsrq(hwc->extra_reg.reg, perf_ibs->disable_mask);
> +		return;
> +	}
> +
>  	config &= ~perf_ibs->cnt_mask;
>  	if (boot_cpu_data.x86 == 0x10)
>  		wrmsrq(hwc->config_base, config);
> @@ -809,6 +826,7 @@ static struct perf_ibs perf_ibs_fetch = {
>  		.check_period	= perf_ibs_check_period,
>  	},
>  	.msr			= MSR_AMD64_IBSFETCHCTL,
> +	.msr2			= MSR_AMD64_IBSFETCHCTL2,
>  	.config_mask		= IBS_FETCH_MAX_CNT | IBS_FETCH_RAND_EN,
>  	.cnt_mask		= IBS_FETCH_MAX_CNT,
>  	.enable_mask		= IBS_FETCH_ENABLE,
> @@ -834,6 +852,7 @@ static struct perf_ibs perf_ibs_op = {
>  		.check_period	= perf_ibs_check_period,
>  	},
>  	.msr			= MSR_AMD64_IBSOPCTL,
> +	.msr2			= MSR_AMD64_IBSOPCTL2,
>  	.config_mask		= IBS_OP_MAX_CNT,
>  	.cnt_mask		= IBS_OP_MAX_CNT | IBS_OP_CUR_CNT |
>  				  IBS_OP_CUR_CNT_RAND,
> @@ -1389,6 +1408,9 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  
>  out:
>  	if (!throttle) {
> +		if (ibs_caps & IBS_CAPS_DIS)
> +			wrmsrq(hwc->extra_reg.reg, perf_ibs->disable_mask);
> +
>  		if (perf_ibs == &perf_ibs_op) {
>  			if (ibs_caps & IBS_CAPS_OPCNTEXT) {
>  				new_config = period & IBS_OP_MAX_CNT_EXT_MASK;
> @@ -1460,6 +1482,9 @@ static __init int perf_ibs_fetch_init(void)
>  	if (ibs_caps & IBS_CAPS_ZEN4)
>  		perf_ibs_fetch.config_mask |= IBS_FETCH_L3MISSONLY;
>  
> +	if (ibs_caps & IBS_CAPS_DIS)
> +		perf_ibs_fetch.disable_mask = IBS_FETCH_2_DIS;
> +
>  	perf_ibs_fetch.pmu.attr_groups = fetch_attr_groups;
>  	perf_ibs_fetch.pmu.attr_update = fetch_attr_update;
>  
> @@ -1481,6 +1506,9 @@ static __init int perf_ibs_op_init(void)
>  	if (ibs_caps & IBS_CAPS_ZEN4)
>  		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
>  
> +	if (ibs_caps & IBS_CAPS_DIS)
> +		perf_ibs_op.disable_mask = IBS_OP_2_DIS;
> +
>  	perf_ibs_op.pmu.attr_groups = op_attr_groups;
>  	perf_ibs_op.pmu.attr_update = op_attr_update;
>  
> @@ -1727,6 +1755,23 @@ static void clear_APIC_ibs(void)
>  static int x86_pmu_amd_ibs_starting_cpu(unsigned int cpu)
>  {
>  	setup_APIC_ibs();
> +
> +	if (ibs_caps & IBS_CAPS_DIS) {
> +		/*
> +		 * IBS enable sequence:
> +		 *   CTL[En] = 1;
> +		 *   CTL2[Dis] = 0;
> +		 *
> +		 * IBS disable sequence:
> +		 *   CTL2[Dis] = 1;
> +		 *
> +		 * Set CTL2[Dis] when CPU comes up. This is needed to make
> +		 * enable sequence effective.
> +		 */
> +		wrmsrq(MSR_AMD64_IBSFETCHCTL2, 1);
> +		wrmsrq(MSR_AMD64_IBSOPCTL2, 1);

What does the BIT 0 of these 2 MSRs mean? Disable? Better define a macro
instead of using the magic number "1". 


> +	}
> +
>  	return 0;
>  }
>  
