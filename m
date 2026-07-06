Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA741424665
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331273; cv=none; b=ezi/JrQq0zz6duMqvyBTwxdLI11SRExMOh4XSz4zu/kl+U5y4eRZE7DrNMqKtyGU+hXiQX9QJBhOt7SPpttkWG+OdOhmygh4Gtc7vEr5iSslDxj7JNbcbCIMdHYtxNUuZKp6ENBRe+ZUNp51PVISB+QknZZgUPs4D5pJsbcalpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331273; c=relaxed/simple;
	bh=bgD63rvCB5kFj/zqdVMBMZtCmBmObqGS5rmNCOfcf8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5IReNahuVzc9jSP24+ngdo9r2Gtp362bGAWoWqnFfK2wDHic03eCA/Xhw5DIUqIqqG+zYROZEwCxKrH1aBoT9nQuMPRjQT10IA6li+OXBijp0SvDk/p3WGW2CmVVyCa4Zh5YXgwLjRzCMIblMjwtcp4yx0A5keVeyGBphYV5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klM1jkhy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klM1jkhy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783331269; x=1814867269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bgD63rvCB5kFj/zqdVMBMZtCmBmObqGS5rmNCOfcf8g=;
  b=klM1jkhyf0pyO1obtaDAlPgUizhYg+6DVI2BLPBxe3gfJTTz47WiPeDJ
   8eXJtEdwMfa/608Knp6OGfkYydhxYhS9QiIe0hC+fMaXXuA1j/IMLbIK2
   BhxKBzrhHMlhsubPQGtMi4EaxVbFmBWTWUdiIX/zembLL31nenXQ1mbpb
   jZOMhxLvqe2wmU8cGIsFnpYUib0F2Uav34785HpoH88qDAKXsvB9FuQ/X
   4Nwe9iSLxNWmCUjWj2uM7+j9+mBLk8cdrAsa3bEctMgnadhClgXVKb0uJ
   PnCo0x5QU8T4tCsvX2bPfoL1IPMzTStw7tH/gGl1YmRQtXM8i2QdtZmww
   Q==;
X-CSE-ConnectionGUID: IpO1S1cTRVel8uztIe0w3A==
X-CSE-MsgGUID: c3M0bjO+S0GkCjcpJhpjTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95471588"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="95471588"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:47:47 -0700
X-CSE-ConnectionGUID: 1DPSgk6vRM6d+SPjxqZIPA==
X-CSE-MsgGUID: mFcII6onSo6N+BDM9NG7Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247280570"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:47:46 -0700
Message-ID: <89f316ca-936b-4938-9421-2f96cfdc4837@linux.intel.com>
Date: Mon, 6 Jul 2026 17:47:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 11/24] perf/x86: Enable XMM register sampling for
 non-PEBS events
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-12-dapeng1.mi@linux.intel.com>
 <20260706023418.CD74F1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706023418.CD74F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/6/2026 10:34 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] reserve_ext_regs_buffers() fails to propagate memory allocation errors and improperly uses WARN_ON_ONCE, leading to a silent feature failure and possible kernel panics under memory pressure.
> --
>
> commit 8262cdbae2d650c85cf4924888ecf8b4f85b98de
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Enable XMM register sampling for non-PEBS events
>
> This commit extends XMM register sampling to non-PEBS events using the xsaves
> instruction. It allocates a per-CPU ext_regs_buf to store SIMD and other
> registers. For PEBS events, data is retrieved directly from PEBS records.
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index d83ea02e24577..3e52610510cdc 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
> [ ... ]
>> @@ -410,6 +410,56 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
>> +static void reserve_ext_regs_buffers(void)
>> +{
>> +	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
>> +	unsigned int size;
>> +	int cpu;
>> +
>> +	if (!x86_pmu.ext_regs_mask)
>> +		return;
>> +
>> +	/* +64 bytes for the 64 bytes alignment request of xsave area. */
>> +	size = xstate_calculate_size(x86_pmu.ext_regs_mask, compacted) + 64;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		per_cpu(ext_regs_buf, cpu) = kzalloc_node(size, GFP_KERNEL,
>> +							  cpu_to_node(cpu));
>> +		if (WARN_ON_ONCE(!per_cpu(ext_regs_buf, cpu)))
>> +			goto err;
>> +	}
>> +
>> +	return;
>> +
>> +err:
>> +	release_ext_regs_buffers();
>> +}
> [ ... ]
>>  int x86_reserve_hardware(void)
>>  {
>>  	int err = 0;
>>  
>>  	if (!atomic_inc_not_zero(&pmc_refcount)) {
>>  		mutex_lock(&pmc_reserve_mutex);
>>  		if (atomic_read(&pmc_refcount) == 0) {
>>  			if (!reserve_pmc_hardware()) {
>>  				err = -EBUSY;
>>  			} else {
>>  				reserve_ds_buffers();
>>  				reserve_lbr_buffers();
>> +				reserve_ext_regs_buffers();
>>  			}
>>  		}
>>  		if (!err)
> [Severity: High]
> Does this code swallow the memory allocation failure?
>
> Since reserve_ext_regs_buffers() returns void, x86_reserve_hardware() 
> appears unaware if kzalloc_node() fails under memory pressure. The hardware 
> reservation will succeed anyway, and the perf event creation is permitted
> even though the backing buffers do not exist.
>
> [ ... ]
>> +static void x86_pmu_sample_xregs(struct perf_event *event,
>> +				 struct perf_sample_data *data,
>> +				 u64 ignore_mask)
>> +{
>> +	struct xregs_state *xsave = get_ext_regs_buf(smp_processor_id());
>> +	u64 sample_type = event->attr.sample_type;
>> +	struct x86_perf_regs *perf_regs;
>> +	u64 intr_mask = 0;
>> +	u64 mask = 0;
>> +
>> +	if (WARN_ON_ONCE(!xsave) || !in_nmi())
>> +		return;
> [Severity: High]
> Can this path be reached with a NULL xsave buffer during a PMI if the earlier
> allocation failed?
>
> If an unprivileged user creates an event requesting extended registers during
> memory pressure, and the allocation in reserve_ext_regs_buffers() fails,
> the event is successfully created. When the PMI hits, this WARN_ON_ONCE in
> NMI context will trigger.
>
> This could panic the system if panic_on_warn is set, or otherwise silently
> drop the requested register data. Should reserve_ext_regs_buffers() return
> an error code so x86_reserve_hardware() can fail the event creation instead?

IMO, it's good enough to use WARN_ON_ONCE() to warn the allocation error.
Propagating the allocation error would need to add much complicated
fallback code since there are lots of allocations, it seems unworthy to
make the code be so complicated.

Thanks.


>
