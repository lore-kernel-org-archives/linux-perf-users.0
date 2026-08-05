Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D2349CD3
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919630; cv=none; b=Dvy3R218NYgibiwfKogR6fyiISok4TjLs9HV+tx+5C28xa8foOApIb8KJbUaqxz2Pr8mJx2QADj4kOps6b9S4SfMoQrek1+b9Qcd5katWltTIq2pDdYG3GXlgNBhdFCcxbcyirFBglc/spA6jNtJ1KdMiHLIxomj9L695V4YzAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919630; c=relaxed/simple;
	bh=Cqxyks8lOnjZjw6cuc1er9ybAlcZCFlZLuqBCHIdAas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2sKtXrk7Z5Pb3YKMxcacl55zwu8YRDIShpy+kkzfkb+a/2jJroMMqTQNjsS/o5Wqb78L6Ko94lhfJD8DGfqdTvsZ/aDNxo8woGTIZcrc93Gu2BTpVaL00kU8YeqTR1opFfxzyVhLFKz0iYxtE2/uZIojM1lWiRXQGuwIqIPU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JkSqRbnH; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JkSqRbnH"
Message-ID: <d0119c08-6aa2-414c-b23f-fe19b2a67a36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785919616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvh5Z3h8059ge05AXgEiEUhLVhn7A5Abx2ATdkUjgXY=;
	b=JkSqRbnHtUlFMvUrHW4li9GmPpnibOAfNeLEm2i7bvZLwsaAq/2YnJHqQ9Mad2i3Fwg9L8
	F8BCjU99IUjba0H/TKZvx479F1NYMrLqgK5wGwQfFkwMCyi+N7uIyszc1Ya6jx/a3H58W8
	l+iN0Qi7FtzREwv+AMwRlspMl6arRzM=
Date: Wed, 5 Aug 2026 01:46:35 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 12/22] RISC-V: perf: Modify the counter discovery
 mechanism
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>,
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-12-7909f863a645@meta.com>
 <90c1a299-617d-4b6d-8aa7-b776cb7c0c46@picoheart.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <90c1a299-617d-4b6d-8aa7-b776cb7c0c46@picoheart.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/7/26 12:45 AM, Yicong Yang wrote:
> On 7/1/26 4:47 PM, Atish Patra wrote:
>> From: Atish Patra <atishp@rivosinc.com>
>>
>> If both counter delegation and SBI PMU is present, the counter
>> delegation will be used for hardware pmu counters while the SBI PMU
>> will be used for firmware counters. Thus, the driver has to probe
>> the counters info via SBI PMU to distinguish the firmware counters.
>>
>> The hybrid scheme also requires improvements of the informational
>> logging messages to indicate the user about underlying interface
>> used for each use case.
>>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   drivers/perf/riscv_pmu_sbi.c | 139 ++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 104 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 74d934238821..c20f1e33c65d 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -67,6 +67,20 @@ static bool sbi_v3_available;
>>   static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
>>   #define sbi_pmu_snapshot_available() \
>>   	static_branch_unlikely(&sbi_pmu_snapshot_available)
>> +static DEFINE_STATIC_KEY_FALSE(riscv_pmu_sbi_available);
>> +static DEFINE_STATIC_KEY_FALSE(riscv_pmu_cdeleg_available);
>> +
>> +/* Avoid unnecessary code patching in the one time booting path*/
>> +#define riscv_pmu_cdeleg_available_boot() \
>> +	static_key_enabled(&riscv_pmu_cdeleg_available)
>> +#define riscv_pmu_sbi_available_boot() \
>> +	static_key_enabled(&riscv_pmu_sbi_available)
>> +
>> +/* Perform a runtime code patching with static key */
>> +#define riscv_pmu_cdeleg_available() \
>> +	static_branch_unlikely(&riscv_pmu_cdeleg_available)
>> +#define riscv_pmu_sbi_available() \
>> +		static_branch_likely(&riscv_pmu_sbi_available)
>>   
>>   static struct attribute *riscv_arch_formats_attr[] = {
>>   	&format_attr_event.attr,
>> @@ -89,7 +103,8 @@ static int sysctl_perf_user_access __read_mostly = SYSCTL_USER_ACCESS;
>>   
>>   /*
>>    * This structure is SBI specific but counter delegation also require counter
>> - * width, csr mapping. Reuse it for now.
>> + * width, csr mapping. Reuse it for now we can have firmware counters for
>> + * platfroms with counter delegation support.
>>    * RISC-V doesn't have heterogeneous harts yet. This need to be part of
>>    * per_cpu in case of harts with different pmu counters
>>    */
>> @@ -101,6 +116,8 @@ static unsigned int riscv_pmu_irq;
>>   
>>   /* Cache the available counters in a bitmask */
>>   static unsigned long cmask;
>> +/* Cache the available firmware counters in another bitmask */
>> +static unsigned long firmware_cmask;
>>   
>>   static int sbi_pmu_event_find_cache(u64 config);
>>   struct sbi_pmu_event_data {
>> @@ -868,34 +885,38 @@ static int rvpmu_sbi_find_num_ctrs(void)
>>   		return sbi_err_map_linux_errno(ret.error);
>>   }
>>   
>> -static int rvpmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
>> +static u32 rvpmu_deleg_find_ctrs(void)
>> +{
>> +	/* TODO */
>> +	return 0;
>> +}
>> +
>> +static int rvpmu_sbi_get_ctrinfo(u32 nsbi_ctr, u32 *num_fw_ctr, u32 *num_hw_ctr)
>>   {
>>   	struct sbiret ret;
>> -	int i, num_hw_ctr = 0, num_fw_ctr = 0;
>> +	int i;
>>   	union sbi_pmu_ctr_info cinfo;
>>   
>> -	pmu_ctr_list = kzalloc_objs(*pmu_ctr_list, nctr);
>> -	if (!pmu_ctr_list)
>> -		return -ENOMEM;
>> -
>> -	for (i = 0; i < nctr; i++) {
>> +	for (i = 0; i < nsbi_ctr; i++) {
>>   		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, 0, 0, 0);
>>   		if (ret.error)
>>   			/* The logical counter ids are not expected to be contiguous */
>>   			continue;
>>   
>> -		*mask |= BIT(i);
>> -
>>   		cinfo.value = ret.value;
>> -		if (cinfo.type == SBI_PMU_CTR_TYPE_FW)
>> -			num_fw_ctr++;
>> -		else
>> -			num_hw_ctr++;
>> -		pmu_ctr_list[i].value = cinfo.value;
>> +		if (cinfo.type == SBI_PMU_CTR_TYPE_FW) {
>> +			/* Track firmware counters in a different mask */
>> +			firmware_cmask |= BIT(i);
>> +			pmu_ctr_list[i].value = cinfo.value;
> could this override the counter info initialized by rvpmu_deleg_find_ctrs()?
> the initialization from counter delegation performs prior to sbi, should we
> check first here?

Theoretically possible because firmware counter IDs are all logical. So 
a firmware
implementation can make weird choices about firmware IDs and counter 
delegation
may trip it. Thanks for catching it. I will fix it.

>> +			*num_fw_ctr = *num_fw_ctr + 1;
>> +		} else if (cinfo.type == SBI_PMU_CTR_TYPE_HW &&
>> +			   !riscv_pmu_cdeleg_available_boot()) {
>> +			*num_hw_ctr = *num_hw_ctr + 1;
>> +			cmask |= BIT(i);
>> +			pmu_ctr_list[i].value = cinfo.value;
>> +		}
>>   	}
>>   
>> -	pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, num_hw_ctr);
>> -
>>   	return 0;
>>   }
>>   
>> @@ -906,7 +927,7 @@ static inline void rvpmu_sbi_stop_all(struct riscv_pmu *pmu)
>>   	 * which may include counters that are not enabled yet.
>>   	 */
>>   	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
>> -		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
>> +		  0, pmu->cmask | firmware_cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
>>   }
>>   
>>   static inline void rvpmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>> @@ -1159,16 +1180,48 @@ static void rvpmu_ctr_stop(struct perf_event *event, unsigned long flag)
>>   	/* TODO: Counter delegation implementation */
>>   }
>>   
>> -static int rvpmu_find_num_ctrs(void)
>> +static int rvpmu_find_ctrs(void)
>>   {
>> -	return rvpmu_sbi_find_num_ctrs();
>> -	/* TODO: Counter delegation implementation */
>> -}
>> +	int num_sbi_counters = 0;
>> +	u32 num_deleg_counters = 0;
>> +	u32 num_hw_ctr = 0, num_fw_ctr = 0, num_ctr = 0;
>> +	/*
>> +	 * We don't know how many firmware counters are available. Just allocate
>> +	 * for maximum counters the driver can support. The default is 64 anyways.
>> +	 */
>> +	pmu_ctr_list = kcalloc(RISCV_MAX_COUNTERS, sizeof(*pmu_ctr_list),
>> +			       GFP_KERNEL);
>> +	if (!pmu_ctr_list)
>> +		return -ENOMEM;
>>   
>> -static int rvpmu_get_ctrinfo(int nctr, unsigned long *mask)
>> -{
>> -	return rvpmu_sbi_get_ctrinfo(nctr, mask);
>> -	/* TODO: Counter delegation implementation */
>> +	if (riscv_pmu_cdeleg_available_boot())
>> +		num_deleg_counters = rvpmu_deleg_find_ctrs();
>> +
>> +	/* This is required for firmware counters even if the above is true */
> does counter delegation depend on SBI PMU? may need further explanation here,
> not sure if it's a rule from the spec or if it's the driver's policy.
Counter delegation doesn't depend on SBI PMU. However, a platform may 
have both
counter delegation and firmware counters which rely on SBI PMU.

I will reword the comment to make it less ambiguous.

>> +	if (riscv_pmu_sbi_available_boot()) {
>> +		num_sbi_counters = rvpmu_sbi_find_num_ctrs();
>> +		if (num_sbi_counters < 0) {
>> +			kfree(pmu_ctr_list);
>> +			pmu_ctr_list = NULL;
>> +			return num_sbi_counters;
>> +		}
>> +		if (num_sbi_counters > RISCV_MAX_COUNTERS)
>> +			num_sbi_counters = RISCV_MAX_COUNTERS;
>> +	}
>> +
>> +	/* cache all the information about counters now */
>> +	if (riscv_pmu_sbi_available_boot())
>> +		rvpmu_sbi_get_ctrinfo(num_sbi_counters, &num_fw_ctr, &num_hw_ctr);
>> +
>> +	if (riscv_pmu_cdeleg_available_boot()) {
>> +		pr_info("%u firmware and %u hardware counters\n", num_fw_ctr, num_deleg_counters);
>> +		num_ctr = num_fw_ctr + num_deleg_counters;
>> +	} else {
>> +		pr_info("%u firmware and %u hardware counters\n", num_fw_ctr, num_hw_ctr);
>> +		num_ctr = num_sbi_counters;
>> +	}
>> +
>> +	return num_ctr;
>>   }
>>   
>>   static int rvpmu_event_map(struct perf_event *event, u64 *econfig)
>> @@ -1478,12 +1531,21 @@ static int rvpmu_device_probe(struct platform_device *pdev)
>>   	int num_counters;
>>   	bool irq_requested = false;
>>   
>> -	pr_info("SBI PMU extension is available\n");
>> +	if (riscv_pmu_cdeleg_available_boot()) {
>> +		pr_info("hpmcounters will use the counter delegation ISA extension\n");
>> +		if (riscv_pmu_sbi_available_boot())
>> +			pr_info("Firmware counters will use SBI PMU extension\n");
>> +		else
>> +			pr_info("Firmware counters will not be available as SBI PMU extension is not present\n");
>> +	} else if (riscv_pmu_sbi_available_boot()) {
>> +		pr_info("Both hpmcounters and firmware counters will use SBI PMU extension\n");
>> +	}
>> +
>>   	pmu = riscv_pmu_alloc();
>>   	if (!pmu)
>>   		return -ENOMEM;
>>   
>> -	num_counters = rvpmu_find_num_ctrs();
>> +	num_counters = rvpmu_find_ctrs();
>>   	if (num_counters < 0) {
>>   		pr_err("SBI PMU extension doesn't provide any counters\n");
>>   		goto out_free;
>> @@ -1495,9 +1557,6 @@ static int rvpmu_device_probe(struct platform_device *pdev)
>>   		pr_info("SBI returned more than maximum number of counters. Limiting the number of counters to %d\n", num_counters);
>>   	}
>>   
>> -	/* cache all the information about counters now */
>> -	if (rvpmu_get_ctrinfo(num_counters, &cmask))
>> -		goto out_free;
>>   
>>   	ret = rvpmu_setup_irqs(pmu, pdev);
>>   	if (ret < 0) {
>> @@ -1599,13 +1658,23 @@ static int __init rvpmu_devinit(void)
>>   	int ret;
>>   	struct platform_device *pdev;
>>   
>> -	if (sbi_spec_version < sbi_mk_version(0, 3) ||
>> -	    !sbi_probe_extension(SBI_EXT_PMU)) {
>> -		return 0;
>> -	}
>> +	if (sbi_spec_version >= sbi_mk_version(0, 3) &&
>> +	    sbi_probe_extension(SBI_EXT_PMU))
>> +		static_branch_enable(&riscv_pmu_sbi_available);
>>   
>>   	if (sbi_spec_version >= sbi_mk_version(2, 0))
>>   		sbi_v2_available = true;
>> +	/*
>> +	 * We need all three extensions to be present to access the counters
>> +	 * in S-mode via Supervisor Counter delegation.
>> +	 */
>> +	if (riscv_isa_extension_available(NULL, SSCCFG) &&
>> +	    riscv_isa_extension_available(NULL, SMCDELEG) &&
>> +	    riscv_isa_extension_available(NULL, SSCSRIND))
>> +		static_branch_enable(&riscv_pmu_cdeleg_available);
> Ssccfg is the necessary extension needed here, is it possible to handle the
> dependencies in cpufeatures.c so we can only check the Ssccfg here? (I see
> we've already made Ssccfg to depend on Smcdeleg there)
We already do that. This is just a additional paranoia check.


>> +
>> +	if (!(riscv_pmu_sbi_available_boot() || riscv_pmu_cdeleg_available_boot()))
>> +		return 0;
>>   
>>   	if (sbi_spec_version >= sbi_mk_version(3, 0))
>>   		sbi_v3_available = true;
>>
> this should stay with the SBI PMU probe block above.

Makes sense.

>
> Thanks.
